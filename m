From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:49 +0000
Subject: [PATCH 4/5] keyctl.h: update pointer types
Message-Id: <20180927131450.23458-5-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

These should be `const` since the kernel should not touch them. In
addition `otherinfo` is defined to be opaque, so make it a `void *`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 include/uapi/linux/keyctl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 1a5a7948606e..6004e05b685b 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -76,8 +76,8 @@ struct keyctl_dh_params {
 };
 
 struct keyctl_kdf_params {
-	char __user *hashname;
-	char __user *otherinfo;
+	const char __user *hashname;
+	const void __user *otherinfo;
 	__u32 otherinfolen;
 	__u32 __spare[8];
 };
-- 
2.17.1
