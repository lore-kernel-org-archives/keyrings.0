From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue, 25 Aug 2020 21:53:23 +0000
Subject: [PATCH] docs: crypto: Fix parameters order for keyctl()
Message-Id: <20200825215323.309899-1-anatol.pomozov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, keyrings@vger.kernel.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>

key is the second parameter, keyring is the third one.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/security/keys/core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index aa0081685ee1..59f752bdfc47 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -604,7 +604,7 @@ The keyctl syscall functions are:
 
   *  Unlink a key or keyring from another keyring::
 
-	long keyctl(KEYCTL_UNLINK, key_serial_t keyring, key_serial_t key);
+	long keyctl(KEYCTL_UNLINK, key_serial_t key, key_serial_t keyring);
 
      This function looks through the keyring for the first link to the
      specified key, and removes it if found. Subsequent links to that key are
-- 
2.28.0
