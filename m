From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Tue, 09 Jun 2020 13:48:52 +0000
Subject: [PATCH v3 5/8] crypto: testmgr - support test with different ciphertext per encryption
Message-Id: <20200609134855.21431-6-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200609134855.21431-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200609134855.21431-1-tianjia.zhang@linux.alibaba.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, dhowells@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com, nramas@linux.microsoft.com, tusharsu@linux.microsoft.com, zohar@linux.ibm.com, gilad@benyossef.com, pvanleeuwen@rambus.com
Cc: tianjia.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, zhang.jia@linux.alibaba.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org

Some asymmetric algorithms will get different ciphertext after
each encryption, such as SM2, and let testmgr support the testing
of such algorithms.

In struct akcipher_testvec, set c and c_size to be empty, skip
the comparison of the ciphertext, and compare the decrypted
plaintext with m to achieve the test purpose.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6863f911fcee..0dc94461c437 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4025,7 +4025,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		pr_err("alg: akcipher: %s test failed. err %d\n", op, err);
 		goto free_all;
 	}
-	if (!vecs->siggen_sigver_test) {
+	if (!vecs->siggen_sigver_test && c) {
 		if (req->dst_len != c_size) {
 			pr_err("alg: akcipher: %s test failed. Invalid output len\n",
 			       op);
@@ -4056,6 +4056,11 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		goto free_all;
 	}
 
+	if (!vecs->siggen_sigver_test && !c) {
+		c = outbuf_enc;
+		c_size = req->dst_len;
+	}
+
 	op = vecs->siggen_sigver_test ? "sign" : "decrypt";
 	if (WARN_ON(c_size > PAGE_SIZE))
 		goto free_all;
-- 
2.17.1
