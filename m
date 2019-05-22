From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:28:03 +0000
Subject: [PATCH 0/7] keys: Miscellany
Message-Id: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org


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

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-misc

David
---
David Howells (7):
      keys: sparse: Fix key_fs[ug]id_changed()
      keys: sparse: Fix incorrect RCU accesses
      keys: sparse: Fix kdoc mismatches
      keys: Break bits out of key_unlink()
      keys: Make __key_link_begin() handle lockdep nesting
      keys: Add a keyctl to move a key between keyrings
      keys: Grant Link permission to possessers of request_key auth keys


 include/linux/key.h              |   13 ++-
 include/uapi/linux/keyctl.h      |    3 +
 kernel/cred.c                    |    4 -
 security/keys/compat.c           |    3 +
 security/keys/internal.h         |    3 -
 security/keys/key.c              |    6 +
 security/keys/keyctl.c           |   58 ++++++++++++
 security/keys/keyring.c          |  178 ++++++++++++++++++++++++++++++++++----
 security/keys/process_keys.c     |   22 ++---
 security/keys/request_key.c      |    4 -
 security/keys/request_key_auth.c |    4 -
 11 files changed, 250 insertions(+), 48 deletions(-)
