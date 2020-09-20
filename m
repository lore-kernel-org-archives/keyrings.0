From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Sun, 20 Sep 2020 16:20:59 +0000
Subject: [PATCH v7 06/10] crypto: testmgr - Fix potential memory leak in test_akcipher_one()
Message-Id: <20200920162103.83197-7-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@google.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephan Mueller <smueller@chronox.de>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Waiman Long <longman@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Colin Ian King <colin.king@canonical.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Vitaly Chikunov <vt@altlinux.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Pascal van Leeuwen <pvanleeuwen@rambus.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Jia Zhang <zhang.jia@linux.alibaba.com>

When the 'key' allocation fails, the 'req' will not be released,
which will cause memory leakage on this path. This patch adds a
'free_req' tag used to solve this problem, and two new err values
are added to reflect the real reason of the error.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index cd002a030af5..ed8e29efe280 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -3954,7 +3954,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	key = kmalloc(vecs->key_len + sizeof(u32) * 2 + vecs->param_len,
 		      GFP_KERNEL);
 	if (!key)
-		goto free_xbuf;
+		goto free_req;
 	memcpy(key, vecs->key, vecs->key_len);
 	ptr = key + vecs->key_len;
 	ptr = test_pack_u32(ptr, vecs->algo);
@@ -3966,7 +3966,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	else
 		err = crypto_akcipher_set_priv_key(tfm, key, vecs->key_len);
 	if (err)
-		goto free_req;
+		goto free_key;
 
 	/*
 	 * First run test which do not require a private key, such as
@@ -3976,7 +3976,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	out_len_max = crypto_akcipher_maxsize(tfm);
 	outbuf_enc = kzalloc(out_len_max, GFP_KERNEL);
 	if (!outbuf_enc)
-		goto free_req;
+		goto free_key;
 
 	if (!vecs->siggen_sigver_test) {
 		m = vecs->m;
@@ -3995,6 +3995,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		op = "verify";
 	}
 
+	err = -E2BIG;
 	if (WARN_ON(m_size > PAGE_SIZE))
 		goto free_all;
 	memcpy(xbuf[0], m, m_size);
@@ -4061,6 +4062,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		c_size = req->dst_len;
 	}
 
+	err = -E2BIG;
 	op = vecs->siggen_sigver_test ? "sign" : "decrypt";
 	if (WARN_ON(c_size > PAGE_SIZE))
 		goto free_all;
@@ -4097,9 +4099,10 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 free_all:
 	kfree(outbuf_dec);
 	kfree(outbuf_enc);
+free_key:
+	kfree(key);
 free_req:
 	akcipher_request_free(req);
-	kfree(key);
 free_xbuf:
 	testmgr_free_buf(xbuf);
 	return err;
-- 
2.19.1.3.ge56e4f7
