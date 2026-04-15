Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38D10785;
	Wed, 15 Apr 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211527; cv=none; b=oNcqFGEJdYxRVuxJbpz5UxUw8oWxCCtzo4EmtVY9+5IW6OTEB7FwKk56IiD0UhpUbeGzDdXXA5MqPqiFE5jpwEtTjqhba2LEAdsSNlhCy1d9E92o/XZlML3UbIQfQ8TLBay6Kr5HF518KARLX175q/yi2rk9yBZkTRHM/91sO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211527; c=relaxed/simple;
	bh=PSrSRwRn4MKa54/IrG32UGFRrDBkQctp2senTqauhH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6z/nT6bOJ8IeuczM30/R0EtJEZQgLMyb8mBjr0oVsNn7dGVL9XUGmHC/aWKR6L+poa4IL1jGjuJXTailW4Pl5ucqWmLnvk3FrgG8RoQqnHzwbflnD8hpp9svIZmIFg2ae+xFOP5e5n0Za4AE38bYAFwYuRTymF6IAGHOXaeAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXbK/YgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXbK/YgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC4C19425;
	Wed, 15 Apr 2026 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211526;
	bh=PSrSRwRn4MKa54/IrG32UGFRrDBkQctp2senTqauhH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXbK/YgNnRdZ9ajObaY+LEjqh4VhI9V0SNCCSgmGgqJB3KWhp063X5ZZ4E2VCxSuQ
	 sFGBq5PJas07AbSLpc82nWDxJKPo1J1nQ1A8dnwAStaV/EVCQkjW6/ughsTzULZhd+
	 YNa6edu2EF8Z4fTYryfWW6wilBr+nw2t27q2CC7WczFchaxnjEEHN3paXzvVCt2CRN
	 sc43ydUFENZX1GuomdlMMtMzllJGNvD1v9r5qd+JZah09fFIjvFKgAgEhrYZZ96CrU
	 /j3zKEktQORaKIaWuNEhpTwfbOMBWhQvjdAW0ZG3QYYgN3OgwGSYiJGyk7qnVdYHmQ
	 Kzueh9SsBUpag==
Date: Wed, 15 Apr 2026 03:05:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Debugging as a feature
Message-ID: <ad7WQ_Gr5H9GRdSX@kernel.org>
References: <20260409160752.988713-1-jarkko@kernel.org>
 <129b137c-be9b-4b01-824f-beec7111377c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129b137c-be9b-4b01-824f-beec7111377c@linux.ibm.com>

On Sun, Apr 12, 2026 at 02:47:20PM -0400, Nayna Jain wrote:
> 
> On 4/9/26 12:07 PM, Jarkko Sakinen wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> > feature in Linux kernel. Introduce CONFIG_TRUSTED_KEYS_DEBUG for trusted
> > keys, and use it to replace these ad-hoc feature flags.
> > 
> > Given that trusted keys debug dumps can contain sensitive data, harden the
> > feature as follows:
> > 
> > 1. In the Kconfig description postulate that pr_debug() statements must be
> >     used.
> > 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> > 3. Require trusted.debug=1 on the kernel command line (default: 0) to
> >     activate dumps at runtime, even when CONFIG_TRUSTED_KEYS_DEBUG=y.
> > 
> > Traces, when actually needed, can be easily enabled by providing
> > trusted.dyndbg='+p' and trusted.debug=1 in the kernel command-line.
> 
> Thanks Jarkko. Additional changes looks good to me. I just realized that the
> kernel command-line parameters document may need to be updated to include
> these parameters.

Good point. I will bake that to my PR version of patch. It's low risk as
per corrateral damage. Thanks for pointing this out.

> 
> Apart from that, feel free to add my
> 
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thank you! These defines have been a huge itch for me for a while :-)


> 
> Thanks & Regards,
> 
>     - Nayna
> 
> 

BR, Jarkko
