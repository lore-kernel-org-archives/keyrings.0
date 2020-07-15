From: David Howells <dhowells@redhat.com>
Date: Wed, 15 Jul 2020 22:28:38 +0000
Subject: [PATCH] keys: asymmetric: fix error return code in software_key_query()
Message-Id: <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200622112136.72745-1-weiyongjun1@huawei.com>
In-Reply-To: <20200622112136.72745-1-weiyongjun1@huawei.com>
To: torvalds@linux-foundation.org
Cc: Wei Yongjun <weiyongjun1@huawei.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return negative error code -ENOMEM from kmalloc() error handling
case instead of 0, as done elsewhere in this function.

Fixes: f1774cb8956a ("X.509: parse public key parameters from x509 for akcipher")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/public_key.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d7f43d4ea925..e5fae4e838c0 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -119,6 +119,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
+	ret = -ENOMEM;
 	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
 		      GFP_KERNEL);
 	if (!key)
