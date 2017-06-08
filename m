From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:57 +0000
Subject: [PATCH 21/23] KEYS: DH: add __user annotations to keyctl_kdf_params
Message-Id: <149692979733.11452.3343604662741164881.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephan Mueller <smueller@chronox.de>
---

 include/uapi/linux/keyctl.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 201c6644b237..ef16df06642a 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -70,8 +70,8 @@ struct keyctl_dh_params {
 };
 
 struct keyctl_kdf_params {
-	char *hashname;
-	char *otherinfo;
+	char __user *hashname;
+	char __user *otherinfo;
 	__u32 otherinfolen;
 	__u32 __spare[8];
 };

