Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795682682;
	b=EX1TtPH0Aw+YkfUxqB6Ic7uBGfdrruBn0RwQhiX6NX2doBFup+XJP+Nshc0Ki4J+23Bk
	 NMjx6qyqjrgaxPPQvBXzxM0swxNJoTyNicmv5QUO2udFwMRF+CKH2ocWov9UD9nDBj42Q
	 fBUyQmJj9UJgKPYoygytH6ASnoY18v01LmBCZX1FPLy37yef0UlzkFrAZiyx2srwRI0Ua
	 tYWbkR9FJPBRe0IOrREEWXypUYswvFFBKoKKIB1M1Qn4tWZFK/U/v/madJfq5lwjx/Bhw
	 pvyZRfMPn0JIpw5xX2m5G8CL+V4dFcymC8KVdbH1lYLUCy4mj1a+NrkvvSkIWQVNHnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682682;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YKcLweyW7rqQhUKSTjq85KM55V3zvJpsJlb9dgd9Bjw=;
	b=L/mRvgOV7AO/oZRCOWXih2XnMs1iF59PwehnRoUrMlfi0LusA8Iz5+dl933vFG0m4+1z
	 RywxSjSChVxoMB5EadpyuFmTIhKYoyZoiBDjetaFkKzK7B4Fh5CNJ8T3rSocFjxasxvQ8
	 loOJnWUbqBXvzDxpoxIVUYCFVe4jgSynJyMr9+UndbLFcwKFNAEwFu5gLeDKMW19Whonr
	 0yVhTXpYiZRF7w7XMtKK9QwqNHsZYq+/8RlufAVxvAaJS989A2gmBmImAGmQFiAAX10L+
	 z8IgGh4mBBFyQepHW76UO85OhvJekzCqTgJ0D8iPqygXE5sUMUSBsJGyzoJLkCkYHHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EHN2EP3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D60606A31C;
	Thu, 26 Nov 2026 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D60606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EHN2EP3P
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: afa@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B431A201DCB;
	Thu, 26 Nov 2026 09:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795682679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKcLweyW7rqQhUKSTjq85KM55V3zvJpsJlb9dgd9Bjw=;
	b=EHN2EP3Po6xToGBTFwplBkmMRCxLwpnyF2f3lcdNfbKywjQ6ozA1sQSU7M2QR3RIKp6TwA
	cHKbLPWR3O3WALWbXQx/qKEnWdhECYC8Kdrdg+6u5+Q2OqNphblBoGDDgkfhda5SkT7Ypv
	v1RVc67hOT633f9i4a/+DwMpAoej+Ovr5qcmSmP/jaMWQEN7Pfot2V2ynTZdEcfJNJgZMY
	9M6Y5+pXI4CgxinpEw5cQSGM4MkwHiFjWJIaa9CsrAZdy8uyAMAmmTQ7HFXX7JK3ba3CXK
	+M5AsV8dfdWG52ACC82RmAwdXtomLv5H4Z9hTc81kkTPJZqTUon6HqF0K5EXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795682679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKcLweyW7rqQhUKSTjq85KM55V3zvJpsJlb9dgd9Bjw=;
	b=TO9kexPkrcxH+ceLFAfk2OnUMNHyGKLHQp+o1gYkdE53u2y77l9Eb1JtrSQ514ZBFjiM5j
	VckRFIs/gEtNFYwMI1KSDxuAlASuCl2osSTRqHgZDOY8V/yF+vlZ4aoxoMjXleIe8IfRQu
	d+Xfo79fsUuXuSy+5UNqybX54md9MgpHZdsgYXW9di1rCgNWjfySije3RBGjhNNg+USf8Q
	3tb20FvlUlPeNzfDdoueX3jX7wH71cMdyrXuQtU7zHSif8tmkMltxZmYgNOsMb/pIIH8+/
	7iDIWssb0QT/YvsGiRGmn/Zl6CfEdgPXpmw3aph6xPaUOizryXeQ3+r2eHZV3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=afa@pengutronix.de smtp.mailfrom=a.fatoum@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795682679; a=rsa-sha256;
	cv=none;
	b=OpuWA3Wq5qd4bZ0m92XxbgfmopMrV25U97lgCuYOphVbc87roszgc+YvortwdWIF2JhyAC
	XYcrgAT0vJ3GA0jZD/kwUWGZMcNJytvMvsE5Kia9uLalBGbhRJYiVO1JO4mDj6cBa599cI
	ap0+1Qx4jUxw1WCJf4x/K3V6IsKFreAehOhzKb2ADxBSuc7tGxV8ewBm8rq2ZSP8nPp557
	tRCzyTvslF1D5r9QEGHm5BioBDr1/jWEH/6ZspF3FB2KuzmK4ctzQed1epC7k44+0brU9t
	4jiwSH/rF0UbpASl5xjjkNP398fCYs+Uyyczrdzh1RdBfhKaC38TnRrC4yJnRw==
Message-ID: <078b7a65-e378-4536-b4af-26a29e328c1a@pengutronix.de>
Date: Thu, 26 Nov 2026 09:44:38 +0100
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
Subject: Re: [PATCH] KEYS: trusted: caam: propagate protected key option
 parsing errors
To: Keisuke Tsukuda <tkdkei@outlook.jp>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com"
 <serge@hallyn.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261124155310.32044-1-tkdkei@outlook.jp>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261124155310.32044-1-tkdkei@outlook.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 16:53, Keisuke Tsukuda wrote:
> From: Keisuke Tsukuda <tkdkei@outlook.jp>
> 
> get_pkey_options() returns -EINVAL for invalid protected key options,
> such as "key_enc_algo=GG". trusted_caam_seal() and trusted_caam_unseal()
> ignore this error and return 0. The trusted key core then instantiates
> a key without a blob for "new", or with a zero-length key for "load".
> 
> On an i.MX6Q running a 7.4.0-rc2-based kernel, adding a key with
> "new 32 pk key_enc_algo=GG" succeeds, but KEYCTL_READ returns zero
> bytes because no blob was created. The key cannot be saved and
> reloaded.
> 
> Return the parsing error from both paths. On the patched kernel,
> "new" and "load" with "key_enc_algo=GG" both fail with -EINVAL, while
> valid requests succeed.
> 
> Fixes: a703a4c2a328 ("KEYS: trusted: caam based protected key")
> Signed-off-by: Keisuke Tsukuda <tkdkei@outlook.jp>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  security/keys/trusted-keys/trusted_caam.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 6a33dbf2a..33000d7bb 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -110,7 +110,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
>  		info.pkey_info.is_pkey = 1;
>  		ret = get_pkey_options(datablob, &info.pkey_info);
>  		if (ret < 0)
> -			return 0;
> +			return ret;
>  		dump_options(&info.pkey_info);
>  	}
>  
> @@ -142,7 +142,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
>  		info.pkey_info.is_pkey = 1;
>  		ret = get_pkey_options(datablob, &info.pkey_info);
>  		if (ret < 0)
> -			return 0;
> +			return ret;
>  		dump_options(&info.pkey_info);
>  
>  		p->key_len = p->blob_len + sizeof(struct caam_pkey_info);


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
