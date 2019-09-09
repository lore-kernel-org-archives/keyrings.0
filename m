From: Sasha Levin <sashal@kernel.org>
Date: Mon, 09 Sep 2019 15:41:21 +0000
Subject: [PATCH AUTOSEL 4.19 6/8] keys: Fix missing null pointer check in request_key_auth_describe()
Message-Id: <20190909154124.31146-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190909154124.31146-1-sashal@kernel.org>
In-Reply-To: <20190909154124.31146-1-sashal@kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Hillf Danton <hdanton@sina.com>, Sachin Sant <sachinp@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

[ Upstream commit d41a3effbb53b1bcea41e328d16a4d046a508381 ]

If a request_key authentication token key gets revoked, there's a window in
which request_key_auth_describe() can see it with a NULL payload - but it
makes no check for this and something like the following oops may occur:

	BUG: Kernel NULL pointer dereference at 0x00000038
	Faulting instruction address: 0xc0000000004ddf30
	Oops: Kernel access of bad area, sig: 11 [#1]
	...
	NIP [...] request_key_auth_describe+0x90/0xd0
	LR [...] request_key_auth_describe+0x54/0xd0
	Call Trace:
	[...] request_key_auth_describe+0x54/0xd0 (unreliable)
	[...] proc_keys_show+0x308/0x4c0
	[...] seq_read+0x3d0/0x540
	[...] proc_reg_read+0x90/0x110
	[...] __vfs_read+0x3c/0x70
	[...] vfs_read+0xb4/0x1b0
	[...] ksys_read+0x7c/0x130
	[...] system_call+0x5c/0x70

Fix this by checking for a NULL pointer when describing such a key.

Also make the read routine check for a NULL pointer to be on the safe side.

[DH: Modified to not take already-held rcu lock and modified to also check
 in the read routine]

Fixes: 04c567d9313e ("[PATCH] Keys: Fix race between two instantiators of a key")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/request_key_auth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 5e515791ccd11..1d34b2a5f485e 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -71,6 +71,9 @@ static void request_key_auth_describe(const struct key *key,
 {
 	struct request_key_auth *rka = get_request_key_auth(key);
 
+	if (!rka)
+		return;
+
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
@@ -88,6 +91,9 @@ static long request_key_auth_read(const struct key *key,
 	size_t datalen;
 	long ret;
 
+	if (!rka)
+		return -EKEYREVOKED;
+
 	datalen = rka->callout_len;
 	ret = datalen;
 
-- 
2.20.1
