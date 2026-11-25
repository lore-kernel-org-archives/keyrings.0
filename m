Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642417;
	b=gaoVfUKNMgdGFZbGB4+wRrh/1SK6PzLeSximi6QtSrxEswiVwVoyC+wKXGsfAu410rOs
	 Z7hw+/K0OR7LuH3qJsHBGFtmTyuUQ7zfd7Ll2rPrHj/gocHyE/QeAphHT6bLpCPhCs+UC
	 QeWPcFWZI3AFNA+Lcbq0ItbpAnitmk0RkiidPhFzkSkysklBJmENJ2kAN9FsL+Lwja9lP
	 Rt9pFmV4OJmCp94oVOLrh/pDupfpn7jcoE9MeB273RVuOsg1adffFCJIz7WtlCDFPyHrA
	 uobFAoFJZvDTZRPuIc4ieZQZFNRQkBION7qSmjStHcq81q1o/41GcZVvFUsYR47UN6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
	b=y9qmck9kX1TBWbmTNijl3QsrsDR0HrQiJa20qjaJckpkkmQGS4jVI9cwTt4WvDUMiJxI
	 nGR2OzhyHPWbkynaDHiqee7GDXW10Dw9Z2vCuBwqmhTeLfMMkJbRl/G0DUSKkQWGTGm45
	 0zlI0VGf6i1B03/KV0wvZTsR2g6+xUSWbapdofDOHJ5pDtCZzLqrxIJCOU3eAeBBDKYCw
	 Y0at5ZqQ1PKrNyDd1mYsqAD7U1oPuDqCQ2Muu5MhjoXpnIESFns8FPv+rXEscl1hy0v0A
	 6grsH0vaqkiuqv+vJPj9VxlhJGG7me3s+er8fuOBpf2yHG9jAuWK5n25HvpQto7F5zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036F606A323
	for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 21:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4036F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyaNhQwk
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49412eb1474so4084829f8f.3
        for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642416; x=1796247216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=LyaNhQwkXbqpnZKQEFhSkXYdJnRuGKBuuLo4jMsASztOhDAKo/KLjtuUsGuJcBlEXa
         L9q5KsH0RDu7VhTtDI/7sQNdeUHKbiCE4UoTYbpDjatBwUbHY0aghBKcJ1jAy3etEkOB
         SRACMXZz5iIdXEUmV0YEGNUmGpDA+sNgu6gEYF9DmXC8KGwmX9bCsi/CJOLNgO+wTbbG
         lhvnHY38xO9YEx6YYjl+XslYqIdorjHMYTu7z3o6izDZiq+V8t7zvkDvaFfxCYiKSkSe
         OIEvBBzRuYo1TczJtkPUnW8+3ij30yPkrtXbZqfgQ434wojlx8AeDgewp82b/5hogoP1
         RBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642416; x=1796247216;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGNJ1d/2nF+bRZrybTD7E/noHwTUs34iqH0nvE138sc=;
        b=Q50mvQTwluDP4J3pWCBSxTujQyLm5qLm7JzbVFVm5i5CmIftmjP2qZo09Z7DOpZncR
         L7ABaN5/IQqiLCjfzMKsIjxd5GoaMfsc8i3jaVQQfX5rUKCqihi4qVw9kfA4nYZvgbDQ
         3IsFduQltpbT44+Wz8uNVLgwbjgwVG17gQHnZDViHvQ7Z86F4EXHLPAvLTshmZXvjMGX
         Y0yLRzX160rHFb8Pw5s+Q1+ID2hVUL+7rwTBM0eVQ680uizX2dI+bZX8v/cug86wM8Ow
         2yH5TXZ9WACl7rtlshKyBhz41/q8q1ojdIPjFwcBit9jwbNvRrKg4IhGlzTHFm+skfWM
         JpCg==
X-Gm-Message-State: APuU4Z/exDvk5NGn2hHvGBqJGE1X1wwWf7RyycUrbijiOld5WhHJOQBD
	oCazTr8YwYO9oP98qUZ7nVC7KeV/UiI34kREuy9sjnti1AGoR1cR6whN
X-Gm-Gg: AZFdTZfFbmu2wLczJtCTqlL7MABkwk8a7fMITKceyZ2xCRt8tcKQ/DboGElnk/Sy4F9
	0NcqY09xKt+W1kPjsLZCFYtQzkDlNMVCHO0cX06K+0NKdEjfj9NQVPts46CxjYAv+mx+6fSRYwI
	eSWA9qnqcefFTlEfva+wDthaLx+N0uOAWTeTzFtmkE+Zcf8JLxIhSVwRQjSf5PisK6eqNYjAEdM
	GBDDyHbibmduibqGymiL8TtOT1kOGMwUTP/ZoWFUzt+Ll/nzvMFbRGgcOaq0pqNCO02C/H8jtLL
	O+10lDL85waB9gjV2e6IV65K5NGxp7f6jVG2V6kuqLtFaDL/FVQTj1zCb/z1nIM6vpFLCXBxssl
	roO1vvYLVaXOUzjO4+LdI+fyfmDS7Q72+xAvjnzLsFmnC8/Bu1IncT8sDKm+jvEKRJXmmGpnk7N
	5yAKDIUDAG35X/M9FCzlVQN3oO93VEzrOzq9e+9w+eo7rv4mByXJwxRHXrnd9IEDTFnG6+wEB8Y
	wLEsxhYcmt9gmgfyMlc+lqL9MfD1wWRLDM0Vnn9OfyTnR9hPrLbLW9R5G8A0IuGivYNAivqOZj9
	Ioezdz51EJ6Dj9Kd3nZeX2+dqFO9fadAdtJy11eN6SHmgtovVZ5NHBwT4Io/qM2Wtg==
X-Received: by 2002:a05:6000:4a0e:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4abb7787c05mr35815085f8f.50.1795642415460;
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680355sm30439805f8f.27.2026.11.25.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:33:35 -0800 (PST)
Date: Wed, 25 Nov 2026 21:33:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Alasdair Kergon <agk@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Benjamin Marzinski <bmarzins@redhat.com>,
 David Gstir <david@sigma-star.at>, David Howells <dhowells@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, David Woodhouse
 <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, Ignat
 Korchagin <ignat@linux.win>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, James Morris <jmorris@namei.org>,
 James Prestwood <prestwoj@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>, Peter Huewe
 <peterhuewe@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Sumit
 Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 2/9] lib/asn1_encoder: Add
 asn1_encode_integer_bytes()
Message-ID: <20261125213333.23eedef1@pumpkin>
In-Reply-To: <awcBD-bp27JCVpc-@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-3-jarkko@kernel.org>
	<20261125091921.4bf40279@pumpkin>
	<awcBD-bp27JCVpc-@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 17:38:55 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:19:21AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:36 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > Add a helper encoding a positive integer from a byte array in big-endian
> > > format.  
> > 
> > Interesting...
> > You allow for integer values longer than 127 bytes but don't allow for the
> > much more common likelyhood of the encoding being 'implicit'.  
> 
> This is the first thing I wrote in 2024 and have not touched since
> without further feedback :-)

I wrote an ASN.1 encoder/decoder for a tcap library a few years back.
Pretty much everything was implicit and some of the tags exceed 5 bits.
About the only things that needed multi-byte lengths were constructed.
Oh - and you can't fit in a maximal length SMS if you use the indefinite
length for constructed items between 128 and 255 bytes, you have to use
the two-byte encoding.

There were a few functions for 'add item to buffer', but I didn't need
this one.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

