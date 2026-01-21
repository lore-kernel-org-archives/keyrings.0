Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE3449EB4
	for <keyrings@vger.kernel.org>; Wed, 21 Jan 2026 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983126; cv=pass; b=i4EzHQ6dEt94w7lBbCKlnL1acbMV6Ao1OxkR/vUKoWvb4RoFO0I8wucn3XqtYjCAEAGE0Wa7uwi96wJEIC1/4IcDwPFxFT+JRdrudkSuv0z8zKdK0++jPmSCtB1oZ+dgnCV2QDFa2/0gDV9PrbVBj+0L7yr6oM67TN0A5Hjwg5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983126; c=relaxed/simple;
	bh=NcPcHijqCx7t3zPi3d2W+9QUjcbq1aI+GVwFFFeFbq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpExtbEDMocdfckdts4UtNdv15IPNkkJNWcTrrKa7B7RW5IMqBqVwXDv6s+BHngWebHJBGoEw/7j/msQAGn+KjGe6SCZZCa33FBxrOwow1Y/pCJYnnn9rQz1QzWZZWSjNZ2tD41kQckLSeX4mKceBtNKgMRbiUg2fYfuXWb0PPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZdVhO9OQ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZdVhO9OQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd490be5fso101994e87.2
        for <keyrings@vger.kernel.org>; Wed, 21 Jan 2026 00:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768983123; cv=none;
        d=google.com; s=arc-20240605;
        b=UgSRh/gR7XlNisq7J0H16C5XMPEIG4/x3Ku46cs6YWag/O+vhe2rAiAlXA217vMva3
         GGe392FyYK+VPhg0hT0Afot3rjPdaW+/6bW6SMu93QQTSrXpHqEIQIjNOJZ60ijcRbah
         i7qSXezBXSXwWMOUChyj1uDEDfhCjXUBtEfMwHJIr8jrxw9d7YZCC3+gMvsTGOXm3j8u
         EgMpryrjhBR+UkOjuYH728F9VMhzhprD5f0yRLGeTm6swzJDeBS4Mwe6rZ9T0tqe0dKs
         /kb7K7DI/5iR30FhDFqNs9C4lJsSG2CMzjw0+z3eWcQMXsH+dIHgp+jIdsoccYhqEgrH
         /SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        fh=y+JxrItci4pZsHFX3JuPh5ZkP+nRmw3bE6iCsCwYWh8=;
        b=BiTKQbxpuYXPvnixLys9SfwxsqIofcvNjSC/OI7ll8miqg1qGfdC21rEhiD6GuGvtZ
         V/iy2oStxCS7sFIbXhj8Zf3kDaNnk6ZNIzFWqgrUX/XHVqCBspubFBwjz54NCldcOhfZ
         Wphy8DpzZys6jjoNJhNVYNvNKZ+ftwUgfz1bPNNyutRGY4uB7QdMdud5fVajz5yZjHn5
         zsCzM6MFq1lDTzOBbfdElxun3PHIJl3P3GzxgjuTG/AVkltYaOMG2LRYj6zgpfd6ebBL
         tbmkh/gFod7azEtpbCB5I/vxatrPfmUpkWQ7U5YkzFl2ZBYKbmadRl5FFyqpS6uin7Q8
         TePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768983123; x=1769587923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        b=ZdVhO9OQUc0wiKmBFlmD8k8TUGqsMUSipCPOvNPYADDKeiTc6sa99VIgDi2FHKkZ/U
         Awkh2QH5dLTlkwim2U0tmBzoezXZIt391oDRSB8q2+eF46TUcVLaE5lyHBezcI0rGyGX
         3gRH2QPt/ybJ8oj79BkHF/V87RMdLtTZx/m3mQPAaxSwc3316N9I+ufcZQa/FAOHBKrx
         KkDqoxXHMtVYME+lgECQbFbuNoTnZztld4VI8sgtKWgUzM01s/I6jl0t28uH8S7NCGDj
         cKdh0oboHRLvXVG6ac6s4kUaodyOt0hTQG5dVDS3n4mumRZ3/0/OgbiW1TKMj8abHGzo
         z98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983123; x=1769587923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        b=HtR2YM083mwHCew9VxigUamkBYGvIh7DYIIHlzj8L0gnBhkSRd3xvn1/qns4CCazTc
         9CnnEsDpUYnw6hpCW9K+mgoArROFQYWjTbGPllAMFP8OBV11zA7C7VcZGbfKQqmvQMQu
         ptxqPcgsRb4VSByGJYCkODluc/9Bvngsb8RD/e8pYEhGoJgnkMPxQQrHwX2t+ptunFXx
         x7x4p9nlSkhKyeN/o4lgf/50JBoRtFzA08RNwv/RCYrNjKJgLaT8Uud7g2aa2FvWyssO
         BG9J9Jl/fDw26sZsyKnI7VEXpWnmr7C+ZCrfepTprfgh7Ky115SYTdQE/1I4xscsUOmU
         ZJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2TMkA2IPoMeyGe7EkSASsB4ofITEQyRK2NKCmsqFVEc+tIXmqYiv9Ij+LgKiRRgL6bJ4uDzt4Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz332yNnSNNvJA7ysKlK7bNCt4eyQQQU7wWJhkOyfcUQVo/O+q3
	A1TlOlsh+IyjuaAlRTQscnMFyBtRDix9oi0vZWFVh72BbfEJp54S1TYkTNE9faMsOat5M09sOdD
	gxhKTx34La4UwojdlC0/uUyPzHBnoKr7yHJIPWE9jHA==
