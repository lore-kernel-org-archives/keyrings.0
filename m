Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6411FE471;
	Wed,  8 Apr 2026 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636657; cv=none; b=f5RwKKvYxcyViFAq/IFgDI9WG/bgjfSQNEcqr7EjMI6qa3E+V4cBL5KT93FBO8B7gXUQojmTfsb5fs9En22HsNkhutArxGS+szXCbkrGh30aBIVf+Lbl7GSD7uy78+Alex2wTkd2lhOyEVgGklMpdRB6HmCZ3wlzSe4b9rbq2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636657; c=relaxed/simple;
	bh=wdXP+Y/M3a6rmGdJlv5tuAAPC4Fs1AKm2YCnmY/7eG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS7E0uRKcbqLzEIcJBD+ng42k+NkPcLYZ103U4Rf4Jgu85UJJnvfgE3dDGbjNEjd1aSx8uw7kkYnFsEPbgX85CekKb9BVD6U1Gftn+xXG9SjVuVU/X9ApAvZc+ksWdwSj9qEa2BjS1JFi+cyyt6LlZKdsrgs52cj60CInbLagCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAuNwNkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAuNwNkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB0C19424;
	Wed,  8 Apr 2026 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775636656;
	bh=wdXP+Y/M3a6rmGdJlv5tuAAPC4Fs1AKm2YCnmY/7eG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAuNwNkm13Ia08UjBlMM0ttyRusC2fPmui7y8K5exyg3q67w4/yJaRNdBA/JagBXJ
	 ZQJhEPJmbC4KJe1UsH/odHz297GkKR/NQ9XS++I0c85yYPQV/oB7B2WGlgZbCLWB4m
	 es/clu1SA7eafiT5e7buA+Gm1kD9wKxfJ4NUPsH25MvWwYuNdjuIm6irnDa9UGCx3+
	 Nr3TlXmetUHbib2qpmKXb//GSIRQ/yMiFDsvs5NCbmPJHiNi3ypZ3EHqAaTQ+hcCuV
	 nXxyqRsWRw+/pS51v0chT6hVjIg+ON0cq8oS9Vs3GELLesLAz8Iq21LqrLouYLEYqk
	 i7mAuxHf2IORQ==
Date: Wed, 8 Apr 2026 11:24:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Nayna Jain <nayna@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Debugging as a feature
Message-ID: <adYQrEp84CI3Ju3o@kernel.org>
References: <20260324110018.67081-1-jarkko@kernel.org>
 <0ce8d850-9ca7-4327-a6be-d1cb84925915@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce8d850-9ca7-4327-a6be-d1cb84925915@linux.ibm.com>

On Thu, Mar 26, 2026 at 10:34:58PM +0530, Srish Srinivasan wrote:
> 
> On 3/24/26 4:30 PM, Jarkko Sakkinen wrote:
> > TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> > feature in Linux kernel.  Introduce CONFIG_TRUSTED_KEYS_DEBUG for
> > trusted keys, and use it to replace these ad-hoc feature flags.
> > 
> > Given that trusted keys debug dumps can contain sensitive data, harden
> > the feature as follows:
> > 
> > 1. In the Kconfig description postulate that pr_debug() statements must be
> >     used.
> > 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> > 
> > Traces, when actually needed, can be easily enabled by providing
> > trusted.dyndbg='+p' in the kernel command-line.
> > 
> > Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> > Reported-by: Nayna Jain <nayna@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> 
> Tested on PKWM and emulated TPM backends.
> 
> Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>

Thank you!

As it is uprised as a feature (like it should as ad-hoc compilation
flags are harmful), this also requires a boot flag so that "I know
what I'm doing" is addressed.

I'll send one more round with a flag 'trusted.debug=0|1'. These extra
steps protect production kernels for reasonable measure.

BR, Jarkko
