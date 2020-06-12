From: Frank Werner-Krippendorf <mail@hb9fxq.ch>
Date: Fri, 12 Jun 2020 20:34:58 +0000
Subject: [PATCH] dh key: Missing a blank line after declarations
Message-Id: <20200612203458.13517-1-mail@hb9fxq.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Werner-Krippendorf <mail@hb9fxq.ch>

This patch fixes a "WARNING: Missing a blank line after declarations" issue found by checkpatch.pl

Signed-off-by: Frank Werner-Krippendorf <mail@hb9fxq.ch>
---
 security/keys/dh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index c4c629bb1c03..5515f51e62db 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -161,6 +161,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		if (zlen && h) {
 			u8 tmpbuffer[32];
 			size_t chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
+
 			memset(tmpbuffer, 0, chunk);
 
 			do {
-- 
2.20.1
