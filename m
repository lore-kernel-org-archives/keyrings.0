From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Jan 2019 07:16:14 +0000
Subject: [PATCH] security: keys: add NULL checking for key->type->instantiate
Message-Id: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Geliang Tang <geliangtang@gmail.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

key->type->instantiate can be NULL, add NULL checking to prevent
NULL pointer dereference in __key_instantiate_and_link().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 security/keys/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 44a80d6741a1..ae3cc11be0d2 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -438,7 +438,8 @@ static int __key_instantiate_and_link(struct key *key,
 	/* can't instantiate twice */
 	if (key->state = KEY_IS_UNINSTANTIATED) {
 		/* instantiate the key */
-		ret = key->type->instantiate(key, prep);
+		if (key->type->instantiate)
+			ret = key->type->instantiate(key, prep);
 
 		if (ret = 0) {
 			/* mark the key as being instantiated */
-- 
2.17.1
