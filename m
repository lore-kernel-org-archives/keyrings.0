Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8D37BE6D
	for <keyrings@vger.kernel.org>; Tue,  5 May 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965165; cv=none; b=HR9XD+fPWxxISK16LRekRVj70a7Jn8Db/3MagqG3ntxolhATAr+EDsc7B53mrxzosJ8aMUeZuqrmqnp2WgBEShOlXqbHVAouk3+O4Rej7YorqmjIaTuPRALUyqUDTlOhfu2jBtzS4eTQwvHwpntht1WwovDz0C4Y1i8/+y6aq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965165; c=relaxed/simple;
	bh=nRbLOHGEyOjk/t0bZalKTB4E8OOIwpFqPuCtBA3zIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tosgjAZWhSvLQf6Wxiu080mGMfsT5huncwY5Wd4UxJo34zhFxhCFg+7EmBI4zXOOam5FUsNX86zZhYoMaVw+J5CKa6j0aEEYKl0zUcWONG4flZd+vj4GVfZW7HJdNGeYLJFpSWNBuVb4ws5Rf628JoRZEGy/xV6rgp24Z0X4V3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxHePwsF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxHePwsF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-837dfccd950so829412b3a.0
        for <keyrings@vger.kernel.org>; Tue, 05 May 2026 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965163; x=1778569963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbRZ7m/cJH5tgSneixdWn6s/PvzDoEk3eHGZhZSgWB4=;
        b=YxHePwsFX/qaJOxm9aYUxMcRwfgfsZWQwamFm1xzseB6uA/051mzxYfqvUR/lpu9gH
         5XN9afuhlftD0jylaUtLopSAJnh1DAiNEDPyp4QidvLaWvOdCkyQnxq8rdKVCbwhgGjx
         ek7qE2mAcQaYD11oMMPWB3hIYJcq8PGmLJtw/UAd00NVoPzJUe9gSyl6FS1pJt6ME8IT
         2VID1gWEceugCxs6qtfJqUdFZ5YSeIcJjGFSvc62nFZ0I2jnnTuBsWL44Ku1BMItYVCU
         2Qsb3iaF0kPhLWSeZpcbsjnewnCjvaSRpSpdrg0a9ago9Xix/Kh7KbqBx6h0u0xkQM2o
         21iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965163; x=1778569963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbRZ7m/cJH5tgSneixdWn6s/PvzDoEk3eHGZhZSgWB4=;
        b=XRs/ca5Rgniqe2IlfF+SoM1GrE5jsOljVvUzIkeIeizxGz6V3PQaReTd9wkpW4bIe6
         RZUsx/6e09ihGRsqTjzS9V2hDUgd9sIkHC0rxdbynnrXnsDdj1XvxkkSuRCDuYKV/8ue
         69+0Pi0fK3J88eVXjLYNlWfltfZ6dtDaFnKQxC+1BsrCc3CSsJuILpSi2lfRGdQEwGUX
         SLYU0nj/Cf/Yat2ULV+PG6XpRojzikDKnFF+yn7riDzE3A6BcU1TmrfaN4QUyV48Rqr8
         rfHv7EEAFUWd/ngEOBc8tREZWPE/MnqdSMUgcYcz/V6PPhZ1MogpXeQkJLmWAvJBrAOA
         8qpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RE5UUZowOH3MLu22w4NJ2WOBZ/QSQrWv/8P5qVG/xoG5DQXoLt7MNzBeSwHCQICnwWvr33n/1+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaihlyOg7rak65CSFn0gqwPSGmt59Chl49VtZNUVTf4vvvb+J
	LlDIyKc+TsDF2FWxFO6fHBRQ5rSnEwM4uzWV0fIH5Wh8gRjmTKqPpPnx
X-Gm-Gg: AeBDieseu83RUAqwpd64DeVcRH4HZM9YAKb1ganxMPZeSW0X+G+OBbV4uFFNXZVcaEF
	ewqPq6ZrIuCITPOuaQxAfiDR5EdTj2DjaGkKSU/yc0GV26ZKc+TwgK2ZTbgh8jZAU8hoeeTJNqV
	CtsmTUdhIIAF2FlSyI8+SzNxH2EP7tvBeafs7KGzgjqog5C9kxTkl3BIcCQB6cAV5oAgCJYXZgS
	pQvAIBpxV9gd76Iv8gLDJ6/cCr89iu1YY6g/ryqxLWFRWlIg7mSbDNz32L4w882bR0tetF7vv03
	ZBty07vR9/3YJQRVuaU7BAJPzWGViZWRLUkJY2+9kZ6dp67YFQ4BOBTB5hyXEjZhjvzK0V0JZWs
	OTpbScGUggzeQ6E8mKqrEaMYnbzJVXvXwVTUkEdimcElWDo2pG05+Q2x0pWjuMbMY22Qm0SBF01
	NsRXRiwW2PioKZLB1mGH+JP5TIobM4Rjwku0xd/Hicse8TDt1Miv+sGl7asW16DQ==
X-Received: by 2002:a05:6a00:9502:b0:834:e882:3280 with SMTP id d2e1a72fcca58-8352d20292cmr13455389b3a.31.1777965163295;
        Tue, 05 May 2026 00:12:43 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm1085044b3a.52.2026.05.05.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:12:42 -0700 (PDT)
Date: Tue, 5 May 2026 15:12:35 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	"David S . Miller" <davem@davemloft.net>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <kees@kernel.org>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] crypto: fix OOB read in pefile_digest_pe_contents
Message-ID: <afmYY6bDIrKwbwBT@Air.local>
References: <20260430173632.277436-3-bestswngs@gmail.com>
 <afmEQ5ove_8fqEhH@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <afmEQ5ove_8fqEhH@gondor.apana.org.au>

On 26-05-05 13:46, Herbert Xu wrote:
> > 
> > diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
> > index 1f3b227ba7f2..cec99db14129 100644
> > --- a/crypto/asymmetric_keys/verify_pefile.c
> > +++ b/crypto/asymmetric_keys/verify_pefile.c
> > @@ -305,6 +305,8 @@ static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
> >  
> >  	if (pelen > hashed_bytes) {
> >  		tmp = hashed_bytes + ctx->certs_size;
> > +		if (tmp <= hashed_bytes || pelen < tmp)
> > +			return -ELIBBAD;
> 
> I know nothing about this but why should pelen == tmp fail?
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Hi Herbert,

Do you mean this should be `pelen <= tmp` ?

pelen == tmp means the cert table sits right at EOF with no trailing data 
in between - that's a legitimate layout.

Weiming Shi
