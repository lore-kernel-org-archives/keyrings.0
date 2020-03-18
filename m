From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Mar 2020 15:05:03 +0000
Subject: [PATCH 12/17] watch_queue: Add security hooks to rule on setting mount and sb watches [ver #5]
Message-Id: <158454390389.2863966.16459187265972715098.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc: Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.org, dhowells@redhat.comcasey@schaufler-ca.comsds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.orglinux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Add security hooks that will allow an LSM to rule on whether or not a watch
may be set on a mount or on a superblock.  More than one hook is required
as the watches watch different types of object.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   24 ++++++++++++++++++++++++
 include/linux/security.h  |   16 ++++++++++++++++
 security/security.c       |   14 ++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 16530255dc11..c4451ac197ae 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1427,6 +1427,18 @@
  *	Check to see if a process is allowed to watch for event notifications
  *	from devices (as a global set).
  *
+ * @watch_mount:
+ *	Check to see if a process is allowed to watch for mount topology change
+ *	notifications on a mount subtree.
+ *	@watch: The watch object
+ *	@path: The root of the subtree to watch.
+ *
+ * @watch_sb:
+ *	Check to see if a process is allowed to watch for event notifications
+ *	from a superblock.
+ *	@watch: The watch object
+ *	@sb: The superblock to watch.
+ *
  * @post_notification:
  *	Check to see if a watch notification can be posted to a particular
  *	queue.
@@ -1722,6 +1734,12 @@ union security_list_options {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	int (*watch_devices)(void);
 #endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	int (*watch_mount)(struct watch *watch, struct path *path);
+#endif
+#ifdef CONFIG_SB_NOTIFICATIONS
+	int (*watch_sb)(struct watch *watch, struct super_block *sb);
+#endif
 #ifdef CONFIG_WATCH_QUEUE
 	int (*post_notification)(const struct cred *w_cred,
 				 const struct cred *cred,
@@ -2020,6 +2038,12 @@ struct security_hook_heads {
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 	struct hlist_head watch_devices;
 #endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct hlist_head watch_mount;
+#endif
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct hlist_head watch_sb;
+#endif
 #ifdef CONFIG_WATCH_QUEUE
 	struct hlist_head post_notification;
 #endif /* CONFIG_WATCH_QUEUE */
diff --git a/include/linux/security.h b/include/linux/security.h
index 910a1efa9a79..2ca2569bc12c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1306,6 +1306,22 @@ static inline int security_post_notification(const struct cred *w_cred,
 	return 0;
 }
 #endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_MOUNT_NOTIFICATIONS)
+int security_watch_mount(struct watch *watch, struct path *path);
+#else
+static inline int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return 0;
+}
+#endif
+#if defined(CONFIG_SECURITY) && defined(CONFIG_SB_NOTIFICATIONS)
+int security_watch_sb(struct watch *watch, struct super_block *sb);
+#else
+static inline int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return 0;
+}
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK
 
diff --git a/security/security.c b/security/security.c
index db7b574c9c70..5c0463444a90 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2004,6 +2004,20 @@ int security_watch_key(struct key *key)
 }
 #endif
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+int security_watch_mount(struct watch *watch, struct path *path)
+{
+	return call_int_hook(watch_mount, 0, watch, path);
+}
+#endif
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+int security_watch_sb(struct watch *watch, struct super_block *sb)
+{
+	return call_int_hook(watch_sb, 0, watch, sb);
+}
+#endif
+
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 int security_watch_devices(void)
 {
