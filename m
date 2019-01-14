From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 14 Jan 2019 20:17:23 +0000
Subject: [PATCH 1/3] security: keys: annotate implicit fall through
Message-Id: <20190114201725.13289-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  security/keys/keyring.c:248:10: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 security/keys/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index eadebb92986a..b1ff07d9ce37 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -246,6 +246,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 				    (ASSOC_ARRAY_KEY_CHUNK_SIZE - 8));
 		n--;
 		offset = 1;
+		/* fall through */
 	default:
 		offset += sizeof(chunk) - 1;
 		offset += (level - 3) * sizeof(chunk);
-- 
2.19.2
