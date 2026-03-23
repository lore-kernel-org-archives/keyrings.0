Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75878158535;
	Mon, 23 Mar 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243293; cv=none; b=u9K/jLj8RqnFe1LiqkXha2ZHGhqlo2bm8siJkNpeWCGISVVaGrtr81SA02fnEPl6o3nmMruYBQwleYRrAv5Pa8SnRqvNSHIAKI6xRok4ej2geQlIvLBLIYVQvwkm8BcA5Gty8OPwQ+8l67EWKlVlTg3c3nv33h+S4+/KrHeEsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243293; c=relaxed/simple;
	bh=P8vbusSwn8/tKnPKEl8YhvzzIow1wl3txX/FVcZbs7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDSiApGlQ7+4zudlTXJf1KKvI1ygatVp0ljNknZ7Hy98SyvEPoseERIU0LcU2puANCiJGMiYm9J6txd2cy7e5EyZyzbjnmrP7bYEPD/z0jHyWPDoUkGkTTudTW8SH5AUB9494Ir3rG2vsS31A5WwYA1sEtFPxdzIY2+cw2xIhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I36dXxwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I36dXxwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84469C4CEF7;
	Mon, 23 Mar 2026 05:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774243293;
	bh=P8vbusSwn8/tKnPKEl8YhvzzIow1wl3txX/FVcZbs7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I36dXxwS4qVWSV9fsHIIfjTDUkVdi9g5EY3GImIwY1hNY1LCuhm1FZn0dX5oNteZF
	 ifsgQQ3OZxmZMd1rAJRwEcjOPeG7y7SS+E1NoVkCFCj8x94bv8tmT42uk0FtrJ3I7z
	 L7BquXNR9PWgqsAdgnEKIeIuVEG470VdU0efe2G+vxq4JBDfKRV6v2Vi4Kai2NxbiN
	 yLDP7sMjmLUYkWSf+do9oXR0gPBbRAMD1IcLYqIyOfdRcGi1mSnntiIVQpcwrkKY+x
	 id2CIeTGv5hvlUAAoiwpHYm+PR4ejcBvGYbRj6TJNeJIGzAsc09/x50qa+6B/22lXi
	 KLGRzRuhVrCCQ==
Date: Mon, 23 Mar 2026 07:21:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
Message-ID: <acDN2OIQcWgjk1g6@kernel.org>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
 <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
 <acDM-hNRThVPRYhq@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acDM-hNRThVPRYhq@kernel.org>

On Mon, Mar 23, 2026 at 07:17:51AM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 09, 2026 at 06:45:23PM -0400, Nayna Jain wrote:
> > 
> > On 2/20/26 1:34 PM, Srish Srinivasan wrote:
> > > The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
> > > for logging debug information.
> > > 
> > > Replace pr_info() with pr_debug(), and use KERN_DEBUG for print_hex_dump().
> > > Remove TPM_DEBUG.
> > > 
> > > No functional change intended.
> > There is functional change here.  This change allows secret and nonce in the
> > function dump_sess() to be logged to kernel logs when dynamic debug is
> > enabled. Previously, it was possible only in the debug builds and not the
> > production builds at runtime. With this change, it is always there in
> > production build. This can result in possible attack.
> 
> Good catch, thank you. It's in my master branch still (not in -next).
> 
> TPM_DEBUG should be removed in all cases. If you really want to read
> a secret, use tracing tools.
> 
> This only proves that the print should exist or should be a constant
> value, or overwritten same length value.

I dropped the current patches but yeah, a comment "do not touch this,
could be poisonous" won't be an acceptable way to address this.

If you want "some" debug information you can always put F-string or
0-string of same length, so there's options.

BR, Jarkko
