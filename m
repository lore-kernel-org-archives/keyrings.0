Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0037B03F;
	Fri, 28 Aug 2026 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902722; cv=none; b=g2pUDkJoqnmvk1jWI/xzfUK3xoUDgLemx71ErQATmEowDQa4nNDxc3kEN6FXQ3pYLZ9579IJ1T4ctRuTZkb3Ao+tAJ5rei6UHEeQqSSrVk0JRo/EBE3scI+y4Rr30AtU8IFKf4PJH8BIQU4Sz3KLrmHWIFAU0wB3seUjtjnlGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902722; c=relaxed/simple;
	bh=CY1MCw296rTEilDXmH6qCuIxraHR0EygzKP9dHAWCH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lol/Gg2H8QHWacvP3rhGd3sgBT+H3IDXMjtgLFb1u71yiKmtdFRKFxPdIfyyAcp6ryDEKqhbsmHIBezN+XYVwSa0FVf0pJjWkXMnCDYUh+R334qKjH98EouE+0VZgF8xtmBCuMJLdWTHVkDfrpMWlAZa1SnlRXqHE4vBdXZw1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eieh/qy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eieh/qy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13301F000E9;
	Fri, 28 Aug 2026 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787902721;
	bh=Z7ctyS22lyMkCdECqhsZoC0DdVG9KUycgY+RuvIOq6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eieh/qy2VQDifX+eBWl52+d3oJaK7NUOws9PXGHmYbTggce0yRcDnkIZXShWAL40N
	 yecScfy7iyVYG6ZVQ/QItp3s6JFO95wb/lS1xOcN7vy4sKeDhEVBg0yzl7PX9GlBXB
	 QFST4Vmv+Yyyc4SDI/4naNCoswv0NOlICoSAwk2Q=
Date: Fri, 28 Aug 2026 09:36:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sanket sharma <sanketsharmacsec@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	zohar@linux.ibm.com, dhowells@redhat.com,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal()
 before memcpy
Message-ID: <2026082845-shredding-equation-8991@gregkh>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <2026082651-portal-valid-da58@gregkh>
 <apDocVfEfwX3hFa_@kernel.org>
 <CAEb43b2C_eyR8ncUbJ+3MsT3ap-tB3_O0Mbaqgy1ncXwZAd_Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEb43b2C_eyR8ncUbJ+3MsT3ap-tB3_O0Mbaqgy1ncXwZAd_Yw@mail.gmail.com>

On Fri, Aug 28, 2026 at 01:00:11PM +0530, sanket sharma wrote:
> Hi Team,
> 
> Thank you both for the review feedback all points have been addressed in
> the latest versions.
> 
> One quick question: once the patches are merged, will a CVE be assigned
> automatically by the kernel CVE team, or do I need to separately request
> one via security@kernel.org?

<formletter>

Please see:
        https://www.kernel.org/doc/html/latest/process/cve.html
for how kernel CVEs are assigned.

</formletter>
