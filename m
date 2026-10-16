Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420640F759
	for <keyrings@vger.kernel.org>; Fri, 16 Oct 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146957; cv=pass; b=bx97/K/Gk/fE4A2GdS12O5/zT1lzKWx1D2bUoO2RNYL4YwwrzCSzNHF7+z0gYWZEKzATQoRlTFEdIy2tPoHbG/31KEJ/LvMcmpNrQ6YUGz5HFJINUafVlHnvnGcQlenwng0G4vHzorw2ordR+FPnTQo1AQhZUunIglU/zK1M/mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146957; c=relaxed/simple;
	bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyiT42O8W0XDXcGfnYXJDmLIN+752CAuFfGBrCAW8Zl6wGU4B05w4A7IzMjM2V8mMRZVk1a06rWNdbGA9rpMgO27MiQYuPOkxAQ97HH15+cIuKgX4wp0u4SwhtdwdWctmS3VkYy2v1eaMwvkZXufI7IsKfs2rIlsTSPUuWiik+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDIyBTxh; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDIyBTxh"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2720295d50.1
        for <keyrings@vger.kernel.org>; Fri, 16 Oct 2026 03:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792146955; cv=none;
        d=google.com; s=arc-20260327;
        b=nXWXPdFzDd7R4X2de9KWK/FYwhHhbAT9IsW2hjqqGibmNWow5QDy77YgrF/Pbt8Gch
         v8RZLIPg4u8o5m7ig9XXrDkVFtbLAWUXdnBFIkf3bXLWLG9HARAKn5Wq3K+h23sFewDC
         EdPjOjK+aSibPip6a7o+JwubkEwC5HDN4CejQ1luAVV1TE5FsFt/jxPk1jRdSlH/erVT
         PYgyeueeG4LFbJsYfDci1ZpvC6xnUZ7DxFlSFOF0tJ1xuqyr4vCCfHfR4gLeXHwzfGM+
         fCBi//uPbwN06gJRFH1DMX2dOM9UB/pLx8OhWxuXVfdsxUn7Ex9QDX30F2Y6rUztHJ7T
         shnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        fh=SYWBiy2qKiJbBB/kyqnlzK/Qhw457c3JY+q7/Ht6Ekc=;
        b=HpXEP/OPlTNG1Ec/dxFSMClDeMR1xow3wbrEVGhHUNPG0rmn0ro+/oO7Viua8znvom
         solnGQ/Izk7QDiQdBIbsM6XJEp/3P4OiN/Nxmv71Zql842xgCHV+U2Rl3sw5qy2y2GkZ
         9KkSzCweytgcOXNQfBi+HjwmTRFAePGMoInRwb5/fDBMcPd5qdzmgqmfjC036JRQ65OW
         cM+Gobl8af5bSiXSP3lUO5ICAN44bZXHr8zdzuTF2w1zMx9bpJ1d3yHu2eELd3r2Po/4
         584CkdT9RTpyO2/qotJDhB3rw8o0761xflWKZZZ6qPIXJug3O2hF7KHdiGiUDIdcwVv7
         MZKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146955; x=1792751755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        b=eDIyBTxhrDQff7mW9sng0mdhK3g5PpoOmrMtkcWP6JeUT4/mOAEAjZpWV9xgqTpuVw
         4WmqIfMpdw/CyGzm+tjj/e+d/GSGnxSgJIK122wf2DexNRHhrvyY4JyG0eGYNb0xial0
         aGobp7Ulo7sQRukxtwfsZaxp2fZP6PUgab+9MT0w+4hvwZBleb9SxxaiEl/5bcFv6NEO
         Je4+NP8A1Vp/cLpgs1qPbS3PNYTLxMDGa57appTf7WOU19RyyichOtCGDnvTfvs6YpkQ
         Loq7c6bQNBjrgn8578PL691hsdKWIlncs6fQRNVqSYVM2/wst7lrVPHUTzY0vb1wz9SJ
         6eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146955; x=1792751755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        b=cZkxLRZPpdGAAvygwo9bcz+Q2Zp5FQKv5rUNSdl9DpQHYiF+oIyUjt3NN/G+Ud5oLl
         ZvToia2z0cm1+A/z1enDPffB7Lp/VaWWvnPM4veuxOoeBSukNtpjYhL9qoVJwisFroon
         xS0MPN9MsxL24s1nu9HaN95pZDXafyF5/xx4tXqfhYY4O5R23f9VSGyhwSD4MTfyI1Ju
         sz32QA7eKpn/jSOCEkQAc39JAy2ET+A0W4Spq8SDsb4HLuiRdEDga8N+S2uOyG3hN17N
         6IGLq76EVLTt1kbwOrxJOP6NbznT9U4xJ2Ytl1w0FOOawBXACRIAfMznPm5wpOUnjMft
         fseg==
