From: trix@redhat.com
Date: Tue, 21 Jul 2020 14:15:16 +0000
Subject: [PATCH] KEYS: remove redundant memsets
Message-Id: <20200721141516.20335-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>

From: Tom Rix <trix@redhat.com>

Reviewing use of memset in keyctrl_pkey.c

keyctl_pkey_params_get prologue code to set params up

	memset(params, 0, sizeof(*params));
	params->encoding = "raw";

keyctl_pkey_params_get_2 and keyctl_pkey_query have the same
prologue and they call keyctl_pkey_params_get.

So remove the prologue from the callers.

In keyctl_pkey_params_get_2, reorder the copy_from_user
of uparams to closer to it's use to ensure that
the keyctrl_pkey_params_get is called first.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/keyctl_pkey.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..60b504681388 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -119,12 +119,6 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	struct kernel_pkey_query info;
 	int ret;
 
-	memset(params, 0, sizeof(*params));
-	params->encoding = "raw";
-
-	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
-		return -EFAULT;
-
 	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);
 	if (ret < 0)
 		return ret;
@@ -133,6 +127,9 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
+		return -EFAULT;
+
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 	case KEYCTL_PKEY_DECRYPT:
@@ -166,8 +163,6 @@ long keyctl_pkey_query(key_serial_t id,
 	struct kernel_pkey_query res;
 	long ret;
 
-	memset(&params, 0, sizeof(params));
-
 	ret = keyctl_pkey_params_get(id, _info, &params);
 	if (ret < 0)
 		goto error;
-- 
2.18.1
