Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793288981;
	b=Oco+k7eknOOMxQHNqSdgEbDAuWMPiiRNw8QN1ypIW4A0UAt4xMFazhmLIdLxeKpkQm1K
	 BHEMiePnslu3aopATHxzNCFVJd+BTmO4xG50z/txIQdQw7mI4ky7YobKmtlQBbhjNFZ9S
	 rhWikM/YxCUgZY893Gvs+79f1GipRGWBobOc3hbxAAy0C4qWPRDB4GHitQA/MRtin0qD8
	 Ww8SxkDbePCRr4BRiMmTNqmy2dFS1a3FpKtCkULm80J51Cs0+C5mnrORDAF0FE3Tqdd7e
	 gjEKZEJq7OfoSfuTJVQahYTpRETediAlBsBv0EHx/TG54L3rEFMOVyEmHef385dKKXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
	b=X5XS7Wj4X6rgoGB9HFSLj5++wrWlPX72WZBo51xVc5Buaxpjb0rp3rwhTTUasNuKdCK6
	 QkppV1JGbByz4Ym5On9jP3GpaxxaNXLUkN5W3+ykVNPdFlhl2AklC/3xmO0+JF8q01d5j
	 3UD60+4lXVPD5f+yM782ubGio3d01fLm7bHg89NOgDgEDI07TYM8jAoMKGIynHPmlGolQ
	 5bPwGdeMTLtOHPMecVdNiSTELLzqOkAxl9EG+gizICII+YXJbCGS5Z+1Cq0wG0r4qBFkw
	 XYtmUIwweD42DNSISBqDvHsAht4lGDnt70Jk4GIzQWw5TGe2MyCehmCI8ulFk6XkI3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAaee+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB74606A31D
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 15:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB74606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAaee+S
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ad98c3fb15so21357327b3.2
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 08:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793288980; cv=none;
        d=google.com; s=arc-20260327;
        b=GYHgPTpkkEnEnWsv547jg+ts5fhlAxOK54tkYoccgs70afo8CDTDDLgUyPdmeVwTsW
         9/ZnnNAm4rvgt+1Xzqnhj9FzTUwzrfUqp4zg8qDyUyySHJ2xD3Mue5CvvavKw9SHYpwF
         ubFSLEdS9ewAKW5EH2N4l8RaWW0iR9QB9lGlG/pt2xekinb+jnrE2q+/HqEGrmy9snCR
         1bdyTO6q+0zvF3zYOk+oy35zYsLPXGWLB0VfSslTNs6DX4iYfirENi8kKTcfy4gw0ynY
         gLToMeGoQWFgCllSqa5qJX2BZXH9VSnzNH70LTrThEdtPwvk2zqjRbQwkNafVmtJxJwe
         +9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        fh=hvcX0Fu66ReM16BA+HuxeShuGWv7C/FRJCEPfCuYShA=;
        b=MWzHiAmk5qhA+KZ7c6sF7rIUYAjaPO/WukJ8dbAD/lPAFm4wvHn7OLi6ybWai1i4kE
         3oqEjGX+RaYYOg/lqU8V/2fCbXcKtdIOGQ5WqrzntRFefawDYuiXWataTkAiz5YdqfDK
         aH002BiE+sHBADK2LNvumhSd2BFU9dW62HQ3+E6va9OriMq5bkxFPG+0iCnC7lXFePy6
         JPo58Y4Rn+E50+ZL2JwHHUwCQ+ajmD7hfcA3T30S9tVe1e32ETdyAmSxtd2ywTgvXl7D
         p8n3Yi1MYGcDv+ZzbhdSsa1+SYIkoo90bW/v4XNvK/E7nU0gp0b8g4ECdEuTmxntOmRE
         weKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793288980; x=1793893780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        b=dcAaee+S80BXfYgGuIWlMPBosR9i6QOVqlb3vY8l/9iLrOGFm4+unNUDtzGxGKyFok
         12itqDDa4OKJG7gxl5X0/Z5LCZ5XMw0rWJ4xOU0k3c4iJ6cNbZgfgoRMJe6YaOpNHua1
         lV6h4ZR37JaIght9Dl3mG0pPKgqN9UvyZVpy+m8yUwT8n4UtUsVM1dvkwKjzDUnG2PfT
         YxPF+I4avo3XTgDKQyFs4LDafCmkMUjLyVIW/AOR3KxufhBpfK0ADP3CHeEY5YwlL1Ax
         yy1ZevKVxXWeX95dN/+heiR4nSOxEhBPanoY6PJM7ZVxGbgFyY6FgcwO2mGaqagjj674
         zrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288980; x=1793893780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        b=wRvxOOIdIRXrl9qUBv8HsN/BYY6xVhS0HXtshKH6dc+1iiUHdmChAWfLPj3xplBL8C
         8JmvDcZFaTg6f5eBfgFZNJCbjDC23LfDgo0Pe+vlDy3SNIUuXW7UmtE6UdIPpZoDznsu
         Kfrwxs0ACby9V9F1pZaLclZE4lXZ3CykHCnRyHQVTgDtrpr+0sK3s8eP1xE9g9r9SW1p
         L7B8tySKZuhy0Qs3IzziZXGZYyAAf5mqSrZBdIyE2bygoWfu1QR98l1rnNRi7JaMIXGL
         LaDfjQ35cMZh7Sdfik7WkIqvAWkjVsPbe5Z9VjsF8oVgIvsT260F++UfL7YZvEYJ6RRR
         RenA==
