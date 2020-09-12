From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 12 Sep 2020 17:31:34 +0000
Subject: [PATCH v11 0/3] Trusted Key policy for TPM 2.0
Message-Id: <20200912173137.9519-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

This is a lockstep patch with the prior trusted key rework patch.  Now
the key format is ASN.1, the policy statements needed to unseal the
key can be coded into the key file itself meaning the kernel can now
construct and use the policy session necessary rather than the user
having to do it.  This makes using TPM 2.0 keys with policy much easier.

The current implementation only has a limited subset of the full TPM
2.0 policy commands, but it is enough to implement keys locked to PCR
values and expiring keys.  The main missing feature is support for the
TPM2_PolicyOR statement, which means all current policy has to be AND
chains (key doesn't unlock unless every policy statement succeeds).

James

---

James Bottomley (3):
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 .../security/keys/trusted-encrypted.rst       |  83 +++-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |   6 +
 security/keys/Kconfig                         |   2 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2-policy.c      | 463 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  31 ++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_tpm1.c     |  23 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 120 ++++-
 10 files changed, 733 insertions(+), 15 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

-- 
2.26.2
