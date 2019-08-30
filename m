From: David Howells <dhowells@redhat.com>
Date: Fri, 30 Aug 2019 15:13:34 +0000
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from LTP
Message-Id: <11986.1567178014@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <85B7196E-D717-4F19-A7E8-82A18287A3DE@linux.vnet.ibm.com>
In-Reply-To: <85B7196E-D717-4F19-A7E8-82A18287A3DE@linux.vnet.ibm.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, linuxppc-dev@ozlabs.org, Hillf Danton <hdanton@sina.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Can you try this patch instead of Hillf's?

David
---
commit df882ad6d4e24a3763719c1798ea58e87d56c2d7
Author: Hillf Danton <hdanton@sina.com>
Date:   Fri Aug 30 15:54:33 2019 +0100

    keys: Fix missing null pointer check in request_key_auth_describe()
    
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
    
    Fixes: 04c567d9313e ("[PATCH] Keys: Fix race between two instantiators of a key")
    Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index e73ec040e250..ecba39c93fd9 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -66,6 +66,9 @@ static void request_key_auth_describe(const struct key *key,
 {
 	struct request_key_auth *rka = dereference_key_rcu(key);
 
+	if (!rka)
+		return;
+
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
@@ -83,6 +86,9 @@ static long request_key_auth_read(const struct key *key,
 	size_t datalen;
 	long ret;
 
+	if (!rka)
+		return -EKEYREVOKED;
+
 	datalen = rka->callout_len;
 	ret = datalen;
 
