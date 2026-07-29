Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083244ADD8C
	for <keyrings@vger.kernel.org>; Wed, 29 Jul 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340928; cv=none; b=efSN4V1DA3TnRqUT9keFZ7HWsTXHjd/QBMZuBCcxn8FAEUn/4r1EtCB0Qg1vDDP3dldLpIBg0iZ5wIS7ZbMBCRcNt++KmR37jxF8iBEVFr7J+Kb3Yq3OhxYF14ZqqejREagWlBLDx9NfKPf66mMhZnnpeM/kGBzoIJU+CYSoqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340928; c=relaxed/simple;
	bh=Y+Y0x6idyLBrvGyMNbAFMVeJf9fsdiD4Y9a0Bv71bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfD3mPWO+SWNhshjJn5rLxZ01pXmVHsOpv92OrPp16m7c1Qg3FM9uwaCk6eLP/h5uBHL2C8SuVPubKXtrloVX51GceFvjTSbI6k6kdDeg7Tn6moPPTWbCNBM5vZvu+UyV1eHf6qZyUQknnX/u+RxDzKnFbd8QvKKR/iipjky2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fks8wmDE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fks8wmDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NdUHKoeLppmKhk+2GZ7BujuLZIoMfsfETi/INyypqg=;
	b=Fks8wmDEP6anM7glkSJGjDRnmzbYgIaB6C0yd8fU1cHCGq+RK2PMHwKce0X58XMR8rQG9Q
	AkLcXyh7AlqdD5mUzziJ6wv2PpWebjuMuLYI3OHd6fMrD3sbFog1SazqO7/dmxAN7OTLeP
	sxYZMLLJPb0I678vMaxRJhVClqRdXyE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-mk35JMeCNnqpQU5HXFRA5w-1; Wed,
 29 Jul 2026 12:02:01 -0400
X-MC-Unique: mk35JMeCNnqpQU5HXFRA5w-1
X-Mimecast-MFC-AGG-ID: mk35JMeCNnqpQU5HXFRA5w_1785340919
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 664F719560A7;
	Wed, 29 Jul 2026 16:01:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AF4F414;
	Wed, 29 Jul 2026 16:01:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v5 08/10] rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
Date: Wed, 29 Jul 2026 17:01:05 +0100
Message-ID: <20260729160108.2031453-9-dhowells@redhat.com>
In-Reply-To: <20260729160108.2031453-1-dhowells@redhat.com>
References: <20260729160108.2031453-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
the AF_RXRPC socket that generated one of the calls on that connection for
the application (which might be in userspace) to service.  The application
then picks up the CHALLENGE and requests a RESPONSE packet be generated,
allowing the app to include app-specific data in it if appropriate.  There
is, however, no actual limit on the capacity of the CHALLENGE queue, and
this could be abused remotely - and also getting the OOB mechanism right
has proven tricky.

Further, by analogy with other AFS codebases, it's not actually necessary
to generate the application data in response to the CHALLENGE.  The reason
I did this was to set the encryption on the app-data to be the same as that
specified in the CHALLENGE as the server must be able to handle that.
However, it's sufficient to use the encoding type set in the token that is
going to be sent to the server; presumably the kerberos server knows that
the fileserver can handle that type - otherwise why tell the client to use
it?

This is a part of the fix.  With this, the appdata key created by the AFS
filesystem or passed in via sendmsg CMSG to a user AF_RXRPC socket is added
to an rxrpc_call struct and will then be added to an rxrpc_bundle struct.

Note that afs_make_op_call() has to be moved so that it can call
afs_use_server().  afs_operation-based calls did not heretofore 'use' the
server and server will be 'un-used' by afs_free_call().

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: linux-afs@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: stable@kernel.org
---
 fs/afs/internal.h          | 31 ++++++++++++++++---------------
 fs/afs/rxrpc.c             | 21 ++++++++++++++++++++-
 include/net/af_rxrpc.h     |  1 +
 include/trace/events/afs.h |  1 +
 include/uapi/linux/rxrpc.h |  1 +
 net/rxrpc/af_rxrpc.c       |  3 +++
 net/rxrpc/ar-internal.h    |  3 +++
 net/rxrpc/call_object.c    |  2 ++
 net/rxrpc/conn_client.c    |  4 ++++
 net/rxrpc/proc.c           |  5 +++--
 net/rxrpc/sendmsg.c        | 26 +++++++++++++++++++++++++-
 11 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a8f303c20ef7..f75e007e483e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1418,21 +1418,6 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 		       __builtin_return_address(0));
 }
 
