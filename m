From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 14 Jan 2019 20:17:25 +0000
Subject: [PATCH 3/3] security: keys: annotate implicit fall throughs
Message-Id: <20190114201725.13289-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190114201725.13289-1-malat@debian.org>
In-Reply-To: <20190114201725.13289-1-malat@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  security/keys/request_key.c:293:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/request_key.c:298:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/request_key.c:307:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/request_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 301f0e300dbd..af8816ffb6ce 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -287,16 +287,19 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 				}
 			}
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_THREAD_KEYRING:
 			dest_keyring = key_get(cred->thread_keyring);
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_PROCESS_KEYRING:
 			dest_keyring = key_get(cred->process_keyring);
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_SESSION_KEYRING:
 			rcu_read_lock();
 			dest_keyring = key_get(
@@ -306,6 +309,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 			if (dest_keyring)
 				break;
 
+			/* fall through */
 		case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
 			dest_keyring  				key_get(cred->user->session_keyring);
-- 
2.19.2
