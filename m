Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C535F60E
	for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811858; cv=pass; b=T/7y7a1qZKMWWE0zG8s1y+022YJaBIpsMRfRlT8XMK0k0io9KgDllj21QVKuTQQEfTgfCTv1vPU74Ka4Ck8b0X3lWze4etQ5VEy4MnI8w16nzxECfCv1bDDx0wgyDnqUp+zIpWK+zL60HWsOm8giilncTirT1o/iuAH8luDI9/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811858; c=relaxed/simple;
	bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdSqAw8zjJDhJQ40idt+z/lxSqok+MrZXrj3P/6f9D/cW2diDORshemUtR2Kn2BElQU+XaLzr9qM7+Cx0dcwSbHpbh5DcpzTbqBEYRWytJyP3auN8v2Kh3YSVSx/PDFIk4Zap+SKmPyEY37RhmJ2dBMh5+iA+0aT2Mq27WHQa4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To+M7vtE; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To+M7vtE"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c8bde2dcso10087337b3.0
        for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 06:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811856; cv=none;
        d=google.com; s=arc-20260327;
        b=diM2JX3lBM4yoL6wlm6H8v8iak2QfSOQe1JjPZaeq/XSNI2fdWOG1xrE2cpTQK7joS
         SEtoH1WoDzORrGMIYdEpAxHrMAl+y+o4ZSgmU9E1xWqw6Yq/5OR+aTRBtYW2b2tjowS4
         iVMQm+XH3D//WSWDJ0BsKyGOq8D/B1tI94TtoWXvpIWPZDEoQ16jkgexHgybr6/qsDzv
         qCawdmbzhb2jg/5IiYyL3Y+dV+e9cyUDNx0CzRk4WPPC6fxI0IY3QHwSuzj13eY537ig
         fsgRVSF/NGbKt4Gfy8M8exKKG1gRGW2Yj8qDpfgjoed+mMLfdyYENI/bIOQPyYv7Ffo0
         ZSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        fh=/yejKrFcVZ36oM8+q5yd5jajREP9X8KKNojPWF+GCmQ=;
        b=mm/llqJ42imZDMGOhVwr5MgxIgljnb3+hL6rtDBv1ujgCjoui8QEbUe/HrRnQKpJsh
         OpJVcX+gITL4nHXXnY408r15KrkYszj3zUZ24Hht24ExN5jR4EllnvuFcLS1Zsh39hcL
         M5zijaveNDB2B1gE8+pNMinRTuZtwkesQK1QVcKXgmXHoPhgWdy2AZyYV2H3St54IdAG
         3m3lRUrpJVp5DHF6GnYx6XgbTHUJPKrvTPG4SjHJon9pgvS9hZ2g1Ib5mim+4XtNtmIw
         ANUin9Hfoi8WyctwoiUKVDqEjnvTPbz3IL1s+W2EzlZw4eauC/4YsBx44Z4/L0LH1KRV
         0Xfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811856; x=1792416656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        b=To+M7vtEZkHjvtni0GIsJBcpb0+VCa/dx3mQlJluv7Qpe9ljPPgmqRSrKAo/OZ99xL
         3jM5alSXRo2mXSMvFY2cShficiN3ssbSKnQplu+kzxCjE8+VbiZ90UFLksVHJG6ul2u2
         c+ZObO3y8ocMfuoRfHUqAplNQgNZrVWvFRVXVffPRtSiNgA/I6FVnWKv/QTS3s6V6P3k
         U5a4GqYXtC3WUOu0wSaQRNagJJLOGHkLi1SVwrCchuWIMFAUOFJe795cA8WdgDa94gcC
         pC1lApWtK1n+JvxyZK8gXSrDpUAwYE/utCJeTMnOv7a3LGsp5hiKQqpeBgIZX+0fZdo7
         ofgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811856; x=1792416656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        b=LHF2ZbLj62HmvcfnP7/iKbCceKG47Kdtkr9jMixKLwFhLSRNFTeleQnGC5IYD6GjwY
         KHgnnE1FT6aJd4/rf5l20eTZDrSYumW8cC7wi13ZL2UrI2Cni/ncLxlfTVtiOlF0jeBD
         t229BQe+wkUqwy0dx7V96zl4CFoIVhOxhj4x6XHR2CxC+MR+1WAWsoGN58gFJrMpDmci
         XLiSltlRFt2HuKtwMxlHa12IMo/RcanDDBc3An5bAkyeLeBT4DtTOGIG5TT5hqov9Wa4
         XJlhm7YhqaHIu7RP64ZCqcRuCq6DOIDlm1tByWzVl5wwKUF75xWpEeJVX/HTYRwbEBOw
         NDyQ==
