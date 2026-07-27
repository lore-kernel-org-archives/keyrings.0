Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E02737F9
	for <keyrings@vger.kernel.org>; Mon, 27 Jul 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187390; cv=none; b=riKS8xfvREbeXtUlNU+9SDgT2bH/N8MXlxCKcW7L1y7qc1LeaIYDsfy9St/L3vbWWBY2HhgFaX7pPHVI83MfyJOePQ1g5T2FsNc3ekW8XA5X7xRrQLvLg5wOdRdHO2+CPY9Lnmk7v4KMDCCidqm9kNA0QSKrlW/O8JTcXifaRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187390; c=relaxed/simple;
	bh=RS4sMkfTvFYE7AM8t/lpidonFFEmgBkgYNWP7YOVbnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giuS8LYGtNzXOE2zbUqRjeEppi0xCOLBlU50pNB5YcBnZrPGizjSjxv9XC1AfM3hkS8vPagq+Scxqqc1pLC0LIb8dECK9e5SwxuAvlgmdR9JxPNBN665bVci1aVWE0GhTbLwby9JXQXN36BYDXxMXvIFmyITPKKRXgNDOAjYFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ya2qK29c; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ya2qK29c"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so5272893a12.0
        for <keyrings@vger.kernel.org>; Mon, 27 Jul 2026 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785187386; x=1785792186; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HopFweete7JiAcK9AfHYQfunXxICnvR55+iTDr8jE2I=;
        b=Ya2qK29cA6uxZECt1FzPpWHrx+HKRFMmKNeG4F+SF1zN8whqupWAE3pA2/8vOwnTFg
         1wwTBFLAj9h5tI19r1VY05F4kBgfMyfoplQ9mriRjGT8UCelOpcffBb8N9q5GRDePTDC
         Yi3Ze5CG2wnX3kyPd1eG0oRXRf/KV/XI/+nMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187386; x=1785792186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HopFweete7JiAcK9AfHYQfunXxICnvR55+iTDr8jE2I=;
        b=U8cfiwS0a37L/DxXGTT1N/0ppZuC7zplB4r0+pDhaP1WQiELb8Jjx+yeRVl8ywh4fO
         qKqaAVoqS0Z9/TCdHmBEV8C4FuAaqyqZ9vgUXz7+549iGVLt71uJflfsDc6NbUhsL6VM
         T5+Wd47wIKy8XJf9FXPORCX/MUOBKJ/k4hg/5Jqj5ykOLW3VCsKXP0w8nyJEYuaxA4E0
         9OSxW5XdNbrLBHDPoh8dY7vSJt2opQK4GJXdORSl9YacO7HM8rVRZBa2bkKx68GXVgyS
         vLvCzhzqNCMyZSlPFASQiXMYPLHB5+yh5WbW4SM3j08D6uOTG8oYC6KzrhoYkve70yBT
         775A==
X-Forwarded-Encrypted: i=1; AHgh+RqlIgLwjmwpqGBz/3mU8B81v5fFDxUL4CtWXsyygSeZj//FfpMFarzHJeRCHaRCy5gGOwbkkKRYrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqg3PwEJY5RJGuMKX7PJzlKnS8tKP1o5l+Z8BxpobPkSwYaYK
	orBg/p5As/918fQ9CJYC/bBa8oVmvSXSPAltnVqArDovcC87dGbyDqZbJnh9++ycxISDNpyJTpp
	1ttFAGhU=
X-Gm-Gg: AR+sD12Ombo24z3FfCOlYk+O/HR4YV2NshqXO8bWf9BIoLt+kUy4wKsK2Koj49p2PrD
	bkDK8F1COCP/NcUagwdGm0M36ujHKUAfntOu6kaEanDeXQiReDt7HV7xhKbugCBnVmhA3Qdwkrp
	I58cyVZ/g3uVKfjFmzhh+Tz17Exylq0HlUTZMsFjz2bt4BUgHhOMywxxIqyz+buggYXzalfgtWx
	GPW7qTluneXZ8+CcO8xcFBrTxiE68O1GMmb1v1bG4fw3Pe0G4+7WRfKYu85n4og5So18HZ3roR5
	lLjSYO5z2ooFfqce4xFyCp1SReQYnlWE8Wc8qN2GPJ0fMBMVjIbeyzkQidzEmxa8DplZzIBQ53B
	vOT6yyYVIom82c6LjiPG0lBq/JDfhIA47tzzjdjj8r4gv/j0/UAd6mRdl0XsmEobtvAqEsTXFNo
	LYwPjX7qWRmBYPI2zxfRUtx6/2TEnFHyEuoAVUi4TqEWEUnAaOL1A=
X-Received: by 2002:a17:907:1ca5:b0:c15:a444:5cf8 with SMTP id a640c23a62f3a-c1f691b80ddmr36443966b.33.1785187385947;
        Mon, 27 Jul 2026 14:23:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a79c38sm670956366b.11.2026.07.27.14.23.05
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 14:23:05 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso387018566b.1
        for <keyrings@vger.kernel.org>; Mon, 27 Jul 2026 14:23:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoJsMY8C3uLEXi9jRuv9+l6TnUYpqcBZatmXBqfptfdbeghgVForD03BBNavicHk806iOqUvIj4hQ==@vger.kernel.org
X-Received: by 2002:a17:906:eec6:b0:c19:5d7c:ae72 with SMTP id
 a640c23a62f3a-c1f691b5cf2mr31384066b.32.1785187384769; Mon, 27 Jul 2026
 14:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amenZnA_QgqwMNeC@kernel.org>
In-Reply-To: <amenZnA_QgqwMNeC@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jul 2026 14:22:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
X-Gm-Features: AUfX_mwib83YoilcdlPj47fvLuig6sMdQiV0Di9mKNp1biJ0RxnNpzwkKIq32tU
Message-ID: <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: for-next-keys-7.2-rc6
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, 
	Fabrice Derepas <fabrice.derepas@canonical.com>, 
	Michael Bommarito <michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 at 11:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains bug fixes discussed in [1] and two fixes
> (in one commit) from Fabrice for DCP trusted keys backend..

Please don't explain commits with links. The commit log is supposed to
be legible without a network connection. Links are ok as supplements
and background information, but not as a "this is explained by link".

And the pull request is supposed to have what I can useas that commit
log (either in the email or in the tag). Yes, I edit things for
clarity and consistency, but I don't want to follow links and try to
figure out what some discussion was all about.

So please give me an explanation for what you are asking me to pull.
Both so that I see what I'm pulling, and so that I'll have a merge
message explaining things for later.

I've done this myself this time, but please make your pull requests
legible in the future. The patch series you merged even had a cover
letter, please keep track of these things and don't make people search
for them.

             Linus
