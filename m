Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128F3DAAD2
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534694; cv=none; b=UZ1SlrPBf9cD8fnt5hn5f4m/4hByYhxOtwL88VJ9eSPpqzMAVMkDjftfa/r7RjxhO+I4Jr5OjtMJIIu3chjfS7xgM8guj3T3lDf86Fsj0NgtEdvnIBueoqsuDusD7k9fqC/K395bthx2TzE0WpecBQK6fQ1jNqM4rN9mN03KeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534694; c=relaxed/simple;
	bh=WATkgCQ/kmtG5HulqnoTUl0JCJKYR2K92PtDB5Opiv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3WU1HnJz/MBc/It1a2k2cFAiIf3mW20aLpMv/brF8p/gPc46uxNsbgZxFk1ZMO8kPS8Gx97/NzZ4RNo/fTecp1gVNgvZT2Lq+VpA2bmRRa0ATdPuY44ZYQQ4hW8sJuz85yi2bdlVVMhGu/GweK7hS+erjc7FeSr6oD3NLScjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-92f0b5ed131so463550785a.3
        for <keyrings@vger.kernel.org>; Fri, 09 Oct 2026 01:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534692; x=1792139492;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+Ti0O2O4lnX/hVbcn12QwKSuhI8bbGy+WYpeuSvKe4=;
        b=0rv4NnSTGV8rHa71ErnSsaAkG0bMrmxfwRvhKwBUlLTFpXfv7QfOASMkhyF3mnLsPN
         MTeVsfKYcA58qZXLRbMn/hrZUltDN441dZXvQ8TOAC5GnOQZ9KUIrR3n6ZvS/PDrT9s0
         oY00fVVdVcNf4KA/ehI4OhO5biT/wV8QK+wuLT/sU8n2GMSc50+f9wu6PMw+CoymA92O
         1Zj8Bu72nVy16zDPi4borKADq/Kc/nypLLxTLa27RjZhdcwMQ69/QtV6Zd/s0KVMWBW+
         AFeBqSdWFXBAmVyOdFHEDFqn+1eMEjQLGCS4At0HzzATHA/WsJAegmfXdZSuwCoDg2Ca
         gwLQ==
X-Forwarded-Encrypted: i=1; AKwUvBywMmsEFdUq3VyoK+4hesi3KaQtWM2PdjVO5JsvkZnAvpTmsIYdy5x6p5lPUqRYjr5Pd4ARnqG87g==@vger.kernel.org
X-Gm-Message-State: AFuF++m9eJMLM7VIvBLa55kmm0JLXJbEuHaYZJdLSwYew7pz9Yl2A8wc
	8st6aE/wqj9idBDwM3IiMN+fKkurPnR+AvXlMLlyVmQj6SONlcmhA/nMrbJdiqiEzirnJwVCVDk
	2Y112oSYVc3ubRq3thOvmQF3nPGyJ9L5tX0mz8ut1+9ye1vMQD0Nr
X-Gm-Gg: AYBFou37KVKngKIZPIjYjl4qKnvpDHMHwUb8d9J6IwnobhWdXWbaYk5QV+D0ROrdVts
	iPJb7ymIypu1p5y7VeLTKxFSbw/75/1YLiOZKsfwKRDKzk/7dLU1TBCf6N69vgO34R3VvTud4rI
	QWkDjVSKpcnF8YQqEKb81wn8jMNP8A5arDuMqpCMOv0u7GjentDByPRKbjMoFHE43ztrqPIHocG
	YRaoLx8Fh8NSdqDz+BTp0g13QzQg6Q2Po2pyzce8+g4kguXqyurFa+K9F5MRwmtY1oWQ5WsrVrg
	tqi37+TfrJ9k6GPyoAp+ace2WxaWY30dF3uaEskm/XypMC3lXum8BLBcKcECyManQ2YFyZP+72q
	E7v0=
X-Received: by 2002:a05:620a:4013:b0:937:27fb:96f8 with SMTP id af79cd13be357-93ebd25c85bmr177526785a.41.1791534692184;
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm29407285a.9.2026.10.09.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id D784A12862D5; Fri, 09 Oct 2026 01:31:30 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:31:30 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 11/17] tpm: Add kernel signing key creation with audited
 provenance
Message-ID: <asimYsZxxGvPAFiZ@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-12-matthewg@nvidia.com>
 <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 07:00:28PM +0200, James Bottomley wrote:
> On Thu, 2026-10-08 at 06:20 -0700, Matthew Garrett wrote:
> > Add tpm2_kernel_key_create(), which creates an ECDSA P-256 signing
> > key for the kernel along with evidence that the kernel, rather than
> > userspace, created it. The key is created with TPM2_CreateLoaded
>  
> I don't think you want to do this.  TPM2_CreateLoaded was added in spec
> version 1.38.  A lot of current TPMs on the market today have spec
> versions lower than this and would reject the command (The spec version
> of the Nuvoton in my Dell XPS-13 is 1.16). Since it's really just a
> shorthand for TPM2_Create followed by TPM2_Load, you can simply do that
> instead, which would save us from a load of complaints about this not
> working.

This is what I get for working to the spec instead of reality. Thanks, 
I'll split that up.
