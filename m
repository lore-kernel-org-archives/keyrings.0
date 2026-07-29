Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470C48EBF7
	for <keyrings@vger.kernel.org>; Wed, 29 Jul 2026 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340922; cv=none; b=Mxzz0MCsz73nxrLAD7iOU+EoJLzSlxUpKNmy5M4we11NzecfcS3rq/A1mfKn6O8Qx23jrYH1xuAFQIZBWIieCCtqWqcQ/96+AaCKsORANZOQLChHgBQ+XfLdS/KFqOHmu/UgmcrzRj2LWiNIbYgXlU8GpQvE27KvJXQdTKVMa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340922; c=relaxed/simple;
	bh=Utpoma61MeFoTJHwJmLPOQFPO9OCZWWb3YIbNhfUsno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbIOmSnmbX9gxSZnDPZzVo3YMdHh8lrhPd8IIJ00lzoFoIShAiU/GgcLkLBnGkOEDd2DYmRpCO0bwDA8oJtBp/sBUbG7DJFggmUiuRiLnQky6yhmp1rKvxd/t1GAxjekpSHzyI9a9OdQJ4kTjgIGidrMC7MfXhEb66cyZbw1Cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zss0AlRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zss0AlRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qz95LXdO85wNO9KJ1H56ZJNNLoAaj+nlIO9L0T8ld7c=;
	b=Zss0AlRTsNYsUUP3yXRha01jaPUaPurqCEESdTzNKykD7ARALQWq6y8P0tygJ6t3Ix4GnI
	cKCs8srzzrfuwj1S2C9LhnDVRefJ3IsDRAS8o0+HKtzg280r2/5Y0R4K3O/NpjB1SFB+Dx
	4AANI2oL+UewjUbL+oby+OudwaxwpRM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-9N2MObqCOOGLjSJnaNdc_g-1; Wed,
 29 Jul 2026 12:01:56 -0400
X-MC-Unique: 9N2MObqCOOGLjSJnaNdc_g-1
X-Mimecast-MFC-AGG-ID: 9N2MObqCOOGLjSJnaNdc_g_1785340914
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F148819560A1;
	Wed, 29 Jul 2026 16:01:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B04F71800480;
	Wed, 29 Jul 2026 16:01:49 +0000 (UTC)
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
Subject: [PATCH net v5 07/10] afs: Create a server appdata key
Date: Wed, 29 Jul 2026 17:01:04 +0100
Message-ID: <20260729160108.2031453-8-dhowells@redhat.com>
In-Reply-To: <20260729160108.2031453-1-dhowells@redhat.com>
References: <20260729160108.2031453-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

This is a part of the fix.  With this, the AFS filesystem creates an
appdata key for each fileserver it talks to with RxGK and attaches it to
the afs_server record.

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
 fs/afs/cm_security.c   | 232 +++++++++++++++++++++++++++++++++++++++++
 fs/afs/fs_probe.c      |   5 +
 fs/afs/internal.h      |   2 +
 fs/afs/server.c        |   1 +
 include/net/af_rxrpc.h |   2 +
 net/rxrpc/key.c        |  37 +++++++
 6 files changed, 279 insertions(+)

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index 103168c70dd4..7f08ede12206 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/slab.h>
+#include <linux/key-type.h>
 #include <crypto/krb5.h>
+#include <keys/user-type.h>
 #include "internal.h"
 #include "afs_cm.h"
 #include "afs_fs.h"
@@ -23,6 +25,236 @@ static int afs_create_yfs_cm_token(struct sk_buff *challenge,
 				   struct afs_server *server);
 #endif
 
