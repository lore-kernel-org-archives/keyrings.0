From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:09:24 +0000
Subject: [RFC PATCH 13/27] keys: Provide a keyctl to query a request_key authentication key
Message-Id: <155024696409.21651.3488621563034826227.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Provide a keyctl to query a request_key authentication key for situations
where this information isn't passed on the command line (such as where the
authentication key is placed in a queue instead of /sbin/request-key being
invoked):

	struct keyctl_query_request_key_auth {
		char		operation[32];
		uid_t		fsuid;
		gid_t		fsgid;
		key_serial_t	target_key;
		key_serial_t	thread_keyring;
		key_serial_t	process_keyring;
		key_serial_t	session_keyring;
		__u64		spare[1];
	};

	keyctl(KEYCTL_QUERY_REQUEST_KEY_AUTH,
	       key_serial_t key,
	       struct keyctl_query_request_key_auth *data);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/keyctl.h |   12 ++++++++++++
 security/keys/compat.c      |    2 ++
 security/keys/container.c   |   42 ++++++++++++++++++++++++++++++++++++++++++
 security/keys/internal.h    |    2 ++
 security/keys/keyctl.c      |    4 ++++
 5 files changed, 62 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 85e8fef89bba..bb075ad1827d 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -69,6 +69,7 @@
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
 #define KEYCTL_WATCH_KEY		30	/* Watch a key or ring of keys for changes */
 #define KEYCTL_CONTAINER_INTERCEPT	31	/* Intercept upcalls inside a container */
+#define KEYCTL_QUERY_REQUEST_KEY_AUTH	32	/* Query a request_key_auth key */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -114,4 +115,15 @@ struct keyctl_pkey_params {
 	__u32		__spare[7];
 };
 
+struct keyctl_query_request_key_auth {
+	char		operation[32];	/* Operation name, typically "create" */
+	uid_t		fsuid;		/* UID of requester */
+	gid_t		fsgid;		/* GID of requester */
+	__u32		target_key;	/* The key being instantiated */
+	__u32		thread_keyring;	/* The requester's thread keyring */
+	__u32		process_keyring; /* The requester's process keyring */
+	__u32		session_keyring; /* The requester's session keyring */
+	__u64		spare[1];
+};
+
 #endif /*  _LINUX_KEYCTL_H */
diff --git a/security/keys/compat.c b/security/keys/compat.c
index 6420881e5ce7..30055fc2b629 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -164,6 +164,8 @@ COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
 #ifdef CONFIG_CONTAINERS
 	case KEYCTL_CONTAINER_INTERCEPT:
 		return keyctl_container_intercept(arg2, compat_ptr(arg3), arg4, arg5);
+	case KEYCTL_QUERY_REQUEST_KEY_AUTH:
+		return keyctl_query_request_key_auth(arg2, compat_ptr(arg3));
 #endif
 
 	default:
diff --git a/security/keys/container.c b/security/keys/container.c
index c61c43658f3b..115998e867cd 100644
--- a/security/keys/container.c
+++ b/security/keys/container.c
@@ -225,3 +225,45 @@ int queue_request_key(struct key *authkey)
 	kleave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * Query information about a request_key_auth key.
+ */
+long keyctl_query_request_key_auth(key_serial_t auth_id,
+				   struct keyctl_query_request_key_auth __user *_data)
+{
+	struct keyctl_query_request_key_auth data;
+	struct request_key_auth *rka;
+	struct key *session;
+	key_ref_t authkey_ref;
+
+	if (auth_id <= 0 || !_data)
+		return -EINVAL;
+
+	authkey_ref = lookup_user_key(auth_id, 0, KEY_NEED_SEARCH);
+	if (IS_ERR(authkey_ref))
+		return PTR_ERR(authkey_ref);
+	rka = get_request_key_auth(key_ref_to_ptr(authkey_ref));
+
+	memset(&data, 0, sizeof(data));
+	strlcpy(data.operation, rka->op, sizeof(data.operation));
+	data.fsuid = from_kuid(current_user_ns(), rka->cred->fsuid);
+	data.fsgid = from_kgid(current_user_ns(), rka->cred->fsgid);
+	data.target_key = rka->target_key->serial;
+	data.thread_keyring = key_serial(rka->cred->thread_keyring);
+	data.process_keyring = key_serial(rka->cred->thread_keyring);
+
+	rcu_read_lock();
+	session = rcu_dereference(rka->cred->session_keyring);
+	if (!session)
+		session = rka->cred->user->session_keyring;
+	data.session_keyring = key_serial(session);
+	rcu_read_unlock();
+
+	key_ref_put(authkey_ref);
+
+	if (copy_to_user(_data, &data, sizeof(data)))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/security/keys/internal.h b/security/keys/internal.h
index e98fca465146..9f2a6ce67d15 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -362,6 +362,8 @@ static inline long keyctl_watch_key(key_serial_t key_id, int watch_fd, int watch
 
 #ifdef CONFIG_CONTAINERS
 extern long keyctl_container_intercept(int, const char __user *, unsigned int, key_serial_t);
+extern long keyctl_query_request_key_auth(key_serial_t,
+					  struct keyctl_query_request_key_auth __user *);
 #endif
 
 /*
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 38ff33431f33..a19efc60944d 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1863,6 +1863,10 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 						  (const char __user *)arg3,
 						  (unsigned int)arg4,
 						  (key_serial_t)arg5);
+	case KEYCTL_QUERY_REQUEST_KEY_AUTH:
+		return keyctl_query_request_key_auth(
+			(key_serial_t)arg2,
+			(struct keyctl_query_request_key_auth __user *)arg3);
 #endif
 
 	default:
