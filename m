From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 26 Sep 2017 20:10:59 +0000
Subject: [PATCH v2 0/6] KEYS: fix atomicity issues with key flags
Message-Id: <20170926201105.126166-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The first patch in this series fixes the race between updating and
finding a negative key, which could be used by an unprivileged user to
cause a kernel oops.  That patch is Cc'ed to stable.

The remaining patches fix some other, more theoretical atomicity issues
with accessing key->flags and key->expiry, then eliminate
KEY_FLAG_NEGATIVE, which becomes unnecessary after the first patch.

Eric Biggers (6):
  KEYS: fix race between updating and finding negative key
  KEYS: load key flags atomically in key_is_instantiated()
  KEYS: load key flags and expiry time atomically in key_validate()
  KEYS: load key flags and expiry time atomically in
    keyring_search_iterator()
  KEYS: load key flags and expiry time atomically in proc_keys_show()
  KEYS: remove KEY_FLAG_NEGATIVE

 include/linux/key.h                      | 37 +++++++++++++++++++++++---------
 security/keys/encrypted-keys/encrypted.c |  2 +-
 security/keys/gc.c                       |  4 +---
 security/keys/key.c                      | 24 +++++++++++++++------
 security/keys/keyctl.c                   |  5 ++++-
 security/keys/keyring.c                  | 12 ++++++-----
 security/keys/permission.c               |  7 +++---
 security/keys/proc.c                     | 28 +++++++++++++-----------
 security/keys/request_key.c              | 11 ++++++----
 security/keys/trusted.c                  |  2 +-
 security/keys/user_defined.c             |  2 +-
 11 files changed, 86 insertions(+), 48 deletions(-)

-- 
2.14.1.992.g2c7b836f3a-goog

