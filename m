Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424131;
	b=lge0wCp7j1k3Zvd8yoTPbQfaBMLMFdZWu4waokFaJPvsw1cf23sUDr+Ppxn0mdRddy7p
	 M7t5tDtr+VCHsmfhCkMmkeACwlPFHdDC3SLTOH2TWjc8bxyj78sGBwJcoGg+7RN7NsbzU
	 LC+XjxdQKEcSFLfboS1IZlrIR7TB+GdjY4uQbKP7Ta3RnSZOM29cUKTBodBkmuaLbkHYm
	 Fktdb4NwUvPFcV8E1Pb39VJQXjCmT/nR+NOZt1k/2+XnaTKu1wcqmo4WmaAOIdAlmc1Wn
	 D92OI3DlMzN7WoMn9tSsHaikxadUVXPcUBVKMp7eGseuoj67a/hy8438p2anBSSW6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424131;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=l9Q4UMh62ih54xKZZA+hG600zf0HWv1kidaciNLBM80=;
	b=z+SdZHd+5UWx1tBWlMjQYzb5Ars3mJApP7VNUCx4252Z5A85OI9X4XqzcB2Vj50WPVow
	 X/x8gNyXnN25SyBtgqUuSn+n/TqwtkVHbkmLqdsFPS2zWGQ9xjiUfGH0QzrIj0jqODvh0
	 EoARiifo4IKf24sJIR8z1xFXeekmq2gurY0Q6iNSikuvMJuQJ95Uix/LLOrfXeP8isjtA
	 bHVzMMj2Jo6laU18lgj8ygkSiZmCSsdKUVueowGcmhggDz19bV7itGIDvVPIifB+/D0sz
	 EzJ8LYdnacx8VWaLQOSSN4vLpCu0emy0qhsGll3Ci3t6yxPzK4ir4SA0aWE1q60hTpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPN5XYT1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6893607AF0B
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6893607AF0B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPN5XYT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9Q4UMh62ih54xKZZA+hG600zf0HWv1kidaciNLBM80=;
	b=hPN5XYT1PLf3X0K2qjsHOfK78YYP21GxrG9yxAtjjaz/yQWRPSQGBTgdsWbQO8/+JIj7tB
	3afObZuvWP3cfLQtrNieUtKH5srNzW50J0JENZQi/SC/fPgT3Ip4lFRjf163YMveJoPdp4
	BHVGyA0fvA2bquKRBtkJ5Y6EUc50New=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-8SkUrmygPuSklfyw_LsWDw-1; Mon,
 19 Oct 2026 15:35:26 +0000
X-MC-Unique: 8SkUrmygPuSklfyw_LsWDw-1
X-Mimecast-MFC-AGG-ID: 8SkUrmygPuSklfyw_LsWDw_1792424124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3788618002D7;
	Mon, 19 Oct 2026 15:35:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 312A518004D2;
	Mon, 19 Oct 2026 15:35:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-4-jarkko@kernel.org>
References: <20261019142516.300040-4-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 3/8] KEYS: Reject @desclen values over U16_MAX in key_alloc()
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
Content-ID: <2609868.1792424119.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:35:19 +0100
Message-ID: <2609869.1792424119@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Reject @desclen values over U16_MAX with -EINVAL in order to prevent
> integer overflow.

KEY_MAX_DESC_SIZE.

David

