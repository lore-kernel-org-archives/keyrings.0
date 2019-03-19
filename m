From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Mar 2019 06:06:41 +0000
Subject: [PATCH 5/6] security/integrity/evm: Drop direct dependency on key_type_encrypted
Message-Id: <155297560193.2276575.1761562049509563946.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
To: keyrings@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, vishal.l.verma@intel.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org

Lookup the key type by name and protect evm from encrypted_keys.ko
module load failures.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: <linux-integrity@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 security/integrity/evm/evm_crypto.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index c37d08118af5..5c65c3aef427 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -354,10 +354,15 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 int evm_init_key(void)
 {
 	struct key *evm_key;
+	struct key_type *type;
 	struct encrypted_key_payload *ekp;
 	int rc;
 
-	evm_key = request_key(&key_type_encrypted, EVMKEY, NULL);
+	type = key_type_lookup("encrypted");
+	if (IS_ERR(type))
+		return PTR_ERR(type);
+
+	evm_key = request_key(type, EVMKEY, NULL);
 	if (IS_ERR(evm_key))
 		return -ENOENT;
 
@@ -372,3 +377,5 @@ int evm_init_key(void)
 	key_put(evm_key);
 	return rc;
 }
+
+MODULE_SOFTDEP("pre: encrypted_keys");
