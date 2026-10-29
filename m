Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793275515;
	b=X2MSVBL+FFoBfeGbrb8xStqhpA3WqVYvx9I8eCKzAHfb3ID07gruqozl1jLIp2oadiSi
	 wesDkG3sBgMWy+aGYt52mcWEeLBBXupp96HaUZqkxAd2kCi1HrYczvQYzD3Ktc2nt2NRq
	 5lJd2fkakwFwafS0gW5r7tMuFHERwU/ZeKBOKKQPQ3LAKNTnzDRvC/sw/zPf/e+nj/wn0
	 TN1vy1QzUQM/hXMhtv6fo6bbHDNa8kb0HWKl2JEDD5xDY/NqeNbTFjup+qGLZURtUZmoA
	 K0QLEd3x+V8/lxFfuHHGZq1Rp2t7YKvpF7+adLecn1zhAoTt3v/fLjXjm+iKtTqZARg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sLpzNdoElMhQ6QaainHoNQa+2HJPLd9vbGUI5B3uIt4=;
	b=zxlkr1LvVA8pYTL/pnlZZ95m1R05/UGqKflnbLQiWJRK0iNBBrMU0i12nnR+z35jESvz
	 eBq0bEfq7hTatqPI94L7Ubd0t4RsFuzelQTwWQGI0h5BnqRb1T3okAiPdrVOkqq4cBQ5c
	 DVKXkxTktdcUbqFayVANHZxN/APpMDFWTKTCUrlCbeOSDLtLOt9d5xy5RrVC297eD4C4l
	 Gr9MOVTQe1AAIANT9tGvKcjbDYfpIU7nxkEi8q687FAZByJAuUXaDQ54VGNfKeZQeRTi5
	 HxhqEpLQmGcNmDo88S46MYCNBfC0lNHnb7SdcX70q/22ZFbgJT72cHi638cn2udHx4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eIjHmej;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D684606A31C
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 12:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D684606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eIjHmej
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843ea301d60so1420918a34.0
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 05:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793275514; cv=none;
        d=google.com; s=arc-20260327;
        b=fpEd10JQO00BMtsF3I3Te3vYP6vHZlNvPRkoEgZ5DDaMw7creLxVwXDNTOEm8Wj1gQ
         ftnchEuCcJrC6/FPT/I1Z5Se5PssXV/BHdMQnEABoGbNRaWOZxqtSNwNLE9ftRWx2YFm
         AmixOP7HD+YzINQKTzKxGo4gYBawK4bX9izw2uOv+6grKfzUre115Q/JQhLBLBuYqgpq
         bt3X8iV+8gVYhlX0NrE5kyQRE23zzrn/SOKy0J9Q4Dh4qk+oC+Vg5UJ4gJXg96R/pz/4
         KJoR4pHzrT5mITVDIX2nLMIUxwRh9EOELMdQyhMU2ydF5+8htJZpFCwXnX67v9SQFhF7
         cgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLpzNdoElMhQ6QaainHoNQa+2HJPLd9vbGUI5B3uIt4=;
        fh=+uBRkp0u5jIY9SVXnos/eO1ojcZ5LXBMpjm5JvXy+3g=;
        b=hsXrfa2cUS0lIGPY4lM1lbjoLgXZrVKKQy7IS/oVRmCdA5cMHYNp3pBRWmYffGodKB
         5OzjN9rMMf+IO40liGF2XvPd2MvDaIyBVrQjZXCObdrVJbnrU3zhdcSMVxIaEQqGc3IN
         qJQ2KFo1KW2JiajRxMvFwBt0PDX0x9JLbyEtrZV42beUQmewZvGsNrl7RrhEAK3McWGQ
         o8da9LblKCEz6cOsgH6/GbLtZGC50D7Ghx5mfB+Pdzmkf+izUT8/lXIx+G5GI4PYIcuF
         TiKoj7K5TPDZ8ICKR4IlJ2SkVvmQjwuvZb8lSUFYhjD87yf7/2ZsRfGjVxSVMQabWmbT
         Nshw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793275514; x=1793880314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sLpzNdoElMhQ6QaainHoNQa+2HJPLd9vbGUI5B3uIt4=;
        b=0eIjHmejaUp7aRjz97Gv5XUZehJm8T4WjdCKaoNIe6g1mJZ+asRJkxUQaU0jl47SRP
         0furBWfW79iiyyGPl80iu9d/iAZeOUMEy9OXNRC+WyT1fZGUUzYWEo/gSCCyTLdWZDUe
         4ubvDhhDVEHOgDY7b7ubGPtOzFVvv1nacUIfzEVu/YlO01EOvFr3KEuGblEBUk0yhcY7
         fkVHdHSkjDyClJ+xjxnziE7YM+P7xvxV0oSn+sDffwMh9N0/G2/vCDEj7pkG4D9P9rJQ
         foRmAgMzVLnGktdC80DuZrFMMMPWs0Ejnj6jhGpDXUeoKxLuIAWqJwdPGW1CU1SgxaBR
         IsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275514; x=1793880314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLpzNdoElMhQ6QaainHoNQa+2HJPLd9vbGUI5B3uIt4=;
        b=g8oiX32ramrYMCsrlDTD3P/AMEmTtZgpzzEo7E79Nl40uZea8GPCcEyjRUGjtXzD/t
         oHseTpQXtMAu+egk/N6jW+TUaEscTEJ9gyzPDAczhGXmH2ItiDYOlSah/DlRdZfU7qdt
         mVGVG8JidEKZZiy1sJWhW1SAvf0kYdYQSElftfku+0yE3gIxjWgHSXWY/qYxoclq2JH3
         aJnFBN+tysgGnJIw7KboVXjqG1ZzsG5OaEhsYWTqpjHPmczBmwqiEuavJ1K6r0fJuBt7
         RWYkH2BLTzl084k72gnaBX0TiN/bSWfamuW7nzZO6exfewq/2n25372m7+Pki6B1Nq64
         FjjA==
