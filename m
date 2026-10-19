Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425746;
	b=akp/zGzAOf0aW0ZZnWXlkVW9neZVL6vW5FdaCRf8HL2Ha2tNOCP0Ozk5qzBbRCXK8OPu
	 v3+TQAhz8pd05pss/tio4OybtAfKPT7eA0W29Ug8MRMTEDVh8uwCICWTHrk8lfUGK9wVn
	 JJiPWMROvl9VVjiswxCG+QqV3iMKAp2AeombpcuR8cxYebsdl/A6/x79xJSI9ROcyCAVC
	 W1fl0sxROzrapxJGbPSyvTCzk8pCAUu4CatzOXWjCZHZ942un9qN7fNgNIjDp7OAHHjum
	 yCj9tmvP5n8u5E+Ax07Ngd5QdNPjnLtatqKen8fK4vVnSuwASHchvOoSRQfhUoVesbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425746;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=e21nPxrTd0xUy0wA3EV2y1n1We/XsbVbbkzGvEvuXk8=;
	b=l9/jj9uJH3vtykw0tlqQIm/+T+Qhy+iV1OJ2FaDSBp5Zs29FvAtIwtj/5pCrWlIVW5+n
	 TUmqFA/hRRNP6izZMGmtVrSKa9EGyJCJGCTY+aSfGWwfEr3o7YN56BYiMWlti9UbCWfAS
	 RtMSk+uEWeWt6A6YmDU/mQSxuvCAaf73hPtoNcKCeoT1fhmYvJ8xzv9ouzg+CuatUdEqK
	 Xdg4Zqniot9f0xqa/d8UjGaE9kEakLR+AnhJOGlgI50F89zQxt0lDYy2Le4Ccvl1q+pz2
	 cMkzshFlUr7WwRRl3171I0B1QjrouPBsnmWIuBxQ++BdkHY8+AGgvSRxWZuPQWPNsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivXoLEi4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF2606C922
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 16:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FF2606C922
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivXoLEi4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e21nPxrTd0xUy0wA3EV2y1n1We/XsbVbbkzGvEvuXk8=;
	b=ivXoLEi4jLGUNWQx0cIDi+SPjmFGJ5Qyt2frme9iV7GFo0yfzctwmVrc6538N3bzfOU8aB
	hlayoVLhBbxld78KybrYDBD1E/XPFUaHVWG590zv9fC1mmVInqCSNyTYeAJ1kgk/Uu+WBQ
	WbXQo52rGsKCNEsjqluiyt0qMblXOM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-f4hjYIXgNj-G-E-h_YeMAw-1; Mon,
 19 Oct 2026 16:02:21 +0000
X-MC-Unique: f4hjYIXgNj-G-E-h_YeMAw-1
X-Mimecast-MFC-AGG-ID: f4hjYIXgNj-G-E-h_YeMAw_1792425739
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 639231954AFB;
	Mon, 19 Oct 2026 16:02:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10360362;
	Mon, 19 Oct 2026 16:02:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <atY0fRZ_s5UQk8Fk@kernel.org>
References: <atY0fRZ_s5UQk8Fk@kernel.org> <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Cen Zhang <zzzccc427@gmail.com>,
    paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
    keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
    linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
    jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Protect the read method check against type removal
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
Content-ID: <2610921.1792425734.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 17:02:14 +0100
Message-ID: <2610922.1792425734@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Mon, Oct 19, 2026 at 10:57:21PM +0800, Cen Zhang wrote:
> > keyctl_read_key() checks key->type->read without holding key->sem.
> > A reference keeps the key alive, but does not pin the module containing
> > its type. A surviving RxRPC key can therefore be read while AF_RXRPC
> > is being unloaded:
> > 
> >   KEYCTL_READ task                    Module unload and key GC
> >   ----------------                   ------------------------
> >   lookup_user_key()
> >   permission / possession checks
> >   load key->type
> >                                      af_rxrpc_exit()
> >                                        unregister_key_type()
> >                                          GC: down_write(key->sem)
> >                                          GC: retype to key_type_dead
> >                                          GC: up_write(key->sem)
> >                                        unregister_key_type() returns
> >                                      free_module()
> >   read saved type's read member
> > 
> > The final access can read freed module storage. The read invocation in
> > __keyctl_read_key() is already protected by key->sem, but the earlier
> > method check is outside that critical section.
> > 
> > Move the method check into __keyctl_read_key(), after key_validate() and
> > under its existing read hold on key->sem. The check and invocation then
> > use the same protected type for length queries and every read retry.
> > The GC cannot retype the key until the semaphore is released, and type
> > unregistration waits for that GC pass before the module can be freed.
> > 
> > Return -EOPNOTSUPP when validation succeeds and the type has no read
> > method. A temporary buffer may now be allocated before this result;
> > allocation and copying to userspace remain outside the semaphore.
> > 
> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> 
> I literally described the fix to the reported bug instead of reviewing a
> bug fix. That means by practical means that you only reported a bug.
> This cannot happen again and if it does, next time I'll just do the
> right fix myself and commit to the Git because that matches the reality
> the best.
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>

