From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
Date: Tue, 12 Mar 2019 10:20:23 +0000
Subject: [PATCH] security/keys/request_key.c - fix kerneldoc
Message-Id: <12308.1552386023@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

  CC      security/keys/request_key.o
security/keys/request_key.c:35: warning: Function parameter or member 'authkey' not described in 'complete_request_key'
security/keys/request_key.c:35: warning: Excess function parameter 'auth_key' description in 'complete_request_key'

Fix it up to match the function

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2f17d84d46f1..2623253ae6c8 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -24,7 +24,7 @@
 
 /**
  * complete_request_key - Complete the construction of a key.
- * @auth_key: The authorisation key.
+ * @authkey: The authorisation key.
  * @error: The success or failute of the construction.
  *
  * Complete the attempt to construct a key.  The key will be negated
