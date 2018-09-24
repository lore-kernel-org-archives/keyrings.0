From: Ben Boeckel <mathstuf@gmail.com>
Date: Mon, 24 Sep 2018 13:01:56 +0000
Subject: [PATCH 1/4] keyctl: fix error path message names
Message-Id: <20180924130159.5299-2-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 keyctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index ab43c0a..5cbc92d 100644
--- a/keyctl.c
+++ b/keyctl.c
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
2.17.1
