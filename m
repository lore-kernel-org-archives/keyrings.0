Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F13A9850
	for <keyrings@vger.kernel.org>; Tue, 28 Jul 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260358; cv=none; b=CepG8fNEBDkKhI7HA8k3oJJGkI5qRTIeo9LR+paP2mxOh2p2UGlxnCtNR7JRAzJfR74iAUEfJg2UZY5f4OfHHyAG5BunHrAadXU/bQAp1lKdY9e97CE/o7PNwcyUGqDpi74PoH/TYnv2cgxqtb4AcNyyiQaPAcsTgVYf9kSxFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260358; c=relaxed/simple;
	bh=YB2QMsfzBdxM7HAH6cxE8FkAxukiR0wMgm9b+hE++ws=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=d7XT8JJZtxqR77EjeMVa4bZV/u0s5E/MkywolYVt+Hixm+tU+sskJ7aWJLH7Saq1e/WeXtyy/4dJAibm4SpReYGtah0GrujRYEV7Qrxc1upjTiZhuYRgag5EmpXLWPx6KfXSZhSeqLQn0fwzZamuP15I9nwqPtCe34loS07WQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewQnUojR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewQnUojR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785260356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1RwVjjCiDMn2xZoX/jBgz+4Uz+7HR0QGeChd8KkEvw=;
	b=ewQnUojRfbEbcp3fJf+pk5kbNJzAMXoAeDXa73/e/kKfUrsZkN41p8OkIUsYJxUNhB5VlN
	7PsRoGeKkXlvMPCkcPb9HuirxaHwtvsa3K6zv76YhnDHgy6FNovJlAfmI7NLj7GN0/08S9
	zWnxMFjlHcbWjKMkvii8oXFTVv3orFw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-Zw1prQRsOeWd1ng0cUpWrQ-1; Tue,
 28 Jul 2026 13:39:13 -0400
X-MC-Unique: Zw1prQRsOeWd1ng0cUpWrQ-1
X-Mimecast-MFC-AGG-ID: Zw1prQRsOeWd1ng0cUpWrQ_1785260351
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82BA8195608B;
	Tue, 28 Jul 2026 17:39:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8763E423;
	Tue, 28 Jul 2026 17:39:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260727180854.6280c04b@kernel.org>
References: <20260727180854.6280c04b@kernel.org> <20260723100309.530157-1-dhowells@redhat.com> <20260723100309.530157-9-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
    stable@kernel.org
Subject: Re: [PATCH net v4 8/9] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1872684.1785260344.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:39:04 +0100
Message-ID: <1872685.1785260344@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Jakub Kicinski <kuba@kernel.org> wrote:

> net/rxrpc/sendmsg.c:383:37: warning: implicit conversion from 'int' to '=
enum rxrpc_abort_reason' changes value from 128 to -128 [-Wconstant-conver=
sion]
>   383 |                 trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_=
late_send,
>       |                 ~~~~~~~~~~~~~~~~~                 ^~~~~~~~~~~~~~=
~~~~~~~~~

Yeah - I overran the capacity of the signed mode(byte) enum.

David

