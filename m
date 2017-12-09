From: James Morris <james.l.morris@oracle.com>
Date: Sat, 09 Dec 2017 05:25:36 +0000
Subject: [GIT PULL] Key subsystem fixes for 4.15
Message-Id: <alpine.LFD.2.20.1712091624130.15310@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Please pull these fixes for the keys subsystem from Eric Biggers and Colin 
King.

The following changes since commit f335195adf043168ee69d78ea72ac3e30f0c57ce:

  kmemcheck: rip it out for real (2017-12-08 13:40:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git keys-for-linus

for you to fetch changes up to 4ded3bec65a07343258ed8fd9d46483f032d866f:

  Merge tag 'keys-fixes-20171208' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs into keys-for-linus (2017-12-09 14:39:48 +1100)

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

James Morris (1):
      Merge tag 'keys-fixes-20171208' of git://git.kernel.org/.../dhowells/linux-fs into keys-for-linus

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
