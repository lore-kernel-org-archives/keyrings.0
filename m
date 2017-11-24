From: James Morris <james.l.morris@oracle.com>
Date: Fri, 24 Nov 2017 01:39:44 +0000
Subject: [GIT PULL] security subsystem: keys update for 4.15
Message-Id: <alpine.LFD.2.20.1711241237430.4505@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org

Please pull these updates or the keys subsystem.  From David:

" There's nothing too controversial here:

 (1) Doc fix for keyctl_read().

 (2) time_t -> time64_t replacement.

 (3) Set the module licence on things to prevent tainting.

  It's all been in linux-next for a week or so. "

---

The following changes since commit 5a787756b809888e8925d722862167f1229b58f7:

  Merge tag 'pwm/for-4.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm (2017-11-22 21:09:18 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-keys

for you to fetch changes up to ce44cd8dfc55110fa7423ceb47a8a70dac65fe89:

  Merge tag 'keys-next-20171123' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs into next-keys (2017-11-24 11:54:11 +1100)

----------------------------------------------------------------

Baolin Wang (2):
      security: keys: Replace time_t/timespec with time64_t
      security: keys: Replace time_t with time64_t for struct key_preparsed_payload

David Howells (1):
      pkcs7: Set the module licence to prevent tainting

Eric Biggers (1):
      KEYS: fix in-kernel documentation for keyctl_read()

James Morris (1):
      Merge tag 'keys-next-20171123' of git://git.kernel.org/.../dhowells/linux-fs into next-keys

 Documentation/security/keys/core.rst     | 10 +++++-----
 crypto/asymmetric_keys/pkcs7_key_type.c  |  1 +
 crypto/asymmetric_keys/pkcs7_parser.c    |  5 +++++
 crypto/asymmetric_keys/public_key.c      |  2 ++
 crypto/asymmetric_keys/x509_public_key.c |  1 +
 include/linux/key-type.h                 |  2 +-
 include/linux/key.h                      |  7 ++++---
 security/keys/gc.c                       | 20 ++++++++++----------
 security/keys/internal.h                 |  8 ++++----
 security/keys/key.c                      | 27 ++++++++++-----------------
 security/keys/keyring.c                  | 20 ++++++++++----------
 security/keys/permission.c               |  5 ++---
 security/keys/proc.c                     | 21 ++++++++++-----------
 security/keys/process_keys.c             |  2 +-
 14 files changed, 66 insertions(+), 65 deletions(-)
