From: David Howells <dhowells@redhat.com>
Date: Mon, 30 Mar 2020 12:16:38 +0000
Subject: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
Message-Id: <1437197.1585570598@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, longman@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Here's a couple of patches that fix a circular dependency between holding
key->sem and mm->mmap_sem when reading data from a key.  One potential
issue is that a filesystem looking to use a key inside, say, ->readpages()
could deadlock if the key being read is the key that's required and the
buffer the key is being read into is on a page that needs to be fetched.

The case actually detected is a bit more involved - with a filesystem
calling request_key() and locking the target keyring for write - which
could be being read.

[Note: kbuild spotted a compiler(?) warning that I've not seen before,
 complaining "The scope of the variable 'oldxdr' can be reduced.
 [variableScope]".  It's unhappy that a variable that's declared at the top
 of the function hasn't been moved into an interior for-loop.  Is this
 something we're now requiring?  Anyway, I'd prefer to fix that with a
 follow up patch through the net tree rather than go for a 9th iteration on
 these patches.]

Thanks,
David
---
The following changes since commit 1b649e0bcae71c118c1333e02249a7510ba7f70a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-03-25 13:58:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20200329

for you to fetch changes up to 4f0882491a148059a52480e753b7f07fc550e188:

  KEYS: Avoid false positive ENOMEM error on key read (2020-03-29 12:40:41 +0100)

----------------------------------------------------------------
Keyrings fixes

----------------------------------------------------------------
Waiman Long (2):
      KEYS: Don't write out to userspace while holding key semaphore
      KEYS: Avoid false positive ENOMEM error on key read

 include/keys/big_key-type.h               |   2 +-
 include/keys/user-type.h                  |   3 +-
 include/linux/key-type.h                  |   2 +-
 net/dns_resolver/dns_key.c                |   2 +-
 net/rxrpc/key.c                           |  27 +++-----
 security/keys/big_key.c                   |  11 ++--
 security/keys/encrypted-keys/encrypted.c  |   7 +-
 security/keys/internal.h                  |  12 ++++
 security/keys/keyctl.c                    | 103 +++++++++++++++++++++++++-----
 security/keys/keyring.c                   |   6 +-
 security/keys/request_key_auth.c          |   7 +-
 security/keys/trusted-keys/trusted_tpm1.c |  14 +---
 security/keys/user_defined.c              |   5 +-
 13 files changed, 126 insertions(+), 75 deletions(-)
