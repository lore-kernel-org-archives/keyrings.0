Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9B4D8D80
	for <keyrings@vger.kernel.org>; Wed, 29 Jul 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340938; cv=none; b=QTtm2xx+vK+H2lsl53xJETu+LTwwQpxuztuOrI3igRk5Lb6euALR95q422VNpOPKYeX8hkFDK9UxPA4vnrh7/n6W+mv0xNPSG8ySRtE6lnjv7M3wkNMW5kUeTm9S/EVpuwJPiz+Y2SlLFTYprKOTqcLIxY58/CJuvRE5qgFTKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340938; c=relaxed/simple;
	bh=jkryd+i02ut6pqE8Cm0WyLJdnhCyI9WbksnUaRz+PMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgqzhw0fUK8lKxaKIw1r3jki6+pyxGyk4xPMWUVDWP6u/iKT4/ZUTmuYQ6XItzUcRAEO6utW9L6H6SJFrzhPPcdkUdx24VL4vqQPk09xNkFynIoZiuyN7f/UWXgsxybgbVDL/n8zSZdmWB0aq+Z0zXFVPNKj8JGv46lqZ8AFoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMLAJZVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMLAJZVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vql0QsTEmzqq3nLdUgrQWHeK8BnQLGfTGlE2hU7QaeI=;
	b=DMLAJZVh1+tb/8kbDd5ssUIjm3iDq3lZ83X6tt2iwOQSzjbN5tkLxPi1sY5C6/72zAA/QQ
	ncVicgXM0xttc8+0kBeQh3XrznBxHYldfs8bb8zokfEJ5WJaEnlG0zd+JE1OZr5yl4h1Wk
	12Dm7yaZcNp1Ibe4LX2Mha6IVVAE0Ic=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-fiwgFsovMJ6DxpJr-C_qsQ-1; Wed,
 29 Jul 2026 12:02:08 -0400
X-MC-Unique: fiwgFsovMJ6DxpJr-C_qsQ-1
X-Mimecast-MFC-AGG-ID: fiwgFsovMJ6DxpJr-C_qsQ_1785340925
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6090195608F;
	Wed, 29 Jul 2026 16:02:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF05180044F;
	Wed, 29 Jul 2026 16:02:00 +0000 (UTC)
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
Subject: [PATCH net v5 09/10] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Date: Wed, 29 Jul 2026 17:01:06 +0100
Message-ID: <20260729160108.2031453-10-dhowells@redhat.com>
In-Reply-To: <20260729160108.2031453-1-dhowells@redhat.com>
References: <20260729160108.2031453-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

This is the main part of the fix.  It switches the code over from using the
OOB communication mechanism to get the appdata on the fly from the
application (either the AFS filesystem or userspace) to using the appdata
key preemptively provided by the application.

The following changes are made:

 (1) Revert to making the connection event processor work item parse the
     CHALLENGE and generate the RESPONSE directly.

 (2) Add another (optional) parameter that is passed in when an rxrpc
     client call is created and ends up attached to the connection bundle
     and is a user-type or logon-type key containing the application data.

 (3) RESPONSE generation looks at the bundle and if the app-data is there,
     it will include it (if the security class is YFS-RxGK; RxKAD ignores
     it).

The AFS filesystem driver creates an app-data key when it probes a
fileserver and attaches it to the afs_server struct.  This is picked up
when a call is made to that server and thence passed to rxrpc.

Direct userspace users of AF_RXRPC can partake by creating a user-type or
logon-type key containing the app-data they want to use and passing its
serial ID in a CMSG of type RXRPC_RESPONSE_APPDATA in the initial sendmsg()
of a call.

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
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/af_rxrpc.c         |  5 +--
 net/rxrpc/conn_event.c       | 68 ++----------------------------------
 net/rxrpc/rxgk.c             | 67 ++++++++++++++++++++++-------------
 4 files changed, 48 insertions(+), 93 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index ba2c6e3c78a6..48e774034195 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -78,6 +78,7 @@
 	EM(rxgk_abort_2_short_encdata,		"rxgk2-short-encdata")	\
 	EM(rxgk_abort_2_short_header,		"rxgk2-short-hdr")	\
 	EM(rxgk_abort_bad_key_number,		"rxgk-bad-key-num")	\
