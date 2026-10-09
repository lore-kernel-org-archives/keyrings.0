Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBA3AAF7B
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522469; cv=pass; b=tqVnJDdBGWwTcN1p0W1FFAb71fWwFFbj0J4KnZDZ2SQJLfz0Y2EvqESXGF5DhmKFrFCOgxyg1LdMQY4DP2BWsWRAYqeKpDIqLi1l+/r1KbNOYsIJW3wDwtJswNtoNoIlem/XHW7HBAdr/kForzmxhpwGqWXZkM3Bp3MkpO9WV7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522469; c=relaxed/simple;
	bh=UCPNgs7T7S7vSxo0RpkwEmW84kuw7TMAkPdpCW+Ocws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOv6UrzB/Jmjz8x+rsVb6PS4+DCwR7eLKL3Cz0lkeDyllyfBkxavVGmG9DKT10c1PTPNe20mUQRHuyUgL85G1wgU4qVshKAGPAarecLmWF+md1GY7rKBGBwcMve75Q6uzIpWkO8oGkGq2J8ryBGSbZLQOe+3fgsp+q1X0ENWpDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYgM4cQ7; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYgM4cQ7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ae8607e8afso37282687b3.3
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 22:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791522468; cv=none;
        d=google.com; s=arc-20260327;
        b=IYf6lIoVjU7pu19+oDGTspxduDI/gb6LDLBEXLXOLczb/X9Uk4LyPS+bkhUtT3eEpZ
         soQFPKS1XMs+z6PGTQzdBQq7Jvbu9BXsg6C39Tjh1wq3GAFYNOwqICbs4ye5qJBRAGrQ
         CP39j5BcfPwxoJFY1C27uOV6oYJCVdaIT29obLqRcx7ps8XTIS9h6XNy5KDojbHgYkeN
         PYOAsAI1mN9d4cetWH06gc7G8swjRawdy4igCH1y+P8JPCr35LqBC4Nle5YMx5GDC40k
         I5EcrDZPsApPlvgWfp8Bq/pNG5PEWImxP0prn2MDsuXFsw/9zcD3HzyjoKs6T4up6Gp2
         PM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        fh=IaJ0UQ3+8IY/6U2NBynK7JF5L5BiZBwNiLypLp53/gE=;
        b=Is8mf1j2FkJomhbNxQkRtTL+q74lD0agjTTOrrI6scJxn0DsUctoxYx9z5FaHwZBt2
         gqla4N7jy8/6hEHMCK/9GY34othdUgvPKG1L15P5KPhJE5RQkLZs1nbbtKJceEnp66KV
         IdFqAOhkaddkh2QVvyR0r0UjtpPCAI67QrIKTytNoteqc5aVJWDk/+3wcsIxoR6OCF2P
         rVe5mbEegIqRytW2xRiWsoSsIh+R1/Pa9eV0Cnnspvn3j2qjDHDeK2vqLxxmejHuGSoI
         Jh39P8QqHl95K5cCy9Dt6Otjtf1lcwdCofvoGh6L5pjZtQjUqUBXg1ngWk9HP25GjYdi
         fDjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522468; x=1792127268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        b=lYgM4cQ7CxEgMrskLr36CaxFfeibwioXt8yCoC0CfS6Zo2NcA8Q4rwqfuofTFI1Vrw
         F4w7RNTfmiax16hPrlL0IF8osvzHM4+KW6KaxJv56YoJO5hralzumaLW0CksjvWK1q0z
         mZh4p51AisS8wem2TYap8nCy4nP/tsjtgDn8110DobsSajHAYWXmJsAsr6hPsGjVJO+y
         58CeuY3GNlrmP4Lo4aAlN5He+Mg9IxzF9YcvpZxieW+/NN5gGYbVLGGWb8GsId6INjhx
         djC6q3kWqixOhZXElqFBSyTxrlI2yESqnrS3B+bhGVYkYJ9g/1cIJV3gQpAvcVne5zK6
         f+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522468; x=1792127268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dtIf3z0dvmVlA//c0wg2QPe+8angNo6UaOAKikdDOs=;
        b=l9JA2ZK6lGyPUOg+ElNUR1niUv2j9/wELykOHmDkMUDY1+dL4NhDY53ELbWDDeQbrT
         Tmoh5nr5O3QeiM1ndI8pe4PuDbbXIl80sSZsHjUxHvxmZC4+Y5d3C94kjlFtgh0+sA3i
         7rt7C3XLasDp+RQPwvel0HeYitxLg7aJWvyXdnqQFoYgbQsbzLHOGyxqzd7/jHyZ/cNM
         avrNaqpU0YQUSmfwQpq3/DEws0PgMUhT1hi96SHWMpjsd94jAc0K+iZuDA52uCgxp0/G
         myKRFULnnebdErFwt3+++Vit+uJhNzS0XqtkjMfBxgmsXtr3pM7YSZiUe+v/oZ5e4aKY
         VUDw==
