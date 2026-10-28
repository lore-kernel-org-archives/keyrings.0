Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207202;
	b=t+4DpEPKt3QZfvKjiMk0ZyCBFgA9NSnn5Y0w44EXjOyQvkF9dJ5ETrkqbAlOMqKRc53a
	 Ayjwqyddv7Zb1OIhUtNCSEErG0z4/thTZYOQIiL3zNqX4xGAhStjQirG9SzdGCA2UK+SB
	 8yvv/j5rzJgFHSz0grXmEGGeM/2wH5mSrg4IGl2npDaSKV3XNM57MFHvc3Jnuriu/wVdO
	 LvS+lZKWONie+AYvfvY+HNKjClTcUtL54oZCplvQdl5eHzpDNm2Z5hQfkgRn/c37BFBmm
	 kgRVird2avtY5dUT9p4tQye1Ks53D+74CwJ6Pul3CtiPXcs9wF+EfIwn9vh1Slt+VRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r8YE+O9LVJXedkn0qfcAwD7vBT8ublO6FJuPd17zie8=;
	b=5KRQLVttXLazpvSvUGieBK9Fa1Bf/0d8v6nwETrHkoQ+p0rnebHKqek5IEEAd1HRuHO5
	 58yDipKw078II4lNEGznJhjwCUq8kdjpuh32JANiKk069PJr6NPkpq0wFYsvrzqLiv1sW
	 1HQHr1C1ug31ZV+/mA5LoLciQaoBPM5pw+UudfJyE8iVfA+9ovkE/AIoVIu0dVxuz7Zc4
	 SnT63R+F1BoZaVo9qHlrBUOEQnnibUno1xm+dGfCVnKPF8S+hpkhzMRWencUoTYUaDCTs
	 xMilDB1FMEemYoYyj+kuHgeuymkRXIqIoZO5nS9Rs6olK4GJNnYio0hc7wHYtyFcUlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlWD3h8C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849D606A31E
	for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 17:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C849D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlWD3h8C
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70b875f6f1fso964435eaf.2
        for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 10:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207201; cv=none;
        d=google.com; s=arc-20260327;
        b=pJZi/MkE1M12M2pyV4CSVTZVzhMewLyKJVN0gehXDubSLFlimUtstmMqKGKknX7WhI
         /w7zlVrmtigOtgYTiQM2vZd7LY/2wdBQtPIiQkFFdUwHo6hvcHCaAOCv1Ma8bMaVMfqi
         2zbiHFlcY/QHXr6k99rQFLuisJaL9rtf3UPO5sBh1oKXXUYx7HesErjYuFQO7BPowioF
         jeA6Yy7sg63poErnZTjsj44lFbb6KdYYGI8NlsS4N1JOlgj12RUTVgj9shVYs374NhjC
         TFRPM6W+SeSXBe6JUFDAeUo4mw1uYoUFJRzElQPtThuQhD9UYXQirfhv1YasburdcMPL
         2GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r8YE+O9LVJXedkn0qfcAwD7vBT8ublO6FJuPd17zie8=;
        fh=7HShgjZ/X7VSG5PSgOuA1I8+2tF+MPsZ6XAuG/Bgo7I=;
        b=fOwiSnOxo1Qm6bCxjGmXo5kJoZNj7nrT5mWzxtdYigXTjY9EJCwxuh16SroDaVWb/j
         vZRVx76+OY8MGoRS4CC/pTONCi5ymuLVP2xJNkO9J6b1kyyX1b489I0/JFNVNZJZytOf
         TxGVVRatOqi6df+R5oF6j++M9kVXGd0g4rzFDG/BksAOU4AZ7KlxPCmu//F6bp4VuaT8
         YUQrWl3SnUCMW5bvNdpgvsS6invb0P5864v+zx5FvXvLpKaxUwpaztuAU8hp3D6m8BaS
         TR4KXRVBkUaLMCUpS2WIRJGGLyNAUe78Ja2YVJVyo5NYpTcrciMuuAYyUi/VvxtjIqjb
         +jhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207201; x=1793812001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r8YE+O9LVJXedkn0qfcAwD7vBT8ublO6FJuPd17zie8=;
        b=IlWD3h8C28xeU2MGjteRvVYneEpyZdsvTSCtLKlhmf93hO6cJDu6+R04aiFp5maTmc
         7WkXndyvLB+Bp1GKVyEivY8azTxyhLERtDpZ0/TuwB047pvuXSuV4RdNvrrvDrGOk0/c
         dxObJBWHum3kDH90vCEskncHmfbUnMy3qNG6Q3QiwtKEA5mf+0IF2kIvkIf2X1aCik3H
         exMwLXMyvjXNa+lQJwQByKQazLO2J+RFyoqiVl3Ozcpm9qZ2qcs8+ghnZVc0zgWQ0kC6
         5oG0ix1fJHUcvEOGm9zMm+zMuqGp+anSkwWbhlAkXW1yZqaeJX8M2ZOAXTkWNWY7jlVW
         IDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207201; x=1793812001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r8YE+O9LVJXedkn0qfcAwD7vBT8ublO6FJuPd17zie8=;
        b=TOPab27RgdyV2Hjqb5CTEt8GBgr/VOs3OrAcykOXNagXqEalaiG/BlM+34Az1Chxae
         FK14nun0fxAcsIEXFM1fcO33Ves/nVwzrFXasZ6E9moEY4RR+9RBT6mDZRq9FoZXigi0
         fyBaR6IAQ38w8cfKZRoz3XAQv0nwyw+2zVBiYlw457eC+69FCydpO2qr8cpgfMKYgbsH
         F0VtNi0IhE//FKLRpZjr01A2aT2hZfp8+E3v0jMeJ5RnD1ocNCfNHCB3UbNj3eoxNSDK
         yKTZx2d2iBfnVBedCBQijZsaGXz/fnvnbXU9s8tS+i7wf+KBaEpYCgseE3QgWluk0cjY
         drlA==
