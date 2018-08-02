From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 02 Aug 2018 18:31:08 +0000
Subject: [RFCv3 00/13] KEYS: TPM 1.2 asymmetric key type
Message-Id: <20180802183121.22909-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Here's an RFC to provide access to the TPM-wrapped keys via keyctl
asymmetric key interface.  This RFC is essentially feature complete,
providing encrypt, decrypt, verify and sign operations.  The only
missing bits are a way to provide SRK authorization data if it is not
well known.  This requires changes to the underlying keyctl interface
and is out of scope for this RFC.

These patches depend on asymmetric key patches from David Howells, which
can be found here:
	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-asym-keyctl

And the needed keyutils patches:
	http://git.kernel.org/cgit/linux/kernel/git/dhowells/keyutils.git/log/?h=pkey

A simple parser for DER-encoded TPM keys is added so that userspace
applications can load the key directly into the kernel.  The outer PEM
formatting (if any) must be stripped out by userspace.  For more details
on the format, please see patch 3/10.

Since the loaded key blob contains both the public key portion and the
(encrypted) private key portion of the key, it is possible to perform
operations with both the private and public portion of the key.

For operations where the public key is used, all operations are done in
software using the existing kernel crypto APIs.  For operations that
utilize the TPM protected private key, tpm_loadkey2, tpm_unbind and
tpm_sign operations are used.

Example usage:
	# Generate Private Key
	openssl genrsa -out /tmp/privkey.pem 2048
	# Wrap the key with the TPM
	create_tpm_key -s 2048 -w /tmp/privkey.pem /tmp/privkey.tpm
	# Strip PEM
	openssl asn1parse -inform pem -in /tmp/privkey.tpm -noout -out \
	    /tmp/privkey.der
	# Load the TPM key into the kernel
	tpm_serial=`cat /tmp/privkey.der | keyctl padd asymmetric tpm @u`
	echo -n abcdefghijklmnopqrst >/tmp/data
	keyctl pkey_encrypt $tpm_serial 0 /tmp/data enc=pkcs1 > /tmp/enc
	keyctl pkey_decrypt $tpm_serial 0 /tmp/enc enc=pkcs1 > /tmp/dec
	cmp /tmp/data /tmp/dec

	# Sign with the TPM key
	keyctl pkey_sign $tpm_serial 0 /tmp/data enc=pkcs1 \
		hash=sha1 > /tmp/sig
	# Sign with OpenSSL
	openssl dgst -sha1 -sign /tmp/privkey.pem -out /tmp/sig.ref /tmp/data
	cmp /tmp/sig.ref /tmp/sig

	# SHA1-hash the data
	openssl dgst -sha1 -binary -out /tmp/data.sha1 /tmp/data
	keyctl pkey_verify $tpm_serial 0 /tmp/data.sha1 /tmp/sig \
		enc=pkcs1 hash=sha1

ChangeLog

v3

- Rebased on top of David's linux-fs/keys-asym-keyctl tree.  The
  previous patches were on top of a virgin 4.17 tree with David's
  patches applied.
- Moved a chunk touching struct tpm_key from patch 5 to patch 4.  The
  series now compiles cleanly when each patch is applied individually
  and in order.
- No functional changes

v2

- Cleanup some pr_infos
- Cleanup some error paths to be more pedantic
- Added verify operation
- Added TPM_Sign operation
- Added helpers to perform hashing of input
- Added sign operation


Denis Kenzior (13):
  crypto: rsa-pkcs1pad: Allow hash to be optional
  KEYS: asym_tpm: add skeleton for asym_tpm
  KEYS: Add parser for TPM-based keys
  KEYS: asym_tpm: extract key size & public key
  KEYS: asym_tpm: Implement pkey_query
  KEYS: asym_tpm: Implement encryption operation
  KEYS: trusted: Expose common functionality
  KEYS: asym_tpm: Add loadkey2 and flushspecific
  KEYS: asym_tpm: Implement tpm_unbind
  KEYS: asym_tpm: Implement the decrypt operation
  KEYS: asym_tpm: Implement signature verification
  KEYS: asym_tpm: Implement tpm_sign
  KEYS: asym_tpm: Add support for the sign operation

 crypto/asymmetric_keys/Kconfig      |   21 +
 crypto/asymmetric_keys/Makefile     |   12 +
 crypto/asymmetric_keys/asym_tpm.c   | 1019 +++++++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/tpm.asn1     |    5 +
 crypto/asymmetric_keys/tpm_parser.c |  104 ++++
 crypto/rsa-pkcs1pad.c               |   59 +-
 include/crypto/asym_tpm_subtype.h   |   19 +
 security/keys/trusted.c             |   12 +-
 security/keys/trusted.h             |   14 +-
 9 files changed, 1242 insertions(+), 23 deletions(-)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c
 create mode 100644 include/crypto/asym_tpm_subtype.h

-- 
2.16.1

