From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:16:55 +0000
Subject: [PATCH 08/15] security/keys: BIG_KEY requires CONFIG_CRYPTO
Message-Id: <150783941546.10956.15884531475572047421.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The recent rework introduced a possible randconfig build failure
when CONFIG_CRYPTO configured to only allow modules:

security/keys/big_key.o: In function `big_key_crypt':
big_key.c:(.text+0x29f): undefined reference to `crypto_aead_setkey'
security/keys/big_key.o: In function `big_key_init':
big_key.c:(.init.text+0x1a): undefined reference to `crypto_alloc_aead'
big_key.c:(.init.text+0x45): undefined reference to `crypto_aead_setauthsize'
big_key.c:(.init.text+0x77): undefined reference to `crypto_destroy_tfm'
crypto/gcm.o: In function `gcm_hash_crypt_remain_continue':
gcm.c:(.text+0x167): undefined reference to `crypto_ahash_finup'
crypto/gcm.o: In function `crypto_gcm_exit_tfm':
gcm.c:(.text+0x847): undefined reference to `crypto_destroy_tfm'

When we 'select CRYPTO' like the other users, we always get a
configuration that builds.

Fixes: 428490e38b2e ("security/keys: rewrite all of big_key crypto")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 91eafada3164..6462e6654ccf 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -45,6 +45,7 @@ config BIG_KEYS
 	bool "Large payload keys"
 	depends on KEYS
 	depends on TMPFS
+	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_GCM
 	help