X-Forwarded-Encrypted: i=1; AKwUvByqSvU3zfjmlF3xm/wOrsutLXILDcnUPL2QdMlCYNWg/uSjYju8yYS7kGaWXyHg6NXPjvR9i3HuAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIY6bcOc+3cZW6KD3GrhjnSidxpBO+ygNm1AXKs1xqfoT/Tiiyq
	3CLQ5psEYjOkyPx2TpOwuz4lHrao+3m3hPiYlu2qqBmMY9QQT286LwtZ5Ps5uQmIMsxBhVqodsv
	SeF80OOOMWeg1tI4NZ1x8RyGY/ogksmE=
X-Gm-Gg: AYBFou3uRJEebzWxRTEBddX3Vqjo3TiOzerrf1xfVjX6u33wIpGu/b0G6COJFHi9hvu
	XgHq9xxbMUeDALRc03rxaaLuMVp/PPWRP9BhRGxc1LDu4veJODXXaN940DNOTznoYN9GYGVJwdA
	tj2C2Saur0eJ3fXvrvcf4z6TXClxN4e4nRW0o4P84VdLa6wSHMZVLyAO1HtNKmxwjfkKqPgWSRv
	TAtpblv6LrIuYHOaqgtim9zcOcGXU+S460MY4KlXSeKU6M/24pQFR6QBGIItZscmOHPJDR0wejt
	EsLmpKpR9RpHgYLudcsvv8ZhoLBqmzvFTJsnHdxMC1aoIHQ3RmTo6pxhzQ==
X-Received: by 2002:a05:690c:d8c:b0:866:7724:3bcd with SMTP id
 00721157ae682-8b07ed1e667mr44288127b3.16.1791811856206; Mon, 12 Oct 2026
 06:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
In-Reply-To: <aszalro6U6BFO_D3@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:30:43 +0800
X-Gm-Features: AclHuK-JMVmEQk9s9PUAJHaHm55xlb-Is6siTbFN4AUKpBCWpjVUnqE1DSSZ9Ps
Message-ID: <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Thanks very much for the detailed feedback and for your patience with this =
:).

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 21:03=E5=86=99=E9=81=93=EF=BC=9A
>
>
> I appreciate the fix but if I'm completely hones the commit message
> looks like direct LLM output, which is not acceptable.
>
> It needs to be proof-readed and edited. For this reason, I want a better
> iteration before I apply this.
>
> Br, Jarkko

Thanks very much for the detailed feedback and for your patience with this.

Several people have mentioned that my commit messages look like they were
generated by an LLM =E2=80=94 and to be honest, I did write them with LLM a=
ssistance.
However, they often gave me the feeling of being questioned rather
than explained.
I spend most of my time looking for bugs, following my interest, so
I=E2=80=99m more familiar
with bug patterns than with the deeper details of the subsystem. That
means I can
make mistakes. I=E2=80=99m willing to listen to feedback and keep revising =
the
patch until it=E2=80=99s in
good shape, but the pressure sometimes makes me afraid to continue the
conversation,
worried about making more mistakes. Your patient explanation this time
really means a
lot to me.

Of course, I also fully understand that busy developers feel
uncomfortable when seeing
unclear or poorly written messages. I just wanted to express my thanks
for taking the time
to gently and patiently explain things clearly.

I=E2=80=99ll carefully rework the commit message following your suggestions=
 to
make the concurrency
scenario and the reasoning clearer, and send a new patch once it=E2=80=99s
ready. I=E2=80=99d appreciate it if
you could take another look then.

Best regards,
Cen Zhang
