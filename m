From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:46:45 +0000
Subject: [PATCH 6/6] afs: Support RCU pathwalk
Message-Id: <155856520503.11737.9841245263615099582.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Make afs_permission() and afs_d_revalidate() do initial checks in RCU-mode
pathwalk to reduce latency in pathwalk elements that get done multiple
times.  We don't need to query the server unless we've received a
notification from it that something has changed or the callback has
expired.

This requires that we can request a key and check permits under RCU
conditions if we need to.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |   54 +++++++++++++++++++++++++++++++++++++-
 fs/afs/security.c |   75 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 112 insertions(+), 17 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 79d93a26759a..c394e7c1a8ab 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -961,6 +961,58 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	return d;
 }
 
+/*
+ * Check the validity of a dentry under RCU conditions.
+ */
+static int afs_d_revalidate_rcu(struct dentry *dentry)
+{
+	struct afs_vnode *dvnode, *vnode;
+	struct dentry *parent;
+	struct inode *dir, *inode;
+	long dir_version, de_version;
+
+	_enter("%p", dentry);
+
+	/* Check the parent directory is still valid first. */
+	parent = READ_ONCE(dentry->d_parent);
+	dir = d_inode_rcu(parent);
+	if (!dir)
+		return -ECHILD;
+	dvnode = AFS_FS_I(dir);
+	if (test_bit(AFS_VNODE_DELETED, &dvnode->flags))
+		return -ECHILD;
+
+	if (!afs_check_validity(dvnode))
+		return -ECHILD;
+
+	/* We only need to invalidate a dentry if the server's copy changed
+	 * behind our back.  If we made the change, it's no problem.  Note that
+	 * on a 32-bit system, we only have 32 bits in the dentry to store the
+	 * version.
+	 */
+	dir_version = (long)READ_ONCE(dvnode->status.data_version);
+	de_version = (long)READ_ONCE(dentry->d_fsdata);
+	if (de_version != dir_version) {
+		dir_version = (long)READ_ONCE(dvnode->invalid_before);
+		if (de_version - dir_version < 0)
+			return -ECHILD;
+	}
+
+	/* Check to see if the vnode referred to by the dentry still
+	 * has a callback.
+	 */
+	if (d_really_is_positive(dentry)) {
+		inode = d_inode_rcu(dentry);
+		if (inode) {
+			vnode = AFS_FS_I(inode);
+			if (!afs_check_validity(vnode))
+				return -ECHILD;
+		}
+	}
+
+	return 1; /* Still valid */
+}
+
 /*
  * check that a dentry lookup hit has found a valid entry
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an
@@ -977,7 +1029,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	int ret;
 
 	if (flags & LOOKUP_RCU)
-		return -ECHILD;
+		return afs_d_revalidate_rcu(dentry);
 
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
diff --git a/fs/afs/security.c b/fs/afs/security.c
index a6582d6a3882..fab44171344f 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -305,6 +305,40 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 	return;
 }
 
+static bool afs_check_permit_rcu(struct afs_vnode *vnode, struct key *key,
+				 afs_access_t *_access)
+{
+	const struct afs_permits *permits;
+	int i;
+
+	_enter("{%llx:%llu},%x",
+	       vnode->fid.vid, vnode->fid.vnode, key_serial(key));
+
+	/* check the permits to see if we've got one yet */
+	if (key = vnode->volume->cell->anonymous_key) {
+		*_access = vnode->status.anon_access;
+		_leave(" = t [anon %x]", *_access);
+		return true;
+	}
+
+	permits = rcu_dereference(vnode->permit_cache);
+	if (permits) {
+		for (i = 0; i < permits->nr_permits; i++) {
+			if (permits->permits[i].key < key)
+				continue;
+			if (permits->permits[i].key > key)
+				break;
+
+			*_access = permits->permits[i].access;
+			_leave(" = %u [perm %x]", !permits->invalidated, *_access);
+			return !permits->invalidated;
+		}
+	}
+
+	_leave(" = f");
+	return false;
+}
+
 /*
  * check with the fileserver to see if the directory or parent directory is
  * permitted to be accessed with this authorisation, and if so, what access it
@@ -371,33 +405,42 @@ int afs_permission(struct inode *inode, int mask)
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	afs_access_t uninitialized_var(access);
 	struct key *key;
-	int ret;
-
-	if (mask & MAY_NOT_BLOCK)
-		return -ECHILD;
+	int ret = 0;
 
 	_enter("{{%llx:%llu},%lx},%x,",
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags, mask);
 
-	key = afs_request_key(vnode->volume->cell);
-	if (IS_ERR(key)) {
-		_leave(" = %ld [key]", PTR_ERR(key));
-		return PTR_ERR(key);
-	}
+	if (mask & MAY_NOT_BLOCK) {
+		key = afs_request_key_rcu(vnode->volume->cell);
+		if (IS_ERR(key))
+			return -ECHILD;
 
-	ret = afs_validate(vnode, key);
-	if (ret < 0)
-		goto error;
+		ret = -ECHILD;
+		if (!afs_check_validity(vnode) ||
+		    !afs_check_permit_rcu(vnode, key, &access))
+			goto error;
+	} else {
+		key = afs_request_key(vnode->volume->cell);
+		if (IS_ERR(key)) {
+			_leave(" = %ld [key]", PTR_ERR(key));
+			return PTR_ERR(key);
+		}
 
-	/* check the permits to see if we've got one yet */
-	ret = afs_check_permit(vnode, key, &access);
-	if (ret < 0)
-		goto error;
+		ret = afs_validate(vnode, key);
+		if (ret < 0)
+			goto error;
+
+		/* check the permits to see if we've got one yet */
+		ret = afs_check_permit(vnode, key, &access);
+		if (ret < 0)
+			goto error;
+	}
 
 	/* interpret the access mask */
 	_debug("REQ %x ACC %x on %s",
 	       mask, access, S_ISDIR(inode->i_mode) ? "dir" : "file");
 
+	ret = 0;
 	if (S_ISDIR(inode->i_mode)) {
 		if (mask & (MAY_EXEC | MAY_READ | MAY_CHDIR)) {
 			if (!(access & AFS_ACE_LOOKUP))
