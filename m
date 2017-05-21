From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 May 2017 11:05:36 +0000
Subject: [PATCH] KEYS: Delete an error message for a failed memory allocation in get_derived_key()
Message-Id: <12d1c638-5cf6-71be-b1b7-486b8663e022@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 May 2017 11:23:55 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/keys/encrypted-keys/encrypted.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 1ca895e7e56a..ad57914452c1 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -385,10 +385,9 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 		derived_buf_len = HASH_SIZE;
 
 	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
-	if (!derived_buf) {
-		pr_err("encrypted_key: out of memory\n");
+	if (!derived_buf)
 		return -ENOMEM;
-	}
+
 	if (key_type)
 		strcpy(derived_buf, "AUTH_KEY");
 	else
-- 
2.13.0

