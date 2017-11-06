From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 06 Nov 2017 02:30:43 +0000
Subject: [PATCH v2 0/5] crypto: dh - input validation fixes
Message-Id: <20171106023048.8067-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Stephan Mueller <smueller@chronox.de>, qat-linux@intel.com, keyrings@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>

This series fixes several corner cases in the Diffie-Hellman key
exchange implementations:

1. With the software DH implementation, using a large buffer for 'g'
   caused a double free.
2. With CONFIG_DEBUG_SG=y and the software DH implementation, setting 'p'
   to 0 caused a BUG_ON().
3. With the QAT DH implementation, setting 'key' or 'g' larger than 'p'
   caused a buffer underflow.

Note that in kernels configured with CONFIG_KEY_DH_OPERATIONS=y, these
bugs are reachable by unprivileged users via KEYCTL_DH_COMPUTE.

Patches 4 and 5 are cleanup only.

Eric Biggers (5):
  crypto: dh - Fix double free of ctx->p
  crypto: dh - Don't permit 'p' to be 0
  crypto: dh - Don't permit 'key' or 'g' size longer than 'p'
  crypto: qat - Clean up error handling in qat_dh_set_secret()
  crypto: dh - Remove pointless checks for NULL 'p' and 'g'

 crypto/dh.c                                   | 36 ++++++++++-----------------
 crypto/dh_helper.c                            | 16 ++++++++++++
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 18 ++++++--------
 3 files changed, 37 insertions(+), 33 deletions(-)

-- 
2.15.0

