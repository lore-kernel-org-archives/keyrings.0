From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Thu, 13 Jun 2019 15:46:08 +0000
Subject: [PATCH 2/3] Fix syscall signature for KEYCTL_PKEY_QUERY
Message-Id: <20190613154608.GE9017@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Currently, running 'keyctl pkey_query' (or pkey_{encrypt,decrypt,sign},
due to those using pkey_query internally) will always return:

	keyctl_pkey_query: Invalid argument

This is because we invoke KEYCTL_PKEY_QUERY as:

	return keyctl(KEYCTL_PKEY_QUERY, key_id, info, result);

While the kernel code (security/keys/keyctl.c) does this:

	[...]
	case KEYCTL_PKEY_QUERY:
		if (arg3 != 0)
			return -EINVAL;
		return keyctl_pkey_query((key_serial_t)arg2,
					 (const char __user *)arg4,
					 (struct keyctl_pkey_query __user *)arg5);
	[...]

In other words, there is supposed to be an argument between 'key_id'
and 'info' (presumably for the (currently unsupported) key password
field?) which is supposed to be NULL.  Adding a NULL argument seems to
make things happy.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 keyutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/keyutils.c b/keyutils.c
index 18f2ab4..7234f9d 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -268,7 +268,7 @@ long keyctl_pkey_query(key_serial_t key_id,
 		       const char *info,
 		       struct keyctl_pkey_query *result)
 {
-	return keyctl(KEYCTL_PKEY_QUERY, key_id, info, result);
+	return keyctl(KEYCTL_PKEY_QUERY, key_id, NULL, info, result);
 }
 
 long keyctl_pkey_encrypt(key_serial_t key_id,
-- 
2.21.0
