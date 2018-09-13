From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:09:34 +0000
Subject: [PATCH 5/6] afs: Always build address lists using the helper functions
Message-Id: <153685497417.16086.8080066610207629320.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Make the address list string parser use the helper functions for adding
addresses to an address list so that they end up appropriately sorted.
This will better handles overruns and make them easier to compare.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 630f91633b40..a7fdc05ba8d2 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -129,8 +129,10 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	/* Extract the addresses */
 	p = text;
 	do {
-		struct sockaddr_rxrpc *srx = &alist->addrs[alist->nr_addrs];
 		const char *q, *stop;
+		unsigned int xport = port;
+		__be32 x[4];
+		int family;
 
 		if (*p = delim) {
 			p++;
@@ -146,19 +148,12 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 					break;
 		}
 
-		if (in4_pton(p, q - p,
-			     (u8 *)&srx->transport.sin6.sin6_addr.s6_addr32[3],
-			     -1, &stop)) {
-			srx->transport.sin6.sin6_addr.s6_addr32[0] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[1] = 0;
-			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-		} else if (in6_pton(p, q - p,
-				    srx->transport.sin6.sin6_addr.s6_addr,
-				    -1, &stop)) {
-			/* Nothing to do */
-		} else {
+		if (in4_pton(p, q - p, (u8 *)&x[0], -1, &stop))
+			family = AF_INET;
+		else if (in6_pton(p, q - p, (u8 *)x, -1, &stop))
+			family = AF_INET6;
+		else
 			goto bad_address;
-		}
 
 		if (stop != q)
 			goto bad_address;
@@ -170,7 +165,7 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 		if (p < end) {
 			if (*p = '+') {
 				/* Port number specification "+1234" */
-				unsigned int xport = 0;
+				xport = 0;
 				p++;
 				if (p >= end || !isdigit(*p))
 					goto bad_address;
@@ -181,7 +176,6 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 						goto bad_address;
 					p++;
 				} while (p < end && isdigit(*p));
-				srx->transport.sin6.sin6_port = htons(xport);
 			} else if (*p = delim) {
 				p++;
 			} else {
@@ -189,8 +183,12 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 			}
 		}
 
-		alist->nr_addrs++;
-	} while (p < end && alist->nr_addrs < alist->max_addrs);
+		if (family = AF_INET)
+			afs_merge_fs_addr4(alist, x[0], xport);
+		else
+			afs_merge_fs_addr6(alist, x, xport);
+
+	} while (p < end);
 
 	_leave(" = [nr %u]", alist->nr_addrs);
 	return vllist;
