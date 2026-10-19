Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424463;
	b=J2AwsZxoSyUXGlHH3oqkP6DVMbSK/JNAYtLOY0UR8nxthvs+fnXnmapbKWcodFKr0LRr
	 Tmu/JgOU444tJQFRvnoYh0QLqWc5xA2TGOfeG0W2jLPSduTe5JqIDfDmogULQP7iLGwna
	 bcFY5TTZOyhvtAeCzEjeKoZWrbcqxkqE9n8Ey4DUKpU9757e1kQctLeunOZHyicJxtqfO
	 Sj5t/6y26zXZpbrN31ZcaYZwPN2sksq5gfdjE/b1yogGC+slNHCFwEh3qRF1/1RcAA6Le
	 sdKeH2cqWoLfrWCxjmoDWLkendbqgQa+//SZfnFcHqIE+ZxPAddeP/xx6jz6s8KVyiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424463;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=yziQSCxdp7ps3qMUbiHDhum2cL5ZNoqGNN2WDzodKHc=;
	b=T2dOUC/u/EmAmrriSoiP9JtyBpTBnnjznv5XW+Er8JPSCP+mkViU45FSziiz5dax94Yx
	 oAEAW8wYTOCg4jpfGd1UZuwpKGU0U6MX917VDvetuQ37QAC8llanp3x53EB9jMtzLE5Wh
	 BJ95icm44gepuDhSxzVnWukHInz9YlufUEyU980T73OZGPWnEdhFiTddCi8R+3WXpTN3b
	 858YvNMJY1bkWpRhwtOHyBttdH2rO6CHF7FKT01XmAWFlTewnYZ7RLevA4GIt4BkaMjN9
	 K0N5sTvfzWinH9DBbvi/svK8pmjAmz58Eb47idTWDbsjwswjCl2QDUhi7MqDw+1+vrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv0BTLil;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503260740B7
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8503260740B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv0BTLil
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yziQSCxdp7ps3qMUbiHDhum2cL5ZNoqGNN2WDzodKHc=;
	b=Xv0BTLilkXGFFfs4U2zhzCCzQM7KHdNNxU7p+LYZQzufrycGvdbPXlLraEkFCLlaGMgLa8
	Tmx+Xv3tIWqVF3SIgnNuuXxkZX01PXOVbfwHnRkLRnkMBTxCrqHREOqcnKTSHxvqr2lhIM
	XR2H7z6VsQPyFC2mgGOxal2idvq1MZ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-SMnf-nxSMaCCQN_0EplOqg-1; Mon,
 19 Oct 2026 15:40:55 +0000
X-MC-Unique: SMnf-nxSMaCCQN_0EplOqg-1
X-Mimecast-MFC-AGG-ID: SMnf-nxSMaCCQN_0EplOqg_1792424453
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB9731955F03;
	Mon, 19 Oct 2026 15:40:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3A501803A44;
	Mon, 19 Oct 2026 15:40:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-6-jarkko@kernel.org>
References: <20261019142516.300040-6-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 5/8] KEYS: Prevent overflow of quota in key_alloc()
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
Content-ID: <2610079.1792424447.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:40:47 +0100
Message-ID: <2610080.1792424447@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> -	if (desclen > U16_MAX)

This should also be KEY_MAX_DESC_SIZE.

> +	if (desclen > U16_MAX || type->def_datalen > INT_MAX - desclen - 1)

That looks awkward, but I can see why you did it.

Reviewed-by: David Howells <dhowells@redhat.com>

