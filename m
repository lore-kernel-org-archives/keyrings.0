From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:08:57 +0000
Subject: [RFC PATCH 10/27] containers: Provide fs_context op for container setting
Message-Id: <155024693750.21651.5133054585005541648.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Provide an fs_context op to notify a filesystem that a container has been
set.  The filesystem should do whatever cleanup it needs, then call
do_set_container() and then re-set its container/namespace dependent stuff.

This allows the following:

 (1) proc and mqueue mounts to set the correct pid and ipc namespaces
     respectively.

 (2) afs to discard the old default cell before the net namespace is
     changed (ie. while it is still pinned), after which it can get the new
     default cell.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c             |   18 ++++++++++++++++++
 fs/fs_context.c            |   32 ++++++++++++++++++++++++++------
 fs/proc/root.c             |    9 +++++++++
 include/linux/fs_context.h |    2 ++
 ipc/mqueue.c               |   10 ++++++++++
 5 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 4e33a7038bc5..a349e213bdc8 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -569,6 +569,23 @@ static int afs_get_tree(struct fs_context *fc)
 	return ret;
 }
 
+static void afs_set_container(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_cell *cell;
+
+	afs_put_cell(ctx->net, ctx->cell);
+	do_set_container(fc);
+
+	/* Default to the workstation cell. */
+	rcu_read_lock();
+	cell = afs_lookup_cell_rcu(ctx->net, NULL, 0);
+	rcu_read_unlock();
+	if (IS_ERR(cell))
+		cell = NULL;
+	ctx->cell = cell;
+}
+
 static void afs_free_fc(struct fs_context *fc)
 {
 	struct afs_fs_context *ctx = fc->fs_private;
@@ -583,6 +600,7 @@ static void afs_free_fc(struct fs_context *fc)
 static const struct fs_context_operations afs_context_ops = {
 	.free		= afs_free_fc,
 	.parse_param	= afs_parse_param,
+	.set_container	= afs_set_container,
 	.get_tree	= afs_get_tree,
 };
 
diff --git a/fs/fs_context.c b/fs/fs_context.c
index fc76ac02d618..c0f333cc0e16 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -170,18 +170,38 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 }
 EXPORT_SYMBOL(vfs_parse_fs_param);
 
+/**
+ * do_set_container - Helper to set container
+ * @fc: The fs_context to adjust
+ *
+ * This is called to effect the change of namespaces associated with the
+ * container.  The reason that this isn't rolled into vfs_set_container() is
+ * that the filesystem may need to do some cleanup on the old namespaces (which
+ * are currently pinned by the container) before calling this.
+ *
+ * The user namespace is not changed as that is used for security checks.
+ */
+void do_set_container(struct fs_context *fc)
+{
+	put_net(fc->net_ns);
+	fc->net_ns = get_net(fc->container->ns->net_ns);
+}
+EXPORT_SYMBOL(do_set_container);
+
 /*
- * Specify a container in which a superblock will exist.
+ * Specify a container in which a superblock will exist.  This should be called
+ * before calling vfs_parse_fs_param.  If ->set_container() is supplied by the
+ * filesystem, it should call do_set_container().
  */
 void vfs_set_container(struct fs_context *fc, struct container *container)
 {
 	if (container) {
-		put_user_ns(fc->user_ns);
-		put_net(fc->net_ns);
-
+		put_container(fc->container);
 		fc->container = get_container(container);
-		fc->user_ns = get_user_ns(container->cred->user_ns);
-		fc->net_ns = get_net(container->ns->net_ns);
+		if (fc->ops->set_container)
+			fc->ops->set_container(fc);
+		else
+			do_set_container(fc);
 	}
 }
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index aa802006d855..f8e124ce0888 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -164,6 +164,14 @@ static int proc_get_tree(struct fs_context *fc)
 	return vfs_get_super(fc, vfs_get_keyed_super, proc_fill_super);
 }
 
+static void proc_set_container(struct fs_context *fc)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+
+	put_pid_ns(ctx->pid_ns);
+	ctx->pid_ns = get_pid_ns(fc->container->pid_ns);
+}
+
 static void proc_fs_context_free(struct fs_context *fc)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
@@ -176,6 +184,7 @@ static void proc_fs_context_free(struct fs_context *fc)
 static const struct fs_context_operations proc_fs_context_ops = {
 	.free		= proc_fs_context_free,
 	.parse_param	= proc_parse_param,
+	.set_container	= proc_set_container,
 	.get_tree	= proc_get_tree,
 	.reconfigure	= proc_reconfigure,
 };
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 45486080eb84..086e4f24705a 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -118,6 +118,7 @@ struct fs_context_operations {
 	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
 	int (*parse_param)(struct fs_context *fc, struct fs_parameter *param);
 	int (*parse_monolithic)(struct fs_context *fc, void *data);
+	void (*set_container)(struct fs_context *fc);
 	int (*get_tree)(struct fs_context *fc);
 	int (*reconfigure)(struct fs_context *fc);
 };
@@ -138,6 +139,7 @@ extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
+extern void do_set_container(struct fs_context *fc);
 extern void vfs_set_container(struct fs_context *fc, struct container *container);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 2a9a8be49f5b..821fb227800f 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 #include <linux/nsproxy.h>
 #include <linux/pid.h>
+#include <linux/container.h>
 #include <linux/ipc_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/slab.h>
@@ -329,6 +330,14 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
+static void mqueue_set_container(struct fs_context *fc)
+{
+	struct mqueue_fs_context *ctx = fc->fs_private;
+
+	put_ipc_ns(ctx->ipc_ns);
+	ctx->ipc_ns = get_ipc_ns(fc->container->ns->ipc_ns);
+}
+
 static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -1569,6 +1578,7 @@ static const struct super_operations mqueue_super_ops = {
 
 static const struct fs_context_operations mqueue_fs_context_ops = {
 	.free		= mqueue_fs_context_free,
+	.set_container	= mqueue_set_container,
 	.get_tree	= mqueue_get_tree,
 };
 
