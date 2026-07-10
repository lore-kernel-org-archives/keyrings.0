Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D63DBD5B
	for <keyrings@vger.kernel.org>; Fri, 10 Jul 2026 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676356; cv=none; b=TA8ubyySMInLJxg7pqpsCQUNbInCB1XFyeky5MnWmvfmmSphvymezAllrjjkgKWKUTzczLd3Ua++cq3eNdqnGTEbuj4QoQ5Xl9xweVgE5UHD5bSkrRQKnZt/XUi7lF86tjWjX1/pwgYr7cRQPp1y0I/VhZH4yAeEnjWmyPiuwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676356; c=relaxed/simple;
	bh=tMcFLGQQp6kEB4sPtUNZgVVh+m9JR0FwtLdYZracIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9SMf+wGn43WMAEDsppjSUGYl4cpsr8wsrTdiBDlkF6zLuCB2EcGEd4zlTVQZuH4xxYMI094Ffk7qCcV9MC65tiX0IV7DE0wtZ5WwM0R+06ALCwbSRfgpkz+Yb48L1BTE4JqmLq4jSi7IZi97/c1znLNZopbsbq96DTSfqUpUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AP6GEjb4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=htrIYytj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AP6GEjb4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="htrIYytj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783676354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
	b=AP6GEjb490rkM1XnT5ict1sV72yymoKZS9lqWkb5UHv9017VjoZGVpJPbnfGDPeUlhKA0k
	SvzRd+A9sDK6FAC3m3Yh+9rtVmDD7EWR2tLI72A7cbHcZ1cvZh7etn6Tbfljo3NwQmiOP8
	tLBFvc1fz048DU3LCYNGMfk3Br/fUvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-tsjCNos6M5qi3UaZ4nA0fQ-1; Fri, 10 Jul 2026 05:39:12 -0400
X-MC-Unique: tsjCNos6M5qi3UaZ4nA0fQ-1
X-Mimecast-MFC-AGG-ID: tsjCNos6M5qi3UaZ4nA0fQ_1783676351
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso479605f8f.3
        for <keyrings@vger.kernel.org>; Fri, 10 Jul 2026 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783676351; x=1784281151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
        b=htrIYytjmnFUBerwB057efRfFPOADomWjSj4yawSx6mVdxeqWVJ2QTfoQG1N+Zbv3Z
         KSCTnS7uKRnd7pQN757mTQbwyIKkyM7lq6OxkU9EiGepuScwM/YS5hYzXLeyNgk0xfMC
         zNox7q+LHtWe8aBWAqGd1i8oHIMHLxA+GTjRuIXGBhIGJvjvfaalnZtdo8JoPped2JFG
         zkXB3/lxVxKoDIYt3tIepR2RUCP0ROVXwxb1P4tQWyXhICQCdo69DS4tD4xdoNO7Si+I
         ov2GYxKXiX4dAU5Q1omSqGi7iskWrXQLBjkdWKWzLe4vC8FUVtiT0qxpIgDj+1ILFDe1
         nIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676351; x=1784281151;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXg0+wcS9DBXi+xElmyf+7VX+3uK9Wykzq5J/dCPMos=;
        b=qhQRjykuLEFMkFCVo5mmqq9VzCnbVEvGnz2QgPgoOcrgB94vzUh7QmRMLxHZKqnnHw
         +be2iwWIAi/BfQVbfBQIZlMTSX+YnV2+6F1W+QkGCuF7KHdwUHSTPRuiL4VGu0G19lqa
         nVNy8spsDiPFT8nwwZfgR5NARGY5DefHfoEN/gAxtJwLNTQWA9AsqWTOfY8Nvj8QkhNw
         hj5IACXTkJNSnwsZ36Jw56Gz/H8haFgrTyz6wL8I6pZ6md7zqaIsSTn30nDWqmzM7n9O
         18BkcuY3+zI2ABnOnW8tny5VV9Y9VNIpBabCtFu6vFkYLX9+bLMv6n7IvClWqDMKm94x
         +a+A==
X-Forwarded-Encrypted: i=1; AHgh+RprjO7qquolY2hg0JbxxA2/a2mkNxlZx1Pdd7ytX4fnGMNVLirKY3k/mw/uUMLltmOC4uTHqlsNjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmWDgFQDql3vlwZE30a6srdqqjgP3maadb8L24Ej6q/whQgB/
	/IanS33K0xzqI8A20aazvo6xSWGa6RpyYS0zBRIWsutwv+cZswrCBaa6C5N4IjVTXsSpnD6jgUE
	2InWCwi4itfCkf9f952neLd9nxo0jlJfU5FioBdcpzmYGX7b6YgWhkh7SVNsO
X-Gm-Gg: AfdE7ckLgzGNXBpRh55b4GqRnZixMbsNON7iv7XYkE9QCManLK9Ztl4JkH6Kdtf2Xlv
	hl9SBxNNWhfzBkrzW9ZEMaGZRowH1U29lCv8uhF65URkESiHEtV9yzeTU1zLnTnT4tJL7MCRHDq
	3VYLLiH+q9Zh4yPTe5a2J65MpryVHeXleVpGf/v+QvUEYpA39G1lamqNBw5ZydsU7oNMdCKmxHy
	bMcjCPMjFv4UYJiklQS56mL5X/pRIA2d9MFh+tW4Q3QOkRtcHIgM1/S81xjsn/pI1TkN3CHtz8K
	c+JvAGSUcnoz3tavCi+bFCqYmwoxvQpRZTe03Yp4dl6oFX7oUBwQ5Ion22xFiqCRmMhL0t1AL5S
	oFOhM5mOUU8OGoyYrnwmgb1JPdoFLvtAKA3lLEfLE0K2oidJWWn4gFBTJgtLvpqZF977hLmnyEF
	x3KMI/Rvt7sMJd
