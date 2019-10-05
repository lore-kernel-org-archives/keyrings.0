From: klondike <klondike@klondike.es>
Date: Sat, 05 Oct 2019 13:37:09 +0000
Subject: [PATCH] crypto: asymmetric_keys: select SYSTEM_DATA_VERIFICATION
Message-Id: <34dc7ee8-74f5-744e-a411-e36b462c4889@klondike.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

SYSTEM_DATA_VERIFICATION is a non-visible symbol which is selected by its
other users. PKCS7_TEST_KEY and SIGNED_PE_FILE_VERIFICATION both depend on
the symbol instead of selecting it which makes it impossible to choose
these symbols unless another symbol selecting SYSTEM_DATA_VERIFICATION is
already chosen.

Replace their depends on SYSTEM_DATA_VERIFICATION menu attribute by a
selects SYSTEM_DATA_VERIFICATION attribute so that the options can be
efectively chosen by users.

Signed-off-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
Cc: David Howells <dhowells@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1f1f004dc757..5940f343ab53 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -75,7 +75,7 @@ config PKCS7_MESSAGE_PARSER
config PKCS7_TEST_KEY
tristate "PKCS#7 testing key type"
- depends on SYSTEM_DATA_VERIFICATION
+ select SYSTEM_DATA_VERIFICATION
help
This option provides a type of key that can be loaded up from a
PKCS#7 message - provided the message is signed by a trusted key. If
@@ -88,7 +88,7 @@ config PKCS7_TEST_KEY
config SIGNED_PE_FILE_VERIFICATION
bool "Support for PE file signature verification"
depends on PKCS7_MESSAGE_PARSER=y
- depends on SYSTEM_DATA_VERIFICATION
+ select SYSTEM_DATA_VERIFICATION
select CRYPTO_HASH
select ASN1
select OID_REGISTRY
