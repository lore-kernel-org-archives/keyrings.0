From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Jul 2017 12:15:18 +0000
Subject: [PATCH 0/3] KEYS: Miscellany
Message-Id: <149994811849.15121.8667303093371871645.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org


Hi James,

Could you pass these on to Linus please?

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-next

David
---
Eric Biggers (1):
      KEYS: DH: validate __spare field

Jarkko Sakkinen (1):
      modsign: add markers to endif-statements in certs/Makefile

Mat Martineau (1):
      KEYS: Add documentation for asymmetric keyring restrictions


 Documentation/crypto/asymmetric-keys.txt |   65 ++++++++++++++++++++++++++----
 Documentation/security/keys/core.rst     |    6 +++
 certs/Makefile                           |    6 +--
 security/keys/compat_dh.c                |    2 +
 security/keys/dh.c                       |    5 ++
 5 files changed, 73 insertions(+), 11 deletions(-)

