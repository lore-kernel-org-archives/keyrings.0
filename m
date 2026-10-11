Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92104279F8
	for <keyrings@vger.kernel.org>; Sun, 11 Oct 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714215; cv=none; b=I47lX1hUwE/MqZMEId+l89oU9Hd1l0FFSDY9MbEChXUP08acuJU/ZYy+ojHOAorAAVSLIJNtb2tyCrrlkquAy9CQo7IqXs/z0gamgyy13nfEzmfwyFtfRgjxf4FzRBXiILY/CO654LW6Dqxh5tA7M8poY1n9BDSRLBHuJYMrwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714215; c=relaxed/simple;
	bh=vpW8/KkGJ7bWQM1agx07Nvt0sF65rPu6xz06pQZazSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjMLrZi35Cvu+Uu+o96NtY90XEMx70lZhsYvkADwME09G9KGFvmHwpPzBXk25qWSK+2gznE79gTUTUK7AuPS0keQz+ZfDq+x7G5Ubp3Wm6jr0HuieRBFZCT9lK3H38CpPQcyCucH4VK7nHgZ618b0nZkR7E+AMbOYSneVjZV7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ab33730821so509445a91.3
        for <keyrings@vger.kernel.org>; Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791714213; x=1792319013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCrU7gKGl9q2lr9szhaNlgI07chMKDnbiy6n8axucp8=;
        b=r6ByLq4638sAbESnNWIw1dm2ssQ2kZcfrWGet8tcgUzjuhcydS+arzlGMZiYjavMDm
         G6DC9m+GDTa/ldKf03ESFvy3A1G/h1lJC53SF3Dsk27vIjvYTT9QfOIsT6VBrSeK8FWy
         zJpOInZ5ElM1OTCSfNLIzLEDbAB3ENat3XYq+7dOAM7sFKjxryS9AZE05004Oes3ImYI
         CZHJNb2O33tzO5cX0r0ggr6VS0RqPU1h2INL0vqaYD042CUkYkHapwENqoG9yQnRA1jc
         X6ZqpQSvXHvZNWiwqea9duIfWWddK356GWzhCkMKtkA3e56iY176LWg0NAq9vQizIsTq
         i5TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwusZWJlNghCG8X28pLpNBD1/Urn9ImluhC5PZ1TVYk5NIY75dJGJzwH/17xrfJdM2fFFZxWm+H8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLsOqt/7Of9mbSjD5VaoruQi6Dlmzm1va29UI96RZhhmTPldnJ6
	IbJoTYCImd4kXZdgrC+2scfZ4BegHgy/zu1CCDvA9rDXjGi/tgVXz+gzsZ1KkHFO0ypYl912MBT
	4LNME5w8rF6HmEP/cZthbCVmsDp6xFwEheOCzzqFPIzrP8DvUe9ZI
X-Gm-Gg: AYBFou0xO0/0X73cpV2rsxwOr8DwlXNQWU2pF4a+rfyiRR6toLKi5beQXW5NHb51W1q
	EBQbDItYmudnPT7/5aQsSSEPl3pntSfNjWsV/9jA8QodWbOCrNzY6Od5kgIsniMa/v8mWUPLuPY
	0LIJcXxfwK9exKm/11AOWbyPwVTkoNR/fgt+R4CwrTJBCvf55rdd46lTVXgvEnRETBUJvGTlfB6
	2PZ5068/+0N1h7wtnxautKgngtXWLEi0NWi/dAh+UiM/5WIUrSYkLpmDX5p6+vm/NlNTy5SLD+L
	FXFeGBK/TZFpRLg34JzmP+AGtAGJ8Vl75w8255XEIXROhMNV7Shz5Dmy54OzEGjbyAzGRaJceJO
	sNFk=
X-Received: by 2002:a17:90b:2d86:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ab3a746d73mr5664315a91.29.1791714213229;
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d3f9c8sm4193873a91.0.2026.10.11.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 6F3CB18A4492; Sun, 11 Oct 2026 03:23:32 -0700 (PDT)
Date: Sun, 11 Oct 2026 03:23:32 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <astjpI65VOyU8xvI@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
 <asqthz69ohnMVCye@srcf.ucam.org>
 <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>

On Sun, Oct 11, 2026 at 08:04:27AM +0200, James Bottomley wrote:
> On Sat, 2026-10-10 at 14:26 -0700, Matthew Garrett wrote:
> > Does your log replay correctly for PCR 5? It's *extremely* common for
> > the extension to happen without logging, since logging needs to be
> > done  into the late events table and almost nobody got that right
> > until a few years ago (hence 
> > https://github.com/google/go-attestation/blob/master/attest/eventlog_workarounds.go#L70
> > )
> 
> It seems to.  This is what tpm2-eventlog returns (edited only to show
> PCR 5):

Hmm. Well, that's irritating. Which year's XPS is this?
