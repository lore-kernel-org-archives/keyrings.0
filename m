From: David Howells <dhowells@redhat.com>
Date: Tue, 02 Jun 2020 16:28:00 +0000
Subject: [GIT PULL] keys: Changes for 5.8
Message-Id: <1509351.1591115280@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, mathstuf@gmail.com, gustavoars@kernel.org, Jason@zx2c4.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Could you pull these keyrings fixes please?

 (1) Fix a documentation warning.

 (2) Replace a [0] array with [].

 (3) Make the big_key key type use ChaCha20Poly1305 and use the crypto
     algorithm directly rather than going through the crypto layer.

 (4) Implement the update op for the big_key type.

Thanks,
David
---
The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-next-20200602

for you to fetch changes up to b6f61c31464940513ef4eccb3a030a405b4256d6:

  keys: Implement update for the big_key type (2020-06-02 17:22:31 +0100)

----------------------------------------------------------------
Keyrings changes

----------------------------------------------------------------
Ben Boeckel (1):
      Documentation: security: core.rst: add missing argument

David Howells (1):
      keys: Implement update for the big_key type

Gustavo A. R. Silva (1):
      KEYS: Replace zero-length array with flexible-array

Jason A. Donenfeld (1):
      security/keys: rewrite big_key crypto to use library interface

 Documentation/security/keys/core.rst |   8 +-
 include/keys/big_key-type.h          |   1 +
 include/keys/user-type.h             |   2 +-
 security/keys/Kconfig                |   4 +-
 security/keys/big_key.c              | 257 +++++++----------------------------
 5 files changed, 60 insertions(+), 212 deletions(-)