+#ifdef CONFIG_RXGK
+/*
+ * As the YFS RxGK appdata to be passed in the YFS.FS-service RESPONSE packet,
+ * create a GSS token to use as a ticket to the specified fileserver.
+ */
+static int afs_create_yfs_rxgk_cm_appdata(struct afs_server *server, u32 enctype)
+{
+	const struct krb5_enctype *conn_krb5, *token_krb5;
+	const struct krb5_buffer *token_key;
+	struct crypto_aead *aead;
+	struct scatterlist sg;
+	struct afs_net *net = server->cell->net;
+	const struct key *cm_key = net->fs_cm_token_key;
+	struct key *appdata_key = NULL;
+	size_t keysize, uuidsize, authsize, toksize, encsize, contsize;
+	size_t adatasize, offset;
+	__be32 caps[1] = {
+		[0] = htonl(AFS_CAP_ERROR_TRANSLATION),
+	};
+	__be32 *xdr;
+	void *appdata, *K0, *encbase;
+	int ret;
+
+	if (!cm_key)
+		return -ENOKEY;
+
+	/* Assume that the fileserver is happy to use the same encoding type as
+	 * we were told to use by the token obtained by the user.
+	 */
+	conn_krb5 = crypto_krb5_find_enctype(enctype);
+	if (!conn_krb5)
+		return -ENOPKG;
+	token_krb5 = cm_key->payload.data[0];
+	token_key = (const struct krb5_buffer *)&cm_key->payload.data[2];
+
+	/* struct rxgk_key {
+	 *	afs_uint32	enctype;
+	 *	opaque		key<>;
+	 * };
+	 */
+	keysize = 4 + xdr_len_object(conn_krb5->key_len);
+
+	/* struct RXGK_AuthName {
+	 *	afs_int32	kind;
+	 *	opaque		data<AUTHDATAMAX>;
+	 *	opaque		display<AUTHPRINTABLEMAX>;
+	 * };
+	 */
+	uuidsize = sizeof(server->uuid);
+	authsize = 4 + xdr_len_object(uuidsize) + xdr_len_object(0);
+
+	/* struct RXGK_Token {
+	 *	rxgk_key		K0;
+	 *	RXGK_Level		level;
+	 *	rxgkTime		starttime;
+	 *	afs_int32		lifetime;
+	 *	afs_int32		bytelife;
+	 *	rxgkTime		expirationtime;
+	 *	struct RXGK_AuthName	identities<>;
+	 * };
+	 */
+	toksize = keysize + 4 + 8 + 4 + 4 + 8 + xdr_len_object(authsize);
+
+	offset = 0;
+	encsize = crypto_krb5_how_much_buffer(token_krb5, KRB5_ENCRYPT_MODE, toksize, &offset);
+
+	/* struct RXGK_TokenContainer {
+	 *	afs_int32	kvno;
+	 *	afs_int32	enctype;
+	 *	opaque		encrypted_token<>;
+	 * };
+	 */
+	contsize = 4 + 4 + xdr_len_object(encsize);
+
+	/* struct YFSAppData {
+	 *	opr_uuid	initiatorUuid;
+	 *	opr_uuid	acceptorUuid;
+	 *	Capabilities	caps;
+	 *	afs_int32	enctype;
+	 *	opaque		callbackKey<>;
+	 *	opaque		callbackToken<>;
+	 * };
+	 */
+	adatasize = 16 + 16 +
+		xdr_len_object(sizeof(caps)) +
+		4 +
+		xdr_len_object(conn_krb5->key_len) +
+		xdr_len_object(contsize);
+
+	ret = -ENOMEM;
+	appdata = kzalloc(adatasize, GFP_KERNEL);
+	if (!appdata)
+		goto out;
+	xdr = appdata;
+
+	memcpy(xdr, &net->uuid, 16);		/* appdata.initiatorUuid */
+	xdr += 16 / 4;
+	memcpy(xdr, &server->uuid, 16);		/* appdata.acceptorUuid */
+	xdr += 16 / 4;
+	*xdr++ = htonl(ARRAY_SIZE(caps));	/* appdata.caps.len */
+	memcpy(xdr, &caps, sizeof(caps));	/* appdata.caps */
+	xdr += ARRAY_SIZE(caps);
+	*xdr++ = htonl(conn_krb5->etype);	/* appdata.enctype */
+
+	*xdr++ = htonl(conn_krb5->key_len);	/* appdata.callbackKey.len */
+	K0 = xdr;
+	get_random_bytes(K0, conn_krb5->key_len); /* appdata.callbackKey.data */
+	xdr += xdr_round_up(conn_krb5->key_len) / 4;
+
+	*xdr++ = htonl(contsize);		/* appdata.callbackToken.len */
+	*xdr++ = htonl(1);			/* cont.kvno */
+	*xdr++ = htonl(token_krb5->etype);	/* cont.enctype */
+	*xdr++ = htonl(encsize);		/* cont.encrypted_token.len */
+
+	encbase = xdr;
+	xdr += offset / 4;
+	*xdr++ = htonl(conn_krb5->etype);	/* token.K0.enctype */
+	*xdr++ = htonl(conn_krb5->key_len);	/* token.K0.key.len */
+	memcpy(xdr, K0, conn_krb5->key_len);	/* token.K0.key.data */
+	xdr += xdr_round_up(conn_krb5->key_len) / 4;
+
+	*xdr++ = htonl(RXRPC_SECURITY_ENCRYPT);	/* token.level */
+	*xdr++ = htonl(0);			/* token.starttime */
+	*xdr++ = htonl(0);			/* " */
+	*xdr++ = htonl(0);			/* token.lifetime */
+	*xdr++ = htonl(0);			/* token.bytelife */
+	*xdr++ = htonl(0);			/* token.expirationtime */
+	*xdr++ = htonl(0);			/* " */
+	*xdr++ = htonl(1);			/* token.identities.count */
+	*xdr++ = htonl(0);			/* token.identities[0].kind */
+	*xdr++ = htonl(uuidsize);		/* token.identities[0].data.len */
+	memcpy(xdr, &server->uuid, uuidsize);
+	xdr += xdr_round_up(uuidsize) / 4;
+	*xdr++ = htonl(0);			/* token.identities[0].display.len */
+
+	xdr = encbase + xdr_round_up(encsize);
+
+	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
+		pr_err("Appdata size incorrect %lx != %zx\n",
+		       (unsigned long)xdr - (unsigned long)appdata, adatasize);
+
+	aead = crypto_krb5_prepare_encryption(token_krb5, token_key, RXGK_SERVER_ENC_TOKEN,
+					      GFP_KERNEL);
+	if (IS_ERR(aead)) {
+		ret = PTR_ERR(aead);
+		goto out_token;
+	}
+
+	sg_init_one(&sg, encbase, encsize);
+	ret = crypto_krb5_encrypt(token_krb5, aead, &sg, 1, encsize, offset, toksize, false);
+	if (ret < 0)
+		goto out_aead;
+
+	appdata_key = key_alloc(&key_type_user, "rxrpc: afs rxgk appdata",
+				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
+				KEY_POS_VIEW | KEY_POS_SEARCH | KEY_USR_VIEW,
+				KEY_ALLOC_NOT_IN_QUOTA, NULL);
+	if (IS_ERR(appdata_key)) {
+		ret = PTR_ERR(appdata_key);
+		goto out_aead;
+	}
+
+	ret = key_instantiate_and_link(appdata_key, appdata, adatasize, NULL, NULL);
+	if (ret < 0) {
+		key_put(appdata_key);
+		goto out_aead;
+	}
+
+	/* Store the appdata before the key pointer */
+	smp_store_release(&server->yfs_rxgk_appdata, appdata_key);
+
+out_aead:
+	crypto_free_aead(aead);
+out_token:
+	kfree(appdata);
+out:
+	return ret;
+}
+#endif /* CONFIG_RXGK */
+
+/*
+ * Create the application data to go in a RESPONSE packet a server's CHALLENGE
+ * from the parameters contained in a key.  The key specifies the security
+ * index and other appropriate parameters such as the encoding type for RxGK.
+ */
+int afs_create_server_appdata(struct afs_server *server, struct key *key)
+{
+	u32 krb5_enctype;
+	int ret;
+	u8 security_index;
+
+	if (!key)
+		return 0;
+
+	rxrpc_kernel_query_key(key, &security_index, &krb5_enctype);
+
+	_enter("%u,%u", security_index, krb5_enctype);
+
+	switch (security_index) {
+#ifdef CONFIG_RXGK
+	case RXRPC_SECURITY_YFS_RXGK:
+		/* Read the key pointer before the appdata */
+		if (smp_load_acquire(&server->yfs_rxgk_appdata))
+			return 0;
+		break;
+#endif
+	default:
+		return 0;
+	}
+
+	ret = 0;
+	mutex_lock(&server->cm_token_lock);
+
+	switch (security_index) {
+#ifdef CONFIG_RXGK
+	case RXRPC_SECURITY_YFS_RXGK:
+		/* Read the key pointer before the appdata */
+		if (smp_load_acquire(&server->yfs_rxgk_appdata))
+			break;
+		ret = afs_create_yfs_rxgk_cm_appdata(server, krb5_enctype);
+		break;
+#endif
+	default:
+		break;
+	}
+
+	mutex_unlock(&server->cm_token_lock);
+	return ret;
+}
+
 /*
  * Respond to an RxGK challenge, adding appdata.
  */
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index a91ad1938d07..e26f7f1e30a2 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -241,9 +241,14 @@ int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	struct afs_endpoint_state *estate, *old;
 	struct afs_addr_list *old_alist = NULL, *alist;
 	unsigned long unprobed;
