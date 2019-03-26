From: Vitaly Chikunov <vt@altlinux.org>
Date: Tue, 26 Mar 2019 12:58:42 +0000
Subject: [PATCH v8 10/10] integrity: support EC-RDSA signatures for asymmetric_verify
Message-Id: <20190326125842.24110-11-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326125842.24110-1-vt@altlinux.org>
In-Reply-To: <20190326125842.24110-1-vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Allow to use EC-RDSA signatures for IMA by determining signature type by
the hash algorithm name. This works good for EC-RDSA since Streebog and
EC-RDSA should always be used together.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 security/integrity/digsig_asymmetric.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index d775e03fbbcc..99080871eb9f 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -104,9 +104,16 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 
 	memset(&pks, 0, sizeof(pks));
 
-	pks.pkey_algo = "rsa";
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-	pks.encoding = "pkcs1";
+	if (hdr->hash_algo = HASH_ALGO_STREEBOG_256 ||
+	    hdr->hash_algo = HASH_ALGO_STREEBOG_512) {
+		/* EC-RDSA and Streebog should go together. */
+		pks.pkey_algo = "ecrdsa";
+		pks.encoding = "raw";
+	} else {
+		pks.pkey_algo = "rsa";
+		pks.encoding = "pkcs1";
+	}
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
-- 
2.11.0
