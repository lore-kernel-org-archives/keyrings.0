From: Josh Holland <anowlcalledjosh@gmail.com>
Date: Wed, 23 Aug 2017 20:42:32 +0000
Subject: [PATCH v2] docs: ReSTify table of contents in core.rst
Message-Id: <20170823204232.1879-1-anowlcalledjosh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Sphinx will now generate the table of contents automatically, which
avoids having the ToC getting out of sync with the rest of the document.

Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
---
 Documentation/security/keys/core.rst | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 312f981fa..1266eeae4 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -16,17 +16,7 @@ The key service can be configured on by enabling:
 
 This document has the following sections:
 
-	- Key overview
-	- Key service overview
-	- Key access permissions
-	- SELinux support
-	- New procfs files
-	- Userspace system call interface
-	- Kernel services
-	- Notes on accessing payload contents
-	- Defining a key type
-	- Request-key callback service
-	- Garbage collection
+.. contents:: :local:
 
 
 Key Overview
-- 
2.14.1

