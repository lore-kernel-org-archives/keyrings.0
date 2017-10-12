From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:15:53 +0000
Subject: [RFC][PATCH 00/15] KEYS: Fixes
Message-Id: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
In-Reply-To: <150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org


Hi Eric,

Are you okay with my changes/substitution of your key instantiation-state
patches?

David
---
Here's a collection of fixes for Linux keyrings, mostly thanks to Eric
Biggers, including:

 (1) Fix a bunch of places where kernel drivers may access revoked user-type
     keys and don't do it correctly.

 (2) Fix some ecryptfs bits.

 (3) Fix big_key to require CONFIG_CRYPTO.

 (4) Fix a couple of bugs in the asymmetric key type.

 (5) Fix a race between updating and finding negative keys.

 (6) Prevent add_key() from updating uninstantiated keys.

 (7) Make loading of key flags and expiry time atomic when not holding locks.

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
Arnd Bergmann (1):
      security/keys: BIG_KEY requires CONFIG_CRYPTO

David Howells (2):
      KEYS: Fix race between updating and finding a negative key
      KEYS: don't let add_key() update an uninstantiated key

Eric Biggers (10):
      KEYS: encrypted: fix dereference of NULL user_key_payload
      FS-Cache: fix dereference of NULL user_key_payload
      lib/digsig: fix dereference of NULL user_key_payload
      fscrypt: fix dereference of NULL user_key_payload
      ecryptfs: fix dereference of NULL user_key_payload
      ecryptfs: fix out-of-bounds read of key payload
      ecryptfs: move key payload accessor functions into keystore.c
      KEYS: load key flags and expiry time atomically in key_validate()
      KEYS: load key flags and expiry time atomically in keyring_search_iterator()
      KEYS: load key flags and expiry time atomically in proc_keys_show()

Lee, Chun-Yi (2):
      KEYS: Fix the wrong index when checking the existence of second id
      KEYS: checking the input id parameters before finding asymmetric key


 crypto/asymmetric_keys/asymmetric_type.c |    4 +-
 fs/crypto/keyinfo.c                      |    5 ++
 fs/ecryptfs/ecryptfs_kernel.h            |   44 ------------------
 fs/ecryptfs/keystore.c                   |   73 ++++++++++++++++++++++++++++++
 fs/fscache/object-list.c                 |    7 +++
 include/linux/key.h                      |   37 +++++++++------
 lib/digsig.c                             |    6 ++
 security/keys/Kconfig                    |    1 
 security/keys/encrypted-keys/encrypted.c |    9 +++-
 security/keys/gc.c                       |    7 ++-
 security/keys/key.c                      |   37 +++++++++++----
 security/keys/keyctl.c                   |    9 ++--
 security/keys/keyring.c                  |   12 +++--
 security/keys/permission.c               |    7 ++-
 security/keys/proc.c                     |   35 +++++++++-----
 security/keys/process_keys.c             |    8 ++-
 security/keys/request_key.c              |    7 +--
 security/keys/trusted.c                  |    2 -
 security/keys/user_defined.c             |    2 -
 19 files changed, 201 insertions(+), 111 deletions(-)

