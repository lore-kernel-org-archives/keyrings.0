Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081B2110E
	for <keyrings@vger.kernel.org>; Fri,  2 Oct 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957468; cv=none; b=q38U/SSTbtojjfvf+nS6LPeSOt7seUg8VLJy619TZPDUb5iFiiFptuAioWz49LdtE66idpkwT+vLZdYiqKLeW6gXKdkp97KzZGHxmAoBsvHHdaJuarP9YgFRVdYl0qlwI/bF31HiJKH2LH/4J8cAy61u7BcM/FP3+h6bN0j6eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957468; c=relaxed/simple;
	bh=k6EIrKXphmVYtwYT1711/8oYKVo3ADl2w1gIDOT/428=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRe3XOs8rhfPzCdRyNSKsCqYYuBYKzqnTc78MhHxTR33vDC9QwyhobV+RMsRXwUYfe3AKbwhx7srSzBhSnWOenPNxgfEWWSIBVqVE7b+FxrSZHJ59UnZMtNuEuXzbQxMDRXGmg8br80nA9O4ubo/7qY2/zYT/7iyaM+Bj2vl9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SyIpzk7W; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SyIpzk7W"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e2050feb1so11954566b.1
        for <keyrings@vger.kernel.org>; Fri, 02 Oct 2026 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790957463; x=1791562263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxVPiCTrxqmZkgyyCrGRaSaA/i4Dd2Lh1oLkXXkYEhk=;
        b=SyIpzk7WdLc0zFMHMC++NW7dVImEkeJdrbA61PmSly4Eop1d9PJ7CVnDjCqFybhH/P
         G4otyqCw/1HxspFB6t4/UDyRCSDsTuq/JysYWTPmURsvcHt6a/LEd9/ynB0Xu9APRqdc
         SH4EqdKnORkbSsvSs+pG4Rtlanludd1EqeaWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957463; x=1791562263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxVPiCTrxqmZkgyyCrGRaSaA/i4Dd2Lh1oLkXXkYEhk=;
        b=IXvm5VFOMfN34WKPqn59Xgqi2i3ol4FVsQlnAYm+5uwswnzEs1vaOf0r5yLlCTqZ8S
         dwPbyWNInEiaEKv/1U5n2Hhd8I3wU0UfqPl1zFMAZgFxSnnn2RJBDQ86ro4sTzZl94lz
         mghKYyulJWjBFrKL6arkcbUvSKUU7fnZxMJ1gSzaxZbwiHWtMKjlAS6UJVUzID56DQPo
         wpdDIT//5O6xLrjp7cMhZDn3IFbRl6FD7fhvxUjXIwvkALr5MvvF8dzL36/0iyBK5zxn
         +szqPenv2W0xT8attGTZTyXPhXHsHRYKC9G7UcqxY1mX/nf1QyBKhh2IeJfQ1DroJeV0
         iwZw==
X-Forwarded-Encrypted: i=1; AKwUvBw4EHmskNvAAScpvCCRfXHjdr5hYuILEEENssmbXzygTZVpPYHd8pgbMSoWIWHI3XQqVcViXMjt7w==@vger.kernel.org
X-Gm-Message-State: AFuF++mn2BZ/jtNg1MsngJY37RNeq9zocdJwzQ0IP6200rbHOh0OlTBg
	WNk6eW+xwnmh9Z+kIlr+U6hnlZDtbcC1CLfoQtNQbZL19GwEI+G89AN/tUhd+Ub19i08fxAXSg+
	mhSmN3NI=
X-Gm-Gg: AYBFou1ch+TAY93eJ2dxv/WeTzL/HjELEwpHpxlZvPwxA0KBcPpyCoeqYk4j2mTGvf0
	iFuq7BRVsgFH7Z/ohWRACCYpjadnRtQYVPE0sDcuRNFS0K45rWnXihTuScIcfOiIoz/euBVn+6Z
	Ji9ct+MoHUmYkvTvNrfux/EiQEdFonLivBiO76bQ8cNJTyXxGCVRTOoH5gQvh72toQGg2Yp5eHq
	opd9tUUfEdz0XcWLXE4K4KA50Lob2273Rjn9MdRj8/e+90r7sG/zFqmglDLlsUXeAcQHPGTm2aq
	jGkWLLC0iG+oNw0dgl8BWpBQ5k2a1NnXj0iBc95OQl6fBR2NVjaxfmmKMLMWY/ps50lkOUDvUC9
	ThLcFRtfFQJc032fo3aULsQPXXItw/VstgkMJvur2kfudtwxRW0/S68qG/GHvdvHPC0hVGhxIPB
	A7IxNPKW8y6yBiuKFrxSq2uETTIE5EdufMctRb0CON0WXvmMPHXLSNUwJA3hewPGMQysxGSrmOV
	lSPEg7epEVHQDsVt5LM1FGCl+oFhTRLaTmUPgcLPkx9jEZ+cw==
X-Received: by 2002:a17:907:841:b0:c2a:b1cc:158d with SMTP id a640c23a62f3a-c2e4afb7b9emr247540566b.32.1790957463237;
        Fri, 02 Oct 2026 09:11:03 -0700 (PDT)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com. [74.125.228.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5fc87sm106928466b.43.2026.10.02.09.11.02
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:11:02 -0700 (PDT)
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e20bb4583so10746066b.3
        for <keyrings@vger.kernel.org>; Fri, 02 Oct 2026 09:11:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZuuU4hSMwLkoLFsCHquUWmGJqghYuodaDQRceWVQhbE0vSvGvOMLoDj0+ktArSFpWF6LtGaZ4Kg==@vger.kernel.org
X-Received: by 2002:a17:907:e1d1:10b0:c2e:4e08:19a8 with SMTP id
 a640c23a62f3a-c2e4e081c49mr157712766b.5.1790957461853; Fri, 02 Oct 2026
 09:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ar9D-mM-KA9P_pJC@kernel.org>
In-Reply-To: <ar9D-mM-KA9P_pJC@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Oct 2026 09:10:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>
X-Gm-Features: AclHuK-xk4Cejur6T8G1Bze0Dr20QtZHSq4M1Cl_MKyKmEbexAadoObtNJQHGiw
Message-ID: <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-v7.3-rc6
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 22:41, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Please pull these bug fixes, which have landed after v7.3-rc1.

Jarkko, I've asked you before: please write an explanation for your
pull requests.

"Please pull" is not a reason to pull. The "which landed after
v7.3-rc1" is also not talking about what they do.

The tag contains three lines of text, and none of those lines are in
the least helpful or relevant to the contents of the pull.

It doesn't have to be much. For simple driver fixes it can sometimes
be as trivial as just "Misc trivial fixes". But in this case it
clearly could have been something like "Fix tpm error handling and
buffer size bugs". Merge messages and pull requests  don't need the
_details_ - those are in the individual commits - but they should have
a high-level "what happened" overview.

And this pull request is actively hard to parse. The subject line says
"for-next". So I have to look at an email that is actively *trying* to
make it hard for me to decide whether I should pull and gives me *no*
information at all about what it contains.

Be better. Please.

                LInus
