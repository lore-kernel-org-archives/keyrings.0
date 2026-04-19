Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698ED1A6807
	for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776635548; cv=none; b=LkMA1b6SGQOsG3VQzYysITLoUkUAmfmBfMhfA/uTXyQwmX+IpLWyv2B6oqFZUhzMlC6xrX9uTeGLNlK74Ky8RHgu1wh89pYDE/ZIEowUZt9DCXk1fm7deqlP7+1K5bOf+3SK7essSLJqZC8fCRtJd6uYlW1cofhp58ON96e9NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776635548; c=relaxed/simple;
	bh=CELBaovFracc44SNoSxFbtNzebiD4I6r4kbORD96oiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtyFEKuTX/8qjuWMx6/anwruypmmuz3wPbMQc7Ck6a9MH4NezzUDZtMBjcrk9mEVA3bANmZbnz6bUOq+90CHJ/LZpr74kwrllLuVhREtrLcU5H0zAOAUcepqjdBo4b54XymxSh7rAPMLKrfA5cXHtuXtNrLsUpiICkDBpDSoo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MXJRmn3L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MXJRmn3L"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso3274789a12.1
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776635545; x=1777240345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VD5DcV46JWd7qyXcKhw0Tc1Gqb7giDqKcHIzejffB5E=;
        b=MXJRmn3LzoFuVkGZa64KscT7UV4R0mvicfcl+7AmJX6XWbcez4St0exE02g3fp/+VO
         fMWJg6GV9NhpQGkIlNhmzjVfLvidd1zOpI3W9iwwJmunpfCQFcgyll1994y9xi3FrRSc
         3FH4D7UZ3psyZD7dO+6IUi/zkxlFh//Bw/ZPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776635545; x=1777240345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD5DcV46JWd7qyXcKhw0Tc1Gqb7giDqKcHIzejffB5E=;
        b=VIrA3VSNMuBtvbGCWgZ62UGj+eBprPtFS4wN2lrhprQJWfoH4k/rXCHBYM7PfpBvyi
         CVbnmyMPxhQ0+b2vHXXn9FXNgZGYuxMJqsBkvVB9+YjdsXUGS0x+3lEkjC0PJW/xR9aJ
         mj1Caj13LCpfo/i5WCRwMRsKMB02/DE9KpjuO66mjFpT8ptZ/vR8GaPBnvRIzjlXYkAc
         Z+F56XKpRGxkw1iV8yVbW/OSmJrMW924X3EB47fum9xYMspav28lqpNWhty25Nzf3zBN
         AFZ9+aekNXpeQQ2XNCayKmg1b3bCs1Upkr1Dr3R8a1totOK09cHgYkrAkEMGzeIGn36/
         1tMA==
X-Forwarded-Encrypted: i=1; AFNElJ+GyI7CQL6vlKYQhpYvjfAakAMwiyNm7jMnELbUkFiB66DOwys7m2iEx8E5+OrlGdROLwzvop/YRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyruUo8ngFjk92WZCIdTAlfTIztHFLh+0ifiZUit2OESQtzbs
	Z1+a7J3au3nR1PwFzq+/zirEnYETj853Pr4NyPBpkTEfX9k58ZY3S1qGTG09XvaHP3VomGIk59X
	K5PKAxyA=
X-Gm-Gg: AeBDies3PfSsBHJWKGqbai7TuG8mRFWXZJgX9R512mNpWDikjtB8gzpAAvc9kXM2yMM
	oZENuZ+6VYlTvVzFlRX60Lbdv8X8YrKblLHsqlFsV6/knQuf+XVKBqFKDT7UaH1jqqZidQg4bIU
	+3hXLIS/hwWdOiAMsb8MXLBCDrceHRkpwvYHIcwdYCXWTX/H2Bm0Hiq/PMPpE0g6jTWgkL+CHK6
	cQhwW90xGRjz1R6b4rxJTuIz/twiyFzFPxiVtgz5yLjPP9eFe5dyw5FyM1F3xNx13n7P2uY2qw5
	gZW3mfrtKjZOgPvol4tcgu/vB0oN7gpfoKWvOBbIhOMLhTmx34Fg6Y/Se2IvPyOmdSjw9IUW8ku
	hYlwK9YdPAYtEDtEo4WX6Xb6qwADMEDofYegoQFSyX7IHQzjNqPXHJoeQbuJG8bVCVLlLGji11F
	IZpg9CH5lh8aBvTwfRC4zWZZ15eDMF99xyMykezvKX4H7qMmFIXtr3T961r1Wna0SnBBVfuImZw
	5iyjxkPfXc=
X-Received: by 2002:a17:907:72c5:b0:ba5:bef2:2aa9 with SMTP id a640c23a62f3a-ba5bef2333fmr271583566b.35.1776635545343;
        Sun, 19 Apr 2026 14:52:25 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4520ca202sm285015466b.28.2026.04.19.14.52.24
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 14:52:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so4108589a12.2
        for <keyrings@vger.kernel.org>; Sun, 19 Apr 2026 14:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VLzCW4M4q7mwGppkhspNqZdPbDl6r6VeHsqT9HvYE77tpk0ObbBd19+uH8IboSSU7AzJ170QeXQ==@vger.kernel.org
X-Received: by 2002:a05:6402:50c7:b0:674:bf55:6f40 with SMTP id
 4fb4d7f45d1cf-674bf557015mr1186535a12.26.1776635544304; Sun, 19 Apr 2026
 14:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTLzOgblMZRnDvF@kernel.org> <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
 <aeVLPLa8JDLIEgDR@kernel.org>
In-Reply-To: <aeVLPLa8JDLIEgDR@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 14:52:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
X-Gm-Features: AQROBzCPZsvrw8UMZDVeqzWPc0XV4E0MHK0xN9XYvfTxGZMeyn0Y4OGkvbg9Y3I
Message-ID: <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 14:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I tested both PRs for the same baseline with two separate buildroot builds of

You threw away any and all testing that had been done by anybody else
in linux-next.

And you rebased things on top of a random commit-of-the-day during the
merge window, when things are possibly unstable due to all the *other*
churn going on.

In other words, you did *EVERYTHING* that you shouldn't be doing, and
that the documentation tells you not to do.

The WHOLE POINT of being in linux-next and being ready when the merge
window opens is gone. All for apparently nothing.

Those stable cc tags do not add *any* value, since you could just have
cc'd stable later instead.

I'm not pulling this. You need to stop doing this pointless churn, and
read the docs on rebasing. See

   Documentation/maintainer/rebasing-and-merging.rst

about how you are *not* supposed to randomly just rebase, and
_particularly_ not rebase on top of some random state during the merge
window.

          Linus
