From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 11 Nov 2019 19:33:01 +0000
Subject: [PATCH v5 08/10] IMA: Added a flag to determine whether IMA hook can process the key now or has to q
Message-Id: <20191111193303.12781-9-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Keys should be processed only if custom IMA policies have been
applied. Prior to that the keys should be queued for processing later.

This patch defines a flag namely ima_process_keys_for_measurement
to check if the key should be processed immediately or should be queued.

ima_policy_flag cannot be relied upon because ima_policy_flag will
be set to 0 when either IMA is not initialized or the IMA policy
itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 7d6603bfcc06..61c42d06a636 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -15,6 +15,8 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+bool ima_process_keys_for_measurement;
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1
