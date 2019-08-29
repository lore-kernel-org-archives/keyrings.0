From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:43:12 +0000
Subject: [PATCH v2 04/13] keyctl: unify spelling of "unparsable"
Message-Id: <20190829204322.8015-5-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Both spelling seems to be accepted, but the majority of uses agreed on
the "unparsable" variant.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 keyctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index 7120e38..510b019 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -1003,7 +1003,7 @@ static void act_keyctl_list(int argc, char *argv[])
 		n = sscanf((char *) buffer, "%*[^;]%n;%d;%d;%x;%n",
 			   &tlen, &uid, &gid, &perm, &dpos);
 		if (n != 3) {
-			fprintf(stderr, "Unparseable description obtained for key %d\n", key);
+			fprintf(stderr, "Unparsable description obtained for key %d\n", key);
 			exit(3);
 		}
 
@@ -1096,7 +1096,7 @@ static void act_keyctl_describe(int argc, char *argv[])
 	n = sscanf(buffer, "%*[^;]%n;%d;%d;%x;%n",
 		   &tlen, &uid, &gid, &perm, &dpos);
 	if (n != 3) {
-		fprintf(stderr, "Unparseable description obtained for key %d\n", key);
+		fprintf(stderr, "Unparsable description obtained for key %d\n", key);
 		exit(3);
 	}
 
@@ -2508,7 +2508,7 @@ static int dump_key_tree_aux(key_serial_t key, int depth, int more, int hex_key_
 		   type, &uid, &gid, &perm, &dpos);
 
 	if (n != 4) {
-		fprintf(stderr, "Unparseable description obtained for key %d\n", key);
+		fprintf(stderr, "Unparsable description obtained for key %d\n", key);
 		exit(3);
 	}
 
-- 
2.21.0
