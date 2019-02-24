From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 24 Feb 2019 06:08:18 +0000
Subject: [PATCH v5 00/10] crypto: add EC-RDSA (GOST 34.10) algorithm
Message-Id: <20190224060828.2527-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

This patchset changes akcipher API to support ECDSA style signature
verification, augments x509 parser to make it work with EC-RDSA certificates,
and, finally, implements EC-RDSA (GOST 34.10) signature verification and its
integration with IMA.

Changes since RFC (v1-v4):
- akcipher set_max_size, encrypt, decrypt, sign, verify callbacks may be
  undefined by the drivers, so their crypto_akcipher_* frontends check for
  their presence before passing the call.
- supported_ops flags are set for keyctl, based on the presence of implemented
  akcipher callbacks.
- Transition to verify2 API is abandoned because raw RSA does not need
  sign/verify ops at all, and we can switch to the new verify in one step.
  For this RSA backends have sign/verify ops removed as they should only
  be used (and actually used only) via PKCS1 driver.
- Verify callback requires digest as the input parameter in src SGL, as
  suggested by Herbert Xu, (instead of a separate parameter, as it was in
  verify2).
- For verify op signature is moved into kmalloc'd memory as suggested by
  Herbert Xu.
- set_params API should be called before set_{pub,priv}_key, thus set_*_key
  knows everything it needs to set they key properly. Also, set_params made
  optional for back compatibility with RSA drivers.
- Public-key cryptography section is created in Kconfig.
- ecc.c is made into separate module object, to be used together by ECDH and
  EC-RDSA.
- EC-RDSA parameters and public key are parsed using asn1_ber_decoder as
  suggested by Stephan Mueller and David Howells.
- Test vectors are added and tests are passing.
- Curves/parameters definitions are split from ecrdsa.c into ecrdsa_defs.h.
- Integration with IMA in asymmetric_verify(). Userspace ima-evm-utils already
  have a patch in the queue to support this. Tested on x86_64.

---
Vitaly Chikunov (10):
  KEYS: report to keyctl only actually supported key ops
  crypto: akcipher - check the presence of callback before the call
  crypto: rsa - unimplement sign/verify for raw RSA backends
  crypto: akcipher - new verify API for public key algorithms
  X.509: parse public key parameters from x509 for akcipher
  crypto: Kconfig - create Public-key cryptography section
  crypto: ecc - make ecc into separate module
  crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm
  crypto: ecrdsa - add EC-RDSA test vectors to testmgr
  integrity: support EC-RDSA signatures for asymmetric_verify

 crypto/Kconfig                                |  63 ++--
 crypto/Makefile                               |  10 +-
 crypto/asymmetric_keys/asym_tpm.c             |  34 +--
 crypto/asymmetric_keys/public_key.c           |  63 ++--
 crypto/asymmetric_keys/x509.asn1              |   2 +-
 crypto/asymmetric_keys/x509_cert_parser.c     |  57 +++-
 crypto/ecc.c                                  | 417 +++++++++++++++++++++++++-
 crypto/ecc.h                                  | 153 +++++++++-
 crypto/ecc_curve_defs.h                       |  15 -
 crypto/ecrdsa.c                               | 297 ++++++++++++++++++
 crypto/ecrdsa_defs.h                          | 225 ++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  33 +-
 crypto/rsa.c                                  | 109 -------
 crypto/testmgr.c                              |  60 ++--
 crypto/testmgr.h                              | 157 ++++++++++
 drivers/crypto/caam/caampkc.c                 |   2 -
 drivers/crypto/ccp/ccp-crypto-rsa.c           |   2 -
 drivers/crypto/qat/qat_common/qat_asym_algs.c |   2 -
 include/crypto/akcipher.h                     |  97 ++++--
 include/crypto/public_key.h                   |   4 +
 include/linux/oid_registry.h                  |  18 ++
 security/integrity/digsig_asymmetric.c        |   9 +-
 22 files changed, 1545 insertions(+), 284 deletions(-)
 create mode 100644 crypto/ecrdsa.c
 create mode 100644 crypto/ecrdsa_defs.h

-- 
2.11.0
