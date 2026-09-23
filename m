Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B35383C8
	for <keyrings@vger.kernel.org>; Wed, 23 Sep 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170721; cv=none; b=XhtDDmSDHlJ0mIWlG/ObKg2C9/i2bSQbiQ/EGc2cxLQQDoPxg6jf/j1ae5DSZ47Dm8obTzhpfdHidGERy9K1XqvLlSC3BRb4apO7g9WbdgGbXkuL9jmQztgF8bhyUfMj3qASz2j03hv2FWL0zCpzd1Z1+lcWITwq0JzYoUoHay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170721; c=relaxed/simple;
	bh=oARkvHRv8u06iVI97tQ0CNF8wMYPDcFPNd+6s7DXcpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/qCRrBcScjjCLmseOIn+JzUZENcaU7TmuOwHl/Zhh1i1PmtGNjv/WhsYgs9NHCZi9XdHjcqup23eD3JNHR6mD9454TQOw3uChSBoQIGh1ep0ssXrKwaK+b10V03wD1qLRuzMV8w/5t4ZfdbUq/XwX7cxZTMuc4HFgdx0ha3cZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0yXsV+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0yXsV+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790170719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbMzyVBVe/sIloy3f7aJTGgiLhXy0Ia1vtlgRrzL8zs=;
	b=M0yXsV+8cCFf23w/vvcSfscM5nnFBdZ76EJzKl1txmbuHgDiFUfymuPasmg9oD3r/dnnIr
	pqOWkdl1tsT1ekA6221RL3lJwqVNhIYje5aBG6Joasw+rXxyQHahwiFDl0HRTXjuCuDNVf
	hiuhaqUOCLcE5L3FSRvfsKtTWUSP5xg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-_os72mXuM3qGPT9T6JvuUQ-1; Wed,
 23 Sep 2026 09:38:35 -0400
X-MC-Unique: _os72mXuM3qGPT9T6JvuUQ-1
X-Mimecast-MFC-AGG-ID: _os72mXuM3qGPT9T6JvuUQ_1790170714
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9EA1954B1D;
	Wed, 23 Sep 2026 13:38:33 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 096931956042;
	Wed, 23 Sep 2026 13:38:29 +0000 (UTC)
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
Subject: [PATCH net v11 15/17] afs: Fix lack of setting call->server when doing FS.InlineBulkStatus
Date: Wed, 23 Sep 2026 14:37:02 +0100
Message-ID: <20260923133706.1496540-16-dhowells@redhat.com>
In-Reply-To: <20260923133706.1496540-1-dhowells@redhat.com>
References: <20260923133706.1496540-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix afs_make_op_call to set call->server.  This will prevent
afs_done_fs_inline_bulk_status() from oopsing if the server does not
support the FS.InlineBulkStatus RPC due to call->server not being set.

Note that this requires afs_make_op_call() to be moved so that it can use
afs_use_server(); the server is un-used by afs_free_call().

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
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
 fs/afs/internal.h          | 33 +++++++++++++++++----------------
 include/trace/events/afs.h |  1 +
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 330654ed16ec..40dc85d9a5c9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1424,22 +1424,6 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 		       __builtin_return_address(0));
 }
 
-static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
-				    gfp_t gfp)
-{
-	struct afs_addr_list *alist = op->estate->addresses;
-
-	op->call	= afs_get_call(call, afs_call_trace_get);
-	op->type	= call->type;
-	call->op	= op;
-	call->key	= op->key;
-	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
-	call->service_id = op->server->service_id;
-	afs_make_call(call, gfp);
-	afs_put_call(call);
-}
-
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
 	call->iov_len = size;
@@ -1771,6 +1755,23 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 	return &vnode->netfs.inode;
 }
 
+static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
+				    gfp_t gfp)
+{
+	struct afs_addr_list *alist = op->estate->addresses;
+
+	op->call	= afs_get_call(call, afs_call_trace_get);
+	op->type	= call->type;
+	call->op	= op;
+	call->server	= afs_use_server(op->server, false, afs_server_trace_use_call);
+	call->key	= op->key;
+	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
+	call->service_id = op->server->service_id;
+	afs_make_call(call, gfp);
+	afs_put_call(call);
+}
+
 /*
  * Note that a dentry got changed.  We need to set d_fsdata to the data version
  * number derived from the result of the operation.  It doesn't matter if
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

