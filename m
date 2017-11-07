From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 07 Nov 2017 06:19:51 +0000
Subject: [PATCH] lib/mpi: call cond_resched() from mpi_powm() loop
Message-Id: <20171107061951.861-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

On a non-preemptible kernel, if KEYCTL_DH_COMPUTE is called with the
largest permitted inputs (16384 bits), the kernel spends 10+ seconds
doing modular exponentiation in mpi_powm() without rescheduling.  If all
threads do it, it locks up the system.  Moreover, it can cause
rcu_sched-stall warnings.

Notwithstanding the insanity of doing this calculation in kernel mode
rather than in userspace, fix it by calling cond_resched() as each bit
from the exponent is processed.  It's still noninterruptible, but at
least it's preemptible now.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/mpi/mpi-pow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/mpi/mpi-pow.c b/lib/mpi/mpi-pow.c
index e24388a863a7..f089a52dbbdb 100644
--- a/lib/mpi/mpi-pow.c
+++ b/lib/mpi/mpi-pow.c
@@ -26,6 +26,7 @@
  *	 however I decided to publish this code under the plain GPL.
  */
 
+#include <linux/sched.h>
 #include <linux/string.h>
 #include "mpi-internal.h"
 #include "longlong.h"
@@ -263,6 +264,8 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 				break;
 			e = ep[i];
 			c = BITS_PER_MPI_LIMB;
+
+			cond_resched();
 		}
 
 		/* We shifted MOD, the modulo reduction argument, left MOD_SHIFT_CNT
-- 
2.15.0

