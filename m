From: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Date: Thu, 02 Jul 2020 08:57:21 +0000
Subject: [PATCH 2/4] Fix compilation error when keyutils.h is used in C++
Message-Id: <20200702085723.7026-3-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200702085723.7026-1-cvubrugier@fastmail.fm>
In-Reply-To: <20200702085723.7026-1-cvubrugier@fastmail.fm>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, =?utf-8?q?Stephan_M=C3=BCller?= <smueller@chronox.de>, Christophe Vu-Brugier <cvubrugier@fastmail.fm>

The declaration of the keyctl_dh_compute_kdf() function contains a
parameter named "private". Unfortunately, "private" is a C++ reserved
keyword. As a consequence, compiling a C++ program that includes
keyutils.h fails.

This patch renames the "private" variable to "priv" since a similar
parameter is named this way in the nearby keyctl_dh_compute()
function.

Signed-off-by: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
---
 keyutils.c | 4 ++--
 keyutils.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/keyutils.c b/keyutils.c
index 9c37256..9877fdb 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -244,11 +244,11 @@ long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 	return keyctl(KEYCTL_DH_COMPUTE, &params, buffer, buflen, 0);
 }
 
-long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
+long keyctl_dh_compute_kdf(key_serial_t priv, key_serial_t prime,
 			   key_serial_t base, char *hashname, char *otherinfo,
 			   size_t otherinfolen, char *buffer, size_t buflen)
 {
-	struct keyctl_dh_params params = { .priv = private,
+	struct keyctl_dh_params params = { .priv = priv,
 					   .prime = prime,
 					   .base = base };
 	struct keyctl_kdf_params kdfparams = { .hashname = hashname,
diff --git a/keyutils.h b/keyutils.h
index d50119e..bdecf15 100644
--- a/keyutils.h
+++ b/keyutils.h
@@ -220,7 +220,7 @@ extern long keyctl_invalidate(key_serial_t id);
 extern long keyctl_get_persistent(uid_t uid, key_serial_t id);
 extern long keyctl_dh_compute(key_serial_t priv, key_serial_t prime,
 			      key_serial_t base, char *buffer, size_t buflen);
-extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
+extern long keyctl_dh_compute_kdf(key_serial_t priv, key_serial_t prime,
 				  key_serial_t base, char *hashname,
 				  char *otherinfo, size_t otherinfolen,
 				  char *buffer, size_t buflen);
-- 
2.27.0
