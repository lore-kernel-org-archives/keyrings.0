From: Jann Horn <jannh@google.com>
Date: Wed, 27 Mar 2019 15:55:08 +0000
Subject: [PATCH] keys: safe concurrent user->{session,uid}_keyring access
Message-Id: <20190327155508.144730-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, jannh@google.com
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

The current code can perform concurrent updates and reads on
user->session_keyring and user->uid_keyring. Add a comment to
struct user_struct to document the nontrivial locking semantics, and use
READ_ONCE() for unlocked readers and smp_store_release() for writers to
prevent memory ordering issues.

Fixes: 69664cf16af4 ("keys: don't generate user and user session keyrings unless they're accessed")
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/sched/user.h   |  7 +++++++
 security/keys/process_keys.c | 31 +++++++++++++++++--------------
 security/keys/request_key.c  |  5 +++--
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index c7b5f86b91a1..468d2565a9fe 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -31,6 +31,13 @@ struct user_struct {
 	atomic_long_t pipe_bufs;  /* how many pages are allocated in pipe buffers */
 
 #ifdef CONFIG_KEYS
+	/*
+	 * These pointers can only change from NULL to a non-NULL value once.
+	 * Writes are protected by key_user_keyring_mutex.
+	 * Unlocked readers should use READ_ONCE() unless they know that
+	 * install_user_keyrings() has been called successfully (which sets
+	 * these members to non-NULL values, preventing further modifications).
+	 */
 	struct key *uid_keyring;	/* UID specific keyring */
 	struct key *session_keyring;	/* UID's default session keyring */
 #endif
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index bd7243cb4c85..f05f7125a7d5 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -58,7 +58,7 @@ int install_user_keyrings(void)
 
 	kenter("%p{%u}", user, uid);
 
-	if (user->uid_keyring && user->session_keyring) {
+	if (READ_ONCE(user->uid_keyring) && READ_ONCE(user->session_keyring)) {
 		kleave(" = 0 [exist]");
 		return 0;
 	}
@@ -111,8 +111,10 @@ int install_user_keyrings(void)
 		}
 
 		/* install the keyrings */
-		user->uid_keyring = uid_keyring;
-		user->session_keyring = session_keyring;
+		/* paired with READ_ONCE() */
+		smp_store_release(&user->uid_keyring, uid_keyring);
+		/* paired with READ_ONCE() */
+		smp_store_release(&user->session_keyring, session_keyring);
 	}
 
 	mutex_unlock(&key_user_keyring_mutex);
@@ -340,6 +342,7 @@ void key_fsgid_changed(struct task_struct *tsk)
 key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 {
 	key_ref_t key_ref, ret, err;
+	const struct cred *cred = ctx->cred;
 
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
@@ -353,9 +356,9 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 	err = ERR_PTR(-EAGAIN);
 
 	/* search the thread keyring first */
-	if (ctx->cred->thread_keyring) {
+	if (cred->thread_keyring) {
 		key_ref = keyring_search_aux(
-			make_key_ref(ctx->cred->thread_keyring, 1), ctx);
+			make_key_ref(cred->thread_keyring, 1), ctx);
 		if (!IS_ERR(key_ref))
 			goto found;
 
@@ -371,9 +374,9 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 	}
 
 	/* search the process keyring second */
-	if (ctx->cred->process_keyring) {
+	if (cred->process_keyring) {
 		key_ref = keyring_search_aux(
-			make_key_ref(ctx->cred->process_keyring, 1), ctx);
+			make_key_ref(cred->process_keyring, 1), ctx);
 		if (!IS_ERR(key_ref))
 			goto found;
 
@@ -392,9 +395,9 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 	}
 
 	/* search the session keyring */
-	if (ctx->cred->session_keyring) {
+	if (cred->session_keyring) {
 		key_ref = keyring_search_aux(
-			make_key_ref(ctx->cred->session_keyring, 1), ctx);
+			make_key_ref(cred->session_keyring, 1), ctx);
 
 		if (!IS_ERR(key_ref))
 			goto found;
@@ -413,9 +416,9 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		}
 	}
 	/* or search the user-session keyring */
-	else if (ctx->cred->user->session_keyring) {
+	else if (READ_ONCE(cred->user->session_keyring)) {
 		key_ref = keyring_search_aux(
-			make_key_ref(ctx->cred->user->session_keyring, 1),
+			make_key_ref(READ_ONCE(cred->user->session_keyring), 1),
 			ctx);
 		if (!IS_ERR(key_ref))
 			goto found;
@@ -602,7 +605,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 				goto error;
 			goto reget_creds;
 		} else if (ctx.cred->session_keyring =
-			   ctx.cred->user->session_keyring &&
+			   READ_ONCE(ctx.cred->user->session_keyring) &&
 			   lflags & KEY_LOOKUP_CREATE) {
 			ret = join_session_keyring(NULL);
 			if (ret < 0)
@@ -616,7 +619,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		break;
 
 	case KEY_SPEC_USER_KEYRING:
-		if (!ctx.cred->user->uid_keyring) {
+		if (!READ_ONCE(ctx.cred->user->uid_keyring)) {
 			ret = install_user_keyrings();
 			if (ret < 0)
 				goto error;
@@ -628,7 +631,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		break;
 
 	case KEY_SPEC_USER_SESSION_KEYRING:
-		if (!ctx.cred->user->session_keyring) {
+		if (!READ_ONCE(ctx.cred->user->session_keyring)) {
 			ret = install_user_keyrings();
 			if (ret < 0)
 				goto error;
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index db72dc4d7639..75d87f9e0f49 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -293,11 +293,12 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 			/* fall through */
 		case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
 			dest_keyring -				key_get(cred->user->session_keyring);
+				key_get(READ_ONCE(cred->user->session_keyring));
 			break;
 
 		case KEY_REQKEY_DEFL_USER_KEYRING:
-			dest_keyring = key_get(cred->user->uid_keyring);
+			dest_keyring +				key_get(READ_ONCE(cred->user->uid_keyring));
 			break;
 
 		case KEY_REQKEY_DEFL_GROUP_KEYRING:
-- 
2.21.0.392.gf8f6787159e-goog
