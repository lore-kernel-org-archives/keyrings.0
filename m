From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Dec 2019 15:25:02 +0000
Subject: [PATCH 3/3] afs: Fix afs_lookup() to not clobber the version on a new dentry
Message-Id: <157780590246.25571.8995170375088979996.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
In-Reply-To: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
To: linux-afs@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com

Fix afs_lookup() to not clobber the version set on a new dentry by
afs_do_lookup() - especially as it's using the wrong version of the version
(we need to use the one given to us by whatever op the dir contents
correspond to rather than what's in the afs_vnode).

Fixes: 9dd0b82ef530 ("afs: Fix missing dentry data version updating")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 813db1708494..5c794f4b051a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -952,12 +952,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry, key);
 	key_put(key);
-	if (inode = ERR_PTR(-ENOENT)) {
+	if (inode = ERR_PTR(-ENOENT))
 		inode = afs_try_auto_mntpt(dentry, dir);
-	} else {
-		dentry->d_fsdata -			(void *)(unsigned long)dvnode->status.data_version;
-	}
 
 	if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;
