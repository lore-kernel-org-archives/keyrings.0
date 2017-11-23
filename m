From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Nov 2017 22:04:53 +0000
Subject: [GIT PULL] Keyrings bits
Message-Id: <6839.1511474693@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Hi James,

Can you pull this and pass it along to Linus?  There's nothing too
controversial here:

 (1) Doc fix for keyctl_read().

 (2) time_t -> time64_t replacement.

 (3) Set the module licence on things to prevent tainting.

It's all been in linux-next for a week or so.

Thanks,
David
---
The following changes since commit 37cb8e1f8e10c6e9bd2a1b95cdda0620a21b0551:

  Merge tag 'devicetree-for-4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2017-11-14 18:25:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-next-20171123

for you to fetch changes up to 1e684d3820d8f72d877c0adb521ae17c6fc9bc88:

  pkcs7: Set the module licence to prevent tainting (2017-11-15 16:38:45 +0000)

----------------------------------------------------------------
Keys devel

----------------------------------------------------------------
Baolin Wang (2):
      security: keys: Replace time_t/timespec with time64_t
      security: keys: Replace time_t with time64_t for struct key_preparsed_payload

David Howells (1):
      pkcs7: Set the module licence to prevent tainting

Eric Biggers (1):
      KEYS: fix in-kernel documentation for keyctl_read()

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
