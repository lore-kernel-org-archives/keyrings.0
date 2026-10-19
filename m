Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425566;
	b=K+td/ta5umKzemyGm5MihBdyRLU64nlfE/S7Cbp8nQtIIAE3NgaYutaD6R7jakHoPdJV
	 UJv6TFJZphlX8PCIkVSwmOTQ8AF6TGu3YPTfe+rCGpolAXmJoisdd7OFQAYrl/xOLi2nW
	 9reBRiCkPuCJvENMx5y0896pp+U58dHHUku4/NgMFbesyJsSUHVdTG11hF3/0uUKkBbaS
	 iZNl4yrN3J0hjnJ/M+hl2WuixcyrHiut1JZYgUHF7K/YMu0/e0UWbaOZ8KW1wU/Hmrkld
	 1GeVDDGc31+zkd992DwUX1xRrT0KonqfcWM9x7YtBEGEkNEIrMR0vB9ld447RiE+qMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425566;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=mxDUftepPPOUZ/7SCslBnNQlYRdDOMe7AAGS48la1a8=;
	b=e+T1zSRRcyfiiXsPzMSenHTDeCf/dWJB+7oq8pk4Fm87IYmprMzLoThAOa8jNGDeGQfa
	 25ISd8cMfAGpuzGzEoXXwDT7kYTvVKwj+J2BwVCIR5IvyejFhfoF0BjfapCdWW5du+mHX
	 K3MGJJ8jhPFnh/BdUqIJ7S6SQniKrcfrILmImbP6oTJxbQ/sHdIgnHmlPqJTg2gecJAy/
	 l8CxVsQ3re7ZYjMVVEIcKH7JAFK+PvJAfmnnYoV+nFqJtQnQK1CQ9KqAewAwR8cUqNJvP
	 URaFsQsVOTOafUp4Zt6V6MveVHqVp5W8xbAEDrGlT7S3O9gYjJRSxvAjrowEKf2TEwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4Gxe8kY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCD606AAFC
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFCD606AAFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4Gxe8kY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxDUftepPPOUZ/7SCslBnNQlYRdDOMe7AAGS48la1a8=;
	b=J4Gxe8kYazlJXeMN9mSl1BFw9Qd/ZkzBNEby9HIVa/6KwsN5A/DFf+x4285txNuX2oFfyC
	O56DmN9+jx8Jogi0bOZrcgoYoOIKarxQmp1Bc0fuIbc56Cwhp4YortgYB2nBU+5M+KxvTF
	ucuOy/7/X4xEAUr30UlaVVHWyHqOcXA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-I0xvQN0zMnCVxghSPcACeA-1; Mon,
 19 Oct 2026 15:59:18 +0000
X-MC-Unique: I0xvQN0zMnCVxghSPcACeA-1
X-Mimecast-MFC-AGG-ID: I0xvQN0zMnCVxghSPcACeA_1792425556
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F64A1954ACF;
	Mon, 19 Oct 2026 15:59:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AFCA41B;
	Mon, 19 Oct 2026 15:59:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019145624.309790-2-jarkko@kernel.org>
References: <20261019145624.309790-2-jarkko@kernel.org> <20261019145624.309790-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
    Shuah Khan <skhan@linuxfoundation.org>,
    Randy Dunlap <rdunlap@infradead.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-doc@vger.kernel.org (open
                         list:DOCUMENTATION),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [PATCH v2 2/2] KEYS: Reject keyring creation with overridden credentials
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
Content-ID: <2610819.1792425550.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:59:10 +0100
Message-ID: <2610820.1792425550@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Would it make sense to just reject KEY_LOOKUP_CREATE at the top of the
function if the creds are overridden?

David

