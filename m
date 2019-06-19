From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 13:18:40 +0000
Subject: [PATCH 00/10] keys: Miscellany [ver #3]
Message-Id: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, ebiggers@kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Eric Biggers <ebiggers@google.com>, James Morris <jamorris@linux.microsoft.com>, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org


Here are some miscellaneous keyrings fixes and improvements intended for
the next merge window:

 (1) Fix a bunch of warnings from sparse, including missing RCU bits and
     kdoc-function argument mismatches

 (2) Implement a keyctl to allow a key to be moved from one keyring to
     another, with the option of prohibiting key replacement in the
     destination keyring.

 (3) Grant Link permission to possessors of request_key_auth tokens so that
     upcall servicing daemons can more easily arrange things such that only
     the necessary auth key is passed to the actual service program, and
     not all the auth keys a daemon might possesss.

 (4) Improvement in lookup_user_key().

 (5) Implement a keyctl to allow keyrings subsystem capabilities to be
     queried.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-misc

The keyutils next branch has commits to make available, document and test
the move-key and capabilities code:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next

Changes:

V3:

 (*) Made the capabilities array unsigned char[] rather than unsigned int[].

V2:

 (*) Fixed lock ordering bug in KEYCTL_MOVE.

 (*) Added improvement patch from Eric.

 (*) Added capabilities patch.

David
---
David Howells (9):
      keys: sparse: Fix key_fs[ug]id_changed()
      keys: sparse: Fix incorrect RCU accesses
      keys: sparse: Fix kdoc mismatches
      keys: Change keyring_serialise_link_sem to a mutex
      keys: Break bits out of key_unlink()
      keys: Hoist locking out of __key_link_begin()
      keys: Add a keyctl to move a key between keyrings
      keys: Grant Link permission to possessers of request_key auth keys
      keys: Add capability-checking keyctl function

Eric Biggers (1):
      keys: Reuse keyring_index_key::desc_len in lookup_user_key()


 Documentation/security/keys/core.rst |   21 +++
 include/linux/key.h                  |   13 +-
 include/uapi/linux/keyctl.h          |   17 ++
 kernel/cred.c                        |    4 
 security/keys/compat.c               |    6 +
 security/keys/internal.h             |    7 +
 security/keys/key.c                  |   27 +++
 security/keys/keyctl.c               |   90 +++++++++++
 security/keys/keyring.c              |  278 ++++++++++++++++++++++++++++------
 security/keys/process_keys.c         |   26 +--
 security/keys/request_key.c          |    9 +
 security/keys/request_key_auth.c     |    4 
 12 files changed, 418 insertions(+), 84 deletions(-)
