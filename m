Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF89345750
	for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812000; cv=pass; b=haz+tTl7ZZWcrcB8VgYZZZ4QWBfRhOtz2quT6aYgR8/zV0zeKm2PXIwwKn4GiovxlZwdh6A3zaUDHyGM1mgb2TeX8vXMLw3irOJGhwCMLSgujQ+DQrcZRs0farhrfBl9kDYzXPl2N9PBBe0CfqzvjbEH60ZysGYtmnsRLDBtYn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812000; c=relaxed/simple;
	bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oToLPtSVnvfXAh7EqDgZRnMkQ+AeowGsZF4hEm3K+Ka0WCFcIe0j+1jS7l7oQq2qq3Jic31vMcIScZdb/4R1Z6GkXpXScVtJu8yUMtT1KpWgX1zVeLoq7mrpOrdQlmau9IbVEP56vCL5vUqth4I9btIeuocvH6SEbGt/trrnnXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSzwUVwG; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSzwUVwG"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-888cbacf70eso21203407b3.1
        for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 06:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811998; cv=none;
        d=google.com; s=arc-20260327;
        b=sxEn6UDxkPO1MO6vBFfsTTPlTVFXGkcUhZsmCaW4RenmH3vBhd9eTe2Eo1x9JrQk9f
         Phku7zfKWQMJjrdo0N70gihSt1ysFc24h6+mltiUXtZLf3vgh+X72R2DtBMXtplOs3Kr
         jEfEL6a/VE/+rGa9bNydeWQhJ0x8e95Kl4LpnzGl7Gq1jHrjaqqOxw3KHvm27e4LelSD
         zYyMBYMis6i+2EvJ+/nFdDTAycs8Gws7ceNmkaostRxU3X5cIrSIuNnB6VHIA/1EUnkI
         +78GFLJMaQIvlAAZMj6QPSu2+oFxuAnL1pR7eMfzvBWq59V7aW/WET0HfYUpVbCy17YZ
         mZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        fh=nxjcRHljruSVbKHKrhSLKT5qKveKPquYKjPUKKrUL9c=;
        b=kw1cDyS+/dC6kyZNQwVrt4mWsEx2mWthEP0UTwRRMa+0OB/NkkxMF8NAItnIO1gYFj
         udKs1x2VoKfaK8EZISm/a37xSQlEQA3Ar3g8Z5vCr3WiebDaKnYhXHdB8QwSoEuL4cDk
         xqHqyqXDFm3hvCINogO4YLYTZBE8vufjigyF5eNEsGdQeRHUELK5QGIX2ZVBtQYwsokZ
         M+pEu/TfublCXjTkp1fTcfxlm4wTws+L7PaDXcTlVnqXRZxWG05svFIXw+Kv5PyZLs/n
         MfJGW/TB47NAdtEJCeYfuv8ez3LelRhT5o75eifC0rITqFEIVlE09lCYONozGTMpPYah
         sYkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811998; x=1792416798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        b=FSzwUVwG6G1mDAVrABaSLpBK7Bojaj/Xk3xCR8fmpDJEBquYYdhmlStPb3W6XEf9vs
         AXyTRDOpU4zWm3geVCbPxF+dj12uuIwg+WX5qtUN9SyObD/8m92TNsx8DtUJLZG35fJM
         s1rQBXHRvjZk9DrfcVyJPvvJg8VSKrjch/nczCFZoytXGbBBMM8ohIWTTBm/IUyRU+JS
         UyvnHqe7WmTjZjRAEQ84z32O02JjZ70Ln/mnUE+6w4YDaiZ8TEbsJYbVww1H5Tn3CicH
         H/33qGybbu70JhgQaXCAEsrp0Kao2a3g9qENJ3JeQXssX1JF528u2Py6rIkNiL48O6wd
         KATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811998; x=1792416798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8kBAHTJFyIMI6V+nJ8Kf/uBpMG3W+HiIvXhG9fBQzI=;
        b=bk5xX7z5g+jLgftaD2JrfIXjW3Nh0yW0mPHpHD1hFflBNhVDRFnO679yyayMDSLJj0
         yipI5GLNRmS+vJxpap2fke7cEjx/Rgs1Uw9WySIyIJ62ijxMksGhFEy1iqNHR1j8TK/H
         ykHm6WpcrI+siURX6PoD0IeV5fobyZDA63lm1oxa8Zbt7Ew4NyY1VYOdbK21lgb3hxIm
         lfD1Ad3HCWKHhHqCEfwJQfV0uoomuBMFfuBgHCedFQPWluMb6Uosdha0ux508NjNwixk
         kQzq1LsmVg/ofBJ/tRHqzd/0tw77vICIrt1Z48yj/l8sqVNQiPXUL+Jll3kEFVaJklSZ
         e83A==
