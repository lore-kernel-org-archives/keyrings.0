Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642014;
	b=n//ldnZRz3bkeaiKPHHXYEEtANFQkd1HAZPSeW00/W/PMBL4rSQX+4bHOY9BhJalbpvX
	 1XBPM5vxfuQFDIb2pEUf1QPxsGndCUAyhnfT/ZHFZxb9OrcCl3jWc0lEFocPZHqfW1YSC
	 Qz5mfyMHliLIRjFgHRzYR75+wDHQUEygqRVs8AIGVQELtiV4Or02KPsSHmOyojhpvkL16
	 Kvqjw6K3+HHTuPe4RsC7QGfQwVTTrG5f75BmIjUTrxkoXjsjadFEpFCZBxOKBo4dTfWqF
	 bQkXm1wXZtpLrILO0RYAVqSCH8z8PeQ8qIF7dEfUwZybRNiq2Qq8EyUdNvXtsWyWZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
	b=eZL4yZDIlHvkBo/mI5T1IgxhJJzAGqbGcguGzNk7B04jMaBv/Ky9x+K8zu6SJGXEVBAi
	 BFwr14xwfBgBxHs8hQILgPZ/8f3pPODdfhQ2gkgibaF9Rnh6VZcgVH9b5mnbUjG6fRCO+
	 Nw3i1dag+NcFv3JyZgTT7uCClcQ9ECxHE2jE0XBah2q6CnI2Sfy9qhA4tpqfF/zvZkDoW
	 sBN4QTenqitbHpASARBpGjPkei6+srb6XisEFmwrI0B1EOOlqMI1MTfjEfgCFNgm8bEJ0
	 lKFDDexWqFhWsEGKLYFsO1JwaaKTx0p1eDX+K6dF8fb3Xf7BryGDXC9HqhhZ0AGyukg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFE606A336
	for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 21:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBFE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khbHvIZS
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso59291965e9.3
        for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642012; x=1796246812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=khbHvIZSswKzRKScFBxEP5dKyjo1fhxkUl/Tm9a7vooLiIEIc3+D/8+f+l2qOQAqqt
         NkhbUqa1fNS3fq7OMj0WJMaJl1khGxmmDggv3i+SWU85FgAdjmbQ2zLZepZPts3zxApM
         +6QfPBplV6uwffDVwMTmMBw7k1e3de0G6FQe/sfuWrH5Ds6lbEvkXQTXgjHFZ3p+bjez
         1kr4qDOVCP9dTt5FKMHZl8AC9yxsqKbDOwSROd6mExDAJeQ3K3/NchHUz2ApoMTPzZeQ
         /uhnbwnb7ArGmTHzNkayy/FGQamuBbJ3FEoi6BqwxfvCMlyHosFKu+w8DEKRCPmU15eV
         1whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642012; x=1796246812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvrU0wA9nQ8NmkHqlIbwXmklpSSQk+6g+lOk6duGUaY=;
        b=aAbpBykWTA7+JSGAjtsItJhEG4QAV4ppib5Fqwuscb1UBP7jjzIc7aVsSYujaVozCd
         A0NUjmSTroFvtQriJCHTHn0c7Qd92U6T2yFSSLIQrJnQDxJjmwr2bZrsRTGYZxGUKdaE
         xTQeo+4p/NmLd4Hbf4zzioYZtKISiCdZBYYpsQf3yDP8yIFWqaIwmvhrWOQk+m6sqbO9
         hOBGKHt5wIFkT1LjVtlUwS1FWOSlMI/kAa3WF9uu8GdpTCYlrb1eZIno6WLsmT4+ueWC
         scO/ZGb2J4RqewW+R1PahOlFdrSTjpYXLcodVTEtm7Fi2HYXgMN0vL6Ob+ItEtHf9q9m
         hfWw==
X-Gm-Message-State: APuU4Z+GOt8oN/36bge7kmTfdoPYs6z09tluRdovoGqKEkmDwlOSSWEn
	Ej+Vifxk2wQ3Bz7dZ8MnMIott5xHfo4+nzDAR7rVaVlC3QtrgBI8xZVc
