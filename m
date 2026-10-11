Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFC3B42E6
	for <keyrings@vger.kernel.org>; Sun, 11 Oct 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718116; cv=none; b=BIHj+Nmhj8h2pEOVgajJCWpgK2W7lGzDCy+iegvNT3du4OwFu0WHFzWBNkj2n/ZdIoN9ml5JfENkKxs5HNuSIG2ccl9PVhctUx1iLdiMShiTdii0Mbm/w1BwAW+rpdAfW17fBPDfUbWeYsCC2D/LBQsq4SKJKtaVJWpkuBW4b20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718116; c=relaxed/simple;
	bh=9FzCwcYPrekTsa0r1L9b19cAAS0RIbiRexDegUF0QXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdQ5wbqTtofBMDd8ozc/GDGM7KHlAAYVGRD9GLfxvFRRGz4PXdvBzFixDtywG4bSYNgTrSn9zipB+eFZmq9bk7vJ1mNdcgbp72jR/2uzztoUlbSDSMcTBhcEMkkuLneO6NE3LoLeweejCXLkHcIASDmMVnjlzUpIeLTdBAnE5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so448595a12.1
        for <keyrings@vger.kernel.org>; Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791718114; x=1792322914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+CJmtB1KpJvhzp1M+nBD7BDZNjs1heGmH4XU3JRK2Q=;
        b=BiGPTtoRWtIhPaG3yxuXRTzTI+jDSnQemqH8WppVKxY66fyYDInPpNltmUh0L7EVdB
         87VRSHvQk7yvPT+LhDRuLNNgKEglGMfG3p5PjyXVA62HBpuVMFqv+dp6HGEAVhkztsET
         p5Z0kVSK99tF08nR1l6mhDe8SWeEtZNs0E7N12UWVMfXX24/H+S47BMuSWuOk3ufZJXn
         YpAxzQ9EM0Omr1qdEANlFm3WNeqTX4UI7XUdLItBx3+jS4YZowfZux3H9bHWaw8d3kJ7
         Egmbc3A81/azAYpXYy2FDnbHM9awNqjZBtpNPFDXb9FoIfBaUJLw0Xa5HNHl4OUjjAeB
         gZ6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTqIxIfe9Kq9XtkPw3QVoxEV0CN75WaQNMfSoymy1K7dn41iTpYDugTxSVs84n0upZyPm0oOTrkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL92raQczJZQDYBZz6CNnyKvyejyhK424m1b7ZOcmmcf3OKPu0A
	hM+0zONaZl55svA50pz/kdaBG6PJkl7afJNDc48eCOEkRV0cGXBXeFv8hzDy7S0ZhYJrZ11ON8L
	hcJPPl+w9JtQFGxjc765u6FvMYBE1rFdRpnkQ/XgspqquwIqy+g0/
X-Gm-Gg: AYBFou38VVXw+ouNXmjTgK4KmC9Iye64UOt/Wk8P3rE/O1h6iux6Tip5XYr3FUf7Q+/
	aXPZmwZtYZejBx2WQZtaFIamKRCQwHv6vJ93LezvC3nWHRn/7uAAyyR8BreeHnu72aZe3Ep4Lpu
	gG/OPQ2l52hB+/gySfByOgRED/n3BdYl0bHykQ+GVAdOsRIkXrN8RtKSE+HqDcVqwTPm3qIaYjp
	CUNxgsOvpM0rZlRNB9qPewqP0ttqSuOqZeSKPDYkcK3LNMLbB39D6/YnsNpsT/ZfYxVwtHR0AcD
	s6PArt3ZPPhF4ALIkOllllBobN56erZKn8lonnrgsBWk03w4Tu4poGDz8xxylMFOURrG901GrQ3
	UH1k=
X-Received: by 2002:a05:6a21:e355:b0:3de:a136:6850 with SMTP id adf61e73a8af0-3e164eb339emr4709275637.17.1791718114268;
        Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cd3d9e37988sm284927a12.8.2026.10.11.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:28:34 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 7CB4118A512C; Sun, 11 Oct 2026 04:28:33 -0700 (PDT)
Date: Sun, 11 Oct 2026 04:28:33 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asty4acE2B94t5q6@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
 <asqthz69ohnMVCye@srcf.ucam.org>
 <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>
 <astjpI65VOyU8xvI@srcf.ucam.org>
 <f002fc613bf0bdcf895e5be02dfd2524b7608787.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f002fc613bf0bdcf895e5be02dfd2524b7608787.camel@HansenPartnership.com>

On Sun, Oct 11, 2026 at 12:27:58PM +0200, James Bottomley wrote:
> On Sun, 2026-10-11 at 03:23 -0700, Matthew Garrett wrote:
> > Hmm. Well, that's irritating. Which year's XPS is this?
> 
> It's an XPS-13 9380 Core i7 ... circa 2019 I think.

Yes, that's definitely later than I hoped. Bother. I think this patchset 
is probably still worthwhile because it does unblock us on at least some 
machines, and the implementation is intended to be opaque (other than 
the change in PCR 5 measurements, but we should still get log replay) 
and can be replaced with something else if we want. The other approach 
that springs to mind is tying this to having distros switch to a new 
kernel signing key before enabling this and so having PCR 7 be 
associated with the feature, but that sounds like an incredibly tedious 
thing to get right in a reliable way.
