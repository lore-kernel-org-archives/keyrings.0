From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:46 +0000
Subject: [PATCH 1/5] docs: fix prototype for `request_key`
Message-Id: <20180927131450.23458-2-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/security/keys/core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 3d36f42283e6..51b2e10abc55 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1059,7 +1059,7 @@ payload contents" for more information.
 
 	struct key *request_key(const struct key_type *type,
 				const char *description,
-				const char *callout_info);
+				const char *callout_string);
 
     This is used to request a key or keyring with a description that matches
     the description specified according to the key type's match_preparse()
-- 
2.17.1
