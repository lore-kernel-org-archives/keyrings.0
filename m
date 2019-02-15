From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:07:41 +0000
Subject: [RFC PATCH 03/27] containers: Provide /proc/containers
Message-Id: <155024686175.21651.6141317051029384847.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Provide /proc/containers to view the current container and all the
containers created within it:

	# ./foo-container
	NAME                     USE FL OWNER GROUP
	<current>                141 01 0     0
	foo-test                   1 04 0     0

I'm not sure whether this is really desirable, though.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/container.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/kernel/container.c b/kernel/container.c
index ca4012632cfa..1d2cb1c1e9b1 100644
--- a/kernel/container.c
+++ b/kernel/container.c
@@ -20,6 +20,7 @@
 #include <linux/syscalls.h>
 #include <linux/printk.h>
 #include <linux/security.h>
+#include <linux/proc_fs.h>
 #include "namespaces.h"
 
 struct container init_container = {
@@ -69,6 +70,108 @@ void put_container(struct container *c)
 	}
 }
 
+static void *container_proc_start(struct seq_file *m, loff_t *_pos)
+{
+	struct container *c = m->private;
+	struct list_head *p;
+	loff_t pos = *_pos;
+
+	spin_lock(&c->lock);
+
+	if (pos <= 1) {
+		*_pos = 1;
+		return (void *)1UL; /* Banner on first line */
+	}
+
+	if (pos = 2)
+		return m->private; /* Current container on second line */
+
+	/* Subordinate containers thereafter */
+	p = c->children.next;
+	pos--;
+	for (pos--; pos > 0 && p != &c->children; pos--) {
+		p = p->next;
+	}
+
+	if (p = &c->children)
+		return NULL;
+	return container_of(p, struct container, child_link);
+}
+
+static void *container_proc_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	struct container *c = m->private, *vc = v;
+	struct list_head *p;
+	loff_t pos = *_pos;
+
+	pos++;
+	*_pos = pos;
+	if (pos = 2)
+		return c; /* Current container on second line */
+
+	if (pos = 3)
+		p = &c->children;
+	else
+		p = &vc->child_link;
+	p = p->next;
+	if (p = &c->children)
+		return NULL;
+	return container_of(p, struct container, child_link);
+}
+
+static void container_proc_stop(struct seq_file *m, void *v)
+{
+	struct container *c = m->private;
+
+	spin_unlock(&c->lock);
+}
+
+static int container_proc_show(struct seq_file *m, void *v)
+{
+	struct user_namespace *uns = current_user_ns();
+	struct container *c = v;
+	const char *name;
+
+	if (v = (void *)1UL) {
+		seq_puts(m, "NAME                               ID USE FL OWNER GROUP\n");
+		return 0;
+	}
+
+	name = (c = m->private) ? "<current>" : c->name;
+	seq_printf(m, "%-24s %12llu %3u %02lx %5d %5d\n",
+		   name, c->id, refcount_read(&c->usage), c->flags,
+		   from_kuid_munged(uns, c->cred->uid),
+		   from_kgid_munged(uns, c->cred->gid));
+
+	return 0;
+}
+
+static const struct seq_operations container_proc_ops = {
+	.start	= container_proc_start,
+	.next	= container_proc_next,
+	.stop	= container_proc_stop,
+	.show	= container_proc_show,
+};
+
+static int container_proc_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *m;
+	int ret = seq_open(file, &container_proc_ops);
+
+	if (ret = 0) {
+		m = file->private_data;
+		m->private = current->container;
+	}
+	return ret;
+}
+
+static const struct file_operations container_proc_fops = {
+	.open		= container_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /*
  * Allow the user to poll for the container dying.
  */
@@ -345,4 +448,11 @@ SYSCALL_DEFINE5(container_create,
 	return fd;
 }
 
+static int __init init_container_fs(void)
+{
+	proc_create("containers", 0, NULL, &container_proc_fops);
+	return 0;
+}
+fs_initcall(init_container_fs);
+
 #endif /* CONFIG_CONTAINERS */
