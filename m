Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424518;
	b=dvdzuh0jxuO3CHvAkGe/v7ZDK3QYuQoShGjkiu8p9bOuzgiT+gVNKHOv8WmyS5GzsqKf
	 lz10XCdZQo+YoofquPx5VErco7CsZC5QCflj/K8chR0wFL+f0UEGRRB4zR/0bqi8/TL2p
	 2BaXkOe+MD9YerUKxZNCCVqbZlM+UPcZo+DwxIyRr9D445gPMXIn0Z45E7zZNsZP5UsUe
	 u9poD9SMDF9qaqFknk1uIxhVRZ4PjCjdoMTGMUbSELLKUKIZTRDucS9dkhcNCmZtu7BHy
	 Zp+WHBIa6rCl8jtW8ID02uh4gIG0GQsbnrXJukdxHWSf0QhYcOl3q8Dp6oMzTKQLIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424518;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=NaN+mCZydYoju135pw7TWTUw+J0RdYin2G9nyjNDB/Y=;
	b=tOzAOj+11/ZwcaUQOjRoM46UFitXHg0ieVH65R/j1VFy8tYIezDIaZkOGGwdlKL4jbdX
	 v1/ub9KZilIDi4zdtecFLu1ojpBE0bAa+BJcIwIf8HXdK6Vwg1IBA16cM6VEd5eImwG3h
	 K3ytVKwnycSlwdEvN6PBdjzdNKX2fYcSIE5oko9D7aiwSd1T21uSQqDgl3B5BKXv8gvAw
	 Txmyn7royrX/qr8nJXhkANpJ6tL38/N7YUAxIDeStwlDmTMC5pKc77RsVMo4kbyPZmPUl
	 GEu24mUjcd5r0BfIZMp6aWCvXdYV5VzsMZDHrQMZdHKvgHJB/jUpBkN1FypDr3fNjcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hND9+nOx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EA606DA62
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE6EA606DA62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hND9+nOx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NaN+mCZydYoju135pw7TWTUw+J0RdYin2G9nyjNDB/Y=;
	b=hND9+nOxi4kXEi0hFFxkqlkgzXOkZGXQSGclIuEkI4QUOAaaE0Ydr6RXKnYHBKaB5y424R
	W7iXcflcdTJgPbQCoA9ik9RbQvOT2XPR8lKLPq1dCqHOjQx6mlXfALVwplUJclmBbu2Flo
	ux1dlsbmw9MiXV1UfaIkdhNmwAgQgy0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-FPDmvhMOPueC8vIQAl0fXg-1; Mon,
 19 Oct 2026 15:41:52 +0000
X-MC-Unique: FPDmvhMOPueC8vIQAl0fXg-1
X-Mimecast-MFC-AGG-ID: FPDmvhMOPueC8vIQAl0fXg_1792424510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 467561955F7F;
	Mon, 19 Oct 2026 15:41:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32C9D30000E3;
	Mon, 19 Oct 2026 15:41:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-7-jarkko@kernel.org>
References: <20261019142516.300040-7-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 6/8] KEYS: Prevent overflow of user->qnbytes in key_alloc()
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
Content-ID: <2610122.1792424505.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:41:45 +0100
Message-ID: <2610123.1792424505@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I suggest merging patches 4 and 6, then add:

	Reviewed-by: David Howells <dhowells@redhat.com>

