From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:48 +0000
Subject: [PATCH 3/5] rxrpc: mention that client key payloads are not arbitrary
Message-Id: <20180927131450.23458-4-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 net/rxrpc/key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index e7f6b8823eb6..51fb50541397 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -38,8 +38,8 @@ static void rxrpc_describe(const struct key *, struct seq_file *);
 static long rxrpc_read(const struct key *, char __user *, size_t);
 
 /*
- * rxrpc defined keys take an arbitrary string as the description and an
- * arbitrary blob of data as the payload
+ * rxrpc defined keys take an arbitrary string as the description. See
+ * rxrpc_preparse for the payload format.
  */
 struct key_type key_type_rxrpc = {
 	.name		= "rxrpc",
-- 
2.17.1
