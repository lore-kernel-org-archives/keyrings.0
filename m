From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Dec 2019 00:04:32 +0000
Subject: [PATCH v2 0/8] Fix TPM 2.0 trusted keys
Message-Id: <1575936272.31378.50.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

This fixes a wide array of problems with the current TPM 2.0
implementation of trusted keys.  Since policy based trusted keys never
worked in the current implementation, I've rewritten the policy
implementation to make it easier to use and so the trusted key handler
can understand what elements of a policy are failing and why.

Apart from fixing bugs like volatile object leakage, I've changed the
output format to use the standardised ASN.1 coding for TPM2 keys,
meaning they should interoperate with userspace TPM2 key
implementations.  Apart from interoperability, another advantage of the
existing key format is that it carries all parameters like parent and
hash with it and it is capable of carrying policy directives in a way
that mean they're tied permanently to the key (no having to try to
remember what the policy was and reconstruct it from userspace).  This
actually allows us to support the TPM 1.2 commands like pcrinfo easily
in 2.0.

The big problem with this patch is still that we can't yet combine
policy with authorization because that requires proper session
handling, but at least with this rewrite it becomes possible (whereas
it was never possible with the old external policy session code). 
Thus, when we have the TPM 2.0 security patch upstream, we'll be able
to use the session logic from that patch to imlement authorizations.

James

---

v2: Fix all the code review issues noticed by David Woodhouse and redo
    the ASN.1 encoder API to allow in-place encoding for short tags
    and sequences


James Bottomley (8):
  security: keys: trusted: flush the key handle after use
  lib: add asn.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: use ASN.1 tpm2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy

 Documentation/security/keys/trusted-encrypted.rst |  70 +++-
 drivers/char/tpm/tpm.h                            |   1 -
 drivers/char/tpm/tpm2-cmd.c                       |   1 +
 include/keys/trusted-type.h                       |   6 +-
 include/linux/asn1_encoder.h                      |  21 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 258 ++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 405 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  40 +--
 security/keys/trusted-keys/trusted_tpm2.c         | 307 ++++++++++++++--
 16 files changed, 1124 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4
