From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sun, 20 Sep 2020 16:33:46 +0000
Subject: [PATCH v12 0/5] TPM 2.0 trusted key rework
Message-Id: <20200920163351.11293-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

Update to fix blobauth parsing problem.

General cover letter minus policy bit:

This patch updates the trusted key code to export keys in the ASN.1
format used by current TPM key tools (openssl_tpm2_engine and
openconnect).  The current code will try to load keys containing
policy, but being unable to formulate the policy commands necessary to
load them, the unseal will always fail unless the policy is executed
in user space and a pre-formed policy session passed in.

The key format is designed to be compatible with our two openssl
engine implementations as well as with the format used by openconnect.
I've added seal/unseal to my engine so I can use it for
interoperability testing and I'll later use this for sealed symmetric
keys via engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

James

---

James Bottomley (5):
  lib: add ASN.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: fix TPM2 authorizations
  security: keys: trusted: use ASN.1 TPM2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable

 .../security/keys/trusted-encrypted.rst       |  58 +++
 include/keys/trusted-type.h                   |   2 +
 include/linux/asn1_encoder.h                  |  32 ++
 include/linux/oid_registry.h                  |   5 +
 include/linux/tpm.h                           |   2 +
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   1 +
 lib/asn1_encoder.c                            | 454 ++++++++++++++++++
 security/keys/Kconfig                         |   1 +
 security/keys/trusted-keys/Makefile           |   2 +-
 security/keys/trusted-keys/tpm2key.asn1       |  11 +
 security/keys/trusted-keys/trusted_tpm1.c     |  34 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 266 +++++++++-
 13 files changed, 840 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.26.2
