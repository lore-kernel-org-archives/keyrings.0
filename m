Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30429B216
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997291; cv=none; b=kYZP0MOGEk73IbyTSQFD4wRKnGiTwvd/tqaDO91JerbEGSVBpjG3oBfmKaLF/TNyW/99fShl6RHFXt8WzFANakR4CdGkoW5r+VdG9LUFrTN4lsRUm/KztGTb+0wGeatli9cQynZoET+g+/eKQhDpyx4oqJs1Gy28FT7eVnA1Rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997291; c=relaxed/simple;
	bh=Kdc6yC4xRjvpZvivtkFQl4egG4a2TmHEsEe5UY+hyoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7h3kXs252JJq1acZbcPncI3Dl1JJwu87Av62NOo/DA1+yhdjazeFpq9GHj+iAnP08rnFng0apbnBm8O2T6r54i9sD7g30b6G7Eoe1Eb6J1xUgMiIy9Pn6NLwWyYqgICgvJVE3Oj1TNy0ylm89ZUx0xcHpnWbamZPUVoeaWNFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S02A6xFN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S02A6xFN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2055573c8cso553478166b.3
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1791997288; x=1792602088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/J2ax6te+1JRzLcB5oiAyce7s6PHnNfpG49L6qJGy4=;
        b=S02A6xFNCycHRPd4u1ia8FGDJbuj0AL0+aCUPH1QreW/T3ueyALjyfLxsjMJK+mled
         gukn5iFxbf0joIsbvwb2+gHBn3L4V0Ehgtd888ijw1xXBb/q0YBtvB5nRZ7BIWW5aJxM
         NI2NEDtnKawO051s/CNqDpd8ufR3yiYPxob3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997288; x=1792602088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/J2ax6te+1JRzLcB5oiAyce7s6PHnNfpG49L6qJGy4=;
        b=Tya0xw6AnR+yzIh4LW/r44OYu2BRt+TZZPoUD69KYdOB4sn8Oz2SijVm8Br5s3hzuS
         wQldCnxK2kuB1jKTV+dClnye9G50lymbUZ+wV4FZAp8dD63fHy8rE2jIE0jhigYOMxzG
         SZnJ8XzmIaZ52asngKCkfStp90u/5bcGtLq9LRTRNAkpUoBXAP9RtXlSAUZ5rIgq8wue
         spvkXc8lojduC543Q1aD5/uu6YLamtirByPKircIqOkMTvzMySX3RjVpptK99tGvDhiu
         xqBD0TT/wuZjczkIH/l7AnXIsgne58ce5Da51pDCpLtUOBJLa5XCaeZ6pc3vem11huxm
         C4tw==
X-Forwarded-Encrypted: i=1; AKwUvBzVEhUCR3l4pMA2tFRVzeyV0Y+lwMoetTYCcgQX5mbO1qfS/tKN0kluar0U/gUNh7x0xoGk6APD+g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKTfJGsUsChCxUuJhx4S/5ceEtKaMytg/vuSCNVzlrhK/DE/uYy
	Q+AIP+89pqaymTevjjIcGZWfPOcP88NU9SmVt6ZnyUrtLHswKQZz9Q/WUMHRTv5ItOOCVY+GQZ8
	7h2tCFK8=
X-Gm-Gg: AYBFou1IJHXvlc5URVMDg/b3QbxV2Twm6s5M+3Hf+uHKsIwrJNb9ZdOhPxmJGzQi/AW
	gDlhdlPFK8Tx8hV7zMnMvwFprW/KqUhR3AGuuCROohm1gTNPXzf3mv3IKpmeomua2dO/ywd+iH5
	QqzLhoD4/P3kXWkY6Z3if++TYUULPV8dpL2aRoaut17XtBht0mEJy0UkGwZH9mSyBoE8jKvwnpw
	5LlXixejnTqbbNq6CxCKMEF84/wy6LWG0lXe/hkyA8IPDtci41eGdvHq7J3hfDI4mTcfNwdoC2r
	v7zEXP4MPvZTsNHKHFT8DZr/cBYN37jlSN7o/abFP5jT/BgBfbfLMA3Jkjq2yX8zNA1wxoT9Ulx
	hEs6H76BxWfHMoitSrS+ddlK397xDFyleNH7YEvJ2btvnTLlx/ue+7N1ZbAtKMNy725G2z4EUCb
	AkhH69aZe9EEYZm+aGuCv36KQ0ySl09VSBEoZ5u0STJIHBEvbQI9okqbYz+kIvuWTUOR4ctc0RE
	W3hfoO+x1A6zqc9aeHVH1xFW7y8RugSmWpUzwSWWp73pyPD0EYGdIzMnds=
X-Received: by 2002:a17:907:9690:b0:c29:f0a4:a4f8 with SMTP id a640c23a62f3a-c31a96e4d7fmr1481841066b.0.1791997287753;
        Wed, 14 Oct 2026 10:01:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6be6536sm7699666b.1.2026.10.14.10.01.26
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 10:01:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso593248166b.2
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 10:01:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEPohbzclxaDP6d+wcv63fPl3x4EudVk12uF2NWzg4P58v6yyDD/igQAW3e21NQ+pHt73oHafjvA==@vger.kernel.org
X-Received: by 2002:a17:907:968f:b0:c31:8c48:e18b with SMTP id
 a640c23a62f3a-c31a9afb3b6mr1614699966b.14.1791997286294; Wed, 14 Oct 2026
 10:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014160144.1835860-1-jarkko@kernel.org> <20261014163550.GA327771@quark>
In-Reply-To: <20261014163550.GA327771@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Oct 2026 10:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7cq3pdpGV4mnErRqxTmUm2UA87+v4N-nni2tQNw6Bkg@mail.gmail.com>
X-Gm-Features: AclHuK9QDUgl4J1rJvqvCYjnkQ4RS2QijjPUkASw7HMcAk5l4Pr5JiIIEojmQ2Q
Message-ID: <CAHk-=wi7cq3pdpGV4mnErRqxTmUm2UA87+v4N-nni2tQNw6Bkg@mail.gmail.com>
Subject: Re: [PATCH] lib/tests: kunit for associative array
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Rae Moar <raemoar63@gmail.com>, 
	Ryota Sakamoto <sakamo.ryota@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Kir Chou <note351@hotmail.com>, 
	Petr Mladek <pmladek@suse.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Guan-Chun Wu <409411716@gms.tku.edu.tw>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 09:36, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Would this effort (and Linus's effort) be better spent on converting
> keyrings to use an rhashtable?

I agree that it would be lovely to just get rid of assoc_array, since
this is the only use for it, and no other use has grown in the (many)
years it's been around.

                Linus
