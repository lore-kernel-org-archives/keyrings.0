Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43D3E5585
	for <keyrings@vger.kernel.org>; Wed, 12 Aug 2026 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532535; cv=none; b=KukUOe+TcKUpOznH4vh71N87Zd6LJCqHzGGl/E7ctDKsvl5V5j1EjLCVqMv9eB6YGnABnnKqJl1xcK2MDfAMPS/yvWvYqU/TH426PYMUM+Ng7AFTpIm9b42y5R3x00QerFgLItQsvNM8oftDFT49EzJ6p1AD5FhPak92BNxbXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532535; c=relaxed/simple;
	bh=g7whIjPCnBIdDNy3nhXRSxd4kjcQAsCeek6gExHnQuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ/T46TDq4Kf1Yvr/QJPIvqh4dvbZhJUSonxixrjHG71mcJpkd7ywzZi955JBgDoAfXjiPHYunb18TSYIVsyJxBXo2ZZ6NQ/BcfjL7HJPrCeJgLroiDUqXt2SQ4aht8TIwicxpcpzhPHhSCi/sYMdRBCoyZDzTVICyqZ9udTwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVsFrmr6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVsFrmr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786532532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcUOut2TL3nN6gE7VcMEzOFsZGX3gHY5IVKCvGkoGVk=;
	b=ZVsFrmr6QzN3uMgjKHCXwkrivKC77rgrsQIbNIEG17ppLLxQNMcqUuMmuyUqJ/KQw9xxf9
	7Cay0mICZ4E84K3b15wm+E906P35IQHR43oHyg5HIWMkBxht500RbAk7g98r6i52yQHIaV
	sCt04jqzXRmd4kvb74C3VDAYAMtEN2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-WewKPC9OOruDTGwXZJDUNg-1; Wed,
 12 Aug 2026 07:02:09 -0400
X-MC-Unique: WewKPC9OOruDTGwXZJDUNg-1
X-Mimecast-MFC-AGG-ID: WewKPC9OOruDTGwXZJDUNg_1786532527
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843091800149;
	Wed, 12 Aug 2026 11:02:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B464D422;
	Wed, 12 Aug 2026 11:02:03 +0000 (UTC)
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
Subject: [PATCH net v7 06/11] rxrpc: Expand abort trace enum
Date: Wed, 12 Aug 2026 12:01:21 +0100
Message-ID: <20260812110129.979970-7-dhowells@redhat.com>
In-Reply-To: <20260812110129.979970-1-dhowells@redhat.com>
References: <20260812110129.979970-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The rxrpc_abort_reason enum is marked __mode(byte), but there are currently
exactly 128 in the enum (0-127), but this is about to be increased and the
enum is represented by a signed byte and an increase causes compilation
errors.

Remove the mode marking to return it to a 32-bit int.

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
 include/trace/events/rxrpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index d7c7b04d69fc..ba2c6e3c78a6 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -602,7 +602,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
-enum rxrpc_abort_reason		{ rxrpc_abort_reasons } __mode(byte);
+enum rxrpc_abort_reason		{ rxrpc_abort_reasons };
 enum rxrpc_bundle_trace		{ rxrpc_bundle_traces } __mode(byte);
 enum rxrpc_call_poke_trace	{ rxrpc_call_poke_traces } __mode(byte);
 enum rxrpc_call_trace		{ rxrpc_call_traces } __mode(byte);

