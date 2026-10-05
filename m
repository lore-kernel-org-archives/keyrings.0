Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6F30AAD8;
	Mon,  5 Oct 2026 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229113; cv=none; b=rRRfU0MebeFEtad6gnNP8XqQcIh7KseOuTIAiCFWLdQubTctiJC1c6jaYrjPTz0w7EpYZISi3qgb1iBhihPSnh/k3y4hBxlx+/jy0NDy9xRa7LXa0SC05W5L3GiQT0LLDeGhTjYrbyPdBQuFWsGAH2Bqn3zNr944Hn8xl38O4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229113; c=relaxed/simple;
	bh=EgVO15Ja3YT7CZtonadebCojRhqFNh1i/IKnS6v7nkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X43hJvCneQ8Njm6Xn/0FA60xFQX1h2EHbecRGT9Yvlaa8yb4F7ijUwf2M7mPyx0uCtenbR8H+lLvcewYagg1XGnTBjPr5auGVpli4ioze42Hbc4sir3j+XKdBhqOTgph1Lxj2qCmNGpq481WfZrnjH+7BNa1lwXnWgOeGT++QbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjL+cKoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjL+cKoH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0B82A1F000FF;
	Mon,  5 Oct 2026 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791229111;
	bh=QgwjGlpv4JXqFPzdH0jREE9a7C08MQoBRXZMJPVFMjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WjL+cKoHg3KfbjvPewGXq4ZVN8pLly+4+DHy9Wl77diWMpzQXyAQlVKT4R1yDG4Sb
	 xVG/6+WF3HAC7wDlpr9r7zh+EswFUVVtDtxgqSFvltviqSrFQKLsFx31pNt+SnCnJc
	 9MVclzYaXJoOGxvwqi+HG5MK9VcNfYL+YLXNL+GeQTtTZ1EVSXGgUnvLFJF4PCezcQ
	 whGEOqcdqsZdkvR+TSufrv+vg781HxtJ+D8wRn9PiNN34iY/UWpBY0eZSI9klaI97O
	 fkGS19V+nnC6vcPHjHzh6qaU3TmxNkGhj3ZIlS+K88RqdFN49lohvodWS2UEdREv+R
	 nqLEZ8fb1K5CA==
Date: Mon, 5 Oct 2026 22:38:26 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted_keys: reuse TPM version in option
 handling
Message-ID: <asP8sl912TVaCEIE@kernel.org>
References: <20261002071050.179879-1-ssrish@linux.ibm.com>
 <asMYa0lD7RNcoszb@iki.fi>
 <d3574d84-84dd-4aa5-b80f-acc7844c3f12@linux.ibm.com>
 <asO7zHFE3C6W8TV/@hallyn.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asO7zHFE3C6W8TV/@hallyn.com>

On Mon, Oct 05, 2026 at 10:01:32AM -0500, Serge E. Hallyn wrote:
> On Mon, Oct 05, 2026 at 11:31:46AM +0530, Srish Srinivasan wrote:
> > Hi Jarkko,
> > 
> > On 10/5/26 8:54 AM, Jarkko Sakkinen wrote:
> > > On Fri, Oct 02, 2026 at 12:40:50PM +0530, Srish Srinivasan wrote:
> > > > Determine the TPM version once in the seal and unseal paths and reuse it
> > > > when allocating and parsing trusted key options. This avoids redundant TPM
> > > > version checks.
> > > So this is a bit nitpicking perhaps but a patch that would just clean
> > > the code up a bit would not be be worth of applying. Almost anything
> > > that "does nothing" goes to that bin.
> > > 
> > > What I'm saying is that the conclusion in the last sentence goes to
> > > wrong direction but luckily the change has also feasible effects that
> > > we care about.
> > > 
> > > By caching tpm_is_tpm2() there are less fallible sites in the key
> > > creation process, and reduced number of roundtrips with the TPM chip.
> > > 
> > > Or from blackbox perspective it reduces I/O traffic between kernel
> > > and the hardware platform.
> > 
> > 
> > Yes, that makes sense. Thank you for pointing this out.
> > 
> > I will revise the commit message to highlight the reduced failure
> > surface and I/O between the kernel and the TPM, and
> > send v3.
> 
> And I've seen chips where every round trip is a roll of the dice as
> to whether the chip will become useless till next reboot, so that is
> a bigger win than I was first thinking.

This is true and happens quite often. And in CPU companies in fact all
the time with early FPGA implementations and very early ASIC based
software development platforms.

We also have opt-in bus encryption feature where extra roundtrips have
a horrible time cost.

Roundtrip removals are high value patches for both R&D and production,
and they are always most welcome.

Br, Jarkko
