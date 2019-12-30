From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 30 Dec 2019 17:38:01 +0000
Subject: [PATCH v4 8/9] security: keys: trusted: implement counter/timer policy
Message-Id: <20191230173802.8731-9-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

This is actually a generic policy allowing a range of comparisons
against any value set in the TPM Clock, which includes things like the
reset count, a monotonic millisecond count and the restart count.  The
most useful comparison is against the millisecond count for expiring
keys.  However, you have to remember that currently Linux doesn't try
to sync the epoch timer with the TPM, so the expiration is actually
measured in how long the TPM itself has been powered on ... the TPM
timer doesn't count while the system is powered down.  The millisecond
counter is a u64 quantity found at offset 8 in the timer structure,
and the <= comparision operand is 9, so a policy set to expire after the
TPM has been up for 100 seconds would look like

0000016d00000000000f424000080009

Where 0x16d is the counter timer policy code and 0xf4240 is 100 000 in
hex.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 29 +++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.c          | 19 +++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index b68d3eb73f00..53a6196c7df9 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -241,3 +241,32 @@ about the usage can be found in the file
 Another new format 'enc32' has been defined in order to support encrypted keys
 with payload size of 32 bytes. This will initially be used for nvdimm security
 but may expand to other usages that require 32 bytes payload.
+
+Appendix
+--------
+
+TPM 2.0 Policies
+----------------
+
+The current TPM supports PCR lock policies as documented above and
+CounterTimer policies which can be used to create expiring keys.  One
+caveat with expiring keys is that the TPM millisecond counter does not
+update while a system is powered off and Linux does not sync the TPM
+millisecond count with its internal clock, so the best you can expire
+in is in terms of how long any given TPM has been powered on.  (FIXME:
+Linux should simply update the millisecond clock to the current number
+of seconds past the epoch on boot).
+
+A CounterTimer policy is expressed in terms of length and offset
+against the TPM clock structure (TPMS_TIME_INFO), which looks like the
+packed structure::
+
+    struct tpms_time_info {
+            u64 uptime;       /* time in ms since last start or reset */
+	    u64 clock;        /* cumulative uptime in ms */
+	    u32 resetcount;   /* numer of times the TPM has been reset */
+	    u32 restartcount; /* number of times the TPM has been restarted */
+	    u8  safe          /* time was safely loaded from NVRam */
+    };
+
+The usual comparison for expiring keys is against clock, at offset 8.
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index 45fca829503b..3c7a8e6c84c8 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -336,6 +336,25 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 			tpm_buf_append(&buf, pols->policies[i],
 				       pols->len[i] - pols->hash_size);
 			break;
+		case TPM2_CC_POLICY_COUNTER_TIMER: {
+			/*
+			 * the format of this is the last two u16
+			 * quantities are the offset and operation
+			 * respectively.  The rest is operandB which
+			 * must be zero padded in a hash digest
+			 */
+			u16 opb_len = pols->len[i] - 4;
+
+			if (opb_len > pols->hash_size)
+				return -EINVAL;
+
+			tpm_buf_append_u16(&buf, opb_len);
+			tpm_buf_append(&buf, pols->policies[i], opb_len);
+			/* offset and operand*/
+			tpm_buf_append(&buf, pols->policies[i] + opb_len, 4);
+			failure = "Counter Timer";
+			break;
+		}
 		default:
 			failure = "unknown policy";
 			break;
-- 
2.16.4
