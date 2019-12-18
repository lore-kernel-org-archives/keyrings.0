From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 18 Dec 2019 06:31:33 +0000
Subject: [PATCH v3 0/9] TPM 2.0 trusted keys with attached policy
Message-Id: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

Since the last respin, I've sent the bug fixes separately, since they
were an artifact of the prior code motion rather than zero day bugs in
the code and redone the series to keep the existing external policy
register setting.  This API is still problematic because it doesn't
scale very well and doesn't interoperate with the in-kernel resource
manager, but it can be made to work.

I've changed the output format to use the standardised ASN.1 coding
for TPM2 keys, meaning they should interoperate with userspace TPM2
key implementations.  Apart from interoperability, another advantage
of the existing key format is that it carries all parameters like
parent and hash with it and it is capable of carrying policy
directives in a way that mean they're tied permanently to the key (no
having to try to remember what the policy was and reconstruct it from
userspace).  This actually allows us to support the TPM 1.2 commands
like pcrinfo easily in 2.0.

Using the TPM2_PolicyPassword trick, this series now combines
authorization with policy in a flexible way that would allow us to
move to HMAC based authorizations later for TPM security.  In getting
passwords to work, I fixed the tpm2 password format in a separate
patch.  TPM 1.2 only allows fixed length authorizations, but TPM 2.0
allows for variable length passphrases, so we should support that in
the keys.

The ASN.1 encoder has been completely reworked to track the lengths of
all the buffers passing through it and to return an error if we run
out of space.

---

James Bottomley (9):
  lib: add asn.1 encoder
  oid_registry: Add TCG defined OIDS for TPM keys
  security: keys: trusted: use ASN.1 tpm2 key format for the blobs
  security: keys: trusted: Make sealed key properly interoperable
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy
  security: keys: trusted fix tpm2 authorizations
  security: keys: trusted: add password based authorizations to policy
    keys

 Documentation/security/keys/trusted-encrypted.rst |  64 +++-
 include/keys/trusted-type.h                       |   7 +-
 include/linux/asn1_encoder.h                      |  24 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   8 +
 lib/Makefile                                      |   2 +-
 lib/asn1_encoder.c                                | 367 +++++++++++++++++++
 security/keys/Kconfig                             |   2 +
 security/keys/trusted-keys/Makefile               |   2 +-
 security/keys/trusted-keys/tpm2-policy.c          | 420 ++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  31 ++
 security/keys/trusted-keys/tpm2key.asn1           |  23 ++
 security/keys/trusted-keys/trusted_tpm1.c         |  46 ++-
 security/keys/trusted-keys/trusted_tpm2.c         | 358 ++++++++++++++++--
 14 files changed, 1325 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.16.4