+	int ret;
 
 	_enter("%pU", &server->uuid);
 
+	ret = afs_create_server_appdata(server, key);
+	if (ret < 0)
+		return ret;
+
 	estate = kzalloc_obj(*estate);
 	if (!estate)
 		return -ENOMEM;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 601f01e5c15f..a8f303c20ef7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -549,6 +549,7 @@ struct afs_server {
 	struct timer_list	timer;		/* Management timer */
 	struct mutex		cm_token_lock;	/* Lock governing creation of appdata */
 	struct krb5_buffer	cm_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
+	struct key		*yfs_rxgk_appdata; /* Appdata to be included in RESPONSE packet */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
@@ -1089,6 +1090,7 @@ extern bool afs_cm_incoming_call(struct afs_call *);
 /*
  * cm_security.c
  */
+int afs_create_server_appdata(struct afs_server *server, struct key *key);
 void afs_process_oob_queue(struct work_struct *work);
 #ifdef CONFIG_RXGK
 int afs_create_token_key(struct afs_net *net, struct socket *socket);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 0fe162ea2a36..b08d9080b0c5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -399,6 +399,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 			       afs_estate_trace_put_server);
 	afs_put_cell(server->cell, afs_cell_trace_put_server);
 	kfree(server->cm_rxgk_appdata.data);
