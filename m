From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:26:47 +0000
Subject: [PATCH 00/17] Asymmetric key operations on TPM2
Message-Id: <20200518172704.29608-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-13"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This adds a TPM 2.0 key parser and asymmetric key type for access to
the TPM for encryption, decryption, sign, and verify using RSA private
keys. The majority of the work went into the tpm driver subsystem
piggy backing off some old, not-yet-upstreamed, patches from James
Bottomley. These can be found here, and they are attached in this
patch set:

https://lore.kernel.org/linux-crypto/1568031408.6613.29.camel@HansenPartner=
ship.com/

There is also a patch from James which may already be upstreamed which
adds some OID registry values for TPM keys. I have also copied over
the ASN.1 definition from the trusted key type in order to parse a
TPM key from asymmetric keys.

These patches have been rebased on top of 5.6, and I would urge
James to take a look at these and make sure I rebased them correctly.
(The folder structure of the TPM/trusted subsystem had since changed
in the kernel since these patches, so I did my best).

As far as the patches are concerned the majority of the functionality
happens in drivers/char/tpm/tpm2-cmd.c: tpm2_rsa_decrypt(). This takes
a parent handle, key blob, and data to be decrypted. Assuming the parent
exists and the key blob is valid the data will be decrypted using the
TPM. This API can also be used for signing by pre-padding the input data
with pkcs1, effectively turning a decrypt call into an encryption using
the private key.

The parser and asymmetric key type are relatively simple modules. The
key parser uses the ASN.1 definition described earlier to parse out
the public and private portions of the key. From here the TPM2
asymmetric key type extracts the pieces of the private and public
keys which the TPM needs to perform these operations. These are whats
referred to as the 'key blobs'.

This new asymmetric key type can be accessed using keyctl, and behaves
exactly the same as any other pkey operations. Below is how I have
been testing this functionality. It will require that you have the
proper tools installed to access the TPM (tss2/openssl_tpm2_engine).

# Starting from scratch, enable and clear TPM in BIOS

export TPM_INTERFACE_TYPE=DEv
export TPM_DEVICE=3D/dev/tpm0

# Create a primary key for wrapping the user private key
# and make it persistent.
tsscreateprimary -hi o -st -ecc
# This should return a handle, in my case 80000000
tssevictcontrol -hi o -ho 80000000 -hp 81000001
tssflushcontext -ha 80000000

# Create a private key if not already
openssl genrsa > privkey.pem

# Wrap private key using the TPM
create_tpm2_key -w privkey.pem -p 81000001 privkey.tpm
# The above commands only need to be done once. A Null primary
# key could be used instead which would not require the above steps
# but that kind of key does not persist across boots meaning you
# would need to create a new wrapped TPM key every boot.
# privkey.pem could now be deleted as the key has been wrapped
# by the TPM.

# If built as modules, load parser and asymmetric key type
modprobe tpm2_key_parser
modprobe asym_tpm2

# Now asymmetric keyctl operations can be performed using
# privkey.tpm. First it needs to be converted into DER for
# keyctl
openssl asn1parse -inform pem -in privkey.tpm -noout -out privkey.tpm.der

# Add key to the kernel
serial=3D`cat privkey.tpm.der | keyctl padd asymmetric tpm @u`

# Create some data do be encrypted/signed
echo "abcdefg" > plaintext.txt

# Encrypt plaintext.txt
keyctl pkey_encrypt $serial 0 plaintext.txt enc=3Dpkcs1 > encrypted.dat

# Decrypt encrypted data
keyctl pkey_decrypt $serial 0 encrypted.dat enc=3Dpkcs1 > decrypted.dat

# Sign
keyctl pkey_sign $serial 0 plaintext.txt enc=3Dpkcs1 hash=3Dsha256 > signed=
.dat

# Verify
keyctl pkey_verify $serial 0 plaintext.txt signed.dat enc=3Dpkcs1 hash=3Dsh=
a256

James Bottomley (12):
  tpm-buf: move from static inlines to real functions
  tpm-buf: add handling for TPM2B types
  tpm-buf: add cursor based functions for response parsing
  tpm2-space: export the context save and load commands
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm-buf: add tpm_buf_parameters()
  tpm2: add hmac checks to tpm2_pcr_extend()
  tpm2: add session encryption protection to tpm2_get_random()
  trusted keys: Add session encryption protection to the seal/unseal
    path
  tpm: add the null key name as a tpm2 sysfs variable
  Documentation: add tpm-security.rst
  oid_registry: Add TCG defined OIDS for TPM keys

James Prestwood (5):
  tpm: tpm2-cmd: add driver API for RSA decryption
  include: linux: tpm: expose tpm2_rsa_decrypt
  include: crypto: add asym_tpm2_subtype definition
  asymmetric_keys: add TPM2 ASN1 definition
  asymmetric_keys: add tpm2 key parser/type

 Documentation/security/tpm/tpm-security.rst |  204 ++++
 crypto/asymmetric_keys/Kconfig              |   20 +
 crypto/asymmetric_keys/Makefile             |   12 +
 crypto/asymmetric_keys/asym_tpm2.c          |  653 ++++++++++
 crypto/asymmetric_keys/tpm2_parser.c        |  155 +++
 crypto/asymmetric_keys/tpm2key.asn1         |   23 +
 drivers/char/tpm/Kconfig                    |   11 +
 drivers/char/tpm/Makefile                   |    2 +
 drivers/char/tpm/tpm-buf.c                  |  202 ++++
 drivers/char/tpm/tpm-sysfs.c                |   29 +-
 drivers/char/tpm/tpm.h                      |   38 +
 drivers/char/tpm/tpm2-cmd.c                 |  523 +++++++-
 drivers/char/tpm/tpm2-sessions.c            | 1203 +++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h            |  114 ++
 drivers/char/tpm/tpm2-space.c               |    8 +-
 include/crypto/asym_tpm2_subtype.h          |   32 +
 include/linux/oid_registry.h                |    5 +
 include/linux/tpm.h                         |  160 ++-
 18 files changed, 3284 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm-security.rst
 create mode 100644 crypto/asymmetric_keys/asym_tpm2.c
 create mode 100644 crypto/asymmetric_keys/tpm2_parser.c
 create mode 100644 crypto/asymmetric_keys/tpm2key.asn1
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h
 create mode 100644 include/crypto/asym_tpm2_subtype.h

--=20
2.21.1
