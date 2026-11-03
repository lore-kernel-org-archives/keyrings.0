Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700201;
	b=oShf1EALdsWj+7DzpaqoIUmgcQeg7ACrLZNqYoPqSFEgV27fZ9dsVaBPkYVjK48xDBE5
	 JwN7TasMWghyTqSu4gJJReX4IEaD80psmwIqvNRWqnYfl+/dnlvBJKuul52NLgk8S5WaT
	 UGhBiFPx8oNF0kkIhCGTahIwDmNImN2yDCNjf13szsSDi8jNEXIFzTPRNsMhy3GsZmLm9
	 q2RsXWwxPq91d50quWwpUDxz2LhCdkMC2t+Q58KI46badR66JOeIdmx2euaZNik5sMRRI
	 JpqVERuDapuB1c9DHg46y+fvuiPX1pxfQXy1qh5V8sKchLg/19kY0Ids6RYWDPrj0vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700201;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=OTEmd9f41wMG+18kcGlnpl8UhbldgzXmqe8LN0msAw8=;
	b=HXQBAwF00g5kxeBiTwyLGTXHBLtdgb2rCoQ57cZY0VGpOrdlqmeY8x+smZYz31TdGY4t
	 HKbiPRi8uWDtQUrkAMjQB+nhWHoL1Srk0DD8IE4V9BMuCvZFbnso5hIAFFJraDljJDXgv
	 Xjr9ajaxBPsI8h8icwmFbLY42qaiF16MAvm0rUzhEwLDU0XIRatNomwuT3zyrsMPBEIte
	 jSWZG/0Au2aqaGMENFxyio8z3Vgye/YoxoiwKbEwgj8zAQ4wxsjlnYboUdPZBRXkjqapL
	 pj3xRy8DGSmF8Mi6C30G9EmyDxHyQh/Qj3ZJb46V/86l5UdjT096mEA8JMgNLAUdTQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TQKtRuOi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16D606A81E
	for <keyrings@vger.kernel.org>; Tue,  3 Nov 2026 10:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A16D606A81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TQKtRuOi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793700200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTEmd9f41wMG+18kcGlnpl8UhbldgzXmqe8LN0msAw8=;
	b=TQKtRuOiHyl6VEFg7wSftBuYWh2V7nXCvEBwoqfgB+acIarc8pWjUDTm4Tqsn9/nyDVnFK
	JfA1PiDvUj3QR6NugSvnFpKzgD5b3niwO/ssJqSGCbU2s2n7049K/qZHDbI3Dp6jntvH1D
	7NVCAr285kinu93Jo6W7MlYHTRzvta8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-bVG1b6y6N5y4cdL06X-BMQ-1; Tue,
 03 Nov 2026 05:03:15 -0500
X-MC-Unique: bVG1b6y6N5y4cdL06X-BMQ-1
X-Mimecast-MFC-AGG-ID: bVG1b6y6N5y4cdL06X-BMQ_1793700192
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20DB1955EA1;
	Tue,  3 Nov 2026 10:03:11 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D029195608B;
	Tue,  3 Nov 2026 10:03:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
    keyrings@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <641293.1793700187.1@dhowells-thinkpadp1gen8.rmtgb.csb>
Date: Tue, 03 Nov 2026 10:03:07 +0000
Message-ID: <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> The first change has user space visible effect: rmmod semantics will change
> from always succeeding into returning -EBUSY when keys or restrictions have
> the LKM pinned.

Please don't do that.  That will cause the AF_RXRPC module to get pinned in
place by outstanding connections that haven't timed out yet.

David

