From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 29 May 2018 03:29:38 +0000
Subject: [RFC 00/10] KEYS: TPM 1.2 asymmetric key type
Message-Id: <20180529032949.30526-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Here's an RFC to provide access to the TPM-wrapped keys via keyctl
asymmetric key interface.  This RFC only provides pkey_query,
pkey_encrypt and pkey_decrypt operations.  sign and verify operations
should be simple, but I did not want to proceed with them until I sanity
checked that this is the right approach.

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
both encryption and decryption operations.

For operations where the public key is used, all operations are done in
software using the existing kernel crypto APIs.  For operations that
utilize the TPM protected private key, tpm_loadkey2 and tpm_unbind
operations are used.

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

Denis Kenzior (10):
  crypto: rsa-pkcs1pad: Allow hash to be optional
  KEYS: asym_tpm: add skeleton for asym_tpm
  KEYS: Add parser for TPM-based keys
  KEYS: asym_tpm: extract key size & public key
  KEYS: asym_tpm: Implement pkey_query
  KEYS: asym_tpm: Implement encryption operation
  KEYS: trusted: Expose common functionality
  KEYS: asym_tpm: Add loadkey2 and flushspecific
  KEYS: asym_tpm: Implement tpm_unbind
  KEYS: asym_tpm: Implement the encrypt operation

 crypto/asymmetric_keys/Kconfig      |  21 ++
 crypto/asymmetric_keys/Makefile     |  13 +
 crypto/asymmetric_keys/asym_tpm.c   | 666 ++++++++++++++++++++++++++++++++++++
 crypto/asymmetric_keys/tpm.asn1     |   5 +
 crypto/asymmetric_keys/tpm_parser.c | 104 ++++++
 crypto/rsa-pkcs1pad.c               |  59 +++-
 include/crypto/asym_tpm_subtype.h   |  19 +
 security/keys/trusted.c             |  12 +-
 security/keys/trusted.h             |  14 +-
 9 files changed, 890 insertions(+), 23 deletions(-)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 crypto/asymmetric_keys/tpm.asn1
 create mode 100644 crypto/asymmetric_keys/tpm_parser.c
 create mode 100644 include/crypto/asym_tpm_subtype.h

-- 
2.16.1

