From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Sun, 20 Sep 2020 16:20:58 +0000
Subject: [PATCH v7 05/10] crypto: testmgr - support test with different ciphertext per encryption
Message-Id: <20200920162103.83197-6-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@google.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephan Mueller <smueller@chronox.de>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Colin Ian King <colin.king@canonical.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Vitaly Chikunov <vt@altlinux.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Jia Zhang <zhang.jia@linux.alibaba.com>

Some asymmetric algorithms will get different ciphertext after
each encryption, such as SM2, and let testmgr support the testing
of such algorithms.

In struct akcipher_testvec, set c and c_size to be empty, skip
the comparison of the ciphertext, and compare the decrypted
plaintext with m to achieve the test purpose.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
---
 crypto/testmgr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 23c27fc96394..cd002a030af5 100644
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
2.19.1.3.ge56e4f7
