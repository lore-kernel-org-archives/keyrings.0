Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D63331EB8
	for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667230; cv=none; b=sDoIzvcKBLApTTOSGY619aATTWZ23HpOGRQeWQabEgbYWBDOEWSr0w+kH3BrYO2V7hTJMBvgvejB8sJTvWm2t8xSi0KV0E7JMhCylFPLW0fPgLzI2Ki8xHitEqPmDdJ2fBnOVv8aPQ/azKKjm1aCCzzuR4qRWRcDPmalnVGSZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667230; c=relaxed/simple;
	bh=l2Rg6OHGxNhrquADY2PNe8wejzKKsSn3puAVABR9uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fshiUCzqrDpJ8L0tuzIlsKMr9cWMTykWb7kRgm2arj21pG3WdwNHLh7Rx/RFPeC61wsKnGEpO4Tn072vXAq6sqhYwyAAG2++JZDtKmpc7m9MecqIGEldyMyCUwWSWPA8uUTnorHK6eP1/ZIwRs353QHC3JqjZVZSzwAgzenzS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8917c712f32so280881b3a.2
        for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 14:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667229; x=1792272029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpfqyCSTiDIx8bI640+p9clkC+s+ooT/bqQ5SHe1jVs=;
        b=jaAV5gdPxI/kcbn8yHUHCp8yQli4WG+Q3FG2JadHz+08anzeznDKTER8CNcKhWDdju
         ZW6C7ir9foAOww2BeGJgQvu9Vgn2VzEyhx8FFd3uzxxQaPinVCJXPGMZOoHmu0d6LgLA
         gTo3y2P/pYko9s9NprdhF6FXreUCOxt9Dn6DG3wHfmu0X1V/YHmWRNSXx6eEToEgaU1R
         Y4BPqW2nSgaU8Aj1QXWe8LWYmUwfS5+FBCXignDNqi6UVQ2xbaQxlMwzwDT8iT2/cvba
         3yJ7TqMTcgDw3TPgYkaMAW5RD4Z4hBMWi7+4tXq1BrHp4BCrtmiF7FrJKqZwMC5mRuek
         HW5g==
X-Forwarded-Encrypted: i=1; AKwUvBxdwxk+hOd7KlSN/S/Q8uvP9zChg1FJ9o83DJ3kOT2l99/SJBv7pBlYUtuAfNhDmsYeBHV3FcYLXw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJLxoZqamZRp/ahuepjR0hue6af+xBz3kDS6/RGzoc5x5rC1hIN
	UaiBSlFMFuvc363eUiKY3+B/2MR7JqbsAelYjfmFSILRvhhyN9fRMpD7Qyb83kRrIYuYBAb+pJb
	QNvdRhT3JX3UUgWy5DQugz7/pnHZMLfvqPEXTY9e7PDPiUdGDlMcE
X-Gm-Gg: AYBFou0IU+hVknrcl336yF5cSt67oisY8rQf4fS1k0FRXpm5xhteIFHZMCDrVABLkwD
	DsfKPqfHreMYrTpdf/QmP1T3gfbn3FoPqnaxchXznAslZ+JYyTjtWl/Bme4CYAeNba6IrZxfVUK
	TjmJSXwsl7Oe2Kh6GFSF6MqGpomJQ/FTLichEWLuiJI49rpveBT9mLygUexfJxJmpjW1RqBhTFZ
	PBeG/fugzZZmSEBrENIaBoFsIk23nOSwkzy7Hh3Bknlvh3RzdA9Ra+4lCJ8yL3yBG6jeRy/TBZh
	LtMcXqnk3pqHQm1l4wZPZenChrGL75/ySxSLIiitxYBdP/ypAxVyTtc/R1QrdF7RhB10681IbRr
	Bmrk=
X-Received: by 2002:a17:90b:3d89:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3ab3afdaaacmr5631535a91.57.1791667228755;
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab3780a473sm3281598a91.4.2026.10.10.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 0568D1287ADC; Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:20:28 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqsHMX1YUUDdy75@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:42:58AM +0200, James Bottomley wrote:

> This does strike me as very elaborate, especially the ephemeral key
> bit; would you countenance a simplification?  Since all you want is
> proof that the hibernate image hash matches the one the creating kernel
> made, you could simply create your kernel only NV index as a PCR and
> measure the hash directly to that.  Since user space is barred from
> writing, all you need is an audit of the measurement going into the NV
> register (indeed, it could be an ordinary NV index you simply write the
> hash value to), coupled with a read of PCR 5.  Then your audit log
> directly verifies the hibernate image hash and you don't have to bother
> with the ephemeral keys.

Just to be clear, "ephemeral keys" here refers to the ephemeral signing 
keys and not the generated AK, right? I /think/ that would work, but let 
me ponder that some more.