+	EM(rxgk_abort_chall_bad_app_key,	"rxgk-chall-bad-app-key")\
 	EM(rxgk_abort_chall_key_expired,	"rxgk-chall-key-exp")	\
 	EM(rxgk_abort_chall_no_key,		"rxgk-chall-nokey")	\
 	EM(rxgk_abort_chall_short,		"rxgk-chall-short")	\
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index a19c0fd3c51a..9eb6ca3c5ebf 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -598,10 +598,7 @@ static int rxrpc_sendmsg(struct socket *sock, struct msghdr *m, size_t len)
 		fallthrough;
 	case RXRPC_SERVER_BOUND:
 	case RXRPC_SERVER_LISTENING:
-		if (m->msg_flags & MSG_OOB)
-			ret = rxrpc_sendmsg_oob(rx, m, len);
-		else
-			ret = rxrpc_do_sendmsg(rx, m, len);
+		ret = rxrpc_do_sendmsg(rx, m, len);
 		/* The socket has been unlocked */
 		goto out;
 	default:
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..9146b9d4c2ac 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -279,10 +279,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 
 	switch (sp->hdr.type) {
 	case RXRPC_PACKET_TYPE_CHALLENGE:
-		ret = conn->security->respond_to_challenge(conn, skb);
-		sp->chall.conn = NULL;
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		return ret;
+		return conn->security->respond_to_challenge(conn, skb);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		spin_lock_irq(&conn->state_lock);
@@ -425,66 +422,6 @@ static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
 	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
 }
 
-/*
- * Post a CHALLENGE packet to the socket of one of a connection's calls so that
- * it can get application data to include in the packet, possibly querying
- * userspace.
- */
-static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
-{
-	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxrpc_call *call = NULL;
-	struct rxrpc_sock *rx;
-	bool respond = false, queued = false;
-
-	sp->chall.conn =
-		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
-
-	if (!conn->security->challenge_to_recvmsg) {
-		rxrpc_post_packet_to_conn(conn, skb);
-		return true;
-	}
-
-	rcu_read_lock();
-
-	for (int i = 0; i < ARRAY_SIZE(conn->channels); i++) {
-		if (conn->channels[i].call) {
-			call = conn->channels[i].call;
-			rx = rcu_dereference(call->socket);
-			if (!rx) {
-				call = NULL;
-				continue;
-			}
-
-			respond = true;
-			if (test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags))
-				break;
-			call = NULL;
-		}
-	}
-
-	if (!respond) {
-		rcu_read_unlock();
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		sp->chall.conn = NULL;
-		return false;
-	}
-
-	if (call)
-		queued = rxrpc_notify_socket_oob(call, skb);
-	rcu_read_unlock();
-	if (call && !queued) {
-		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
-		sp->chall.conn = NULL;
-		return false;
-	}
-
-	if (!call)
-		rxrpc_post_packet_to_conn(conn, skb);
-	return true;
-}
-
 /*
  * Input a connection-level packet.
  */
@@ -513,7 +450,8 @@ bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_buff *skb)
 		}
 		if (!conn->security->validate_challenge(conn, skb))
 			return false;
