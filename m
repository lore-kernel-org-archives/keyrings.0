From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 11 Jul 2018 18:35:49 +0000
Subject: [PATCH 1/2] crypto: DH - update test for public key verification
Message-Id: <3498555.DuuoTkek00@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <3594538.6iHA3aaNKK@positron.chronox.de>
	<2573864.V43BhLOfag@positron.chronox.de>
	<20180711041059.GA13331@sol.localdomain>
In-Reply-To: <20180711041059.GA13331@sol.localdomain>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

By adding a zero byte-length for the DH parameter Q value, the public
key verification test is disabled for the given test.

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/testmgr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index b6362169771a..759462d65f41 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -644,12 +644,14 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\x11\x02" /* len */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* q_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
 	"\x02\x11" /* len */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
+	"\x00\x00\x00\x00" /* q_size */
 	"\x00\x00\x00\x01" /* g_size */
 #endif
 	/* xa */
@@ -751,12 +753,14 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\x11\x02" /* len */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* q_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
 	"\x02\x11" /* len */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
+	"\x00\x00\x00\x00" /* q_size */
 	"\x00\x00\x00\x01" /* g_size */
 #endif
 	/* xa */
-- 
2.17.1




