Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422180;
	b=ge/hARUF6We+kOygVnUPI7avi3h8VIEcpRE0UR6Avc3eaRnNcWeiBgKekDABSztL8K+M
	 XyjR012G1uATZP15w/F9O39a+uuJejRu9z8+Dl0OddQX5CU80T7Wme0YkCTokiDLvwsXw
	 5AdZoiO9Ms5RKunAhvI5YpKtIdmHVVYnsw++cmt3oRWmZQwH+PF5Os26+58Ywg9aC+q8d
	 vRfkCcjnVA8QvB5lHB+tuPPb6MpFtzEvnWVsEuTeCLpByc/PZWSP03FcWW87YDM2av+Px
	 xBfUZOFY+fvJNnQPX4Y0uaVPXJH5oz8c+RqVfFjDyb+gzg+GyLsHWrp7/HWRirSVrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422180;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID:X-Scanned-By;
	bh=ePfx8hCB21CUPflsrVIbtqMdLOLqMseprJFxmf9l//o=;
	b=j/RpnwEZwH/pfWxuepFWP3AEcGCyVAI5VQ+C/cw9Br5sougkfSRyrUF/U26YdwRLzMHO
	 lMHPXM/3ny7WJZc1FupFgCdiU0uvc6j16kEJ5A2OgDUJiPUvkO7VvWueWOs7KskZ6A//e
	 +7IeRA8alut5G8uB+39NYxx6n/EQvS2zDg4MZM7qFlic8FZVDgWsqAOXbRRACEbTPnLAZ
	 PkI59xPy0CkgYo1xTenU0RhwmkzYJGYhXxkqnxz807nvP4qwVeXifPbB6/6n2ZKlvuhVl
	 9ZkGsx20gxNR+yXBM9sYqEf27GU4qMjyN6NH82Rib+ObKVod8mVLbb0ZnDKBzcSjANg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLpA1od2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADCC607BF38
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 15:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADCC607BF38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLpA1od2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792422178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePfx8hCB21CUPflsrVIbtqMdLOLqMseprJFxmf9l//o=;
	b=KLpA1od2ifcIJW4RCrOC8K/qOubcxrCPxXOimI6c8STi1t3GsBRxTXpsEXzNaHIBFm3RHN
	SxYRRc4/+ONd4aqgkO7xEuuLNmJED28lQpTs8oWwyuYcRBqIZhz3btzLo3PhO6jq2J0DSW
	4roFa2T+76RoLC8rxtTXiMCaxGpL6cE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-zTfVQHItOKawKXPO1Yy_uA-1; Mon,
 19 Oct 2026 15:02:54 +0000
X-MC-Unique: zTfVQHItOKawKXPO1Yy_uA-1
X-Mimecast-MFC-AGG-ID: zTfVQHItOKawKXPO1Yy_uA_1792422172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41CE01954AD3;
	Mon, 19 Oct 2026 15:02:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 653A030001A2;
	Mon, 19 Oct 2026 15:02:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>
References: <20261016215326.4110064-6-jarkko@kernel.org> <20261016215326.4110064-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct keyring_index
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
Content-ID: <2608629.1792422168.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:02:48 +0100
Message-ID: <2608630.1792422168@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Maintain two linked lists in the index:
> =

> - all: enumerate committed links without retrying hash table walks when
>   the table resizes.
> - keyrings: visit nested keyrings during recursive search without scanni=
ng
>   links to other key types.

Do you actually need two lists?  Can you just "sort" the list to put all t=
he
keyrings first?

> +			struct keyring_index __rcu *links;

Does that actually need an __rcu mark?  Is it going to get replaced once
allocated?

> +struct keyring_link;
> +

Somewhere near the top of internal.h, please, not sandwiched in the middle=
 of
some func declarations.

> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -14,12 +14,12 @@
>  #include <linux/err.h>
>  #include <linux/user_namespace.h>
>  #include <linux/nsproxy.h>
> +#include <keys/keyring-type.h>
> +#include <keys/user-type.h>

Why #include user-type.h here?

> +struct keyring_index {
> +	struct rhashtable	ht;
> +	struct list_head	all;
> +	struct list_head	keyrings;
> +	unsigned long		nr;		/* Number of committed links */

Given key->serial is 1-INT_MAX, nr probably doesn't need to be unsigned lo=
ng -
otoh, it's not likely to leave a hole, I guess.

> +struct keyring_link {

I wonder if keyring_entry would be a better name, but the docs do mention
making and removing links.

> +	unsigned long		hash;
> ...
> +	struct rcu_head		rcu;

Can they be in a union?  And I would put rcu first as I think there are (o=
r
maybe used to be) some things that required it to be first.

> +	struct list_head	keyrings_link;	/* in keyring_index::keyrings */

This may be unnecessary if you can put keyrings at the front of the list.

> +	struct keyring_link	*replaces;	/* Link this one replaces, or NULL */

Please don't put this in keyring_link.  It's only needed by __key_link() a=
nd
friends and could be passed around in a context struct as the edit script =
is
done now:

	struct keyring_link_context {
		struct keyring_link *spare;	/* Spare link block */
		struct keyring_link *replace;	/* Link being replaced */
	};

then:

	 int __key_link_begin(struct key *keyring,
			     const struct keyring_index_key *index_key,
	-		     struct assoc_array_edit **_edit)
	+		     struct keyring_link_context **_edit)

> +/*
> + * Remove every link from a keyring.  The caller holds keyring->sem
> + * write-locked.  A concurrent RCU reader can see some of the links gon=
e and
> + * others not yet.
> + */
> +static void keyring_remove_all_links(struct key *keyring)
> +{
> +	struct keyring_index *links =3D keyring_index_locked(keyring);
> +	struct keyring_link *link, *tmp;
> +
> +	if (!links)
> +		return;
> +	list_for_each_entry_safe(link, tmp, &links->all, all_link)
> +		keyring_remove_link(links, link);
>  }
> ...
>  int keyring_clear(struct key *keyring)
>  {
> ...
> +	keyring_remove_all_links(keyring);

This can be made atomic by replacing the key->links pointer value with NUL=
L
(since key->links is marked __rcu), then destroying the content afterwards=
.

David

