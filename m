Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562D47C0E8;
	Wed,  9 Sep 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987906; cv=none; b=Vh9U1igX678u2h5/dxjMUAHvq2vd/1Mk27O/iC55w+X5mD4iVlT90cBPVFseTihIeuB82taz4yz/P/qdArenXP75R1keJDmD1bpvj0TrRLTBCChu4h1vIJyrHEM7f/47tzBR+sTAStuZcw94PqFbteTl8smUAdDJxlbtmtMzYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987906; c=relaxed/simple;
	bh=lXinx9FReUQVvTMA+d8sFIQdBqwNVNXoqxFRJALc4SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGaHEOkzBLLDRbIRy1+4Uy0/+ULklR7sBJVEJUe9W1oW3DRumnAHjvLVcXEYj/xJfDHEkRs+b3LQCe0aauDO5K50PwuaZpA8x4M5JApc2IyNrmnVjrvW6fTmSaqYM9ayQF4PGHdxztVOVTbefhvfG1TfwzDeLPTWYxqjjQR5nnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwirm6dU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwirm6dU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6DE111F000FF;
	Wed,  9 Sep 2026 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987905;
	bh=HDrA2l45xzbtIngYwABKD713gGWsPAUQd40E+2YD4tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dwirm6dUP+MI5h2xHmxXy10AYWoaV3DD/JUqljYZqLkPSKVlQb8lTdbHQCh08Rd+O
	 ypls84vYgWUNOQQmlPfCkuec9w38R8gbu/FlQ5udiZozSeqq/OB+HUbtbmfpmzT4Yl
	 vLmWuRyj1Ym0ADjPDFhKyqcuuosyt4/HW205Y8Ha/0KhKi7lAc42nkEvrX0Yslt0hC
	 JLJsslCRcaKk6d5J/0DA8KfNatn6vsqlKUt9TE4vrwIlzxqqcfxZ0SmZsTu4LaKNLQ
	 IaPh0dUeK+VqeFRXb8Qr1V0mcxbYhVlU8Pnf9DLYL/G4+Oi+FM7wZr2IK1gUWh9zKl
	 TuwOAFPz4nS2g==
Date: Thu, 10 Sep 2026 00:05:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH 1/2] keys/trusted_keys: return immediately after TPM
 unseal failure
Message-ID: <aqHJ_HlQDyldmPRR@kernel.org>
References: <20260902103120.222326-1-ssrish@linux.ibm.com>
 <20260902103120.222326-2-ssrish@linux.ibm.com>
 <b2d390dd-3ba0-4faf-967b-d1188da12e62@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d390dd-3ba0-4faf-967b-d1188da12e62@linux.ibm.com>

On Thu, Sep 03, 2026 at 03:54:38AM +0530, Srish Srinivasan wrote:
> 
> On 9/2/26 4:01 PM, Srish Srinivasan wrote:
> > trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
> > fails. If pcrlock() succeeds, its return value overwrites the unseal error,
> > causing key instantiation to succeed.
> > 
> > Return immediately when unseal fails to preserve the original error.
> > 
> > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > ---
> >   security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index bf0bf7f36970..1168ca235205 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >   		ret = tpm2_unseal_trusted(chip, p, options);
> >   	else
> >   		ret = key_unseal(p, options);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >   		pr_info("key_unseal failed (%d)\n", ret);
> > +		return ret;
> 
> 
> This should be "goto out;"
> will fix this in my next version

OK, remove my reviewed-by from 1/2 so that I remember to check it
properly

> 
> 
> > +	}
> >   	if (options->pcrlock) {
> >   		ret = pcrlock(options->pcrlock);

You can retain r-by in 2/2.


BR, Jarkko