X-Forwarded-Encrypted: i=1; AKwUvBwLN4ozL6eznNqmTSd/1mxcW4R/lSn7AAf2/KA5WJHyHKE8Z3ttvgJkYh03aqXsA7t/z68eDC+cpw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJp+FMniUqyNjr7IiJAugy+5uj5QbkXWC1NdHM2Tip/WL5EhnKp
	/EG+KhFccQ9YAacrsoYBohfwofUPwncWdJdnuJrQw+13s42I56LSIWKJUllDHg8buzwOLKzSDkh
	AgEUOMmLI2Xej583+6S1fruBRZDPmg9k=
X-Gm-Gg: AYBFou3+78t46f7c8FjAMYVL1Bwnj7aDHcjDOEv42/qtpRcO+A9YRzawQSZH1XxKl5a
	zZZZgDfZQ1hRnq1fO9I1Pi0Jtc7HukKSGxlKq593ftWqvMOozrIfooSziSnV0Qk5gbcv2isKT1s
	/QZ9ySxjDJtc59UldggFsIShN6iRmZ3YA4fTTKYgrTqjWBGg6wL7Nh5R1E/mWxtEoyIGMWFindh
	ZLVlqRlMAiP13BcbYoC5LDFBcxa5Et+gjz6DyGo8d25TArmKjTajerFdTjzoPyzPr3TwKP0sYnx
	Qm5pBg/Sr8VlWUtL53opNOI7qAK9UkQfzQ9uBkqZ8nhSjVgJjRG9tp3dEKOqgyGyQ33v
X-Received: by 2002:a53:ea42:0:b0:676:8b69:97eb with SMTP id
 956f58d0204a3-6793634a484mr2435865d50.160.1791811997636; Mon, 12 Oct 2026
 06:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org> <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
In-Reply-To: <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:33:06 +0800
X-Gm-Features: AclHuK8khvWi4McmLLK-ANublHQc9k3MPlNZnAtRVi0Ml1u14dD-i-9XyWHto-8
Message-ID: <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Sorry for the previous email =E2=80=94 the line wrapping got a bit messy on=
 my
side. Hope it was still readable :).

Best regards,
Cen

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=80 21:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Jarkko,
>
> Thanks very much for the detailed feedback and for your patience with thi=
s :).
>
> Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=80 21:03=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> > I appreciate the fix but if I'm completely hones the commit message
> > looks like direct LLM output, which is not acceptable.
> >
> > It needs to be proof-readed and edited. For this reason, I want a bette=
r
> > iteration before I apply this.
> >
> > Br, Jarkko
>
> Thanks very much for the detailed feedback and for your patience with thi=
s.
>
> Several people have mentioned that my commit messages look like they were
> generated by an LLM =E2=80=94 and to be honest, I did write them with LLM=
 assistance.
> However, they often gave me the feeling of being questioned rather
> than explained.
> I spend most of my time looking for bugs, following my interest, so
> I=E2=80=99m more familiar
> with bug patterns than with the deeper details of the subsystem. That
> means I can
> make mistakes. I=E2=80=99m willing to listen to feedback and keep revisin=
g the
> patch until it=E2=80=99s in
> good shape, but the pressure sometimes makes me afraid to continue the
> conversation,
> worried about making more mistakes. Your patient explanation this time
> really means a
> lot to me.
>
> Of course, I also fully understand that busy developers feel
> uncomfortable when seeing
> unclear or poorly written messages. I just wanted to express my thanks
> for taking the time
> to gently and patiently explain things clearly.
>
> I=E2=80=99ll carefully rework the commit message following your suggestio=
ns to
> make the concurrency
> scenario and the reasoning clearer, and send a new patch once it=E2=80=99=
s
> ready. I=E2=80=99d appreciate it if
> you could take another look then.
>
> Best regards,
> Cen Zhang