X-Gm-Gg: AZuq6aKVRMbVc0d0scvqE98RM0a93+smDcjLMKfVtG6L8R+GXBhWYlT354mFjG+EHC2
	W+HSY9QYOompOZt9XoDBgT81oGbIZ5iuJokCU3Q+nF7f8wDaNNSntk10bglWIpZQfd7I89rUJdo
	hbC/22uW3XmpglP+t2L0B2xSmfiQFnHqunam4ThwzXdaotURC0eq/gHVCQxZnFRLxOQF5qEU4IF
	A2HZZw++l3NiFhUDneM24SHRnyE5olg4foW1dgknIXOXxMpzPF4A1pWI7L6kbw7mMmstPlbCY6Q
	mcAk5/5e9JhQsNMcNasgfEv55dl5
X-Received: by 2002:a05:6512:138f:b0:59a:183c:4863 with SMTP id
 2adb3069b0e04-59baeeb1d8cmr5444078e87.8.1768983122854; Wed, 21 Jan 2026
 00:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120224108.GC6191@quark> <20260120145103.1176337-1-dhowells@redhat.com>
 <20260120145103.1176337-8-dhowells@redhat.com> <1416722.1768950957@warthog.procyon.org.uk>
 <20260120233617.GA10653@quark>
In-Reply-To: <20260120233617.GA10653@quark>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 21 Jan 2026 08:11:51 +0000
X-Gm-Features: AZwV_QiRbs3OO4qM3uwaFGGNt_nfptg6k5-iiQUJvwUGMqgS-PCFW0-TncfBeF8
Message-ID: <CALrw=nGHEf3zT0yb2ybpH58ah4dT4_H11TseDL7Fs-w7RBY6hQ@mail.gmail.com>
Subject: Re: [PATCH v13 07/12] crypto: Add RSASSA-PSS support
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, 
	linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tadeusz Struk <tadeusz.struk@intel.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 11:36=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Tue, Jan 20, 2026 at 11:15:57PM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > > As I mentioned in another reply, error-prone string parsing isn't a
> > > great choice.  C has native support for function parameters.
> >
> > But is constrained that it has to work with KEYCTL_PKEY_VERIFY's info
> > parameter.
>
> The cover letter of this patchset summarizes it as "These patches add
> ML-DSA module signing and RSASSA-PSS module signing."  Adding
> KEYCTL_PKEY_VERIFY support for these algorithms would be a significant
> new UAPI feature that would need its own justification and its own
> documentation and test updates.
>
> However, it was established pretty clearly in past discussions that
> KEYCTL_PKEY_* are a mistake and basically exist only for backwards
> compatibility with iwd.

I disagree that it was "established". It is some folks opinion here,
but I find it quite useful and hope it would be actually extended by
good algorithm support.

> So I don't understand why you're advocating for adding new features to
> them.
>
> - Eric
