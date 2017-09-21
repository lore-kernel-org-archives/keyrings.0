From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 20:57:42 +0000
Subject: [PATCH v2 3/3] KEYS: use kmemdup() in request_key_auth_new()
Message-Id: <20170921205742.144596-4-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921205742.144596-1-ebiggers3@gmail.com>
In-Reply-To: <20170921205742.144596-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

kmemdup() is preferred to kmalloc() followed by memcpy().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key_auth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 2df92b619a38..9d536f9e5222 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -163,9 +163,10 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
 	if (!rka)
 		goto error_free_rka;
-	rka->callout_info = kmalloc(callout_len, GFP_KERNEL);
+	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
 	if (!rka->callout_info)
 		goto error_free_rka;
+	rka->callout_len = callout_len;
 
 	/* see if the calling process is already servicing the key request of
 	 * another process */
@@ -196,8 +197,6 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 
 	rka->target_key = key_get(target);
 	rka->dest_keyring = key_get(dest_keyring);
-	memcpy(rka->callout_info, callout_info, callout_len);
-	rka->callout_len = callout_len;
 
 	/* allocate the auth key */
 	sprintf(desc, "%x", target->serial);
-- 
2.14.1.821.g8fa685d3b7-goog

