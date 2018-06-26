From: David Howells <dhowells@redhat.com>
Date: Tue, 26 Jun 2018 15:59:27 +0000
Subject: [PATCH 0/3] KEYS: Miscellaneous fixes
Message-Id: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org


Hi James,

Here's a bunch of miscellaneous fixes:

 (1) Fix the handling of the X.509 signature BIT STRING.

 (2) Fix a section declaration.

 (3) Fix rounding in KDF.

Could you pass these on to Linus please?

The patches can be found here tagged thusly:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	keys-fixes-20180626

and also on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
Eric Biggers (1):
      dh key: fix rounding up KDF output length

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

Nick Desaulniers (1):
      certs/blacklist: fix const confusion


 certs/blacklist.h                         |    2 +-
 crypto/asymmetric_keys/x509_cert_parser.c |    9 +++++++++
 security/keys/dh.c                        |    6 ++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

