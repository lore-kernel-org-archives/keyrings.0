Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81435E1A7
	for <keyrings@vger.kernel.org>; Sat, 18 Jul 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784406930; cv=pass; b=qCyCS0j53mEu44fTeW4kiV7A3sTnRXLWt8epGUfmqtzYhuFcwoH7YSiOc4NJmMMaXuALW6Lf/GUE2q/r94r7pk0uVQtyYDY8S9P4mpWwa5eeuZt5Y9/TYqu8TUfS9vlWU84cMdtY9qHcGYz0c96MbBQ08WNUQVRMlm2M/Z6VMOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784406930; c=relaxed/simple;
	bh=L4R3GSXsdF+KHdVEA142jPzPE6lMiiTCY9x+aQGKhtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNHbQqE+4E2JMFWUasOK4kskXZsGmarIUjQjEtOjpb3eMZIkEqrUu3PoarViOg3YLyZwVVFT5rQ/cMZyA5nX1solIsg8VX2VFZKCtOJjQA+skCXI018O9jHWl0kKWuOiuFYqz12UtXZQcnHQrvOzfjheEBSggO85XtlfHuvCPqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbXWwlwX; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbXWwlwX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ed2a00f12so62315157b3.2
        for <keyrings@vger.kernel.org>; Sat, 18 Jul 2026 13:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784406928; cv=none;
        d=google.com; s=arc-20260327;
        b=NtaiEaRIkpuV5HjAkWsABRmTHD2DWkWufeUDU86a1kCSB0rsLNP5QhF/p1Y11HvnwN
         s+hjiqDHlAV8hmyQsUgxKYdnNxv0smD+dp6BuK1u8AD2u+P7vEU045jsq4aqhaAtSJaT
         WJFr1fxOAH56sF2lfrckxTZboDKTH6OvFnnz/R3GaZtZS8AEAyoPHN8T8Tatrmc2o6kl
         u+PR+vWmrzzlhIXG8Kb1K0J4GVPYjsDMyym9iimOD07dDuFCzNmeG9QcEIscDTTGw1ya
         cv1yNaV7KUU4muw3gECYKQN/VJfVB2AucD5EA+VF6t8ei/wLmvQI+b/2yXpK+Eu6kOqs
         2f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        fh=H0p/XAwQ+zoV6rGjPYpCMXHFbjKm2uDleglsRVnkKr4=;
        b=cpTTjn1JfiBkDLik9cAamdsiHAXzpgQ4KsITd22785V84bZ7igeMCbWTi+NZ7ADwox
         KxhGooSi7ILTAl9AJVeVvjAiisCf+RbbsAxtmcTioex6cr0fAdtzrWcUfalptSSKIm6D
         YqCXaTob3TEKow4UGvPZ98ZDj4KwVgg+MsqBTyvGqjRC1SZhe7zRvPYT686Ysw/VV8eK
         PCvb3tIQ1CG2EcKYo9RY79tw5XC1JAlLvHqrfLWgRTpLIxvv3hwr8eDeCMde4sj6oZb/
         Kx6Vi91ipY93dMV/U6jQ25oWsvPrTbSD4FdOQO51pFPfyQN71twsAec3lLvyAs9R1umB
         bKaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784406928; x=1785011728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        b=qbXWwlwXkFBO+XQKdl06XjSeJHinrg2BLUgkGYd0u253dljCMdJuk0j6S7p8faqHSo
         8SHaAB5EenfyNrt2kl3I0z7az9dAM5kPvimX9mHH8FovlytRgC8B5fO8BTL1GFDXyA/u
         yxkJuD1iZECUVumBHtjCGmKeutcG5yOxpxviPWYQ0fvg6zPgCN2++QX6Bhm/i0o+o/L3
         e1NwfxgifUPR1H87sWTKo0hCvNgjCB1sieSibKE3zId7lc8Q4jxhyd3DLOLHQP1Wk7u6
         gNPKIOzqeQWZxSmqNDVk+z9GBD7vf8gg4ormDSMkg1HDu91HSDNEMpvMKNrQ3evBsmG3
         Psyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784406928; x=1785011728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        b=jU4Jm551bWwPpQ813ee4Vv3CV3KbNXCFB1isGGfbKkCSiD1xakn10nIIp3OPxeWHXn
         HZybW6KeTGYgAdqZ67EpRNZ+s/O9cq+S6th+FDi7jb/OGAyyhqHe22begvmdHaeFTCM+
         LrF0P9qW3u52HdvBNypBjAM+VEqc04jfN7/2BxFwTpfkH8rD0tqwV6M3gcjExC4WGHDY
         BRKJWDaS0Ogkgw5Y62Ry5qOX34afhqM6v6hvAvy/jJQaIrBehJP8/e+Sa0EY1jcS2VE1
         bL3FyTmb+kR8T/tlNhr20HgwnOc9ssuiWLAlpHfEs+f4WuI8M7IFEpFSXawwnebiEvVM
         P5BA==
X-Forwarded-Encrypted: i=1; AHgh+RrQB/hto3Z+K2CzDKH9OnPKoB0n6xczNoqYTkjbEMuPD8BMwPHtGnUsxlxzXHQL+Ux0+UD/2p9ieA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0uV4Zp7/RXBELMC3hfZZi2oCU1p0VbvWFdkEJl2SVk8c9O0b
	QkYKNBpbZ+RCPc/yJ9PX/vpUEM/N1hcidhKyjwW/uAKH3qRU7gLaO3qVv9Sqkswk2GrbGpGC4ja
	zX1UfRHH92CKHqhliftz8FWGk++7ig5s=
X-Gm-Gg: AfdE7ckH+6x9C4FUvS3d1dra04IBKeE6Plf0hXgHr6sOen1MTfAo6PaIA5a1iXACjcn
	fdlI/iLMNidfzOv/sKvCsPm8xgH/33Y7AH388+AiSsyPqtsNAZ7Y5ZzAWbKgN+bSPJzxfl2n/J4
	MSNBY3UJwCERZlxSK/s7SbffDSf/FuEFcCuBagjwza1L29bF75O8gosguldbxMaGjBk3+eBjsu4
	ZItzZHGQllbFxV2tTKhQHlE0/NftIYY35Zfx10VX+vX+nNco3Y3V5ODLHwHIMoXDm1oJw6nP6C/
	CxwSKyADWXiV6To=
X-Received: by 2002:a05:690e:43cf:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-6683bcc5c09mr1712064d50.56.1784406928154; Sat, 18 Jul 2026
 13:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-4-michael.bommarito@gmail.com> <alvIBm3Po_1gX6g_@kernel.org>
 <alvKED66fSFFcl1Z@kernel.org>
In-Reply-To: <alvKED66fSFFcl1Z@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Jul 2026 16:35:17 -0400
X-Gm-Features: AUfX_myY7jKb26VYe4sNdbzD9c138J4SlvnBQsoBTRGFhUo80gRTiHM4mVVVlu4
Message-ID: <CAJJ9bXyHopjhwusu=yK5HzrF31N5QX0uU-WTRN0g=aSMc9HJmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] assoc_array: trim the final shortcut word using
 the current chunk end
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 2:46=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> Were you able to reproduce this with basic command-line tools? The
> patches are verifiable by reading the code but asking this just in
> case if you had a snippet at hand (not interested on complex
> reproducers).

No, it's a little tricky to hit, definitely not just a few keyctl
commands.  I can send offlist if you'd like but it requires at least
~50 or so lines of C/python

PS - I'll send v3 with the nit fixed and carry your tags today/tomorrow

Thanks,
Mike
