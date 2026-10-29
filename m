Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277132;
	b=Y1TYsGrBxcR0I2rJRDmjAvahqNWF8ddIpJqKEvMCBvjYMVmi7x7a7L4wohUuoNPdXevF
	 0wJ/c5PYxFQGawDWjIoJMJVIdoSOS4ci1cgurY65dU0nNU2lFbvc2a+PdLAugU5Ab2Xu+
	 BJ0Fi5D9+dUlQwiHjyh7See3+7hwJ0ksryHchxUPevvaqXKpNlRzbm2RqFkOVyKtcbsuS
	 UecV6ZxUWLyiGInIdk8OCsOM1gmhyJVxuBghP0lFZHDbTJOOYdAT8JV5bjf1OQhArEcyu
	 9QjQVRpjDeShmpKnOkIKdlokG9bDZxoS7nMjJjbCsw0KxPNKmI7njJ7w3ulXjhQzbnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277132;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zi3/I/lqphxDLrLkyjjzcmioo6LbSf2p9VhXNf8gbL4=;
	b=FCXNUkLuHy06b18dHynxRcufi8sEzDfhXxbLHfaoo8yKDAKQUKWgHL1dHE2mhswHr29g
	 ycR4EKnAl+pz0uuYHp1EF9tucxApVeW5ulyBSkiMjH9i8g5NyVjXDRxsX8fB1j17Ip7Qv
	 cvdYnto7SYKOr2b3Bt4ofzYX6yVmkM6mem+D5jteH+4DoeIH899t24ZwGQjjPiD5VVRb9
	 bkqqU1J2LjOxoxVGDL2woHTmAM5o7770vSCCUZBkAKwse5RT1oW27yy385BpYD2JjYQy7
	 oWv+mL4HIuQ2n4zzhsR28zhd5drtmkn3xtuH7xdb9GWYd/hMRT7wbeCmRQBupKfYw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KshZHmzM;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=F1KZcrV1;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41031606A31D;
	Thu, 29 Oct 2026 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41031606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KshZHmzM;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=F1KZcrV1
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793277118; bh=zi3/I/lqphxDLrLkyjjzcmi
	oo6LbSf2p9VhXNf8gbL4=; b=KshZHmzM7/ziOyQwv2byZQC8NIBXQEzjeQ0ZTx33R2c6oChoeP
	LWT3yCI5UFuztS6zNGHMCLr/n105jvpRP30wp4ZAmP6X82HvGDOGGLeS0AIoYxUGn2cb84dbFQO
	N02Tw+NVuw9EAtko/++lZnjULf95NE6I/2wINHKGWDnCq6fS88Xv1ZXxxwX4GuMvwnSnef5H0VQ
	82if8j7byW2wjfvTpd0oHUIaRhl5YE86UPKhEEt5PdzM99pP6kXFEmrTJEKpL0clyDH4ZSXa7u3
	2Kw00rQjkMlysuSZc2E7/d87YlfvCAwce7NJNO6XAM5DO9Znk/6vndFQsNdQ5GVusBg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793277118; bh=zi3/I/lqphxDLrLkyjjzcmi
	oo6LbSf2p9VhXNf8gbL4=; b=F1KZcrV1SSdid+de1DKPGZ0uNAIAgFUE0N6Hf2UiA9GgRPKFJg
	jLtIKw8bYJHKW0BKsBxaqa1l9avZ4PNL5PAQ==;
Date: Thu, 29 Oct 2026 12:31:59 +0000
From: Bradley Morgan <brads@mainlining.org>
To: zhiyuzhang999@gmail.com
CC: brauner@kernel.org, dhowells@redhat.com, edumazet@kernel.org, greg@kroah.com,
 jarkko@kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 lyutoon@gmail.com, ncardwell@google.com, security@kernel.org,
 tpluszz77@gmail.com
Subject: Re: [BUG] watch_queue: RCU/info_id overlap leaks kernel stack
In-Reply-To: <CALf2hKv6KAFJTyDBy_yqt7QPvA1ewZHzBxchAUmcFxSeNXghOg@mail.gmail.com>
Message-ID: <02F6DE4D-E2E4-4637-96E0-33034D91839A@mainlining.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 October 2026 12:05:02 GMT, Zhiyu Zhang <zhiyuzhang999@gmail.com>
wrote:
>Hi Greg,
>
>> The documentation also says that a patch should be sent which I can't
>> seem to find here, am I missing it somewhere?
>
>I'm sorry for miss-cc you. The patch for the watch_queue bug can be found
>here,
>which just got reviewed by Bradley Morgan <brads@mainlining.org>:
>https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/

Why CC security@k.o for a ai generated bug?

Well, this patch looks okay to me.

>
>Another patch candidate for the relevant netdev bug, which combined as
>the lpe, can be found in this email thread:
>https://lore.kernel.org/netdev/CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0JfaOhLA@mail.gmail.com/
>
>I am waiting for the maintainers' approval to send that patch.
>
>Bests,
>Zhiyu
>
>Greg KH <greg@kroah.com> 于2026年10月29日周四 14:43写道：
>
>
>>
>> On Thu, Oct 29, 2026 at 01:06:28AM +0800, Zhiyu Zhang wrote:
>> > We will send the reproducers (including the complete exp for lpe) to
>you
>> > and the relevant maintainers privately. I understand your point that a
>> > similar reproducer can likely be recreated with a few LLM prompts.
>> > Nevertheless, Documentation/process/security-bugs.rst says not to
>> > publish a reproducer for an AI-assisted finding, so we are keeping it
>off-list.
>> > The same guidance says that AI-assisted findings must be treated as
>public,
>> > which is why the report was posted publicly.
>>
>> The documentation also says that a patch should be sent which I can't
>> seem to find here, am I missing it somewhere?
>>
>> thanks,
>>
>> greg k-h
>
>

--- Thanks!