+	key_put(server->yfs_rxgk_appdata);
 	kfree(server);
 }
 
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 0fb4c41c9bbf..c4b68049c06f 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -109,6 +109,8 @@ int rxkad_kernel_respond_to_challenge(struct sk_buff *challenge);
 u32 rxgk_kernel_query_challenge(struct sk_buff *challenge);
 int rxgk_kernel_respond_to_challenge(struct sk_buff *challenge,
 				     struct krb5_buffer *appdata);
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index,
+			    u32 *_krb5_enctype);
 u8 rxrpc_kernel_query_call_security(struct rxrpc_call *call,
 				    u16 *_service_id, u32 *_enctype);
 
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index a0aa78d89289..16bab72e6f07 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -893,3 +893,40 @@ static long rxrpc_read(const struct key *key,
 	_leave(" = %zu", size);
 	return size;
 }
+
+/**
+ * rxrpc_kernel_query_key - Query parameters from an rxrpc key
+ * @key: The key to query
+ * @_security_index: Where to return the security index
+ * @_krb5_enctype: Where to return the krb5 encryption type if applicable
+ *
+ * Query an rxrpc authentication key, extracting the security index from the
+ * first token therein.
+ */
+void rxrpc_kernel_query_key(const struct key *key, u8 *_security_index,
+			    u32 *_krb5_enctype)
+{
+	const struct rxrpc_key_token *token;
+
+	token = key->payload.data[0];
+	if (!token) {
+		*_security_index = 0;
+		*_krb5_enctype = 0;
+		return;
+	}
+
+	*_security_index = token->security_index;
+	switch (token->security_index) {
+	case RXRPC_SECURITY_RXKAD:
+		*_krb5_enctype = 0;
+		break;
+	case RXRPC_SECURITY_YFS_RXGK:
+		*_krb5_enctype = token->rxgk->enctype;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		*_krb5_enctype = 0;
+		break;
+	}
+}
+EXPORT_SYMBOL(rxrpc_kernel_query_key);