X-Forwarded-Encrypted: i=1; AKwUvBxyYaeXkJbAqgbSkI0gX4TFLofi9l7hKR6IXv0yXn60E96t732z0XEj9A1LFGmuDo3IViO4l/U89g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKGb8D5iGIAZkjOtgMp9ndzkeBaCduscyKVzMOBbHKcXCJL/y0O
	SWGSVGsZuHjbTznTzVCE1tKIPN3qTg7dZyJWCKx+8e8M01gheDPD6KvISQIZ0WBsJ003KcZcLsu
	igbJgNulFCKjh694WiOOB2zhaCYgJFcM=
X-Gm-Gg: AYBFou0NK3J+L2qQYspWBXaD5m9zNDiodt4c3ZO6qexx4z8KRtzvAeLQvTKkbCXRe15
	nrFObPIFRkOCSLo+31SrdXrI949EfSTjbKh6Da7ZMKbaqHCuajRydCQfHa18ckWgDwFwImuJOoH
	YLvH7sK8wssy96CWdmSgI9o54fKEBn9s9KqXismU5WRmJS8R0eOQti4wpekirC0pFVRoQmGK2zl
	2j+VCydJznZuOio4POTGLEgpEN7n/QbOF+3g8pbcmMrlc2Bghf4r5gYxTrsDeg4YHnNtam/bqAl
	bTqJDGGwmLsLE+gCtiknI3Rho9HdoiOCzGyvOmB40PyVTbj4B2lenZ2kwjDkacdevjC1X4RLvoJ
	AmXQVSTrPfouznuq+kHlPCTua0bmEX9Z6xQ0ufSDC7wfpuNxOWM3TqeRt8V7T
X-Received: by 2002:a05:690c:38b:b0:8b0:c71d:2b2b with SMTP id
 00721157ae682-8b1b5d115f8mr52613777b3.45.1793288979677; Thu, 29 Oct 2026
 08:49:39 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
 <auNGzJIWFt64IMWY@kernel.org> <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>
 <auNghmbNdKLQ2hmH@kernel.org>
In-Reply-To: <auNghmbNdKLQ2hmH@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 29 Oct 2026 23:49:28 +0800
X-Gm-Features: AclHuK_tM2GHZqt-tCPoNWRLY1HXoFFSXOkHSMBhJQPhDESUOrTm0WDe9EcLL1A
Message-ID: <CAFRLqsVKXJxqpPCj2od3AxnbuEa2Y6PMz00kgAq83pMH5Rchmw@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 23:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Yeah, overall I think this is improving and that's why I'm nitpicking
> stuff. What I would wish that if you could hold with any other fixes up
> until we've got the previous fully addressed.
>
> I mean submitting a fix trial that is not correct is not a problem
> or wrong for that matter. The problem is that if you put stuff out in
> volumes with patches in various phases, the odds that fix will land
> to the mainline tree rise.
>
> This is exactly what I got pissed of last time. Just wanted to this
> clear this one up. Also, you can use that on-hold time to re-check
> your unsubmitted patches one more time i.e., do your job better
> ;-) At leas for me that is something that I want to continuously
> improve.
>
> Br, Jarkko
>

Thanks for the guidence. I will follow that.

Best regards,
Cen Zhang
