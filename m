Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402914A8A3D
	for <keyrings@vger.kernel.org>; Mon,  7 Sep 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781139; cv=none; b=Vbkyb6APJ8jeu1vhjciPMKM53YMSB3Wck2LcCwX6Q0YOjKT3LayMDgVn858H7vADfraQuWd0bB0wNvsAvQrjP4Oddf3+wEAM7gbfMTsaw4RtRuFZbe66bHkkvcVfoXsiG12c2rdzhJN+hdEp8cRR+fZXx6xOjYKzmDsXVk+3gYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781139; c=relaxed/simple;
	bh=Nzi/FqImYPqXJEs6LFrx+Ut98+MzVTc2UR4XsymYE1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9RrHYUAxXX9bSzrCyrKPBpBeRDu8xtoFep7FUV0qxR3m7tdiTauGJJOoT7Hz6dZWs8ijhBtbPVYrklOTXMyQ759aFKwYPMlIWy9kV88HNgYS4poXqUz8yKWxuODlF7eONA2jV6oqXVS6LxmNgrOGq/C5zQnV3n2e0AruX+hB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HstraWmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HstraWmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDbA/tBSiTsaFEYItL2PrPsX/0bFDHesm+RDDbpSdww=;
	b=HstraWmRvERbBF6MLtKu4l2TL12eXBW88f1pVe8hiJtZ8psDbt75EcdlVHnwHzZQ48yaJS
	Lzsa71ohs7w2rctxJX+2Ryv6GLc58H+BIgGLuCBO87pCmDtbtjy3lLYKkSCuOpl0Bl9/D1
	F2M5E4R743e7ArVmeAdF9Lvm72VmDj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-ft0pyjulOKOv4D0kkoa0Rg-1; Mon,
 07 Sep 2026 07:38:53 -0400
X-MC-Unique: ft0pyjulOKOv4D0kkoa0Rg-1
X-Mimecast-MFC-AGG-ID: ft0pyjulOKOv4D0kkoa0Rg_1788781132
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8AE819560B6;
	Mon,  7 Sep 2026 11:38:51 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 335D11955F0E;
	Mon,  7 Sep 2026 11:38:47 +0000 (UTC)
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
Subject: [PATCH net v9 12/14] afs: Fix lack of setting call->server when doing FS.InlineBulkStatus
Date: Mon,  7 Sep 2026 12:37:39 +0100
Message-ID: <20260907113743.1453210-13-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
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
afs_use_server(); the server is un-used by afs_free_server().

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
index 290873bac89b..65a0866cd8b8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1416,22 +1416,6 @@ static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
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
@@ -1763,6 +1747,23 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
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

