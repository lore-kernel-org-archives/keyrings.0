Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB931282F
	for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667124; cv=none; b=jQOVnIBRLTvhnQ/fs9+Zyoqdn0KAu41209hm9cYFIvfZb0Xb0kTA7FB9HZrPzoDL2P5tisVG4UF/5dt7fhWlniqOpwn9PDvR1ifbZ5wfnazr+O1rzfqIAOkpRbo6Q6bVdiP9QD/Ne/CTiGdRds75HWF3n2shbWIQvh4PfALr2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667124; c=relaxed/simple;
	bh=tcL6A5SoUYWty+VXbzXNe06G0pu698TmKup8qJ97Wco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vky+b96gkMHcmdOZHT0ZM0RHiTZEzqDNSEyNLdb+jFQgObV+aVXzoWQhqJHjnIvZkwHhcOWQ3+o5iq1gQPGSJq6G9OG1uz7OVMMKayTEgyIfs7RsLzF4EEysCzoxO0OCsWDOWHgf7EfXPmlnpiUiD6NyY97VOisoSwo1I+QpNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-917ad52d7b6so10993916d6.2
        for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667121; x=1792271921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXTNApq6aSI569pIUAzzE6jSpAQWrYRivHcZV0gC9AQ=;
        b=UmHCiCVoGi59pNacmP/Wwvw9TKDpXwPdhjGC9DA+GTX1my9VVfh4XGVX8apWSrb26L
         P8dzdoOutNrDZdpmv/VFsxZFrA7CjZI7+7PDKfQJ/Em3p7RfWVG7WGGg7WI5Qko0gbL7
         HL4+sn597xKpDoh1tIn1OpcO4DxJZW5bVlatiygphD/8GO87FzLhNZu/goYqbsnZA/Wl
         61GWjbMTc5zi7L0znqMls/PoVO4SyAgbc9BcsM9YjCA5lO6Gdh+9OM0HtYfMgNbOqJwb
         hv3ea1rvsQogLPkwNiUF/Rtd6cwmVxobfvifvLJe7JaXlB/CROhenmTrMzApPeFU0GTu
         2DQg==
X-Forwarded-Encrypted: i=1; AKwUvBwOLJHYi+p5MWOM+ls2bc69UVHaoibvWDCxP1AWIQrmjUpaszijsGZJaZya51R3q/e04TL/9c5fGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJN5GPUrRkS2AA7ltakvmXvwblmEGVO8wy7Ird8Qhy35W/C4fEE
	V9uVAa3At/lDh7cQwujRcaVicB9XjHZFRKsMTIJgnTDEJpi7GPbalFVO3SxnS0CiAK0locESAyg
	kA+Fq1wKkP+665dU6NwfPs6KbwQCLNYysSPRO
X-Gm-Gg: AYBFou2ThcnlLoT/HZrmHhGX6fUTVnSysK5D0bHcQIYt+Lnm75+SjXMGzuoorB9gYz6
	4+3kM760OdWcudw6Cizd5/AbRcphq8ZayU94F4B/Resc6K9Jc91mPq2eRQzC+8x6ROk0p/lEchs
	NwI07ZsKB4yMWlt8qED9/tu9RLUAl4vNnK/FP0VM4kZAAyI30FFHxiYuUokE0TpXJMH3HQvEecG
	P8/UTRb9gx/A8qhveS13srJhtAAppSPNVSeRHRnSjf6M8unKwpWePZXrZA1ldKyGxD/p8o1IkJe
	2vaZxfhyzPBSwCmgIWj9/SFaeESpASUdnCB6Wp3sbxMx5qngEsgHt+EENET68hcJreNfOch9Cq7
	LI/MYaRNDLc2HG0YH05m7Qc6CCSRrZ2X068gOpxlJ
X-Received: by 2002:a05:620a:2b49:b0:93e:83a9:d59f with SMTP id af79cd13be357-93ebd23f1ddmr876491385a.57.1791667121467;
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm109798385a.9.2026.10.10.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 273C51287ADC; Sat, 10 Oct 2026 14:18:40 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:18:40 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqrsIij3KjUWQev@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:34:10AM +0200, James Bottomley wrote:

> I get that PCR 5 measures boot configuration and isn't supposed to
> change from boot to boot, but what about across things like firmware
> upgrades ... do you have any idea how brittle it actually is?

It is likely somewhat brittle, but: firmware updates may also change the 
memory map, at which point we'll bail out of resume and lose user data 
anyway. I think the appropriate guidance is for userland to unstage any 
pending updates before allowing hibernation.

> If it is brittle, one way out of this might be only to care about the
> last log entries, so make sure the log hashes to PCR5 then find your
> EFI_ACTION and the exit boot services mark in the right order rather
> than caring about exact value match.

So include the old event log as part of the hibernation image? We 
wouldn't be able to trust the event type because that's not part of the 
measured payload, but altering that should fail safe so that shouldn't 
be an issue. My gut feeling is that this makes things more complicated, 
but all of this is opaque to userland so if it turns out to be a problem 
we could revisit it?
