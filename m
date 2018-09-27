From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:33 +0000
Subject: [PATCH v2 4/7] keyctl_dh_compute_kdf: const-ify input parameters
Message-Id: <20180927131436.23328-5-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 keyutils.c              | 5 +++--
 keyutils.h              | 8 ++++----
 man/keyctl_dh_compute.3 | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/keyutils.c b/keyutils.c
index fc7dc4d..a087a33 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -245,8 +245,9 @@ long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 }
 
 long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
-			   key_serial_t base, char *hashname, char *otherinfo,
-			   size_t otherinfolen, char *buffer, size_t buflen)
+			   key_serial_t base, const char *hashname,
+			   const char *otherinfo, size_t otherinfolen,
+			   char *buffer, size_t buflen)
 {
 	struct keyctl_dh_params params = { .priv = private,
 					   .prime = prime,
diff --git a/keyutils.h b/keyutils.h
index 5f81c62..208c175 100644
--- a/keyutils.h
+++ b/keyutils.h
@@ -115,8 +115,8 @@ struct keyctl_dh_params {
 };
 
 struct keyctl_kdf_params {
-	char *hashname;
-	char *otherinfo;
+	const char *hashname;
+	const char *otherinfo;
 	uint32_t otherinfolen;
 	uint32_t __spare[8];
 };
@@ -203,8 +203,8 @@ extern long keyctl_get_persistent(uid_t uid, key_serial_t id);
 extern long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 			      key_serial_t base, char *buffer, size_t buflen);
 extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
-				  key_serial_t base, char *hashname,
-				  char *otherinfo, size_t otherinfolen,
+				  key_serial_t base, const char *hashname,
+				  const char *otherinfo, size_t otherinfolen,
 				  char *buffer, size_t buflen);
 extern long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
 				    const char *restriction);
diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
index 09c5d21..58ad5df 100644
--- a/man/keyctl_dh_compute.3
+++ b/man/keyctl_dh_compute.3
@@ -25,7 +25,7 @@ keyctl_dh_compute_kdf \- Derive key from a Diffie-Hellman shared secret
 .BI "key_serial_t " prime ", key_serial_t " base ", void **" _buffer ");"
 .sp
 .BI "long keyctl_dh_compute_kdf(key_serial_t " private ", key_serial_t " prime ,
-.BI "key_serial_t " base ", char *" hashname ", char *" otherinfo ",
+.BI "key_serial_t " base ", const char *" hashname ", const char *" otherinfo ",
 .BI "size_t " otherinfolen ", char *" buffer ", size_t " buflen ");"
 .\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 .SH DESCRIPTION
-- 
2.19.0.221.g150f307afc
