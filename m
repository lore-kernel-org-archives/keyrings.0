From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:09:08 +0000
Subject: [PATCH 2/6] afs: Do better max capacity handling on address lists
Message-Id: <153685494877.16086.6419466153343099957.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Note the maximum allocated capacity in an afs_addr_list struct and discard
addresses that would exceed it in afs_merge_fs_addr{4,6}().

Also, since the current maximum capacity is less than 255, reduce the
relevant members to bytes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   19 +++++++++++--------
 fs/afs/internal.h  |    8 +++++---
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 025a9a5e1c32..4dbb8af54668 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -17,11 +17,6 @@
 #include "internal.h"
 #include "afs_fs.h"
 
-//#define AFS_MAX_ADDRESSES
-//	((unsigned int)((PAGE_SIZE - sizeof(struct afs_addr_list)) /
-//			sizeof(struct sockaddr_rxrpc)))
-#define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
-
 /*
  * Release an address list.
  */
@@ -43,11 +38,15 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 
 	_enter("%u,%u,%u", nr, service, port);
 
+	if (nr > AFS_MAX_ADDRESSES)
+		nr = AFS_MAX_ADDRESSES;
+
 	alist = kzalloc(struct_size(alist, addrs, nr), GFP_KERNEL);
 	if (!alist)
 		return NULL;
 
 	refcount_set(&alist->usage, 1);
+	alist->max_addrs = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct sockaddr_rxrpc *srx = &alist->addrs[i];
@@ -109,8 +108,6 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 	} while (p < end);
 
 	_debug("%u/%u addresses", nr, AFS_MAX_ADDRESSES);
-	if (nr > AFS_MAX_ADDRESSES)
-		nr = AFS_MAX_ADDRESSES;
 
 	alist = afs_alloc_addrlist(nr, service, port);
 	if (!alist)
@@ -180,7 +177,7 @@ struct afs_addr_list *afs_parse_text_addrs(const char *text, size_t len,
 		}
 
 		alist->nr_addrs++;
-	} while (p < end && alist->nr_addrs < AFS_MAX_ADDRESSES);
+	} while (p < end && alist->nr_addrs < alist->max_addrs);
 
 	_leave(" = [nr %u]", alist->nr_addrs);
 	return alist;
@@ -241,6 +238,9 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 	__be16 xport = htons(port);
 	int i;
 
+	if (alist->nr_addrs >= alist->max_addrs)
+		return;
+
 	for (i = 0; i < alist->nr_ipv4; i++) {
 		a = &alist->addrs[i].transport.sin6;
 		if (xdr = a->sin6_addr.s6_addr32[3] &&
@@ -277,6 +277,9 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 	__be16 xport = htons(port);
 	int i, diff;
 
+	if (alist->nr_addrs >= alist->max_addrs)
+		return;
+
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
 		a = &alist->addrs[i].transport.sin6;
 		diff = memcmp(xdr, &a->sin6_addr, 16);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 871a228d7f37..8ae4e2ebb99a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -73,12 +73,14 @@ struct afs_addr_list {
 	struct rcu_head		rcu;		/* Must be first */
 	refcount_t		usage;
 	u32			version;	/* Version */
-	unsigned short		nr_addrs;
-	unsigned short		index;		/* Address currently in use */
-	unsigned short		nr_ipv4;	/* Number of IPv4 addresses */
+	unsigned char		max_addrs;
+	unsigned char		nr_addrs;
+	unsigned char		index;		/* Address currently in use */
+	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
 	unsigned long		probed;		/* Mask of servers that have been probed */
 	unsigned long		yfs;		/* Mask of servers that are YFS */
 	struct sockaddr_rxrpc	addrs[];
+#define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
 /*
