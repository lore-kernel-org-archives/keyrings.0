From: David Howells <dhowells@redhat.com>
Date: Fri, 08 Dec 2017 15:41:11 +0000
Subject: [GIT PULL] KEYS, ASN.1, X.509, PKCS#7: Fixes
Message-Id: <9594.1512747671@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Hi James,

Can you pull these assorted fixes for keyrings, ASN.1, X.509 and PKCS#7 and
pass them onto Linus please?

Thanks,
David
---
The following changes since commit fd6d2e506ce6f850d45342a15c896591291b77b5:

  Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux (2017-12-04 13:55:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20171208

for you to fetch changes up to 54c1fb39fe0495f846539ab765925b008f86801c:

  X.509: fix comparisons of ->pkey_algo (2017-12-08 15:13:29 +0000)

----------------------------------------------------------------
Keyrings fixes

----------------------------------------------------------------
Colin Ian King (1):
      security: keys: remove redundant assignment to key_ref

Eric Biggers (14):
      KEYS: remove unnecessary get/put of explicit dest_keyring
      KEYS: add missing permission check for request_key() destination
      ASN.1: fix out-of-bounds read when parsing indefinite length item
      ASN.1: check for error from ASN1_OP_END__ACT actions
      X.509: reject invalid BIT STRING for subjectPublicKey
      X.509: fix buffer overflow detection in sprint_oid()
      509: fix printing uninitialized stack memory when OID is empty
      pkcs7: return correct error code if pkcs7_check_authattrs() fails
      pkcs7: fix check for self-signed certificate
      pkcs7: use crypto_shash_digest()
      KEYS: be careful with error codes in public_key_verify_signature()
      X.509: use crypto_shash_digest()
      KEYS: reject NULL restriction string when type is specified
      X.509: fix comparisons of ->pkey_algo

 crypto/asymmetric_keys/pkcs7_parser.c     |  4 ++-
 crypto/asymmetric_keys/pkcs7_trust.c      |  2 +-
 crypto/asymmetric_keys/pkcs7_verify.c     |  9 ++----
 crypto/asymmetric_keys/public_key.c       |  7 +++--
 crypto/asymmetric_keys/x509_cert_parser.c |  2 ++
 crypto/asymmetric_keys/x509_public_key.c  |  8 ++---
 lib/asn1_decoder.c                        | 49 ++++++++++++++++++-------------
 lib/oid_registry.c                        | 16 ++++++----
 security/keys/key.c                       |  1 -
 security/keys/keyctl.c                    | 24 +++++++--------
 security/keys/request_key.c               | 48 +++++++++++++++++++++++-------
 11 files changed, 101 insertions(+), 69 deletions(-)
