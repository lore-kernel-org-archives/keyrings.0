Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8764492E35
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466886; cv=none; b=EtDxLxIQUh9ccI/eRMiEI7QHWLFjoADT/iR6aBianGcAuzJO86UA4XEmE5G3LEDR0wm3W+v/3yrgvnTy/8/bgtm5LZZO+bPFMAzz7d9GQMNHmkb6Bo4GDrSPdRhFRM5eaatK53+plH1gH/u0YdsAs/cOpHD2e4XxxQw6gbDz6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466886; c=relaxed/simple;
	bh=XezWRLY9lxI5ComY59DgZ5KT78+aaYpBiaD6Ktv8gIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsUYvJDqDw05fbUChPAL2ePg8uNkW63GrYOyTM3NM56YjDpJpvhZ0dpijVJ3WK80fgdmdKBL0tFD1mc8Vj+mYHtCjVt+BW2/NX9IZY+M4jbIhKijxpO6ceLHSVhQqIOGDTJAtIUDXW2OZoQztTJQVxudAO8Y43ih/2ziZtd/lJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so17070125ad.1
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466884; x=1792071684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1j9k5OlTGty7BZhrOeehSiHjb4OZRtbs/bCekRUx6wI=;
        b=r93V5bhqtE05D47H/uVNvLNOtxeemKd/G6PH/ZKFvu80HrAODzNhNtIm36Y0Mm9HsS
         UEjKaGLnW4NSUnIOAYnCRqBeoT9wjKY9I3UgI61siacb1wVQ7oDPMvL9qM+n6SG9S+Sv
         90lzwkbEhTFL3+EW/kQS6DP4YyckIr17dCX+CRlwzfbawC2IjnVd3ApIORYedgOwQ3j+
         tlSQGl/gmLd68fLVk0wInvEOZa8r8v21CTMJOU2LMAh78Kt1pI9u0zLJ2ESXB7fF0Qsr
         EuiZQpHgBwL8jfq/zQMwDoS4qoPdtfxN5PsGKMLjF1IcD7WRjoHDJOXRfDYUgMFu8n8w
         zBuQ==
X-Gm-Message-State: AFq9FYIzmafRjnRx4Kj3cY4M7460S9yLCl/Y+ISelvvaCP73jglmaZPD
	eP4vBGmnQh5mqYIvML1UjzAxC2tYWMxrQ6m4DZGWV9BNCF6VfYZC3bqw30jvPfFIwW7reh6C1Rv
	PT8At3acSg49QxdvqemBrd1O0Oax7jDlIj1iDISP+soakh2TRGhaj
X-Gm-Gg: AYBFou32GTFjL+mnq2F3iIpTRhYo8xRbnAGK9qaEAYSthVBTsPNHcPQzj9kDej4Q4U8
	OR3XHlIgD4jT5BWHhu7g+8MplgSxxoradcgOlqEisvOhiaLbryO/CP1mY3XJEfo0FL24qJd7UDM
	MrpSE2OiPLtldYcrEENdsQCMbR0La2M+ug5Zw2D36nONnEuA7LI4cMlH5vVHSsvTrGD+nAcOWWD
	G5ZLkzEtCHcI0o0LwLVeB61HRmoYSHpERPVIk8oJHQsoTwL4XkT+FABU936Z6dwRc1ptJWnFmGI
	zXHsUpr8hlkubSKiT0WvromTdU+3lDhUgyTtF3ckk4fSz8S5kLsrLkg/guonoHuZwZZd2kupM1E
	lxMY=
X-Received: by 2002:a17:902:ce07:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e60038d0e2mr50963895ad.16.1791466884035;
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e6048443f6sm2131865ad.51.2026.10.08.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:41:24 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 37B8D1285603; Thu, 08 Oct 2026 06:41:23 -0700 (PDT)
Date: Thu, 8 Oct 2026 06:41:23 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matthew Garrett <matthewg@nvidia.com>
Cc: keyrings@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asedg6XdGkOaQJ_E@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>

On Thu, Oct 08, 2026 at 06:20:17AM -0700, Matthew Garrett wrote:

> Reserve NV index 0x014c4853 for use by the kernel, and filter commands

I should emphasise that this value is very much a placeholder - please 
don't deploy this patchset anywhere until we've decided whether this is 
something that should live inside the Linux UAPI group range or whether 
the kernel should own an independent range.
