From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 14 Jan 2019 20:17:24 +0000
Subject: [PATCH 2/3] security: keys: annotate implicit fall throughs
Message-Id: <20190114201725.13289-2-malat@debian.org>
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

This commit remove the following warning:

  security/keys/process_keys.c:380:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/process_keys.c:404:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  security/keys/process_keys.c:424:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/process_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 02c77e928f68..3308d738734c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -379,6 +379,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
@@ -403,6 +404,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
@@ -423,6 +425,7 @@ key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx)
 		case -EAGAIN: /* no key */
 			if (ret)
 				break;
+			/* fall through */
 		case -ENOKEY: /* negative key */
 			ret = key_ref;
 			break;
-- 
2.19.2
