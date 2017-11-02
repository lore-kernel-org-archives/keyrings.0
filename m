From: James Morris <james.l.morris@oracle.com>
Date: Thu, 02 Nov 2017 10:21:00 +0000
Subject: [GIT PULL] Keys fixes for v4.15
Message-Id: <alpine.LFD.2.20.1711022118180.24938@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Hi Linus,

Please pull these fixes for the Keys subsystem by Eric Biggers.

The following changes since commit 3a99df9a3d14cd866b5516f8cba515a3bfd554ab:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2017-11-01 16:04:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.14-rc7

Eric Biggers (3):
      KEYS: return full count in keyring_read() if buffer is too small
      KEYS: trusted: fix writing past end of buffer in trusted_read()
      KEYS: fix out-of-bounds read during ASN.1 parsing

 lib/asn1_decoder.c      |    3 +++
 security/keys/keyring.c |   39 +++++++++++++++++++--------------------
 security/keys/trusted.c |   23 ++++++++++++-----------
 3 files changed, 34 insertions(+), 31 deletions(-)
