From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Thu, 13 Jun 2019 15:46:39 +0000
Subject: [PATCH 3/3] Make key=value argument list optional for pkey_{encrypt,decrypt,sign}
Message-Id: <20190613154639.GF9017@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

keyctl's help message suggests that including a key=value style list
of arguments is optional for the pkey_* operations, and for pkey_query
and pkey_verify it indeed seems to be optional, but the other three
operations require that at least one key=value pair be passed in.

This patch changes the logic to make key=value lists optional for
all pkey_* operations.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 keyctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index 5b0aeeb..cf8849e 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -1935,7 +1935,7 @@ static void act_keyctl_pkey_encrypt(int argc, char *argv[])
 	void *in, *out;
 	char info[4096];
 
-	if (argc < 5)
+	if (argc < 4)
 		format();
 	pkey_parse_info(argv + 4, info);
 
@@ -1975,7 +1975,7 @@ static void act_keyctl_pkey_decrypt(int argc, char *argv[])
 	void *in, *out;
 	char info[4096];
 
-	if (argc < 5)
+	if (argc < 4)
 		format();
 	pkey_parse_info(argv + 4, info);
 
@@ -2015,7 +2015,7 @@ static void act_keyctl_pkey_sign(int argc, char *argv[])
 	void *in, *out;
 	char info[4096];
 
-	if (argc < 5)
+	if (argc < 4)
 		format();
 	pkey_parse_info(argv + 4, info);
 
-- 
2.21.0
