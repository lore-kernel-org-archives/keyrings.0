Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FC3E49DE
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534790; cv=none; b=IVS/u2MaCH8UxozJhmf2LMmLJMmYI0pGmcBnZI+lbfeb3u/ZqjivT5VzLNyWu4JJB+San89eTl6Ba629b+iQNBVVKRm3EzOIO3cQFrNFvwhEAr2PRNA8kTZr3fF/R+7V5T2fQibr8tlSsGUNmr0nZit8K8ZeBjrS1MpWkwjCmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534790; c=relaxed/simple;
	bh=J4a7upmFwO+cU/sHwsmNf67cBdZkLVJd4Qid6QJFvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L06MIhVV0TSEDJZOxDgJVO9H2dE1CuGAPlPBQDHZKoXn7y5KD2ecnT1RhGkWaVRxNX6xzpRl9LSkAsRw6TGwvPYh/Vurj9usXL01r3HAR+O7OTlzRDzBl7s8s0nIP8R3MW2E0UxKOMy2ALn5VBWatp68wAxQykRLO3FsgRUiPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e812e2b31bso9283225ad.3
        for <keyrings@vger.kernel.org>; Fri, 09 Oct 2026 01:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534788; x=1792139588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SJdflHLsTV8n6Eka/t1oY8KzfLbWWcjpATxg+lrvcw=;
        b=07zvXODMNCAqMi/VJOmiEp6ATowv7y8Zj2LVU60qUOYh1nBbNOUnqTIU7RXOiPXwV/
         3ciFfkjRvy0CW2SwqHXe4V/9KkASgvuomF+HBi3XnVaug7gDxBcv7uocXI7ep4noaM8r
         ZYVbG3Kehny+4/JoM/IPXQqbQJzAtUw3L2GTssV4hdRh9cdY4GzjF2gGHfC+MMBMddyS
         6IN9qYWJH5ApBoLAIWv3Bc33LnT8PCR8ltFyrjvrbutAFSCOQwENCW67MdgsfzHLAjBz
         uuvjgWG9jvBOotOdioSJRU+wnU+2bqarzW5da3yXtEFKqcd4E3I9+hYvxdTr4qNAVfeE
         1SPw==
X-Forwarded-Encrypted: i=1; AKwUvByRBoWZ1GVfgV+50ZPtlq2rTd2SQrcXQRyROQyCWKaDKygsphmCG/XQRo3u54k3BglI0u7QRScSaA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1lxBlFlmR0i55NX1/UqNawmfTwO3pvvjpKTg4FGD2Fhl4xHoQ
	F7NgNh4Ze3PNWOy+pcZSgkAzQEcSVdk9B/vZmcYN2De8Xq35M+i82TwHCJUQ/7UXdxda76TByJ0
	BHOG8WJN4VZ1YdaVdKpt2MmljIPP4tP8Exp58
X-Gm-Gg: AYBFou1WdIegx2w8Mxtb7RyzNPAPv99z9AXQCa15tT/Kw+sed6n6tBc/JX3CSDto5Lw
	JmTORW29d9YpgbGMGG/k0UUvNg3CNhK2R/OyXLNhGhQiCqVcm661WCnlA6LMPTCSRc7TNBD/Zx7
	39s8+syfzbOf+dKOc9KCHqcIEFEl/Em58KaSn1ZLgwZhZu+gKMHO67/qNhmvJwTljzBXfLKSgr2
	sQBJOIpkX5hXsSyJ/jXZ1bilIUxiujifszO1NHV16kGJgglJB3oY5joS+CrnYs8nV+v8AnE66pc
	EKWXx1qNUZQFhKKXpFOdy1Heb4+RKoaCfyzFgLtHub3/tosjwMmNd754OH+IZFve3jOxctv/Ma0
	tknGrFtaHvJGBJsGG/7zhhuH+myeh8dm0/IPlMIc5
X-Received: by 2002:a17:903:32cd:b0:2e2:d7d6:6563 with SMTP id d9443c01a7336-2e842ce162fmr8538245ad.43.1791534787870;
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841f88d23sm606575ad.22.2026.10.09.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2332C12862DD; Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:33:07 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asimw1D5J0ZqM4i3@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <asfDZiuFKCuuRysC@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfDZiuFKCuuRysC@kernel.org>

On Thu, Oct 08, 2026 at 07:23:02PM +0300, Jarkko Sakkinen wrote:

> > +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> 
> This function could have less generic name.
> 
> tpm2_dev_is_kernel_nv_change?
> 
> I'm not a huge fan of this name either but it does say quite clearly
> what the function does at least. Just a suggestion.

I left it that way on the assumption that it might get extended at some 
point - maybe that's not a big concern.
