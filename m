Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DA30B501
	for <keyrings@vger.kernel.org>; Fri,  5 Jun 2026 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695186; cv=none; b=QlEyeZDkmF4whsqpIiUPPIQ4xPB4OWUedEgYr+jroOtg0l/982iu5Dd4ggiXJ5b8jH6qA2Ur1zFmlDEvVuwZfXjnnEfsbvXwnbKUDJVU/uBphf1x0IFOZIwPmOaGbd4NccareWlEKVkcaOE4tQ1FuNhXHSJMBYJjdmg7Ihdyd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695186; c=relaxed/simple;
	bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqVfxUI+tFDaa6P9rIZ5J3M4s1r1M1XHioOgWCfjPh1M1gqVGAcsCnGmZDsh5LvhvPcnViRTeEA6TK3gMyFYHOyLPJ5MVVMi4pIXcEg/SUDtXQyLIFC/SF8GnpA74usamaPcD3gx3FgwMfmfDSIo9aDCOSFNULGeZS33oVpM7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a765d410so24869355e9.1
        for <keyrings@vger.kernel.org>; Fri, 05 Jun 2026 14:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695184; x=1781299984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
        b=Sof50u49ntOtwQLwMLZ1qZJIrW9tSg3YaHGErXqfmeVFZoakZru+TfK7lulhrMoEh8
         iL8e7yzWazo6gq1BrWEvqwXsYf0JNmwynsTd875CmcflqzGMliud5b+WHuJC5LqsAhGx
         CNHHtRYI9vc1IdnWLtbg713HhvSqsTqfabtv+65wvE1+4/gJ+fN20t4osCvPtlO7X2w3
         tBmRHR7ldRHWqmlJveGwz6vJowTZ4zlMcRy7Q5OyWRUX8QCrFpIIgi8ReqPcYh9JvTei
         ADGCHljysGc5tTpjJA6/9pHWlyTOeDA/spun5duA7qf/MhCwaM/mX8tuBvMPAIhm7ruv
         XdoQ==
X-Gm-Message-State: AOJu0YyEZ2imF6pTWE0vGTlTTKfC7h7aka14r0NWUAOollIo2k5S//As
	FpaHDoV/k3tGY+zB1Mzb0VooZEOr/+A84ARnKHWmBg4tYfgnuogbX/tg
X-Gm-Gg: Acq92OEClkdORcc6Ou2Czphw/6inZKNJC3KflBscfMMWj495dKe7u/wrHXE4IUYbZ46
	wBLdDo9sVGhMemR+uNSK80G8XsLa7HKRoTCAZEyoAR4YTtVbxL+8w9D8Zyvhi41sNffv3caJ43V
	TjqZxeHQLrbc8z3aJ+Gp1/6wUAGlOTzdH+LgO2yMlgkKjT1ey1LAqw2CzR/tULwnQVcjtUZzQlw
	YVludXLTnED+X+wjXCCKe6G+ygpMAmSS3/FV1YC/FKzfRj9VLfRWEddAvLqM3Ub+ZlevnNB41NA
	ZyaY5ftPdwTzVTJsnBbr1sidojEPgxLaHi9pdWRW69vqj/32e1G8i0NMEjzDs2XQM5GWRwCvLAJ
	i7wecKPkLuUi7fLknjg6ETRNBrH9RkfeJh/23eb2EZax4ToVuw3XK3UhFpdTjflWJPSovTGtSYd
	9eAyXmknYlPqUzOKSlTSnwFXW6jTpOZgyomrjTpHzanWmXVbpoFmiLhN0TVoXyrbk=
X-Received: by 2002:a05:600c:8183:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490c25c6625mr78070045e9.25.1780695183438;
        Fri, 05 Jun 2026 14:33:03 -0700 (PDT)
Received: from [10.100.102.74] (89-138-67-1.bb.netvision.net.il. [89.138.67.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d52e5esm48030115e9.2.2026.06.05.14.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:33:01 -0700 (PDT)
Message-ID: <ab767baf-aa94-4ff7-81fb-c19804a7883d@grimberg.me>
Date: Sat, 6 Jun 2026 00:32:59 +0300
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Chuck Lever <cel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
 <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
 <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 17:27, Chuck Lever wrote:
> On Tue, Jun 2, 2026, at 6:39 PM, Hannes Reinecke wrote:
>> I am all for making keyrings namespace-aware. Logically I _think_ they
>> should be tagged per user-namespace, as this really is about the
>> filesystem (and as such would warrant to be tagged per mount ns).
>> Tagging it per net-namespace is not a great fit (well, for me, at
>> least), as also block devices might require keys to present the
>> bdev (eg nvme authentication)
> My understanding of the proposal is that there is one keyring on the
> system for .nfs and the keys in it are visible only in the namespace
> where they were created.
>
> Therefore the consumer (say, NFS, or NFSD) is running in a particular
> network namespace. It will create keys on the one .nfs keyring, but
> only the tlshd in that same network namespace will have access to
> those keys.

Can tlshd run in multiple network namesapces today?

>
>
>> I might be okay to have it tagged per net-namespace, though, as all
>> current users are in some shape or form being network related.
>> But I'm not sure if that stays that way, so I am worried if we're
>> not restricting ourselves to much by that choice.
>> As really, the question is: what is the driving the namespace selection?
>> Is it the _requesting_ layer, ie the layer issuing the mount() call?
>> Or is it the _providing_ layer, ie the layer providing the
>> devices/interfaces where the mount() call is operating on?
>> If it's the former, then we need to tag is as
>> net-namespace. If it's the latter, then we need to tag it as a
>> user-namespace / mount-ns.
> tlshd is a network layer service, so it doesn't make sense to bind
> it to a user or mount namespace, IMHO.

I agree with network namespace isolation.

