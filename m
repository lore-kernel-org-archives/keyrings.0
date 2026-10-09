Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895C3D79FE
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534594; cv=none; b=LTZL3Bo0rTFALm7ez/3gIf27NW+2kAqAtffdDdItBglubELu+VMLye/jjHAKuhATvOgugr91VwEbY2pZkuz/lRwaNMG6vuqK0GJNjSFUu5Cknfme76/0XcKLmaeLbdyszMhX7X4XxBgUoavBUIN91aIfAg8Ke4uLlhKydvJ4++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534594; c=relaxed/simple;
	bh=KdOxe03RJFJSOXfBnXYN+A603ShkIe/cWcsUKZ0d0NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBePPzYiA9qpLzqangNWCvWcpLF2AXUffa58jfmSgp4PRROUMhgc9I/vCeEk/pmoFtgpMQRxWibLi27uOuC2a3X0iAeASvhV5nkmgwVT7xYQDHRHzPEGuBjG3aJo/JGeCbMxv3OQE3DdVkXOTBoWatpzdI7lJcENeAH3AtfEHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e6eb77f0bso499335085a.3
        for <keyrings@vger.kernel.org>; Fri, 09 Oct 2026 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534592; x=1792139392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq8gQSDpD+5YFxqUsScItWyxOjZQR+1g4Dz/3bcOwAM=;
        b=2hTkvq/dvJuD6rSXlO9ka7d81F9/1uj82tYG9uZ8PT9Dh99+b96MH7FIeMUdJPmn4Z
         v7zWu/YXkoP1ez+NGV12V5/fKxqx2ZJRkidrMdO0YeX9Dzs7W8NMEPPBYZ7lI+tiM9z2
         HO51oyjlsrvh/C8RauYXXg0AugEn/h7jf54C2Ts5sL5nF0FZapxOQKRK39ToO3/nQr4o
         rtmo6cTy37kFVsi4Azkz0hWA4h4OuId75ftYw4ho4bZ9qnIYvlEP5KUWeFZW9/3tVzC/
         K+cLUNd2dUy8W/n1+Cgc6OA5/GpiSHgYoLlAt1yGmzVwoaz0TlJz0ID+dsrukqSccCz1
         plHw==
X-Forwarded-Encrypted: i=1; AKwUvBwmFZCCUkGPe02xKmi6C/s4tKH2BJSR3YG7T8y6VCH8fRKW7xL0OTrREEwZvFvs0yd5SYFq0v24eQ==@vger.kernel.org
X-Gm-Message-State: AFuF++khs06jIqkT8agBik/UTpmtpygaDWoJfYSVXk6KYKoLiDotSv3y
	efprZr4iYCZWsZxHuc4teN8c301SEtQsHoontPQ4xvjcWe4iRee70UQSfPeDg94VXNIVa9+o1bS
	riFUXEHluRCIGoTc807n/YpOO+bhW4GNJrvbc
X-Gm-Gg: AYBFou29MjosXvuJIIRaKpwCcASux6D/Hl1FFJuP34Pv1LrkKSMK29e7/Vblz17A+EX
	QTTpYirHHj3p8Knw3boixFM3074rtsMBFTOvKp+HIjYpjmw3QgbWABNTLq1SR9EnID8XzZ8b3Zj
	UWyeEJFW/sHxKTPb8g10J20CaSoILz5biQlk5/40AstHDVTt5k6i0ASjvdahocQHMu9C4Afryq1
	tBJNuxT+9AzurKYAWeY+2qXEr4LxBgv4N2UvGJHR6Xv6XRcHXJgaZc0buRP/q0OB2W2Y9OQFiNH
	CH/M1+eQ+KKL7V69gYr2KtPDzpnIL8yGrjjVrc8+GxnNNN293Iq+2O0VRbc1B2749Iiaa0VTK8S
	oZpQYtRAmb54I2sqmpHIpqW9qlFYRX64FhwdTvzr4
X-Received: by 2002:a05:620a:471f:b0:93c:2c15:e510 with SMTP id af79cd13be357-93ebd2085ddmr144845685a.37.1791534592672;
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb9811a3csm31984285a.3.2026.10.09.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 72C7C12862CC; Fri, 09 Oct 2026 01:29:51 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:29:51 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 05/17] tpm: Add a kernel attestation key and signed audit
 digest retrieval
Message-ID: <asil_22hdNKBXH2p@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-6-matthewg@nvidia.com>
 <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 06:45:15PM +0200, James Bottomley wrote:

> Oof, there's a lot of duplication in here.  Basically you're creating a
> signing primary key (technically it's not an attestation key because
> they're supposed to be non-primary; this isn't a criticism because the
> only consumer is the machine owner who doesn't need to use privacy
> preserving AKs because they know all about the TPM in their own
> machine).  The primary generation routines that exist in tpm2-
> sessions.c:tpm2_create_primary() et al. already does most of this.  The
> only real current difference is that it creates an encryption key not a
> signing key, but that could have an additional bool argument
> (signing=true/encryption=false) rather than duplicating the entire
> routine set.

ACK, that's fair. I'll respin with that in mind.
