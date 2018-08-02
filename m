From: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 02 Aug 2018 16:37:46 +0000
Subject: [PATCH] Fix not passing all arguments to keyctl_pkey_query
Message-Id: <20180802163746.3063-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

pkey_parse_info was being called starting with the 3rd argument.  This
resulted in calls such as:

	'keyctl pkey_query 805557749 enc=pkcs1'

not passing the enc=pkcs1 parameter and resulting in the query always
returning the results for the 'raw' encoding.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---

NOTE: This is a patch against keyutils 'pkey' branch.  Hopefully I got
the right list.

 keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/keyctl.c b/keyctl.c
index 3c43f51..d4c9cb6 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -1732,7 +1732,7 @@ static void act_keyctl_pkey_query(int argc, char *argv[])
 
 	if (argc < 3)
 		format();
-	pkey_parse_info(argv + 3, info);
+	pkey_parse_info(argv + 2, info);
 
 	key = get_key_id(argv[1]);
 
-- 
2.16.1

