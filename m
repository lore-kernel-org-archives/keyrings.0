Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446423;
	b=GHIii/1xth3vPUKjpQAmKjojw+rkl4gW31nBnd4jq0zhPmTtDW/vt/CLvS3Hyv7l+Y97
	 orzg21NJEOifg3KjiPY0GB9rKUTNT62grY8pINcr2ycl21dbSRf9v3VbxSO/usToZv9vb
	 4GddKqmMnK33k1fC9tRSgdPF2KKtfMGdp3bxgGnUmS0DMcrl7TbBAoj9Bz+k2VeE4jGak
	 0m8PB0Mme+UMV/8MDjCUovsiLZkOhfRAynPF3W/DjRV0boM8jOC/6Ta/B4lix4m/SPWrm
	 JavUV0V54f4LuzU+6Y5crFQuuL7SIc17jWoMqAYjo8XtYQOlUG59keCfTsbnciAj3PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446423;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=nCuZlJhYpzEDE8MZyIKHldrb9zK6HERF/NakAdQi+bo=;
	b=P0GATVtMXfyKlPqECMxyCG7mk0luBdSlEexqnFG7AKQgMgoRE/wXUpWC2o7+N5Rvo61L
	 3ahD7BOEv3ZZA0sV24DegtrL/1xZ34zelsUrpOO1dIqvUVSCHGuhkjnip1SMLRClUfq3h
	 QGxw6t6SR+NdgdYH1O7QJ5NMtoxReKWbu+yevuuWSHhDVoRgkpeO7oWkpLs4cxZSqXxuR
	 gCk5gCHfpc3WCZ8+HGpA1fGIlc4GQS1mVnnJ8xTCQYB4CUHWuwD+gGETS75b0pB7ACk+f
	 XrpwN+X+ftCgQWFjq7YDKTGATE/P7fNhmBaRzOcPS06pnzn1WHfFp9b87jCQN6xBvNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="NR/GI9lj";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E901606A31A
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 21:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E901606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NR/GI9lj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792446421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nCuZlJhYpzEDE8MZyIKHldrb9zK6HERF/NakAdQi+bo=;
	b=NR/GI9ljsli7UGyQB4zIvGoTZhGoJpqKiCFFH7mHsJleib39mod3WMYEgCvLX7BbhUeNUb
	FpHKYn+fNPdVoyQKMYAN/kVRQx5NlAri1LYvH3v0NHubdbzfXvR//cJ7QdlUYNXnJusa8b
	VaZrfBqt2DH6yDiqbguoYEJ7/RU3fpc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-xWjmjAB1O92E7IPUm-h4dA-1; Mon,
 19 Oct 2026 21:46:54 +0000
X-MC-Unique: xWjmjAB1O92E7IPUm-h4dA-1
X-Mimecast-MFC-AGG-ID: xWjmjAB1O92E7IPUm-h4dA_1792446411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D19AC18011E9;
	Mon, 19 Oct 2026 21:46:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 712CE1800257;
	Mon, 19 Oct 2026 21:46:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261016215326.4110064-7-jarkko@kernel.org>
References: <20261016215326.4110064-7-jarkko@kernel.org> <20261016215326.4110064-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>,
    Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
    Andrew Morton <akpm@linux-foundation.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    Bagas Sanjaya <bagasdotme@gmail.com>,
    Pasha Tatashin <pasha.tatashin@soleen.com>,
    Jani Nikula <jani.nikula@intel.com>,
    "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>,
    Pratyush Yadav <pratyush@kernel.org>,
    Frederic Weisbecker <frederic@kernel.org>,
    linux-doc@vger.kernel.org (open
                         list:DOCUMENTATION),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 6/6] lib: Remove unused assoc_array
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
Content-ID: <2630214.1792446401.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 22:46:41 +0100
Message-ID: <2630215.1792446401@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Drop the obsolete leaf-count reference from a dm-verity test comment.

This might need reworking as a commit message...

David