X-Forwarded-Encrypted: i=1; AKwUvByy53wGMbovntdWGnsj0OfaEOMrpy9C9JzKBXGFMCcZBI52Xm7EpNprmMbraUdZoyy3bFSjAjIr8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYI2thMkD5hX6jYRKwDrc0k3Vsdcm0oFoQGyazZb+MgHnBteZJPN
	x4FYBjArRNGK9szrqfko4h+TkiIkZRxTiHUUzFf+2w2vSIY2lf0jBSEO4Ino0uHjRC2uyK27Npx
	8WA11wmza2wOCkW9BgD7wEMK0QCzQo/g=
X-Gm-Gg: AYBFou2mzcD7Bhhi43UJtozZDmBwZP3+eE9srBPXX7/fiVBjE8QJ0/w6GU1U2dhRcFk
	xG8pkdfkCHrLOCWVv2vY1Kok2JU6GrHQCK8LH90X0ni2Im2ralz7eyB+ZQgtE06K56BQgCD+FhN
	UmNJmirJg7xTMTq9KMzUeF1aA01kZukzAtSTxAvm6yLTBeRdpCRad4DncXz4LVZuab++Nc+bE7g
	ihiiBlnxfvh6R+DaFCdGZCgltMHcOdozx4INJBQKa/CSuuvEgq0Cq+K1PBVKEge48Fka2e7cHNZ
	j/Mzx/ANY+a/qqHNrn3UTNLnnc8JfOnW6FTcy3CIR7mhFGjUaX0OiDo+zA==
X-Received: by 2002:a05:690c:a588:b0:8b0:7900:144b with SMTP id
 00721157ae682-8b07eea68fcmr1801207b3.68.1791522467787; Thu, 08 Oct 2026
 22:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
 <asfZMToWNmQDTk4W@kernel.org>
In-Reply-To: <asfZMToWNmQDTk4W@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 13:07:35 +0800
X-Gm-Features: AclHuK-clEa45iiMBZBHhd7Il41JvNCy-ntPtuIu1Vj_0gM0qBhgbfp7uMK-3Ds
Message-ID: <CAFRLqsWs0BK+dLJ2D+cFptF6TtgqhPSp5BYOz3K60AyN=oWOPw@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the type name while describing a key
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 01:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Just a small nit. Cut just the snippet of the report that is necessary.
> >
> >     BUG: unable to handle page fault for address: fffffbfff8054794
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100b0b067 PTE 0
> >     Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >     CPU: 0 UID: 0 PID: 500 Comm: key-fixture Tainted: G           O    =
    7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
> >     Tainted: [O]=3DOOT_MODULE
> >     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fi=
x, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >     RIP: 0010:string+0x23f/0x470
> >     Code: 48 8b 04 24 48 83 c3 01 41 83 c6 01 48 39 c5 74 34 e8 f5 2e 5=
e fb 48 89 ef 48 83 c5 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6=
 04 38 38 d0 7f 08 84 c0 0f 85 d6 01 00 00 44 0f b6 65 ff
> >     RSP: 0018:ffff888116307b80 EFLAGS: 00010246
> >     RAX: 1ffffffff8054794 RBX: ffff88810a4a52c0 RCX: ffffffff8626be7b
> >     RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffc02a3ca0
> >     RBP: ffffffffc02a3ca1 R08: 0000000000000001 R09: 0000000000000001
> >     R10: ffffffff893cfe57 R11: ffff88811404d700 R12: 00000000ffffffff
> >     R13: ffff88810a4a52d4 R14: 0000000000000000 R15: dffffc0000000000
> >     FS:  00007fad30f2a780(0000) GS:ffff8881fd7d6000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: fffffbfff8054794 CR3: 0000000104fb7004 CR4: 0000000000770ef0
> >     PKRU: 55555554
> >     Call Trace:
> >      <TASK>
> >      ? __pfx_string+0x10/0x10
> >      vsnprintf+0x330/0x1110
>
> I would cut away the rest (what follows).

Thanks for the review. I've trimmed the KASAN report for v2.

Best regards,
Cen Zhang
