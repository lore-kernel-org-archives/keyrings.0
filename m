From: David Howells <dhowells@redhat.com>
Date: Wed, 29 May 2019 22:01:35 +0000
Subject: [GIT PULL] keys: Miscellany
Message-Id: <18289.1559167295@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi James,

Here are some miscellaneous keyrings fixes and improvements intended for
the next merge window, if you could pull them please.

 (1) Fix a bunch of warnings from sparse, including missing RCU bits and
     kdoc-function argument mismatches

 (2) Implement a keyctl to allow a key to be moved from one keyring to
     another, with the option of prohibiting key replacement in the
     destination keyring.

 (3) Grant Link permission to possessors of request_key_auth tokens so that
     upcall servicing daemons can more easily arrange things such that only
     the necessary auth key is passed to the actual service program, and
     not all the auth keys a daemon might possesss.

Changes: I made the change you suggested on patch 6 and added the
reviewed-by's to patches 1-5 and 7.

David
---
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-misc-20190529

for you to fetch changes up to 39de363a48ae151d766512c8e73a5564a3096c82:

  keys: Grant Link permission to possessers of request_key auth keys (2019-05-29 22:34:52 +0100)

----------------------------------------------------------------
Miscellaneous keyrings development

----------------------------------------------------------------
David Howells (7):
      keys: sparse: Fix key_fs[ug]id_changed()
      keys: sparse: Fix incorrect RCU accesses
      keys: sparse: Fix kdoc mismatches
      keys: Break bits out of key_unlink()
      keys: Make __key_link_begin() handle lockdep nesting
      keys: Add a keyctl to move a key between keyrings
      keys: Grant Link permission to possessers of request_key auth keys

 Documentation/security/keys/core.rst |  21 +++++
 include/linux/key.h                  |  13 ++-
 include/uapi/linux/keyctl.h          |   3 +
 kernel/cred.c                        |   4 +-
 security/keys/compat.c               |   3 +
 security/keys/internal.h             |   3 +-
 security/keys/key.c                  |   6 +-
 security/keys/keyctl.c               |  56 ++++++++++-
 security/keys/keyring.c              | 178 ++++++++++++++++++++++++++++++-----
 security/keys/process_keys.c         |  22 ++---
 security/keys/request_key.c          |   4 +-
 security/keys/request_key_auth.c     |   4 +-
 12 files changed, 269 insertions(+), 48 deletions(-)