X-Forwarded-Encrypted: i=1; AKwUvBzkEWtioj3ooMigeTLjakjNtg4xQ69z9/+94M/umAt04sKZmL1iyhZ7ZEQnSNEveMySM0l1+LS6Iw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKigbj2mwlfLL+yAE/e5+t5EGvqwIAhtguSBihnjxyuppu7qhwQ
	uMgUykMj57UTVEFVW3nlbyAViMQC/kTjh6GR9bltOULteiFImvJskKNuqCQJPBg5M/HC19iytec
	GgQlTFELGyVrj/B1xA5eIRXDc11yc9z0=
X-Gm-Gg: AYBFou1JSKroHx/h6YqkapznEskvu7ySDZm5b9sxGM9c5FD/3wx3UEgYh8x0LplZJMj
	9gTmyJ4tIju7YQ6RC1M5TUu2a9k0W+ixnBp3rL6Xx1pW1TWPVy7zNNnYbQIUq7yB7jOr6Tcfs9c
	rOy2QINZQj6lu44vAwGKrGsQI0eLZmAF/wabllNxIfWlGfkkR+Vk2nOGWSy1ztSb/sHhQ0L8XM7
	x2xBzCpd2E71c8PkPVKuFVz4eZoVd/UvYxqFLlx4gcp1UVLeu9oJBUnEkD/1/Th2VOdmCY7CB6m
	3yhMJu/JyQ24XMD+vqlfRZO0sv9ZNJKGBgtHl2GYUIghikb8NUc45H3uQ6dQ8tFN/2jvWgfTrzX
	8/szstcvBnQ==
X-Received: by 2002:a05:690c:a78a:b0:87e:2404:45fc with SMTP id
 00721157ae682-8b07ee0119bmr44016477b3.53.1792146954580; Fri, 16 Oct 2026
 03:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
 <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
 <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com> <asz2YfhterfAVIDH@kernel.org>
In-Reply-To: <asz2YfhterfAVIDH@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 16 Oct 2026 18:35:42 +0800
X-Gm-Features: AclHuK-sJzY1eXcpx-cLXrXzPnaYrBx0Yr-GHF2vWKubBZ1hKuC-0SCei8df9QY
Message-ID: <CAFRLqsX--CoQ5XwazdJS_bscK43F9oE_nLOpq=2FDh3teQmnfw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 23:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 12, 2026 at 09:33:06PM +0800, Cen Zhang wrote:
> > Hi Jarkko,
> >
> > Sorry for the previous email =E2=80=94 the line wrapping got a bit mess=
y on my
> > side. Hope it was still readable :).
>
> All cool.
>
> >
> > Best regards,
> > Cen
>
> Br, Jarkko
>

After reviewing Chengfeng Ye=E2=80=99s v4 patch
(https://lore.kernel.org/r/20261013090358.1178367-2-nicoyip.dev@gmail.com/)=
,
it also address this issue as well. That fix looks good to me, so
please disregard my earlier patch.

Thanks for your review and patience again.

Best regards,
Cen Zhang
