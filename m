From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:34 +0000
Subject: [PATCH v2 5/7] keyctl_dh_compute_kdf: use a void* for opaque data
Message-Id: <20180927131436.23328-6-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 keyutils.c              | 2 +-
 keyutils.h              | 4 ++--
 man/keyctl_dh_compute.3 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/keyutils.c b/keyutils.c
index a087a33..5cc90cb 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -246,7 +246,7 @@ long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 
 long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
 			   key_serial_t base, const char *hashname,
-			   const char *otherinfo, size_t otherinfolen,
+			   const void *otherinfo, size_t otherinfolen,
 			   char *buffer, size_t buflen)
 {
 	struct keyctl_dh_params params = { .priv = private,
diff --git a/keyutils.h b/keyutils.h
index 208c175..9b3848e 100644
--- a/keyutils.h
+++ b/keyutils.h
@@ -116,7 +116,7 @@ struct keyctl_dh_params {
 
 struct keyctl_kdf_params {
 	const char *hashname;
-	const char *otherinfo;
+	const void *otherinfo;
 	uint32_t otherinfolen;
 	uint32_t __spare[8];
 };
@@ -204,7 +204,7 @@ extern long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 			      key_serial_t base, char *buffer, size_t buflen);
 extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
 				  key_serial_t base, const char *hashname,
-				  const char *otherinfo, size_t otherinfolen,
+				  const void *otherinfo, size_t otherinfolen,
 				  char *buffer, size_t buflen);
 extern long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
 				    const char *restriction);
diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
index 58ad5df..7aaf4a6 100644
--- a/man/keyctl_dh_compute.3
+++ b/man/keyctl_dh_compute.3
@@ -25,7 +25,7 @@ keyctl_dh_compute_kdf \- Derive key from a Diffie-Hellman shared secret
 .BI "key_serial_t " prime ", key_serial_t " base ", void **" _buffer ");"
 .sp
 .BI "long keyctl_dh_compute_kdf(key_serial_t " private ", key_serial_t " prime ,
-.BI "key_serial_t " base ", const char *" hashname ", const char *" otherinfo ",
+.BI "key_serial_t " base ", const char *" hashname ", const void *" otherinfo ",
 .BI "size_t " otherinfolen ", char *" buffer ", size_t " buflen ");"
 .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 .SH DESCRIPTION
-- 
2.19.0.221.g150f307afc