X-Gm-Gg: AZFdTZf87jOG3mQDU1xqIO3Fp5Hln0x2jukDmSJQZqEf0epkqQ4GYUxB5jr/BjJFBU/
	fcplwGbHO81SbPkXEq+gs4vvvZR4Ur29IR00cQDfN0kDPwCUgrw5Z8YJapAF94zjF9fmK/z1/f0
	uG6fXRYK3BfzxfOjXZlMf7ujBoYZpcYVQ2t0UEDFYMq4mUwMv7xgCDEVbI4mT5rMGnjDq1Dw/B8
	mbJTbFJBmbPDpgHG7yvp9RuDKpmKFk1PYVD5HbEWR1xVCr3g8PirUBX0IdWmrC6fEFDoigUEbgm
	qsLNwl/o/xwnMapJGTwl3KtVtmIbwgndAQCNlLdEQL6sV12w2+iF1KFCQvN2nWAWEKD9P98YXZg
	uQPtZyx+34AwUdWGUTUm7mcws73aR5gEqpttcYimX9eiYi5mKjClqkte6sVm38JjxPehjoQ/9KD
	C/7UjMOduPCV6IkUK3xFlXdGqf98f2m0Na/hi/Ns/zTA3QAAVzDQQ+JRMApCd7AxTdu9RR11N/u
	0KSBpr/mgMU7UolDrcysYOWqps7qUEqTQoyWE0CCA4pgVbJUCJGHNR8z+nq7PoEZjkcnq3HEh2G
	uFoUHI7+o+MqFg98o9Jm7liDSJy/br9HV7+g0yHUSsPal3jGVkokpWsZj4RJu0YIjg==
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr433032475e9.31.1795642012525;
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm310815745e9.2.2026.11.25.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:26:52 -0800 (PST)
Date: Wed, 25 Nov 2026 21:26:50 +0000
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
Subject: Re: [PATCH v2 1/9] KEYS: trusted: Allow ASN.1 TPM2 sealed data
 shorter than MIN_KEY_SIZE
Message-ID: <20261125212650.479bea7c@pumpkin>
In-Reply-To: <awcAeLUROL0l_g3X@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
	<20261124194043.1651679-2-jarkko@kernel.org>
	<20261125090930.698d8f1b@pumpkin>
	<awcAeLUROL0l_g3X@kernel.org>
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

On Wed, 25 Nov 2026 17:36:24 +0200
Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Wed, Nov 25, 2026 at 09:09:30AM +0000, David Laight wrote:
> > On Tue, 24 Nov 2026 21:40:35 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >   
> > > tpm2_unseal_cmd() rejects unsealed payloads shorter than MIN_KEY_SIZE (32
> > > bytes) with -EFAULT even when loading an ASN.1 TPMKey (OID_TPMSealedData,
> > > 2.23.133.10.1.5) blob.
> > > 
> > > While kernel-generated trusted keys ("new <keylen>") and legacy old_format
> > > blobs are at least 32 bytes long, external TPM2 tools allow sealing any
> > > non-empty payload up to 128 bytes.
> > > 
> > > Keep MIN_KEY_SIZE for legacy old_format blobs and accept 1..MAX_KEY_SIZE
> > > bytes for ASN.1 TPMKey sealed blobs.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > index 30188a0ec676..d7336f25b514 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > @@ -559,9 +559,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> > >  	rc = tpm_buf_check_hmac_response(chip, buf, rc);
> > >  
> > >  	if (!rc) {
> > > +		u16 min_len = payload->old_format ? MIN_KEY_SIZE : 1;  
> > 
> > There is no point using u16, just use unsigned int.
> > 
> > The same goes for data_len.  
> 
> Hmm... or just int?

Unsigned int can generate slightly better code - especially for
array indexes.
I sort of prefer it for values that can never be negative.

David

> 
> 
> > 
> > David  
> 
> 
> Br, Jarkko

