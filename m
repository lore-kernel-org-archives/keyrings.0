From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Feb 2018 16:20:27 +0000
Subject: [RFC][PATCH 0/6] KEYS: Fixes
Message-Id: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151931627456.27289.17918204393283127682.stgit@warthog.procyon.org.uk>
In-Reply-To: <151931627456.27289.17918204393283127682.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org


Hi James,

Here's a collection of fixes for Linux keyrings, mostly thanks to Eric
Biggers, if you could pass them along to Linus.  They include:

 (1) Fix some PKCS#7 verification issues.

 (2) Fix handling of unsupported crypto in X.509.

 (3) Fix too-large allocation in big_key.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-fixes-20180222

And also on the keys-fixes branch.

David
---
David Howells (1):
      KEYS: Use individual pages in big_key for crypto buffers

Eric Biggers (5):
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting
      PKCS#7: fix direct verification of SignerInfo signature
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig


 crypto/asymmetric_keys/pkcs7_trust.c  |    1 
 crypto/asymmetric_keys/pkcs7_verify.c |   12 ++--
 crypto/asymmetric_keys/public_key.c   |    4 +
 crypto/asymmetric_keys/restrict.c     |   21 ++++--
 security/keys/big_key.c               |  110 ++++++++++++++++++++++++++-------
 5 files changed, 111 insertions(+), 37 deletions(-)

