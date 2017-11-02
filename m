From: Marcho <marcho.markov@gmail.com>
Date: Thu, 02 Nov 2017 22:05:07 +0000
Subject: [PATCH] KEYS: allow searching of user-session keyring if session keyring exists
Message-Id: <001f3865-e1ee-410f-07f2-e655c7f59ec9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

In search_my_process_keyrings(), if a session keyring exists, we will skip the search of a potential user-session keyring.
This is exhibited when using ecryptfs:

kernel: [   27.441621] Could not find key with description: [3bea61015ca4c0e2]
kernel: [   27.441653] process_request_key_err: No key
kernel: [   27.441653] Could not find valid key in user session keyring for sig specified in mount option: [3bea61015ca4c0e2]

$ keyctl show # session keyring exists
Session Keyring
   67329122 --alswrv   1000  1000  keyring: _ses
   83033473 ----s-rv      0     0   \_ user: invocation_id

$ keyctl show @us #requested user-session key exists even though it is reported missing
Keyring
  765040937 --alswrv   1000 65534  keyring: _uid_ses.1000
  546860119 --alswrv   1000 65534   \_ keyring: _uid.1000
  213500744 --alswrv   1000  1000       \_ user: 3bea61015ca4c0e2

This allows ecryptfs to see the key it needs.

--- a/security/keys/process_keys.c	2017-11-02 22:28:29.247550207 +0100
+++ b/security/keys/process_keys.c	2017-11-02 22:29:58.707095600 +0100
@@ -412,8 +412,9 @@ key_ref_t search_my_process_keyrings(str
  			break;
  		}
  	}
-	/* or search the user-session keyring */
-	else if (ctx->cred->user->session_keyring) {
+
+	/* search the user-session keyring */
+	if (ctx->cred->user->session_keyring) {
  		key_ref = keyring_search_aux(
  			make_key_ref(ctx->cred->user->session_keyring, 1),
  			ctx);

