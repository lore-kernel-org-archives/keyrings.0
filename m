From: Josh Holland <anowlcalledjosh@gmail.com>
Date: Sat, 19 Aug 2017 15:21:05 +0000
Subject: [PATCH 1/2] docs: Standardise capitalisation of section headers in core.rst
Message-Id: <20170819152106.20432-2-anowlcalledjosh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The table of contents in security/keys/core.rst had different
capitalisation to the section headers, which broke case-sensitive
search.

Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
---
 Documentation/security/keys/core.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 1648fa80b..7c39c595c 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -16,17 +16,17 @@ The key service can be configured on by enabling:
 
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
+	- Key Overview
+	- Key Service Overview
+	- Key Access Permissions
+	- SELinux Support
+	- New ProcFS Files
+	- Userspace System Call Interface
+	- Kernel Services
+	- Notes On Accessing Payload Contents
+	- Defining a Key Type
+	- Request-Key Callback Service
+	- Garbage Collection
 
 
 Key Overview
-- 
2.14.1

