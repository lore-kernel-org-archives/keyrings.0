From: James Morris <james.l.morris@oracle.com>
Date: Thu, 19 Oct 2017 02:24:16 +0000
Subject: [GIT PULL] Security subystem fixes for v4.14-rc5
Message-Id: <alpine.LFD.2.20.1710191320380.1601@t440.gateway.2wire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

This includes a fix for the capabilities code from Colin King, and a set 
of further fixes for the Keys subsystem.  From David:

"(1) Fix a bunch of places where kernel drivers may access revoked user-type
     keys and don't do it correctly.

 (2) Fix some ecryptfs bits.

 (3) Fix big_key to require CONFIG_CRYPTO.

 (4) Fix a couple of bugs in the asymmetric key type.

 (5) Fix a race between updating and finding negative keys.

 (6) Prevent add_key() from updating uninstantiated keys.

 (7) Make loading of key flags and expiry time atomic when not holding 
     locks."

Please pull!

---


The following changes since commit 73d3393ada4f70fa3df5639c8d438f2f034c0ecb:

  Merge tag 'xfs-4.14-fixes-6' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2017-10-18 14:51:50 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.14-rc5

Arnd Bergmann (1):
      security/keys: BIG_KEY requires CONFIG_CRYPTO

Chun-Yi Lee (2):
      KEYS: Fix the wrong index when checking the existence of second id
      KEYS: checking the input id parameters before finding asymmetric key

Colin Ian King (1):
      commoncap: move assignment of fs_ns to avoid null pointer dereference

David Howells (2):
      KEYS: Fix race between updating and finding a negative key
      KEYS: don't let add_key() update an uninstantiated key

Eric Biggers (8):
      KEYS: encrypted: fix dereference of NULL user_key_payload
      FS-Cache: fix dereference of NULL user_key_payload
      lib/digsig: fix dereference of NULL user_key_payload
      fscrypt: fix dereference of NULL user_key_payload
      ecryptfs: fix dereference of NULL user_key_payload
      KEYS: load key flags and expiry time atomically in key_validate()
      KEYS: Load key expiry time atomically in keyring_search_iterator()
      KEYS: load key flags and expiry time atomically in proc_keys_show()

Eric Sesterhenn (1):
      pkcs7: Prevent NULL pointer dereference, since sinfo is not always set.

James Morris (1):
      Merge commit 'tags/keys-fixes-20171018' into fixes-v4.14-rc5

 crypto/asymmetric_keys/asymmetric_type.c |    4 ++-
 crypto/asymmetric_keys/pkcs7_parser.c    |    3 ++
 fs/crypto/keyinfo.c                      |    5 +++
 fs/ecryptfs/ecryptfs_kernel.h            |   24 +++++++++++----
 fs/ecryptfs/keystore.c                   |    9 +++++-
 fs/fscache/object-list.c                 |    7 ++++
 include/linux/key.h                      |   47 +++++++++++++++++++-----------
 lib/digsig.c                             |    6 ++++
 net/dns_resolver/dns_key.c               |    2 +-
 security/commoncap.c                     |    3 +-
 security/keys/Kconfig                    |    1 +
 security/keys/big_key.c                  |    4 +-
 security/keys/encrypted-keys/encrypted.c |    9 +++++-
 security/keys/gc.c                       |    8 ++--
 security/keys/key.c                      |   41 +++++++++++++++++++-------
 security/keys/keyctl.c                   |    9 ++---
 security/keys/keyring.c                  |   14 +++++----
 security/keys/permission.c               |    7 ++--
 security/keys/proc.c                     |   31 ++++++++++++-------
 security/keys/process_keys.c             |    2 +-
 security/keys/request_key.c              |    7 ++--
 security/keys/request_key_auth.c         |    2 +-
 security/keys/trusted.c                  |    2 +-
 security/keys/user_defined.c             |    4 +-
 24 files changed, 170 insertions(+), 81 deletions(-)
