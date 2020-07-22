From: trix@redhat.com
Date: Wed, 22 Jul 2020 13:46:10 +0000
Subject: [PATCH v2] KEYS: remove redundant memset
Message-Id: <20200722134610.31947-1-trix@redhat.com>
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

keyctl_pkey_query has the same prologue
and calls keyctl_pkey_params_get.

So remove the prologue.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

Signed-off-by: Tom Rix <trix@redhat.com>
---
v1: remove change to keyctl_pkey_params_get_2

 security/keys/keyctl_pkey.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 931d8dfb4a7f..5de0d599a274 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -166,8 +166,6 @@ long keyctl_pkey_query(key_serial_t id,
 	struct kernel_pkey_query res;
 	long ret;
 
-	memset(&params, 0, sizeof(params));
-
 	ret = keyctl_pkey_params_get(id, _info, &params);
 	if (ret < 0)
 		goto error;
-- 
2.18.1
