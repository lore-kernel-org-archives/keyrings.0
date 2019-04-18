From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 18 Apr 2019 14:25:05 +0000
Subject: Re: [PATCH v9 00/10] crypto: add EC-RDSA (GOST 34.10) algorithm
Message-Id: <20190418142505.tkd4bgf76imzuu3g@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190411155122.13245-1-vt@altlinux.org>
In-Reply-To: <20190411155122.13245-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:51:12PM +0300, Vitaly Chikunov wrote:
>
> Vitaly Chikunov (10):
>   crypto: akcipher - default implementations for request callbacks
>   crypto: rsa - unimplement sign/verify for raw RSA backends
>   crypto: akcipher - new verify API for public key algorithms
>   KEYS: do not kmemdup digest in {public,tpm}_key_verify_signature
>   X.509: parse public key parameters from x509 for akcipher
>   crypto: Kconfig - create Public-key cryptography section
>   crypto: ecc - make ecc into separate module
>   crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm
>   crypto: ecrdsa - add EC-RDSA test vectors to testmgr
>   integrity: support EC-RDSA signatures for asymmetric_verify
> 
>  crypto/Kconfig                                |  63 ++--
>  crypto/Makefile                               |  10 +-
>  crypto/akcipher.c                             |  14 +
>  crypto/asymmetric_keys/asym_tpm.c             |  43 +--
>  crypto/asymmetric_keys/public_key.c           | 105 ++++---
>  crypto/asymmetric_keys/x509.asn1              |   2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c     |  57 +++-
>  crypto/ecc.c                                  | 417 +++++++++++++++++++++++++-
>  crypto/ecc.h                                  | 153 +++++++++-
>  crypto/ecc_curve_defs.h                       |  15 -
>  crypto/ecrdsa.c                               | 296 ++++++++++++++++++
>  crypto/ecrdsa_defs.h                          | 225 ++++++++++++++
>  crypto/ecrdsa_params.asn1                     |   4 +
>  crypto/ecrdsa_pub_key.asn1                    |   1 +
>  crypto/rsa-pkcs1pad.c                         |  33 +-
>  crypto/rsa.c                                  | 109 -------
>  crypto/testmgr.c                              |  80 +++--
>  crypto/testmgr.h                              | 159 ++++++++++
>  drivers/crypto/caam/caampkc.c                 |   2 -
>  drivers/crypto/ccp/ccp-crypto-rsa.c           |   2 -
>  drivers/crypto/qat/qat_common/qat_asym_algs.c |   2 -
>  include/crypto/akcipher.h                     |  54 ++--
>  include/crypto/public_key.h                   |   4 +
>  include/linux/oid_registry.h                  |  18 ++
>  security/integrity/digsig_asymmetric.c        |  11 +-
>  25 files changed, 1574 insertions(+), 305 deletions(-)
>  create mode 100644 crypto/ecrdsa.c
>  create mode 100644 crypto/ecrdsa_defs.h
>  create mode 100644 crypto/ecrdsa_params.asn1
>  create mode 100644 crypto/ecrdsa_pub_key.asn1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
