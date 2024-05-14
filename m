Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F717EBB5
	for <keyrings@vger.kernel.org>; Tue, 14 May 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701149; cv=none; b=f4PBg+Rl4yx4XpfxTf7todSTMDXzU3JS+3O3J0VByYyKvYK0IEemKmuVmcb43Kyvq5D5Vt2F5c4cMGVWoVb1ybbqp/cxV6eXOBcoIHdUNhh3j4ujalTEI7Ik15bCQIQ6j3UlVbqJugXn0ESAHtB8P28TFgwW6nEBu9sKgbKPpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701149; c=relaxed/simple;
	bh=ErRx23DPSPLAwdljs0/tvOWY83daNfEDyClGFeMkYK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9/CLmPwMM+OKIiFM9cYYHa8ymuu6FHD6Ljkw8KPw/D39JOFX+wXQnbWrZ9qjw8b9tVqF9M1cjgSJEhzlgVD3pXaxJSHlj92sJ2qUdXsbj5CdrapcnIy+pwSx6zJFOxoreK2S7Lo9cbvqqNuSiHo+n2XKb5Y5OKcFI890nbtpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xebpp9ow; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xebpp9ow"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-61f2dc31be4so4659530a12.1
        for <keyrings@vger.kernel.org>; Tue, 14 May 2024 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715701147; x=1716305947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBawWwjcxALOoVHPnP/xkOR0sFQUYdbuftVX1+1xI+c=;
        b=Xebpp9owF2Y0a6ZdSXrRLBjCBpcDBumNmc9190FVtZKtR8qmo28RCXHX41Jgu1oNXC
         Uo8EMuyAHrKp4lRBInxsSetRR7cxx5GRJDdoypTFzO2sRatRdcecuW8Vabq+bfPJS3SZ
         nmzaRTTkcRwgLTEIm4q6Hl3/ul5h3Orxbv+uSDOJEL0xwo613a87bkWko3Aj+iLQ04b5
         0rLAPfet464O3eiN6ME+udYV30cu6R16WvhddmgjRRWBSjNmU8oVkXdRpC6kid/xiE3i
         PtLoUzQUC40nyNZ+xeQHe3Z9o6sxNBQJPG8kmeZehp+2K2NXoAn8YcKMlT+1fb+0m9ff
         aDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715701147; x=1716305947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBawWwjcxALOoVHPnP/xkOR0sFQUYdbuftVX1+1xI+c=;
        b=KeLPVdCkS/oJYF76ih3N7RFtKa5/OQblK3xK1oTZDWe0lJcqSGWYmVXVIIeOgWpBu/
         Hh3bVVt//tp5PYkQrlGk0rc1VPqFQf0+/yskrePy+mX4HD1GPj5fqtZW/yfRtVkqrwe3
         oI1d0R/puel4nrJ9uGlGBe3KsIGrh40QzqCzu4FHUdzO6qbP/1Z7oyM/pVPWeMbDnGHn
         O0bAmP/HHdTKBXJmh5Xyg8jNghQJtT4NQf6oEbYkk11jKcIqgwozQo4RQduETeTwvJcU
         bC1opF5AqrYClMkcXi0dumShlk6HlqLRNxtHDNt47iCuEsNtzqJZZZLEfP/WCGPGMAQL
         nYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqMesoX6C1WLN9P114yHkHQ5G3V+6SAgKrvAiqpn6DCAYGFqGepEB2lyo/gxtq34zS9d26Xh8AOV9WuM81SAakME84kP/zECo=
X-Gm-Message-State: AOJu0Yx65DdtmijFch7fGu7EOf+sPTi2vaxODRd6n7/xmXH2o8O2pK0f
	V+m5rfLeV4C3EkFzWkGIlmJ6dqvdcLEifPeFAYyh+bM9O0zX4t81hNGJmcBub9FyAmARHtKZRO6
	Xt/yD1Gup1ZIdi5HkBWuexpDIyN+m9HpUV5wXJQ==
X-Google-Smtp-Source: AGHT+IHSk3WRMmWu9wJcWqIf1E5fJGz8RUBTaPj3qnqLT5iMFXiBsjcAdOI+LzUzZnBUyAsuXCIieK429Oq/rLRZqXY=
X-Received: by 2002:a17:90b:1809:b0:2b8:ab23:f2aa with SMTP id
 98e67ed59e1d1-2b8ab23f513mr12114313a91.1.1715701147211; Tue, 14 May 2024
 08:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <3bfcacf38d4f5ab5c8008f2d7df539012940222e.camel@HansenPartnership.com>
In-Reply-To: <3bfcacf38d4f5ab5c8008f2d7df539012940222e.camel@HansenPartnership.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 16:38:55 +0100
Message-ID: <CALrw=nE-t6ZWCvPm=3XS_=-UM9D=mMaXL2GOw-QL5GOLtbcHmA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:30=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2024-05-14 at 14:11 +0100, Ignat Korchagin wrote:
> >   * if someone steals one of the disks - we don't want them to see it
> > has encrypted data (no LUKS header)
>
> What is the use case that makes this important?  In usual operation
> over the network, the fact that we're setting up encryption is easily
> identifiable to any packet sniffer (DHE key exchanges are fairly easy
> to fingerprint), but security relies on the fact that even knowing that
> we're setting up encryption, the attacker can't gain access to it.  The
> fact that we are setting up encryption isn't seen as a useful thing to
> conceal, so why is it important for your encrypted disk use case?

In some "jurisdictions" authorities can demand that you decrypt the
data for them for "reasons". On the other hand if they can't prove
there is a ciphertext in the first place - it makes their case harder.

> James
>