-static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
-				    gfp_t gfp)
-{
-	struct afs_addr_list *alist = op->estate->addresses;
-
-	op->call	= call;
-	op->type	= call->type;
-	call->op	= op;
-	call->key	= op->key;
-	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
-	call->service_id = op->server->service_id;
-	afs_make_call(call, gfp);
-}
-
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
 	call->iov_len = size;
@@ -1764,6 +1749,22 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 	return &vnode->netfs.inode;
 }
 
+static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
+				    gfp_t gfp)
+{
+	struct afs_addr_list *alist = op->estate->addresses;
+
+	op->call	= call;
+	op->type	= call->type;
+	call->op	= op;
+	call->server	= afs_use_server(op->server, false, afs_server_trace_use_call);
+	call->key	= op->key;
+	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
+	call->service_id = op->server->service_id;
+	afs_make_call(call, gfp);
+}
+
 /*
  * Note that a dentry got changed.  We need to set d_fsdata to the data version
  * number derived from the result of the operation.  It doesn't matter if
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..c25d0bc25517 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -347,6 +347,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
+	struct key *app_data = NULL;
 	size_t len;
 	s64 tx_total_len;
 	int ret;
@@ -378,8 +379,26 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 		call->drop_ref = true;
 	}
 
+	if (call->key && call->server) {
+		u32 krb5_enctype = 0;
+		u8 security_index = 0;
+
+		rxrpc_kernel_query_key(call->key, &security_index, &krb5_enctype);
+		switch (security_index) {
+#ifdef CONFIG_RXGK
+		case RXRPC_SECURITY_YFS_RXGK:
+			/* Read the key pointer before the appdata */
+			app_data = smp_load_acquire(&call->server->yfs_rxgk_appdata);
+			break;
+#endif
+		default:
+			break;
+		}
+	}
+
 	/* create a call */
