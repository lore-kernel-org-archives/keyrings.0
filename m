From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 27 Nov 2019 01:56:49 +0000
Subject: [PATCH v9 1/6] IMA: Check IMA policy flag
Message-Id: <20191127015654.3744-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
In-Reply-To: <20191127015654.3744-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Return immediately from process_buffer_measurement()
if the IMA policy flag is set to zero. Not doing this
can result in kernel panic when process_buffer_measurement()
is called before IMA is initialized (for instance, when
the IMA hook is called when a key is added to
the .builtin_trusted_keys keyring).

This change adds the check in process_buffer_measurement()
to return immediately if ima_policy_flag is set to zero.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..9b35db2fc777 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -655,6 +655,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
-- 
2.17.1
