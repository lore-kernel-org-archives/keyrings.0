Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711783;
	b=1QYcYMAcXDoRcE7QFVmjnbv0Xc8BfkRa49eiKka9D79FOnj2FVKD3V/Sc/jr6GGZQ/b3
	 SmjVYcHBwVLtz7DqoS8s7vKnduiGltckDU83Fwk+b89idV9pCvHnBH+DunGBcz7rr01ov
	 1FzFNObopF7E2ZT5SmE91D1uyL7mjA0Yl3DooBBsffVfWC6p6BbN0GbiXBgiYaiq5e+gk
	 4ehWbtXzm1TizkYWuYskYUGSCmkFoT49TZPIePuFXqi6n4lSkkKNJ4JRbuj+jcoaUFRas
	 XpKXVY+he8/QEUSJygphgGqBN9Ie0c51Ia+wAPwGHZJfef1qsoq+MLrhtR9e74zzz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=;
	b=yxRIhPPqRlE1adhGL2MesT7zdoIGtIUM1aRKJiELu+7VyHhyoSP8DXDHmT4cDx0uP6xP
	 HgvLYCzNdZnsDHinEY47x9H1Fax6e2ziA2kQ/Ic5SeDKNvxgfO7DN/VBBqoMtT9FeC2Wa
	 RsAUZ3b8h++z91J5kK7tjmTy2yIazPuhSSdXVgqqpV8MeubX91nz/9AjLnTVUV9ObxPaK
	 J/Qz0tsbYzhZunOC0fwtrHsHEbrxaEWzDBx1PzPt1ToxvzVysf5+kp/gQN+NUk4/B9cfz
	 6WLJjLnmmh/1nh9j9xyxuuxZLW1eCD0mgzMMfQJpUckSjEFJ8Au0EF75uJ6xUvuFO6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7pM3cBj;
	arc=none smtp.remote-ip=74.125.224.68
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7E606A31C
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 16:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7pM3cBj
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-67da7d18f2fso8100289d50.0
        for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711782; x=1796316582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=;
        b=Z7pM3cBjMRzW8nXOyCq83PqF3nIumnqa+W7Jvl0uac73Mvw3NjNEVgvyEkJLAtKR3U
         Px7D6pyDEBhYGHbvE8WxCmjxrPs5BoKZklUD6Mdm3LHEL0HqhSqZjpD4oB70RPzTo/cD
         ouVbipBM2E4R8QSS7wHH4S7bgf1jiNgHAWcFg3ayLsGn7LD454olmDSVULWt19RuoSuR
         LmyhdmdK9Tmwif3e/By/2ZoEDCqCUHQrK8b6/d2VfdtjhGEtVtGeWdV7V/lnUmzB3VOo
         IDrHc9HNHgULAbo4KUw4QB9cQ2s+BnuHg/LslC9KcUmeNhVvDrbQQ+Vn+aDSq6BIKqVM
         HSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711782; x=1796316582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=;
        b=tl9MWsPaiOz7tlwHsm4gxmbZq5N60z3T8maUJ+/IXqU3EkV451Zg94V78IgLST+Mjv
         sh8/7pOz1boP5HLeDv9RKOccFCELvGs+mPZZMVgUxrVKK9ESJhgZWspX3ZQwZ2mNvS03
         jfaqZ3DiXEMVBZZ4MiaynN4pot4RYGDtlXrHn9DEvEi52wyRDRT5I+wxGkwZk4oCKpXp
         1/1WM5g7cp2ODMAdIk6AWPd3Nlp44ik+fQHU2XKX2gyz9IqDff49XaMED8wNbc2cpu6F
         NK5QCbfdzIappX5LOELXWaTS5ViwMRfmY2k/GMMnSTI6uV6bggc7AktjaOS7fvneLewH
         FzbA==
X-Forwarded-Encrypted: i=1; AL+hErE+JbOQG/UZ1uABlnBoEkPc68EcOLPgRPQsTLvn5dm5IKFRUUkMHUdTkR4G2fdJfODG4mTxwsN1Zg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C/CtPPAIfgvujgpVAIU+J+qH6x2XYp3IqNwDCOs+VAHvKvM3A
	XHo/+jstVmGcDJef0u43s0uiakoc1YaNYOKi06YBwcQnHpONUEyPGXJp
X-Gm-Gg: AZFdTZdiu3cOxQynvbinpNGQxxv10jgw/wzNulNKmxt0iHq39fUATfsUlPcNsH0IJ0C
	s8sQjBckSMlQdmJLDpqZq/0AxLw3vnYlyup9ws987LF4tgthPu/hQpxAz8QT3CL1mbUkXnIRR4x
	Pvo2LsqetpbvAA7vAJwiEGo7aNAl5Wfxnkz0le2oBcn7x8pu5w0PSvM1Rp4wo/a62ho7RsxsIAF
	AYy7j/ZKOF5jT29j/ssJk0FpP6TERkMxHGavoR1rHJMqpZatF4+eBtD0iCQdZUVecTLTW1JF1us
	IbTvdmhI53YrfCLbfioKSYDdtevv8YLWE10AVTre9jmXR3eabm1sr0N8crtYW2++0337ocpuPb0
	uc/6vZJ42dFgefNFlTSLxl15J/9JHFnID5NKwRkZxZtuScZnBKApmo2zUdxevatPmx5BB3a1B41
	bEc+dXoFwaLirt5sHOHETxcm393UdgjxkdV/tiYEkDVNVx1CyetW3TlEgfM4ZtIQ5bMW6uuPrlM
	r+RjQM1rskfOtlivnRLomojOCyYbvrxrJ5UKr+Twk7j3bsB14V7v00uq+C+zwzmMcXWh2UdszwR
	kRf0ZZrWPd7kZLPXRCnN0tNjeKjvzoeNHDkI
X-Received: by 2002:a53:ac93:0:b0:679:b8fe:a6f6 with SMTP id 956f58d0204a3-67dec48f5cemr8552044d50.33.1795711782318;
        Thu, 26 Nov 2026 08:49:42 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df330bfb1sm10473400d50.6.2026.11.26.08.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:49:42 -0800 (PST)
Message-ID: <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Date: Thu, 26 Nov 2026 11:49:40 -0500
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
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into .nvme
 keyring
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
 <sashiko-outbox-235710@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-235710@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 09:30, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does nvme_keyring_unlink() remove a pre-provisioned key that originally
> lived in the .nvme keyring or is shared across multiple controllers?

Hi Hannes,

I can confirm this one with a test. nvme-keysd adds the dhchap keys to
the .nvme keyring. After the first disconnect, or a failed connect,
the keys are gone from the keyring, and the next connect fails.

I think the kernel should not add keys to a keyring or remove them.
A pre-provisioned key is either in the keyring or it is not. If it is
not, the connect fails, and it is up to the user or the key manager to
fix that. While a controller uses the key, the reference it holds
(ctrl->host_key) keeps the key alive. So I do not think
nvme_keyring_link() and nvme_keyring_unlink() are needed for
pre-provisioned keys.

Otherwise the design works for nvme-keysd: each authentication reads
the key again, so a key the key manager updates in place reaches the
next authentication.

I will re-run the test on v8.

Thanks,
Martin
