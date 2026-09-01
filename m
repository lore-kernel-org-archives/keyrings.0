Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E61442B1C
	for <keyrings@vger.kernel.org>; Tue,  1 Sep 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279379; cv=none; b=Hpdf2AAeXLKXBg8AiypRXJdpqllL+A21Uqbg+X9zBmMcEPv2xnavbQZWZV3ZzkYDMozSyuZ50noCEq1sxRd54hd/3BLRM21KNb02OXuWuQWMdWb7MNqB/DPwjWCEerfiMgRV4veSyqP+JuUJsnju9V/HAVeUh931UijMu7SPM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279379; c=relaxed/simple;
	bh=eDOuu6SSu52TKbjWx6ehFX9DzfSBGnFG4ldHBQmydqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX3eF5bePE8EnkX2inp5xU+Ucj8caluQZz8dZmvNcQ6knXWsXXnAEaP7/kOMFHIewnuRzsGxH0EeqtZjvBQ6/R6OKvmtvXKYQDLDNJkvP22RyPFUfaIu1fXLD93AenceMv1Ouv1EL9mCOmPkswtswl1wBv26NLuvTFWKTYgrz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6Ll7cs7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Ll7cs7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495590dde14so50316945e9.0
        for <keyrings@vger.kernel.org>; Tue, 01 Sep 2026 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279376; x=1788884176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sg3qBeJDPejirqtBPfSpWtNEMRQUM5xEwb+IRE4corw=;
        b=p6Ll7cs7LZhhhfYhmC5Uq2eKvjhG6DnFGcHMlrg38mvfkSZOxwu/Illqe92gXn7oDK
         ujRNKiY78StWqYXY40H7+isDnySn53TgaiCbMJXL9NM/A+Fuii3u2ybmwht+oFvWPG7W
         YO2v/BJfs5fe0U0z6IEZ4OJxTejoq4/TwvLonu4H6DRNXLne6UncaZ8d83PDGupQuQEK
         9gsXQSQlUfmgWQDHHoPVwbNwKbvpIJvy0rM/8oc2kShiVTzjyQ2bk+LKTczxpF0CHCad
         1JXRky/rGUXYn3UFAPLjqagDYQwIS73DsIa4pwDS57VTGwjuUuvm50OUF4ugVpnAVQAH
         Dt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279376; x=1788884176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sg3qBeJDPejirqtBPfSpWtNEMRQUM5xEwb+IRE4corw=;
        b=Y4KA25ZHIUUAMAXrCLib6QJ8imLXtRH76Da5PRBrd3oE4mAcMK6BAOiiKEiReTHiLY
         j/FK1nqCimljXkCp+aJF7eNPvWc6b/t3FozHB2vqw2frs2F2PTP+lr9orpY2LsNH3NW/
         ko5j1G8BTzMLNq5pTjeEGZ9uF8b4yqcDrowpZLspjAaYskZ70wV5kpGLAp4MvRSBXkoM
         2jbhk77zaGlZ4ysX4tMVzkSAnEWMHpac6TQm4ZOW7axZa/CVjKSwx1Ak5VLa7ukB6ovH
         MxuWoairX/9cwkFc1xgdFR83kJ90FCN+UMhY62nXmlCxP8kryLVliVCkNwJMmt1NJQsi
         7ntg==
X-Forwarded-Encrypted: i=1; AHgh+RoGLjdzClEzEGKOsNBUwonJki2v5bi3wcZKms+MC3280+ZXqvbpfWPR5Y/IhMKkwiYQzHrR3fPYTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n6AALLp6saV2XjvqNYTT51hEgWnE0uOAztQ/eabDjgcWUvehlc
	qAOucefqs4VhjG1b8f1epNOba5le2KuuA89OdXgi4Ils/GU7pqKlPDuV7IsF3aEf
X-Gm-Gg: AR+sD11+A5odhwwSZa269ApOMY9L6c8RTs0LOa4PDc9k+aeFmMLT1W3Xh7rfxLeGyuD
	4Stz/EiGNLQXA/O3Hlr2eGvy5L9M3W34o1Z2GZrAz3iuhWDWIBoTOd0DYGAu3kzhnCxEkiU0WGA
	JY9Q8DKtMrNZ4lBVup+8kUCy3PR3HX642dMisxkZKFxbbXQkoL+3IsGf1sAuCA3TnPbur7MZ3bs
	innghqAHAeuInFXRaAVQwF2xLv4oaDmEDlc99HfKKqT6FVTivbGTZkGULfehh7eBruAc5hgSEKW
	E5FPNpYs7LmD0tZ2S5e4qc8ZO5TmAmOkdOiBLUzu1gSExUCW0e999dv+X5LIhdQ8KdkcoJdkIYE
	v00HjPpgG0/9ByVaaJ8h/g/JxX3Lpv21LRscW7C3EOyNtROlQ9iEGLwvRqtXKbEWdAT/GAuWAXH
	C9rv8ahfeuDd+q0PVzBmfKPJzzf4dWV10wI9iA5sWcsszi10qTqBedHd386kcKhkvzUcUDyLzRz
	UuiBeqdOIBYI3Dbu86Zsbmn4ZYVzMAWlFlnQZ0p50RrIr/jzzhnO/H8yD3OvqBzlac0jMoMp1Js
	/7aBRz+UDl5OXMFeWQVV1Fx9K85HDddEdku1njIxGJGZDargfN2dSbaYCa9lGfppVoapmUkksh/
	zv/uTpw==
X-Received: by 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr176732735e9.2.1788279375445;
        Tue, 01 Sep 2026 09:16:15 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce365048asm17915365e9.5.2026.09.01.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:16:15 -0700 (PDT)
Date: Tue, 1 Sep 2026 18:16:12 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: set persistent keyring timeout before destination
 linking
Message-ID: <apb5_kMgDxSIviWb@gmail.com>
References: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>
 <apbTc9BisLTqBaE_@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbTc9BisLTqBaE_@kernel.org>

On Tue, Sep 01, 2026 at 04:30:27PM +0100, Jarkko Sakkinen wrote:
> > Tested with QEMU 10.2.1 TCG. The reproducer set
> > /proc/sys/kernel/keys/persistent_keyring_expiry to 60 seconds, restricted
> > the destination with KEYCTL_RESTRICT_KEYRING, and then called
> > KEYCTL_GET_PERSISTENT. No LSM policy was loaded.
> > 
> >                       syscall result  /proc/keys expiry
> >   i386 baseline       -EPERM          perm
> >   i386 patched        -EPERM          1m
> >   x86_64 patched      -EPERM          1m
> > 
> > Full kernel builds completed for i386 and ARM926, and for x86_64 with
> > CONFIG_PROVE_LOCKING=y. The x86_64 reproducer completed without lockdep
> > reports, warnings, or bugs.
> 
> Please describe this in the commit message and delete most of
> the text it has. This is the motivation part.

Got it, thanks. I'll shorten commit message.

I also found a narrow race if linking is delayed past expiry and GC runs.
It is unlikely in practice, but reproducible with an injected delay, so
I'll address it in v2.

Thanks,
Karl
