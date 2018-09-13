From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:09:41 +0000
Subject: [PATCH 6/6] afs: Sort address lists so that they are in logical ascending order
Message-Id: <153685498147.16086.4526137363171398613.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Sort address lists so that they are in logical ascending order rather than
being partially in ascending order of the BE representations of those
values.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index a7fdc05ba8d2..99aa75aa5f07 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -251,22 +251,23 @@ struct afs_vlserver_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry
  */
 void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 {
-	struct sockaddr_in6 *a;
-	__be16 xport = htons(port);
+	struct sockaddr_in6 *p;
+	u32 addr = ntohl(xdr);
 	int i;
 
 	if (alist->nr_addrs >= alist->max_addrs)
 		return;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
-		a = &alist->addrs[i].transport.sin6;
-		if (xdr = a->sin6_addr.s6_addr32[3] &&
-		    xport = a->sin6_port)
+		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		u32 a_addr = ntohl(a->sin6_addr.s6_addr32[3]);
+		u16 a_port = ntohs(a->sin6_port);
+
+		if (addr = a_addr && port = a_port)
 			return;
-		if (xdr = a->sin6_addr.s6_addr32[3] &&
-		    (u16 __force)xport < (u16 __force)a->sin6_port)
+		if (addr = a_addr && port < a_port)
 			break;
-		if ((u32 __force)xdr < (u32 __force)a->sin6_addr.s6_addr32[3])
+		if (addr < a_addr)
 			break;
 	}
 
@@ -275,12 +276,12 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	a = &alist->addrs[i].transport.sin6;
-	a->sin6_port		  = xport;
-	a->sin6_addr.s6_addr32[0] = 0;
-	a->sin6_addr.s6_addr32[1] = 0;
-	a->sin6_addr.s6_addr32[2] = htonl(0xffff);
-	a->sin6_addr.s6_addr32[3] = xdr;
+	p = &alist->addrs[i].transport.sin6;
+	p->sin6_port		  = htons(port);
+	p->sin6_addr.s6_addr32[0] = 0;
+	p->sin6_addr.s6_addr32[1] = 0;
+	p->sin6_addr.s6_addr32[2] = htonl(0xffff);
+	p->sin6_addr.s6_addr32[3] = xdr;
 	alist->nr_ipv4++;
 	alist->nr_addrs++;
 }
@@ -290,21 +291,20 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
  */
 void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 {
-	struct sockaddr_in6 *a;
-	__be16 xport = htons(port);
+	struct sockaddr_in6 *p;
 	int i, diff;
 
 	if (alist->nr_addrs >= alist->max_addrs)
 		return;
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-		a = &alist->addrs[i].transport.sin6;
+		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		u16 a_port = ntohs(a->sin6_port);
+
 		diff = memcmp(xdr, &a->sin6_addr, 16);
-		if (diff = 0 &&
-		    xport = a->sin6_port)
+		if (diff = 0 && port = a_port)
 			return;
-		if (diff = 0 &&
-		    (u16 __force)xport < (u16 __force)a->sin6_port)
+		if (diff = 0 && port < a_port)
 			break;
 		if (diff < 0)
 			break;
@@ -315,12 +315,9 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	a = &alist->addrs[i].transport.sin6;
-	a->sin6_port		  = xport;
-	a->sin6_addr.s6_addr32[0] = xdr[0];
-	a->sin6_addr.s6_addr32[1] = xdr[1];
-	a->sin6_addr.s6_addr32[2] = xdr[2];
-	a->sin6_addr.s6_addr32[3] = xdr[3];
+	p = &alist->addrs[i].transport.sin6;
+	p->sin6_port = htons(port);
+	memcpy(&p->sin6_addr, xdr, 16);
 	alist->nr_addrs++;
 }
 
