From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Thu, 13 Jun 2019 15:45:49 +0000
Subject: [PATCH 1/3] Fix 'keyctl pkey_query' argument parsing
Message-Id: <20190613154549.GD9017@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

keyctl's pkey_* operations each have an argument that allows specifying
a key password, but since that feature isn't currently supported, it
is supposed to always be passed in as "0":

	if (strcmp(argv[2], "0") != 0) {
		fprintf(stderr, "Password passing is not yet supported\n");
		exit(2);
	}

However, act_keyctl_pkey_query() has an off-by-one that makes it
start parsing key=value style option pairs at the password argument,
which causes the following error if the password argument is not in
key=value format:

	$ keyctl pkey_query 541826697 0
	Option not in key=val form
	$

And this error if the password argument is in key=value format:

	$ keyctl pkey_query 541826697 a=b
	Password passing is not yet supported
	$

This patch fixes act_keyctl_pkey_query() to start parsing key=value
pairs from the right place in its argument list, which gets it a
little further.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/keyctl.c b/keyctl.c
index aeb92e8..5b0aeeb 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -1900,7 +1900,7 @@ static void act_keyctl_pkey_query(int argc, char *argv[])
 
 	if (argc < 3)
 		format();
-	pkey_parse_info(argv + 2, info);
+	pkey_parse_info(argv + 3, info);
 
 	key = get_key_id(argv[1]);
 	if (strcmp(argv[2], "0") != 0) {
-- 
2.21.0
