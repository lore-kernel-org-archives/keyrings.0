Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308443;
	b=Y5mlo4D37LqvjBiJXA5XKhCm55HWXRguueVEGsba4MWuJ4JxqGHd270KcK8xgPqtVAK+
	 krD7q52u2sVVZmfnkZUtb7GZj2moDI83/k6G7bqhleFnSMBrEXKU1S2m+93cA+hbAoEV8
	 QUT7bL6N0CNurVATi5i4y7O0cwDbpPPL7Y82NNcR1Tya3VTeGUZk+N0b5HV9F1eJFr/t3
	 5GwRE/w20ZCznKTa1VMi3F1bIWiDPBAVFukuMoKqwyA+g0oHSuV9FUlkB/wtoqjda+X1d
	 Z1NtFp03Ey01WLAaXrlZT3WCYSkjyTvF6f4zKHckLmsSeSzfIpI4XcVemlLPnYGAuwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
	b=VaC3CWYMG+XBaSH0YzQvhOD/7TkvJH4+dHCEH9fFlC5taWnrJSwVeKbjDf5Yj1PBDZPM
	 HwzpQ1q/ITbwcUsslmsL1GETd+VVb1TwrX/pK9/9j7WL0vU+5WhU/ETqlVvU8YDOWvIRK
	 IgGIUUYhvOEn6+yv1bMZZiNlufExvU1EzrGzWE/nGU1hHCxg5GGws1ArLVxo8VONZ2giJ
	 1/GlK6QgmP6Zb6Wrj6rrWDWPST1lbFwAqo2tiYRubN/Aqtzc+UHlgqtSDtpQ7QhwiNc5S
	 dScp4vRcOAxcYzejWFHu0MAZ/ufhoMGIo9mgLqaXXiJ4CDcLNhjJ+0KdgAoi1grA8xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FC60A383B
	for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD9FC60A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR+oRQEN
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so15805335e9.0
        for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308441; x=1794913241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=UR+oRQENsNTyw3m8WPRxHakPMD/6M89G2GAH08z8luOgAuTYMwATMm40YkQjUmifrM
         0I0lYgItJ8iRTCd2Zi7HSPoiCb9Jfm897ztEJX6ly4PAjZK66S7FQpnPTnp4WfOgil71
         sS6EAeBEnAQXtYBXug/wf3vqUhZlNR/waxaiX4Vbpj2853UP0Pj/t+2kEPD3uzJ4Z75N
         Vj9xgTWOoMaDcdSmCpYtZWf8y5aFClQ9S7OCYqvtOzp0DKEA6vOIZHfTzdUKMwoECdwy
         qdoejJJ5aBD9AYCkstvgOzgJOwMHKNFwgSF/h1BLTJc5BS5UWlvnbo/XPoCHV9iRnUUh
         itTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308441; x=1794913241;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wv2p26gpeUqh9YHe7IUFpRTwcMzkjGJ1jZc1lffjWFU=;
        b=0917NIRC0gHeSPbxsKh+qTxtwWTEo28UXVEygHmP/35mCKZFsNn/E271hiwUY4H84g
         a/7bX5ngdSDqAqP6Y3gyNpik2+2n5aZbQLLrFC/yLwOTfAM+RvpnLBTruHlHSYqOTb0/
         PNF+Js1gVo5ONTxnlryjEejO7uf9CKGboLf5tOGCtDSZrBnep4GS4pC3bL0j6uV6zyzV
         wx/6/3hgCdL3cCOLPBzMTtv4YOmlWstfx6EVnU5lFjhvFDZnUEFhOy9J3B3MnA1/5jQS
         ywXGtLv93wrvrnrtCEDd3PnnJz2p7E1p+8HgC7oc68Xv/dor076htDE4fqIp+mzAtjA7
         /cpA==
X-Forwarded-Encrypted: i=1; AL+hErH1F+PaAzdpnBKGRnr4dVYn+pC31TDX0Vqgys2qcJ43UzEg4+8dEr5mlAM9faieR9el4gOxb4WJGg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9fz4LCFMyMDCtK5BzJpMYYHwFoL/TpXy3M/ELWVf2ZpD7rJVh0
	mHyf6vJ9hI/N3Zuv6B12oA2yLAT452fubUbJhdAn52jktsV6YpnokQu6
X-Gm-Gg: AYBFou2mTdYyCQ+2Sx+ECvRV7LxnEi7kFdrfXpAtfCHLrC6HuhPxCqYhtC4T1qX/T3I
	bHavA8U4EYhwKLcl6rfMm9fjU8WjbeOPcrFSebgemFY61JszVLgo/vFTUUQfXB7aI1elx68kdK2
	LeFzRIKeoQ4akIGtePJB1ZonO/Dwu476pVk0f7h3+BZ2VxB/iLIB0MiFjdSI/ftS1nPkIzhd0sd
	yIypvxBlFK0xMs0lBTFuGSvbzV7OTOCbtwkadEsND8J+C6G4fmI57i7TtBj47E5F/WbIJvbncpR
	OyQ4QBL6UQoULru+tVEcKdfbdMaGU2XTGYgFvbE/4/d/MQ1w7xsg6KXGwAOiy6SgM8Tnh3+mN1H
	wUOQmZ+ezlxlhS4QNW2OjJCt5buh2h+BRch47s5B1PttBlxkzT/NwNF/8xzt1ohs7kMqxfAJYo7
	3vQ0DsHRPsIpwhfV0yhSqYLkwB7eHZjvTC7jLI+1emRg59rJA808ERa2mMtcYY2yZ3s4Zcy8FqG
	mdV8LsHlFS43I12jyNY/YRH8LYPbkg2OzIOHCnqbwryp4jWjRlFMFbT6x+RRDHUNB0TP1MH8S57
	NrIs/eMdxjj3x/jrOSWrmi+ybKcXBzCu4a/MmEEkconiOtu2YFz1jsj/zDNpwaXsBA==
X-Received: by 2002:a05:600c:6387:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4ba02349a18mr35485105e9.20.1794308440720;
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02381916sm25962625e9.3.2026.11.10.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:00:40 -0800 (PST)
Date: Tue, 10 Nov 2026 11:00:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <20261110110034.0a46b9f7@pumpkin>
In-Reply-To: <avFcjHwnh9mrOEnz@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
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

On Mon, 9 Nov 2026 08:39:24 +0300
Dan Carpenter <error27@gmail.com> wrote:

> In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
> to avoid a conflict.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec676..2d6cc53539c8 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (private->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> +		unsigned char boolean[3], *w = boolean;
>  		/* tag 0 is emptyAuth */
> -		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> +		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
>  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>  			return PTR_ERR(w);

Hmmm... how can that fail?
bool[] is just "\1\1\1".
I bet asn1_encode_bool() isn't inlined - where the compiler would optimise
most of it away.

It is a horrid variable name, asn1_bool_true[] would be better.

David 

>  
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
>  	}
>  
>  	/*

