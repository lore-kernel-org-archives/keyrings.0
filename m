Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253745;
	b=mhYrADZzc3s4M6LNVV+dVoRDkrddrfhmAUd3djqRyjh+jCdGSRz73yTwkm0l+S4Sre4J
	 I8KSWq35QUyaG9y8OENFDVz8FaCd8mTVvzhukQ0QnaGGmobgp/j6mwIZoeaexQEyGBKW6
	 tSqCGWerXz/pz2GmGMfvhq/mpQOIujV/N4d8s7bc3AEF5ht6wcQtnlq3HQuK/Esf1lQxY
	 8JTYo2rzr5Rh4KbLYJl695HNpRk9OWJ3mxhFSfR02c9yRdmM+6TCwmYeLWRaAjUDfDXHi
	 cjPYQVa+Du9jn/pzFGdOgjLrZ3e1Az0NzsjKccdlP7C6NGUFyWSjuMT0yHo8nMlG/1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253745;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
	b=n/8hKVkBIJwQ29isKh0MsjmTQSdIl5its8uMnyk2siN07vHL2rzDZLNnj/BMsV5o3pqK
	 mJCDBZoH9rkjNigitKBQUS8duLUmHOPBqTjgMxKXuqdQXhOmN+Bj7j9W3PgqGZ4BCCaPV
	 q3E9mDwrefFeebaZXoy0j6DOsxlTtsTmqiLhsmjHLjMfSJ7h0BUINc9H3H7mdxOIPOWpM
	 mYSu2RUDuOIiNSkxPZa2SEA2PSMG1y8fTz2zttl2N5PJbP458BfjXbtU1szzp/AWk/1Aj
	 wQE5Llob0+uTiEisqZyEC27XcQFi215QlXcsybCJb4QtrCBrfZS6b5JtjoNB5zGkeCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E6606A331
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 19:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3E6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so13513455e9.2
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 11:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253743; x=1794858543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ba2Q7AJDVOznKzIVSG4WADmv5TxkLP7hX7pgseAgvN0=;
        b=IVfoqZuFV6XbhOtYe5h30awDqKpwbpjDPRcRBX+iXb0QyTs0yXspWMhGdzvCeVdKfA
         gMUy3ql6ZodjZfEPYo/25NS5pHMLB2wRiZVxlf7SCOpwXSwmvgMsKHP7Zq80j84tSmIJ
         R8geoUs4Pn1OfX5LDS8ummMqYaSGPPoZ2vIur0DI/IFIWrnzBwpklO7xmy3XE+YnQo5d
         /wvuNKEMw7q/wic3238dEy3DG9A2OH+nUrMGcnrKDl6zHYOY4bAZ2Z0PX01H188gCdLr
         IeQmPs3shi+OtyVHmxQiYQA3oqCXdmFy7ZESS3oJbm5uJTTH/L2tcvKKKC4l54f8PbHy
         JP/w==
X-Forwarded-Encrypted: i=1; AL+hErHbLWx0E7edqqhRFbkoernB355euhBDjEicGtTT15iLrJs4aqyvYnOOJsIcSNPXfVREsxF9SMkhYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+FGQ3dYhtS2UiojtPr8gBrEE+v9ihG3ByDRf0VpGIPbeg+YERv
	bmehUG+DMt7FC/ttL3kKZe6XcIS4VPRToekigQcmV0R1pb+OYtbBNIwL
X-Gm-Gg: AYBFou2cyHxD59l0LmHeBqFiESSkpUB0KcK+h0HQmuk/w/CMonZc3ZcPzjWwR5rNgXs
	pKLdm804JS8WQDSqaZV/AltSeiiLeaerXpaXTETA3ar//SIaF6XnVMO9LrwrXXAfVbifC71s5JL
	PRqL13o0jO4s1X8aSzHMrSDnYnIMLqnoIkD+UZszGcHo7ThFaETSiC36g1jyC+0ogFko6EIlduv
	d/8ZY0zOlRHuZzGQFCIJQHHoddD49vdOPU71GlN9L3Ta/fnCRjnKKXIW5oHEFJOI55HH6gUKiAZ
	SflP8TWYqecHKwJOXfTEqicXya4pgpRUSWDMaZkYbEG7dMWJRYao2dUq77G2PTwHrx8n9bsljEe
	+6L3JcrjgspA64YuP8BLGu4T50Cpfx0GZ/SNXoxyigAnegzTAnyT/EX4AHlSOsRp2O98qehtdJf
	wfkgJZoj5ojrQM+D1np+kZwqAGkEGeqNUE5u8mjwhZNnc6PpzqanzsU5knS+A8s2MHXhiBVzkq+
	UNkue4/9oJfbUf8ZBTbUE0S5R2U8xdjD1uoL+Ll0ExyB0lcngdRJquZDuwkB3hLla+Vfi35n/CA
	pbXHptNO3cRbioTnkK616+B6mC1jb4VSqGHE+LJLSdRTbgTlsBmpYdGIhOMQlN/+9z/XlhTnLWY
	rMcU6w8jG/vH636sNCD2FIchfOPr11Ivpyljf5cQhB9JzHncMV02WIyMz+V4n88g=
X-Received: by 2002:a05:600c:1d29:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba023376d4mr4246085e9.11.1794253742529;
        Mon, 09 Nov 2026 11:49:02 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02300988sm6618615e9.0.2026.11.09.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:01 -0800 (PST)
Date: Mon, 9 Nov 2026 22:48:58 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avIjqp3n29DKkpPp@stanley.mountain>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <avHelQ1nxsDVcQkZ@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHelQ1nxsDVcQkZ@kernel.org>

On Mon, Nov 09, 2026 at 04:54:13PM +0200, Jarkko Sakkinen wrote:
> 
> Are we migrating to C23? I've not followed this too closely.

Google AI says that we will adopt C23 next year or the year after.
I argued that it would be would be after 2030 but AI said, "No, there
is too much juicy stuff in C23 for kernel developers to wait so long."

I don't have a pressing need for this patch to be merged.  I was
just playing with some compiler related tools noticed this.  It's
the only place in the kernel which uses "bool" as a variable name.

regards,
dan carpenter