-		return rxrpc_post_challenge(conn, skb);
+		rxrpc_post_packet_to_conn(conn, skb);
+		return true;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
 		if (rxrpc_is_conn_aborted(conn)) {
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d24..031c6719d33e 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/key-type.h>
+#include <keys/user-type.h>
 #include "ar-internal.h"
 #include "rxgk_common.h"
 
@@ -837,7 +838,7 @@ static noinline ssize_t rxgk_insert_response_header(struct rxrpc_connection *con
  */
 static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 					    struct sk_buff *challenge,
-					    const struct krb5_buffer *appdata,
+					    const struct user_key_payload *appdata,
 					    struct sk_buff *response,
 					    size_t offset)
 {
@@ -859,20 +860,20 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 	if (ret < 0)
 		return -EPROTO;
 
-	a.appdata_len = htonl(appdata->len);
+	a.appdata_len = htonl(appdata->datalen);
 
 	ret = skb_store_bits(response, offset, &a, sizeof(a));
 	if (ret < 0)
 		return ret;
 	offset += sizeof(a);
 
-	if (appdata->len) {
-		ret = skb_store_bits(response, offset, appdata->data, appdata->len);
+	if (appdata->datalen) {
+		ret = skb_store_bits(response, offset, appdata->data, appdata->datalen);
 		if (ret < 0)
 			return ret;
-		offset += appdata->len;
+		offset += appdata->datalen;
 
-		ret = rxgk_pad_out(response, appdata->len, offset);
+		ret = rxgk_pad_out(response, appdata->datalen, offset);
 		if (ret < 0)
 			return ret;
 		offset += ret;
@@ -890,7 +891,7 @@ static ssize_t rxgk_construct_authenticator(struct rxrpc_connection *conn,
 	ret = skb_store_bits(response, offset, &b, sizeof(b));
 	if (ret < 0)
 		return ret;
-	return sizeof(a) + xdr_round_up(appdata->len) + sizeof(b);
+	return sizeof(a) + xdr_round_up(appdata->datalen) + sizeof(b);
 }
 
 static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
@@ -923,7 +924,7 @@ static ssize_t rxgk_encrypt_authenticator(struct rxrpc_connection *conn,
  */
 static int rxgk_construct_response(struct rxrpc_connection *conn,
 				   struct sk_buff *challenge,
-				   struct krb5_buffer *appdata)
+				   const struct user_key_payload *appdata)
 {
 	struct rxrpc_skb_priv *csp, *rsp;
 	struct rxgk_context *gk;
@@ -936,11 +937,11 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
 
-	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
+	auth_len = 20 + xdr_object_len(appdata->datalen) + 12 + (1 + 4) * 4;
 	authx_len = crypto_krb5_how_much_buffer(gk->krb5, KRB5_ENCRYPT_MODE,
 						auth_len, &auth_offset);
 	len = sizeof(struct rxrpc_wire_header) +
-		8 + (4 + xdr_round_up(gk->key->ticket.len)) + (4 + authx_len);
+		8 + xdr_object_len(gk->key->ticket.len) + xdr_object_len(authx_len);
 
 	response = alloc_skb_with_frags(0, len, 0, &ret, GFP_NOFS);
 	if (!response)
@@ -1011,24 +1012,44 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
  * Respond to a challenge packet.
  */
 static int rxgk_respond_to_challenge(struct rxrpc_connection *conn,
-				     struct sk_buff *challenge,
-				     struct krb5_buffer *appdata)
+				     struct sk_buff *challenge)
 {
-	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
+	struct user_key_payload dummy = {}, *appdata = &dummy;
+	int ret;
+
+	_enter("{%d,%u,%x,%x}",
+	       conn->debug_id, conn->service_id,
+	       key_serial(conn->key), key_serial(conn->bundle->app_data));
 
 	if (key_validate(conn->key) < 0)
 		return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EPROTO,
 					rxgk_abort_chall_key_expired);
 
-	return rxgk_construct_response(conn, challenge, appdata);
-}
+	if (conn->bundle->app_data) {
+		struct key *app_key = conn->bundle->app_data;
+
+		/* The wrong sort of key shouldn't get this far. */
+		if (WARN_ON_ONCE(app_key->type != &key_type_user &&
+				 app_key->type != &key_type_logon))
+			return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EKEYREJECTED,
+						rxgk_abort_chall_bad_app_key);
+
+		rcu_read_lock();
+		appdata = (struct user_key_payload *)
+			user_key_payload_rcu(conn->bundle->app_data);
+		if (appdata && !refcount_inc_not_zero(&appdata->ref))
+			appdata = NULL;
+		rcu_read_unlock();
+		if (!appdata)
+			return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EKEYREVOKED,
+						rxgk_abort_chall_key_expired);
+	}
 
-static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
-						struct sk_buff *challenge)
-{
-	struct krb5_buffer appdata = {};
+	ret = rxgk_construct_response(conn, challenge, appdata);
 
-	return rxgk_respond_to_challenge(conn, challenge, &appdata);
+	if (appdata != &dummy)
+		put_user_key_payload(appdata);
+	return ret;
 }
 
 /**
@@ -1044,9 +1065,7 @@ static int rxgk_respond_to_challenge_no_appdata(struct rxrpc_connection *conn,
 int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
 				     struct krb5_buffer *appdata)
 {
-	struct rxrpc_skb_priv *csp = rxrpc_skb(challenge);
-
-	return rxgk_respond_to_challenge(csp->chall.conn, challenge, appdata);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(rxgk_kernel_respond_to_challenge);
 
@@ -1348,7 +1367,7 @@ const struct rxrpc_security rxgk_yfs = {
 	.validate_challenge		= rxgk_validate_challenge,
 	.challenge_to_recvmsg		= rxgk_challenge_to_recvmsg,
 	.sendmsg_respond_to_challenge	= rxgk_sendmsg_respond_to_challenge,
-	.respond_to_challenge		= rxgk_respond_to_challenge_no_appdata,
+	.respond_to_challenge		= rxgk_respond_to_challenge,
 	.verify_response		= rxgk_verify_response,
 	.clear				= rxgk_clear,
 	.default_decode_ticket		= rxgk_yfs_decode_ticket,

