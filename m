From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Date: Tue, 17 Dec 2019 11:09:39 +0000
Subject: [PATCH] KEYS: trusted: fix type warnings in ntohl/nthos
Message-Id: <20191217110939.2067979-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: ben.dooks@codethink.co.uk
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

The ntohl takes a __be32 and ntohs takes __be16, so cast to
those types before passing it to the byte swapping functions.

Note, would be32_to_cpu and be16_to_cpu be better here?

security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:201:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:202:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:202:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:202:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:202:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:289:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:290:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:290:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:290:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:290:15: warning: cast to restricted __be16
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:418:21: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:442:19: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:549:24: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:550:23: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:602:17: warning: incorrect type in assignment (different base types)
security/keys/trusted-keys/trusted_tpm1.c:602:17:    expected unsigned int [usertype] ordinal
security/keys/trusted-keys/trusted_tpm1.c:602:17:    got restricted __be32 [usertype]
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32
security/keys/trusted-keys/trusted_tpm1.c:638:20: warning: cast to restricted __be32

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/keys/trusted_tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index a56d8e1298f2..e080967931d2 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -12,9 +12,9 @@
 #define TPM_RETURN_OFFSET		6
 #define TPM_DATA_OFFSET			10
 
-#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
+#define LOAD32(buffer, offset)	(ntohl(*(__be32 *)&buffer[offset]))
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
-#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
+#define LOAD16(buffer, offset)	(ntohs(*(__be16 *)&buffer[offset]))
 
 struct osapsess {
 	uint32_t handle;
-- 
2.24.0
