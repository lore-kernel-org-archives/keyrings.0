Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424023;
	b=scPexiIUaw7VU/uYxdMlodVNqS1fWYyIU50EwPvaHIeECLup4aVDwd7tFN6YVQ7qvRKs
	 7IEkSSCrF8QVg2Sq+7CK4BpzlzuJIjvLrByHyM+PUnAerlAd0eUMl9Xx/nbiJVBz/5jkw
	 zz/ujyjc7gCzuRlgNgcQC0Sy+xFbv2f/Eagm6n2sGDzUay6oZE5SXE0OvL5NXl7DsRcsO
	 Xgn5r7pR2WO0Go7NaQLHGjN//kw68C7I6NhavNT0qUoSQDSOJV4GOwlOAGeNUYTpLUOkP
	 cZkOBx2l0TxZlLRwRa9XwRf+QAMcjzgROPO3UP2QbZNLWyBIhK9iSgDFNdnDAYw3iRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424023;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=HQLKqGX+encDCMAwYFRiOY1YUEB13YG3cmAO/gPLw/A=;
	b=BH8vbXMLT+9LvOjH+BjTtkBJzCZUR4n0YPn4mEIIyCVPedmLEkRODPzB76SKHxYt2/2x
	 m8A/oKPmcHg2pyjxL932bNenzCi4OPV91vJL49DkaT0cCOj6DtFn+VvjI26HOGSJHkayM
	 8R2otMYyONi4IjCbGaRnbrREjGAC6PAXMm3Wi4/M+V9xLJEGe72rsMkb5bQUspKAadDQG
	 dIRWD2CO8ymygaggqt+vX5wKr3USpimQDtXw2neMmGuilovpYQAgzta6ZBUlBBVRNUWK9
	 OMB5bx4LVBFilNx5J5G38kdBmZQGBhvbNXlUdKjD1+NyOL2BBeFNfpqpv0Qk66uVm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4BIHaHn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC56606AAF3
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC56606AAF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e4BIHaHn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQLKqGX+encDCMAwYFRiOY1YUEB13YG3cmAO/gPLw/A=;
	b=e4BIHaHn1nchifG+RS8EFRg2ahN8F81BtM3Fxajarn6Ov3ibyl+dC7C0ZwVYx7/fnYOkkM
	9PZaS0r38T9xrl/HKivEz5cjiHrFx5hFIr7uJzXDfdIRrEvutn+AR9rTZVs09LrPomPXSe
	mDCMqMfY2nd71pa80nZMakUzJ7JZwl8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-Y5GSTjQOOgK6WlncQzmNDw-1; Mon,
 19 Oct 2026 15:33:38 +0000
X-MC-Unique: Y5GSTjQOOgK6WlncQzmNDw-1
X-Mimecast-MFC-AGG-ID: Y5GSTjQOOgK6WlncQzmNDw_1792424016
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BEE71955F11;
	Mon, 19 Oct 2026 15:33:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6202B1800257;
	Mon, 19 Oct 2026 15:33:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-3-jarkko@kernel.org>
References: <20261019142516.300040-3-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 2/8] KEYS: Change the type of key->datalen to unsigned int
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
Content-ID: <2609765.1792424012.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:33:32 +0100
Message-ID: <2609766.1792424012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I would merge this with patch 1.

Apart from that:

	Reviewed-by: David Howells <dhowells@redhat.com>

on both 1 & 2.

David

