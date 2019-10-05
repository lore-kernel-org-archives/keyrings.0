From: klondike <klondike@klondike.es>
Date: Sat, 05 Oct 2019 14:45:25 +0000
Subject: [PATCH] init: Make SYSTEM_DATA_VERIFICATION a visible symbol
Message-Id: <7f9abb2b-0825-b4e3-db4a-6f2e7ca129f2@klondike.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

PKCS7_TEST_KEY and SIGNED_PE_FILE_VERIFICATION both depend on
SYSTEM_DATA_VERIFICATION which is non-visibile. As result these symbols
can not be chosen unless another symbol selecting
SYSTEM_DATA_VERIFICATION is already chosen.

Make SYSTEM_DATA_VERIFICATION visible so that PKCS7_TEST_KEY and
SIGNED_PE_FILE_VERIFICATION can be chosen by users when other symbols
selecting SYSTEM_DATA_VERIFICATION are not selected.

Also complete the help section so that this becomes clear to users.

Signed-off-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
Cc: David Howells <dhowells@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>

diff --git a/init/Kconfig b/init/Kconfig
index b4daad2bac23..6e2efdff8cf7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1921,7 +1921,8 @@ config MMAP_ALLOW_UNINITIALIZED
See Documentation/nommu-mmap.txt for more information.
config SYSTEM_DATA_VERIFICATION
- def_bool n
+ bool "Support signed data verification"
+ default n
select SYSTEM_TRUSTED_KEYRING
select KEYS
select CRYPTO
@@ -1938,6 +1939,9 @@ config SYSTEM_DATA_VERIFICATION
module verification, kexec image verification and firmware blob
verification.
+ If you want to be able to verify the signatures of images sent to
+ kexec, you must enable this option.
+
config PROFILING
bool "Profiling support"
help
