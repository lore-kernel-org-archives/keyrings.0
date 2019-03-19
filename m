From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Mar 2019 06:06:20 +0000
Subject: [PATCH 1/6] security/keys/encrypted: Allow operation without trusted.ko
Message-Id: <155297558061.2276575.9485856950730059730.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
To: keyrings@vger.kernel.org
Cc: linux-nvdimm@lists.01.org, James Bottomley <jejb@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

The trusted.ko module may fail to load. In the common case this failure
is simply due to the platform missing a TPM. Teach the encrypted_keys
implementation to lookup the key type by name rather than having a
module dependency.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Suggested-by: James Bottomley <jejb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 security/keys/encrypted-keys/masterkey_trusted.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index dc3d18cae642..7560aea6438d 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -19,6 +19,7 @@
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
 #include "encrypted.h"
+#include "../internal.h"
 
 /*
  * request_trusted_key - request the trusted key
@@ -31,9 +32,15 @@ struct key *request_trusted_key(const char *trusted_desc,
 				const u8 **master_key, size_t *master_keylen)
 {
 	struct trusted_key_payload *tpayload;
+	struct key_type *type;
 	struct key *tkey;
 
-	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
+	type = key_type_lookup("trusted");
+	if (IS_ERR(type)) {
+		tkey = (struct key *)type;
+		goto error;
+	}
+	tkey = request_key(type, trusted_desc, NULL);
 	if (IS_ERR(tkey))
 		goto error;
 
@@ -44,3 +51,5 @@ struct key *request_trusted_key(const char *trusted_desc,
 error:
 	return tkey;
 }
+
+MODULE_SOFTDEP("pre: trusted");