X-Received: by 2002:a05:600c:6286:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-493e6892d8bmr105299435e9.8.1783676351406;
        Fri, 10 Jul 2026 02:39:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6286:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-493e6892d8bmr105299095e9.8.1783676350840;
        Fri, 10 Jul 2026 02:39:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm55755378f8f.10.2026.07.10.02.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:39:10 -0700 (PDT)
Message-ID: <6d6388c9-cdeb-4b91-b393-125f4a5b7e0c@redhat.com>
Date: Fri, 10 Jul 2026 11:39:07 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] rxrpc: Fix CHALLENGE packet overqueuing and
 simplify RESPONSE generation
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
 stable@kernel.org
References: <20260702144919.172295-1-dhowells@redhat.com>
 <20260702144919.172295-5-dhowells@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702144919.172295-5-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 4:49 PM, David Howells wrote:
> Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
> the AF_RXRPC socket that generated one of the calls on that connection for
> the application (which might be in userspace) to service.  The application
> then picks up the CHALLENGE and requests a RESPONSE packet be generated,
> allowing the app to include app-specific data in it if appropriate.  There
> is, however, no actual limit on the capacity of the CHALLENGE queue, and
> this could be abused remotely - and also getting the OOB mechanism right
> has proven tricky.
> 
> Further, by analogy with other AFS codebases, it's not actually necessary
> to generate the application data in response to the CHALLENGE.  The reason
> I did this was to set the encryption on the app-data to be the same as that
> specified in the CHALLENGE as the server must be able to handle that.
> However, it's sufficient to use the encoding type set in the token that is
> going to be sent to the server; presumably the kerberos server knows that
> the fileserver can handle that type - otherwise why tell the client to use
> it?
> 
> With this in mind, make the following changes to the rxrpc server:
> 
>  (1) Remove the OOB queuing stuff and retire the related CMSG values and
>      sockopt.
> 
>  (2) Revert to making the connection event processor work item parse the
>      CHALLENGE and generate the RESPONSE directly.
> 
>  (3) Add another (optional) parameter that is passed in when an rxrpc
>      client call is created and ends up attached to the connection bundle
>      and is a user-type key containing the application data.
> 
>  (4) RESPONSE generation looks at the bundle and if the app-data is there,
>      it will include it (if the security class is YFS-RxGK; RxKAD ignores
>      it).
> 
>  (5) The AFS filesystem driver will create an app-data key when it probes a
>      fileserver and will attach it to the afs_server struct.  This is then
>      picked up when a call is made to that server and passed to rxrpc.
> 
>  (6) Direct userspace users of AF_RXRPC can partake by creating a user-type
>      key containing the app-data they want to use and passing its serial ID
>      in a CMSG of type RXRPC_RESPONSE_APPDATA in the initial sendmsg() of a
>      call.
> 
> To support this, I've made a change outside of afs and rxrc:
> 
>  (7) Add a refcount to the user-type key payload.  The problem is that the
>      RESPONSE packet generator needs to look at the length of the app-data,
>      allocate a buffer for the packet and then copy the app-data in - but
>      the RCU read lock cannot be held across the allocation and the key
>      might get updated.  To get around this, a ref is taken on the payload
>      before the allocation and then put afterwards.
> 
>  (8) Since the DNS resolver makes use of the user-defined type's code, but
>      allocates the payload itself, make it initialise the refcount.
> 
> Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
> Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: keyrings@vger.kernel.org
> cc: stable@kernel.org
> ---
>  fs/afs/cm_security.c         | 151 ++++++--------
>  fs/afs/fs_probe.c            |   5 +
>  fs/afs/internal.h            |  37 ++--
>  fs/afs/main.c                |   1 -
>  fs/afs/rxrpc.c               |  39 ++--
>  fs/afs/server.c              |   2 +-
>  include/keys/user-type.h     |   2 +
>  include/net/af_rxrpc.h       |  20 +-
>  include/trace/events/afs.h   |   1 +
>  include/trace/events/rxrpc.h |   2 -
>  include/uapi/linux/rxrpc.h   |   6 +-
>  net/dns_resolver/dns_key.c   |   1 +
>  net/rxrpc/Makefile           |   1 -
>  net/rxrpc/af_rxrpc.c         |  49 +----
>  net/rxrpc/ar-internal.h      |  22 +-
>  net/rxrpc/call_object.c      |   4 +-
>  net/rxrpc/conn_client.c      |   2 +
>  net/rxrpc/conn_event.c       |  68 +-----
>  net/rxrpc/key.c              |  36 ++++
>  net/rxrpc/oob.c              | 387 -----------------------------------
>  net/rxrpc/recvmsg.c          |  84 +-------
>  net/rxrpc/rxgk.c             | 128 +++---------
>  net/rxrpc/rxkad.c            |  27 ---
>  net/rxrpc/sendmsg.c          |  15 ++
>  net/rxrpc/server_key.c       |  40 ----
>  security/keys/user_defined.c |  23 ++-
>  26 files changed, 238 insertions(+), 915 deletions(-)
>  delete mode 100644 net/rxrpc/oob.c

This is quite big and difficult to review, could you please someout
break it in smaller chunk?

/P

