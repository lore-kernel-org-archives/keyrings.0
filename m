From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Feb 2019 16:19:45 +0000
Subject: [PATCH 0/4] keys: Miscellaneous fixes
Message-Id: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com, ebiggers@kernel.org, linux-kernel@vger.kernel.org


Hi James,

Here are some keyrings fixes.

 (1) Handle quotas better, allowing full quota to be reached.

 (2) Fix the creation of shortcuts in the assoc_array internal
     representation when the index key needs to be an exact multiple of the
     machine word size.

 (3) Fix a dependency loop between the request_key contruction record and
     the request_key authentication key.  The construction record isn't
     really necessary and can be dispensed with.

 (4) Set the timestamp on a new key rather than leaving it as 0.  This
     would ordinarily be fine - provided the system clock is never set to a
     time before 1970.

The patches can be found here tagged thusly:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	keys-fixes-20190214

and also on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
David Howells (3):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key
      keys: Timestamp new keys

Eric Biggers (1):
      KEYS: allow reaching the keys quotas exactly


 fs/nfs/nfs4idmap.c                   |   31 ++++++++-------
 include/keys/request_key_auth-type.h |   36 +++++++++++++++++
 include/linux/key-type.h             |   22 +++-------
 lib/assoc_array.c                    |    8 ++--
 security/keys/internal.h             |   13 ------
 security/keys/key.c                  |    5 +-
 security/keys/keyctl.c               |    1 
 security/keys/process_keys.c         |    1 
 security/keys/request_key.c          |   72 ++++++++++++++--------------------
 security/keys/request_key_auth.c     |   16 ++++----
 10 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100644 include/keys/request_key_auth-type.h