-	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
+	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer,
+					 call->key, app_data,
 					 (unsigned long)call,
 					 tx_total_len,
 					 call->max_lifespan,
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index c4b68049c06f..19c61a2f5af3 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -55,6 +55,7 @@ void rxrpc_kernel_set_notifications(struct socket *sock,
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 1b3c48b5591d..04b0bb682b81 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -148,6 +148,7 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
 	EM(afs_server_trace_update,		"UPDATE   ") \
 	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
+	EM(afs_server_trace_use_call,		"USE call ") \
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
 	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
 	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index d9735abd4c79..bcdfdf9c67a1 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -63,6 +63,7 @@ enum rxrpc_cmsg_type {
 	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
 	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
 	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
+	RXRPC_RESPONSE_APPDATA	= 20,	/* Cs-: User key holding app data for RESPONSE */
 	RXRPC__SUPPORTED
 };
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9ab0f22c881e..a19c0fd3c51a 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -318,6 +318,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
  * @sock: The socket on which to make the call
  * @peer: The peer to contact
  * @key: The security context to use (defaults to socket setting)
+ * @app_data: The security response application data (or NULL)
  * @user_call_ID: The ID to use
  * @tx_total_len: Total length of data to transmit during the call (or -1)
  * @hard_timeout: The maximum lifespan of the call in sec
@@ -340,6 +341,7 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
 					   struct key *key,
+					   struct key *app_data,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
@@ -368,6 +370,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 		key = NULL; /* a no-security key */
 
 	memset(&p, 0, sizeof(p));
+	p.app_data		= app_data;
 	p.user_call_ID		= user_call_ID;
 	p.tx_total_len		= tx_total_len;
 	p.interruptibility	= interruptibility;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a6f830c1621f..6e16df7173d3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -516,6 +516,7 @@ struct rxrpc_bundle {
 	struct rxrpc_local	*local;		/* Representation of local endpoint */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	struct list_head	proc_link;	/* Link in net->bundle_proc_list */
 	const struct rxrpc_security *security;	/* applied security module */
 	refcount_t		ref;
@@ -720,6 +721,7 @@ struct rxrpc_call {
 	struct rxrpc_sock __rcu	*socket;	/* socket responsible */
 	struct rxrpc_net	*rxnet;		/* Network namespace to which call belongs */
 	struct key		*key;		/* Security details */
+	struct key		*app_data;	/* Security response app data */
 	const struct rxrpc_security *security;	/* applied security module */
 	struct mutex		user_mutex;	/* User access mutex */
 	struct sockaddr_rxrpc	dest_srx;	/* Destination address */
@@ -914,6 +916,7 @@ enum rxrpc_command {
 };
 
 struct rxrpc_call_params {
+	struct key		*app_data;	/* Security response app data */
 	s64			tx_total_len;	/* Total Tx data length (if send data) */
 	unsigned long		user_call_ID;	/* User's call ID */
 	struct {
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e..9f6130d90c4c 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -211,6 +211,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	call->interruptibility	= p->interruptibility;
 	call->tx_total_len	= p->tx_total_len;
 	call->key		= key_get(cp->key);
+	call->app_data		= key_get(p->app_data);
 	call->peer		= rxrpc_get_peer(cp->peer, rxrpc_peer_get_call);
 	call->local		= rxrpc_get_local(cp->local, rxrpc_local_get_call);
 	call->security_level	= cp->security_level;
@@ -697,6 +698,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
 	key_put(call->key);
+	key_put(call->app_data);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..dd79630d3066 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -81,6 +81,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->local		= call->local;
 		bundle->peer		= rxrpc_get_peer(call->peer, rxrpc_peer_get_bundle);
 		bundle->key		= key_get(call->key);
+		bundle->app_data	= key_get(call->app_data);
 		bundle->security	= call->security;
 		bundle->exclusive	= test_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
@@ -118,6 +119,7 @@ static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 	write_unlock(&bundle->local->rxnet->conn_lock);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
+	key_put(bundle->app_data);
 	kfree(bundle);
 }
 
@@ -274,6 +276,7 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 #define cmp(X, Y) ((long)(X) - (long)(Y))
 		diff = (cmp(bundle->peer, call->peer) ?:
 			cmp(bundle->key, call->key) ?:
+			cmp(bundle->app_data, call->app_data) ?:
 			cmp(bundle->security_level, call->security_level) ?:
 			cmp(bundle->upgrade, upgrade));
 #undef cmp
@@ -303,6 +306,7 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 #define cmp(X, Y) ((long)(X) - (long)(Y))
 		diff = (cmp(bundle->peer, call->peer) ?:
 			cmp(bundle->key, call->key) ?:
+			cmp(bundle->app_data, call->app_data) ?:
 			cmp(bundle->security_level, call->security_level) ?:
 			cmp(bundle->upgrade, upgrade));
 #undef cmp
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index e9a27fa7b25d..f300491b06bd 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -238,7 +238,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 		seq_puts(seq,
 			 "Proto Local                                          "
 			 " Remote                                         "
-			 " SvID Ref Act Flg Key      |"
+			 " SvID Ref Act Flg Key      AppData  |"
 			 " Bundle   Conn_0   Conn_1   Conn_2   Conn_3\n"
 			 );
 		return 0;
@@ -250,7 +250,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &bundle->peer->srx.transport);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %3u %3d"
-		   " %c%c%c %08x | %08x %08x %08x %08x %08x\n",
+		   " %c%c%c %08x %08x | %08x %08x %08x %08x %08x\n",
 		   lbuff,
 		   rbuff,
 		   bundle->service_id,
@@ -260,6 +260,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 		   bundle->exclusive ? 'e' : '-',
 		   bundle->upgrade ? 'u' : '-',
 		   key_serial(bundle->key),
+		   key_serial(bundle->app_data),
 		   bundle->debug_id,
 		   bundle->conn_ids[0],
 		   bundle->conn_ids[1],
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 790292ba1439..8e64f4ad7e83 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/export.h>
 #include <linux/sched/signal.h>
+#include <keys/user-type.h>
 
 #include <net/sock.h>
 #include <net/af_rxrpc.h>
@@ -544,6 +545,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 {
 	struct cmsghdr *cmsg;
+	key_serial_t key_id;
+	key_ref_t key;
 	bool got_user_ID = false;
 	int len;
 
@@ -628,6 +631,23 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
 				return -ERANGE;
 			break;
 
+		case RXRPC_RESPONSE_APPDATA:
+			if (len != sizeof(key_serial_t))
+				return -EINVAL;
+			if (p->call.app_data)
+				return -EINVAL;
+			key_id = *(key_serial_t *)CMSG_DATA(cmsg);
+			key = lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			if (key_ref_to_ptr(key)->type != &key_type_user &&
+			    key_ref_to_ptr(key)->type != &key_type_logon) {
+				key_ref_put(key);
+				return -EINVAL;
+			}
+			p->call.app_data = key_ref_to_ptr(key);
+			break;
+
 		default:
 			return -EINVAL;
 		}
@@ -735,8 +755,10 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 			goto error_release_sock;
 		call = rxrpc_new_client_call_for_sendmsg(rx, msg, &p);
 		/* The socket is now unlocked... */
-		if (IS_ERR(call))
+		if (IS_ERR(call)) {
+			key_put(p.call.app_data);
 			return PTR_ERR(call);
+		}
 		/* ... and we have the call lock. */
 		p.call.nr_timeouts = 0;
 		ret = 0;
@@ -820,11 +842,13 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
+	key_put(p.call.app_data);
 	_leave(" = %d", ret);
 	return ret;
 
 error_release_sock:
 	release_sock(&rx->sk);
+	key_put(p.call.app_data);
 	return ret;
 }
 

