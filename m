From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 10 Jan 2019 20:31:16 +0000
Subject: [PATCH RESEND] keyctl: use keyctl_read_alloc() in dump_key_tree_aux()
Message-Id: <20190110203116.85397-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

dump_key_tree_aux() (part of 'keyctl show') was racy: it allocated a
buffer for the keyring contents, then read the keyring.  But it's
possible that keys are added to the keyring concurrently.  This is
problematic for two reasons.  First, when keyctl_read() is passed a
buffer that is too small, it is unspecified whether it is filled or not.
Second, even if the buffer is filled, some keys (not necessarily even
the newest ones) would be omitted from the listing.

Switch to keyctl_read_alloc() which handles the "buffer too small" case
correctly by retrying the read.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 keyctl.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index 2c8fdff..fa9e601 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -2231,29 +2231,18 @@ static int dump_key_tree_aux(key_serial_t key, int depth, int more, int hex_key_
 	/* if it's a keyring then we're going to want to recursively
 	 * display it if we can */
 	if (strcmp(type, "keyring") = 0) {
-		/* find out how big the keyring is */
-		ret = keyctl_read(key, NULL, 0);
-		if (ret < 0)
-			error("keyctl_read");
-		if (ret = 0)
-			return 0;
-		ringlen = ret;
 
 		/* read its contents */
-		payload = malloc(ringlen);
-		if (!payload)
-			error("malloc");
-
-		ret = keyctl_read(key, payload, ringlen);
+		ret = keyctl_read_alloc(key, &payload);
 		if (ret < 0)
-			error("keyctl_read");
+			error("keyctl_read_alloc");
 
-		ringlen = ret < ringlen ? ret : ringlen;
+		ringlen = ret;
 		kcount = ringlen / sizeof(key_serial_t);
 
 		/* walk the keyring */
 		pk = payload;
-		do {
+		while (ringlen >= sizeof(key_serial_t)) {
 			key = *pk++;
 
 			/* recurse into next keyrings */
@@ -2281,7 +2270,8 @@ static int dump_key_tree_aux(key_serial_t key, int depth, int more, int hex_key_
 							    hex_key_IDs);
 			}
 
-		} while (ringlen -= 4, ringlen >= sizeof(key_serial_t));
+			ringlen -= sizeof(key_serial_t);
+		}
 
 		free(payload);
 	}
-- 
2.20.1.97.g81188d93c3-goog
