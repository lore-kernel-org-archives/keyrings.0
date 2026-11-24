Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558406;
	b=mMuJFzpxnGwTyDABZnjP2Wx8yDMzegVcRy/N/hUuxQ8V3UsI82SIVBsA4i8bTSvESrb9
	 bgvsne3x77gQT6B4ECRfLNs+zRK6N8w0tKCl17X2lfrTxn1rygwHSugjwkq50YnWVONWL
	 ah6/j3kHz6otW6e9L0R4T2fqEhiBD72Xjf0Whwn+YOV+ugHpoFKMSLLVAlixIraHLPSNh
	 z8l6M8AuqRSOhzZK1Op+UkFiWl9+mcriLtw0Fx13e82lofJu732LFKOh59cxEOfK/HBli
	 BkHm3XYV6wVgytuQmpf5TaU6XNRfI5kTxBGq5uQHa8XMDy2pUy4Pb5RFbwe8gXBy0QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=;
	b=u5KJ6AfzjqASLFtrqvQ5Vwf0tCzD9vB25TiYXOSRGqNnVSwLwTGN8QaSmywIODFY1l/2
	 IeknMaYVBxQ1Kem6r1F+QB3/cC2NmG/XYdZM3sQgVcKgR4acGsUJnznO6bUBcKEJLbxxq
	 cw3R2Z2zat5DkkyeXd6dWhkRtgIuOO0UPxt83Uk37wIxEtucVSbTM2SbFyu7J445f9J5P
	 umHMoB3AqmTz4apKocPX9F0fq5ReTVH4sIEYNyr9PDDEttoXyC8ZSb0UwSBOnXMNfOlPR
	 0pyAzAXLWHgkYXfrLGQ9b9OzKJk/v+bf/5EIVpGp+1NLiXdyzeq3Ok/X8i5vOgicd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDLc7hNT;
	arc=none smtp.remote-ip=74.125.224.131
Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165D606A321
	for <keyrings@vger.kernel.org>; Tue, 24 Nov 2026 22:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5165D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDLc7hNT
Received: by mail-yx2-f3.google.com with SMTP id 00721157ae682-8b521794242so7621777b3.1
        for <keyrings@vger.kernel.org>; Tue, 24 Nov 2026 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795558405; x=1796163205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=;
        b=IDLc7hNTu5+Ki/2urx0xGVwPx1ge6KES8tl67HhEyposIInM0NddOsieyTHhoBgRZw
         eUDh3pmJ5kPD9Lm7UFichaB1jeC2oGKsbtCdp4VeabJCFDYUydsl8PM0qIQs1t7dIB5z
         05o0lKtNRFIiNhsZe6HeyHpR26szeysImpDo+yB9d+RxbNfuKleNZZ0jOeJvBYUWV1KX
         VGRLmjh2PDD8SLm4vwpsjUEwPsEPmHKdN7xZDwD7E9RsWTeLgGX5X8ENm7drAFPd0S9e
         mlV5S4svAzhoMWD9ItfNanRRJv2FMGccMK/KBjFaX71pAqPozA9w7gbkV7O9Fcs1UC0P
         7/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795558405; x=1796163205;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=;
        b=XJjQmRIwiQmr200mJb9d0dDQXzA5uMNcnaPAE3bg2A3ThFWBBkkMQ3987B+D4hizKf
         mbw02azMuZ8LSm38/5fsfYZ/om0SzYZWSYS813PlpP0Qsp2nqXioXmHLnuimjZUGFeXZ
         Cew1aCYxsarybK4sSyeioHM19nB8Crr+JBKKU41tUI7/RjgAXcEmizi0ylkGQ0U//AyO
         pJXwxrx/6nkVxAi4tMNAEx2Pa/vBdJ3/JaBPYKago0Qf/2b5tSOONps+vLNIIBsEp2K7
         DBHh+gIAxP+A6wRPw18jThnWqsLgvobFhTJmtqdMJWF07lSWZp8l5Ao/4p4H0EhAGolm
         htPw==
X-Forwarded-Encrypted: i=1; AL+hErEa4GzYGkcRuWZIDTmaLANKD+bvJQWK7GGWSr98pfVRGqQodrjkKA5osh4oX7PRTUSuzc22LZT0OQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y++S6/7I4KrO/RRejo+HcB1yY5oGbKFse27tOwziuIjJFOgey
	QLsc9QCFQC1/p2rvBtxrRuEUGILOQODgVZfkCIuQ1AnksODgiK6JsEVh
X-Gm-Gg: AZFdTZeaMPo9oZJvfTu34bI2oDmGhnjKGejVUkZ4cBcuJxM8JWWAPyDn92kbtC/QsnK
	d/LAHryN6x6GkmKIjKyKJkgYIB9x9wEj76owyFeG78Vx+o3sRjYvt8Cjp6OSC3D5Uf4KDglaDRg
	832jNZts+3KNXKexYQR5kT5llt+gN7eUByUhEUCPr0KNm1mqkUf5buD4SRGKVbJ1zUWg5RZyFrG
	qi1ULpjOvn7qKkUrM3qf57lOcUsikermNPrQT+FUS79u2NEr4kzAcwFzk12M/7ThjrNCvMVPohq
	62ShNK4Yi9jUL+Y0iEClRYU6FBzBXiiHCu38I0Ul9GV8PxwWazIvB9+TobGK5p1HQMsMoaMwqBd
	QPECPKkzpdiwUPEGwjcjEh072ebxTXhyvP4kAmy0PdJDct8UK2qlInh5vKnGkuLx7gzumh51UFk
	pFHJM1bBFji9XBrltqt+tVevt0o/uK/b100IkBpBKMHoFXXVPiu2pKBxhqPjtoKaWDIURP8uPE5
	ifrZ4/rRJsWEyca9Z8E6MRDYp0yaBHpplFnoedeecxzZm9MR0R0wKq+TCFf/odKas7zHgVdDzrE
	o6dLubohRUl7sojpe6E4Zgn6dW31Y8OEjMws
X-Received: by 2002:a05:690c:4b8f:b0:8b0:e10d:1975 with SMTP id 00721157ae682-8b520435695mr52461807b3.29.1795558405356;
        Tue, 24 Nov 2026 14:13:25 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028d89csm65560977b3.15.2026.11.24.14.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 14:13:24 -0800 (PST)
Message-ID: <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
Date: Tue, 24 Nov 2026 17:13:24 -0500
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
 <20261124213222.GD2227373@google.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261124213222.GD2227373@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/26 16:32, Eric Biggers wrote:
> Even if you actually need runtime key rotation without touching
> configfs/sysfs (why, when nvme-keysd could just write those files
> itself?), this series doesn't actually implement that.

Correct, v6 does not implement it. That is what I am asking for.

Writing sysfs from nvme-keysd would give two mechanisms for the same
key: the keyring for the connect, and sysfs for every change after
that. One mechanism is enough.

It would also make nvme-keysd controller-aware. Today nvme-keysd adds
a key to the keyring and does not know which controllers use it. This
is by design. To write sysfs, it would have to track every controller
and know which key each one uses, also for controllers created later.

A lookup by description at each authentication avoids this. It is
also how NVMe/TCP TLS PSKs already work.

With a lookup at each authentication, the sysfs and configfs
attributes no longer need to carry secrets. For a key from the
keyring, they can hold the key description: a read returns it, and a
write sets the description used at the next authentication. The
secret then stays in the keyring, and changing it needs no write to
sysfs. Raw secrets given on connect keep the current behavior.

Martin