X-Forwarded-Encrypted: i=1; AKwUvBwOMqrvLetivCBgeMfYrJmss1o5Jvmd7d1Fs/6vDMg4BjiMaYqSGHiuHxj1s1PlDdf4qtiVniv3gg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJKiM8NnGSnw5xvRO+3lU4OFQapJwWCoTGFBz9OPBglsS2J7k1j
	xc4aNWDX4bEKW12YyUodfG2xFnDLFzDozIFjV2WPFBgWa41uesqtQrbdiOsJgm1v9pi0kvdOjur
	uuCF33bu0ijTafwtHSjbTKBnQ58Y6K6Q=
X-Gm-Gg: AYBFou1GtvYCRSJ3MN/2ehmYMl7IxYzqxX6e+qKk3Cbo+kZpkLDf1a26tGCQEbZsVoH
	VFJf15a+D7Gt5CYVf+acutMlYTE7EvJ31PgsuY04BdWFiBTyibDP63j8oyTK0RK9kjBOPKBiJ9p
	5SV2oEuxBPeq6pVqGyizLI6NCW/wOFxB/WJoZQhFZQ6pprCfLTlRPQKhMZ2xzFVbutfvdGS5wYR
	0FZAX9owe+TtTXNe3WIZwQ8GFuAOEuyh6ChgtXTQamH2K1Gy/M4Qhk4h+c7tkbKQlzRn5msqzhP
	N+SMWL+jiueMU/KEXuNCwvo7R+/fxfzBdHqPhsi0yJDjtK5x185xOxC3u43uPM6ac0bcMXEyu1T
	blwXlW2GyYzT9WwrSZrXwptZpD3B7EId/eixv
X-Received: by 2002:a05:6808:1828:b0:539:c292:8b04 with SMTP id
 5614622812f47-5637ffde0bamr3891526b6e.8.1793275514190; Thu, 29 Oct 2026
 05:05:14 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com>
 <auIbEZv5macfZ4aq@kernel.org> <CALf2hKty86GatQ01C30j20oa+TeVdJRvbX=a_+0Rga33woJ6Lw@mail.gmail.com>
 <2026102915-safeness-snazzy-a36d@gregkh>
In-Reply-To: <2026102915-safeness-snazzy-a36d@gregkh>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 29 Oct 2026 20:05:02 +0800
X-Gm-Features: AclHuK8zRhRPaIrhF4m_S98aD3-pZNqJmm07Lao36pBAALpwRoRGtZ4pi-ZjGic
Message-ID: <CALf2hKv6KAFJTyDBy_yqt7QPvA1ewZHzBxchAUmcFxSeNXghOg@mail.gmail.com>
Subject: Re: [BUG] watch_queue: RCU/info_id overlap leaks kernel stack
To: Greg KH <greg@kroah.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, brauner@kernel.org, dhowells@redhat.com, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, 
	edumazet@kernel.org, ncardwell@google.com, lyutoon@gmail.com, 
	tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> The documentation also says that a patch should be sent which I can't
> seem to find here, am I missing it somewhere?

I'm sorry for miss-cc you. The patch for the watch_queue bug can be found h=
ere,
which just got reviewed by Bradley Morgan <brads@mainlining.org>:
https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.c=
om/

Another patch candidate for the relevant netdev bug, which combined as
the lpe, can be found in this email thread:
https://lore.kernel.org/netdev/CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0=
JfaOhLA@mail.gmail.com/

I am waiting for the maintainers' approval to send that patch.

Bests,
Zhiyu

Greg KH <greg@kroah.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=97=A5=E5=91=
=A8=E5=9B=9B 14:43=E5=86=99=E9=81=93=EF=BC=9A


>
> On Thu, Oct 29, 2026 at 01:06:28AM +0800, Zhiyu Zhang wrote:
> > We will send the reproducers (including the complete exp for lpe) to yo=
u
> > and the relevant maintainers privately. I understand your point that a
> > similar reproducer can likely be recreated with a few LLM prompts.
> > Nevertheless, Documentation/process/security-bugs.rst says not to
> > publish a reproducer for an AI-assisted finding, so we are keeping it o=
ff-list.
> > The same guidance says that AI-assisted findings must be treated as pub=
lic,
> > which is why the report was posted publicly.
>
> The documentation also says that a patch should be sent which I can't
> seem to find here, am I missing it somewhere?
>
> thanks,
>
> greg k-h
