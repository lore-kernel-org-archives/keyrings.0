From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Oct 2017 08:23:12 +0000
Subject: [GIT PULL] KEYS: Fixes
Message-Id: <7111.1508314992@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <866.1508281053@warthog.procyon.org.uk>
In-Reply-To: <866.1508281053@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi James,

Can you pull this collection of fixes for Linux keyrings and pass them along
to Linus.  They include:

 (1) Fix a bunch of places where kernel drivers may access revoked user-type
     keys and don't do it correctly.

 (2) Fix some ecryptfs bits.

 (3) Fix big_key to require CONFIG_CRYPTO.

 (4) Fix a couple of bugs in the asymmetric key type.

 (5) Fix a race between updating and finding negative keys.

 (6) Prevent add_key() from updating uninstantiated keys.

 (7) Make loading of key flags and expiry time atomic when not holding locks.

Note that I've removed the two patches that Eric asked me to.

Thanks,
David
---
The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20171018

for you to fetch changes up to 68a1fdbbf8bd3378325e45c19e167a165f9ffc3a:

  pkcs7: Prevent NULL pointer dereference, since sinfo is not always set. (2017-10-18 09:12:41 +0100)

----------------------------------------------------------------
Keyrings fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      security/keys: BIG_KEY requires CONFIG_CRYPTO

Chun-Yi Lee (2):
      KEYS: Fix the wrong index when checking the existence of second id
      KEYS: checking the input id parameters before finding asymmetric key

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

 crypto/asymmetric_keys/asymmetric_type.c |  4 ++-
 crypto/asymmetric_keys/pkcs7_parser.c    |  3 ++
 fs/crypto/keyinfo.c                      |  5 ++++
 fs/ecryptfs/ecryptfs_kernel.h            | 24 +++++++++++-----
 fs/ecryptfs/keystore.c                   |  9 +++++-
 fs/fscache/object-list.c                 |  7 +++++
 include/linux/key.h                      | 47 ++++++++++++++++++++------------
 lib/digsig.c                             |  6 ++++
 net/dns_resolver/dns_key.c               |  2 +-
 security/keys/Kconfig                    |  1 +
 security/keys/big_key.c                  |  4 +--
 security/keys/encrypted-keys/encrypted.c |  9 +++++-
 security/keys/gc.c                       |  8 +++---
 security/keys/key.c                      | 41 ++++++++++++++++++++--------
 security/keys/keyctl.c                   |  9 +++---
 security/keys/keyring.c                  | 14 ++++++----
 security/keys/permission.c               |  7 +++--
 security/keys/proc.c                     | 31 +++++++++++++--------
 security/keys/process_keys.c             |  2 +-
 security/keys/request_key.c              |  7 ++---
 security/keys/request_key_auth.c         |  2 +-
 security/keys/trusted.c                  |  2 +-
 security/keys/user_defined.c             |  4 +--
 23 files changed, 168 insertions(+), 80 deletions(-)
