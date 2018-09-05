From: David Howells <dhowells@redhat.com>
Date: Wed, 05 Sep 2018 21:54:17 +0000
Subject: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org


Hi James,

Here's a set of patches that does the following, if you could pull it please:

 (1) Adds keyctl() functions that permit an asymmetric-type key to be used
     to encrypt, decrypt, sign and verify a small piece of data (typically
     a session key or a hash) using the public and/or private key held in
     the kernel.  A query function is also provided.

 (2) Adds an asymmetric-key parser for PKCS#8 to allow RSA private keys to
     be passed to the kernel.  Currently only DER-encoded and unencrypted
     PKCS#8 is supported.

 (3) Adds an asymmetric-key parser for TPM-wrapped key blobs.  The parser
     gets the TPM to unpack the blob and then attaches it to a key from
     which it can be used.  Currently only TPM-1.2 is supported.

Example usage for a PKCS#8 blob:

	j=`openssl pkcs8 -in private_key.pem -topk8 -nocrypt -outform DER | \
	    keyctl padd asymmetric foo @s`

Example usage for a TPM wrapped blob:

	openssl genrsa -out /tmp/privkey.foo.pem 2048
	create_tpm_key -s 2048 -w /tmp/privkey.foo.pem /tmp/privkey.foo.tpm
	j=`openssl asn1parse -inform pem -in /tmp/privkey.foo.tpm -noout |
	    keyctl padd asymmetric foo @s`

See http://david.woodhou.se/draft-woodhouse-cert-best-practice.html#rfc.section.4.4

These keys can then be used thusly:

	echo -n abcdefghijklmnopqrst >/tmp/data
	keyctl pkey_encrypt $j /tmp/data enc=pkcs1 >/tmp/enc
	keyctl pkey_decrypt $j /tmp/enc enc=pkcs1 >/tmp/dec
	cmp /tmp/data /tmp/dec
	keyctl pkey_sign $j /tmp/data enc=pkcs1 hash=sha1 >/tmp/sig
	keyctl pkey_verify $j /tmp/data /tmp/sig enc=pkcs1 hash=sha1


The kernel patches can be found tagged here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-asym-keyctl-20180905

and also on a branch here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-asym-keyctl

The keyutils changes needed can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/keyutils.git/log/?h=next

David
---
David Howells (8):
      KEYS: Provide key type operations for asymmetric key ops
      KEYS: Provide keyctls to drive the new key type ops for asymmetric keys
      KEYS: Provide missing asymmetric key subops for new key type ops
      KEYS: Make the X.509 and PKCS7 parsers supply the sig encoding type
      KEYS: Provide software public key query function
      KEYS: Allow the public_key struct to hold a private key
      KEYS: Implement encrypt, decrypt and sign for software asymmetric key
      KEYS: Implement PKCS#8 RSA Private Key parser

Denis Kenzior (14):
      crypto: rsa-pkcs1pad: Allow hash to be optional
      KEYS: asym_tpm: add skeleton for asym_tpm
      KEYS: asym_tpm: extract key size & public key
      KEYS: Add parser for TPM-based keys
      KEYS: asym_tpm: Implement pkey_query
      KEYS: asym_tpm: Implement encryption operation
      KEYS: trusted: Expose common functionality
      KEYS: Move trusted.h to include/keys
      KEYS: asym_tpm: Add loadkey2 and flushspecific
      KEYS: asym_tpm: Implement tpm_unbind
      KEYS: asym_tpm: Implement the decrypt operation
      KEYS: asym_tpm: Implement signature verification
      KEYS: asym_tpm: Implement tpm_sign
      KEYS: asym_tpm: Add support for the sign operation


 Documentation/crypto/asymmetric-keys.txt  |   26 +
 Documentation/security/keys/core.rst      |  217 ++++++
 crypto/asymmetric_keys/Kconfig            |   31 +
 crypto/asymmetric_keys/Makefile           |   25 +
 crypto/asymmetric_keys/asym_tpm.c         |  988 +++++++++++++++++++++++++++++
 crypto/asymmetric_keys/asymmetric_keys.h  |    3 
 crypto/asymmetric_keys/asymmetric_type.c  |   43 +
 crypto/asymmetric_keys/pkcs7_parser.c     |    1 
 crypto/asymmetric_keys/pkcs8.asn1         |   24 +
 crypto/asymmetric_keys/pkcs8_parser.c     |  184 +++++
 crypto/asymmetric_keys/public_key.c       |  191 +++++-
 crypto/asymmetric_keys/signature.c        |   95 +++
 crypto/asymmetric_keys/tpm.asn1           |    5 
 crypto/asymmetric_keys/tpm_parser.c       |  102 +++
 crypto/asymmetric_keys/x509_cert_parser.c |   21 -
 crypto/rsa-pkcs1pad.c                     |   59 +-
 include/crypto/asym_tpm_subtype.h         |   19 +
 include/crypto/public_key.h               |   14 
 include/keys/asymmetric-subtype.h         |    9 
 include/keys/trusted.h                    |  136 ++++
 include/linux/key-type.h                  |   11 
 include/linux/keyctl.h                    |   46 +
 include/uapi/linux/keyctl.h               |   30 +
 security/keys/Makefile                    |    1 
 security/keys/compat.c                    |   18 +
 security/keys/internal.h                  |   39 +
 security/keys/keyctl.c                    |   24 +
 security/keys/keyctl_pkey.c               |  323 +++++++++
 security/keys/trusted.c                   |   14 
 security/keys/trusted.h                   |  124 ----
 30 files changed, 2639 insertions(+), 184 deletions(-)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 crypto/asymmetric_keys/pkcs8.asn1
 create mode 100644 crypto/asymmetric_keys/pkcs8_parser.c
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c
 create mode 100644 include/crypto/asym_tpm_subtype.h
 create mode 100644 include/keys/trusted.h
 create mode 100644 include/linux/keyctl.h
 create mode 100644 security/keys/keyctl_pkey.c
 delete mode 100644 security/keys/trusted.h