X-Forwarded-Encrypted: i=1; AKwUvBxBnhpxmC60Gs7Nuqs4hwnK9WcXWySOQBlyTCgEvrbJziiWfYmVdI+SmysFAXnCu7pslicsWjvOgw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIF+cHltLFDA5CPSGFlSOduA/uJzrCKMPV/JBiaepG0X3ms/vaB
	2tSwOBjQuLaIL8hYxYiFAHJIDgGwNHs5wYxOT3VD90TN+8Sfwkt+k+mZuYVEZia6uChwc/UbwtZ
	3Dgv/1p1aryt8vR+2MH+Biq29MWNKXC8=
X-Gm-Gg: AYBFou0ILiIMk4HH4aN3mmtm9XEe6S7+XkdbnGdzi7hXs8Q0IyE5h2EA2WsDg+eUpgG
	JSLdIXVO81hNQ3mWoun9cwaWn1CYqj8K6ALStY1bJgzI50Ks4tg9KjSbaiF7jSZZvd2zKs/keyn
	pXCBIq5CBIDwQIAKtprgTYpciePaPyNXHzMFlfJQ/7PKwe9HLEaFfGxXiUB/1cuFHLXOqHR19oJ
	1mim19bUwLV4UVfyPeIJfeYkfPVaTKxYrnkFC9k9E0te6B2V5t22H2l9hzPc8srETjCcqjTif+z
	fURt7LOa/HUOOf88/VI4oANcoJmHbBIT+v08hNwFK2oIRNFxxfNjK9MZJ8V2FJ61ncMzxNXtmK/
	j9tJeusPT6FDMgMlL9/VZOU39ahaTSEpKsEzt
X-Received: by 2002:a05:6820:1689:b0:713:e4f1:9b6b with SMTP id
 006d021491bc7-713ed6c153cmr1700322eaf.16.1793207200763; Wed, 28 Oct 2026
 10:06:40 -0700 (PDT)
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
 <auIbEZv5macfZ4aq@kernel.org>
In-Reply-To: <auIbEZv5macfZ4aq@kernel.org>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 29 Oct 2026 01:06:28 +0800
X-Gm-Features: AclHuK9LCfZ7Sw7e1tkChniRiLi7m_rwAqFg95luAluDfEL8misebeHJhLl0MGs
Message-ID: <CALf2hKty86GatQ01C30j20oa+TeVdJRvbX=a_+0Rga33woJ6Lw@mail.gmail.com>
Subject: Re: [BUG] watch_queue: RCU/info_id overlap leaks kernel stack
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: brauner@kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, edumazet@kernel.org, 
	ncardwell@google.com, lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Sorry for disturbing, and thank you for the concrete suggestion.
We have now reduced the watch_queue issue to a shell + keyctl reproducer
using watch_session, watch_add and timeout.

We will send the reproducers (including the complete exp for lpe) to you
and the relevant maintainers privately. I understand your point that a
similar reproducer can likely be recreated with a few LLM prompts.
Nevertheless, Documentation/process/security-bugs.rst says not to
publish a reproducer for an AI-assisted finding, so we are keeping it off-l=
ist.
The same guidance says that AI-assisted findings must be treated as public,
which is why the report was posted publicly.

We have also prepared the fix and verified locally that it prevents the
issue. We sent the report first so that the patch commit can carry the
stable lore URL in its Closes: trailer. We will post the patch for review a=
sap.

Best,
Zhiyu

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 23:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 28, 2026 at 11:41:35PM +0800, Zhiyu Zhang wrote:
> > We have a short source reproducer, exact config and QEMU results. In
> > accordance with the kernel policy, we are not posting the reproducer pu=
blicly.
> > We can provide it privately if a maintainer requests it. On the vulnera=
ble
> > baseline it normally reports the canary, stack/task pointers and two ag=
reeing
> > KASLR anchors within a few seconds.
>
> This is public nobody cares. Likely I could make the reproducec with a
> couple of prompts.
>
> What if you instead spent some time with your "short reproducer" and figu=
re
> out how to make equal reproducer with bash and keyctl? It's a good
> habbit and helps to check the relevance because you have to think things
> through.
>
> This announcement is just total waste of time and energy anyhow.
>
> Br, Jarkko
>
>
