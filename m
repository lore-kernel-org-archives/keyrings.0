From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 11 Jul 2018 18:36:23 +0000
Subject: [PATCH 2/2] crypto: ECDH - fix typo of P-192 b value
Message-Id: <31905154.JqEMqoRUPu@positron.chronox.de>
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

Fix the b value to be compliant with FIPS 186-4 D.1.2.1. This fix is
required to make sure the SP800-56A public key test passes for P-192.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/ecc_curve_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 94e883a9403f..336ab1805639 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -27,7 +27,7 @@ static u64 nist_p192_p[] = { 0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFEull,
 static u64 nist_p192_n[] = { 0x146BC9B1B4D22831ull, 0xFFFFFFFF99DEF836ull,
 				0xFFFFFFFFFFFFFFFFull };
 static u64 nist_p192_a[] = { 0xFFFFFFFFFFFFFFFCull, 0xFFFFFFFFFFFFFFFEull,
-				0xFFFFFFFFFFFFFFFEull };
+				0xFFFFFFFFFFFFFFFFull };
 static u64 nist_p192_b[] = { 0xFEB8DEECC146B9B1ull, 0x0FA7E9AB72243049ull,
 				0x64210519E59C80E7ull };
 static struct ecc_curve nist_p192 = {
-- 
2.17.1




