From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:30 +0000
Subject: [PATCH v2 1/7] keyctl: fix error path message names
Message-Id: <20180927131436.23328-2-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 keyctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index ab43c0a..50ece20 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -966,7 +966,7 @@ static void act_keyctl_describe(int argc, char *argv[])
 	/* get key description */
 	ret = keyctl_describe_alloc(key, &buffer);
 	if (ret < 0)
-		error("keyctl_describe");
+		error("keyctl_describe_alloc");
 
 	/* parse it */
 	uid = 0;
@@ -1727,7 +1727,7 @@ static void act_keyctl_dh_compute_kdf(int argc, char *argv[])
 	ret = keyctl_dh_compute_kdf(private, prime, base, argv[5], NULL,  0,
 				    buffer, buflen);
 	if (ret < 0)
-		error("keyctl_dh_compute_alloc");
+		error("keyctl_dh_compute_kdf");
 
 	/* hexdump the contents */
 	printf("%u bytes of data in result:\n", ret);
@@ -1791,7 +1791,7 @@ static void act_keyctl_dh_compute_kdf_oi(int argc, char *argv[])
 	ret = keyctl_dh_compute_kdf(private, prime, base, argv[5], oi,  oilen,
 				    buffer, buflen);
 	if (ret < 0)
-		error("keyctl_dh_compute_alloc");
+		error("keyctl_dh_compute_kdf");
 
 	/* hexdump the contents */
 	printf("%u bytes of data in result:\n", ret);
-- 
2.19.0.221.g150f307afc
