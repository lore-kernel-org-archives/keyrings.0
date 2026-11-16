Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792578;
	b=cZ+P++TEJd8lOv1sffNRY2UcxtZ/wgnYYmesxHau41n4oTxHPSbYGr6X7F9MBtbMWfjA
	 ohx+xzz7qh83JsV9OJed0aga0YqFfeaL+ocAXm6ncXy4cN82braMLO7guoJ2hvOpYDy1J
	 R/Do5s2cWYTiPC3W/GzV7CJZqRQMP9keyjUC0+Jhm/m9LehHhwxbbogKgiCzNUBICHkOM
	 m5kzIN4zDcgHXbyhE2PV1q2JQ67WdBersRc81NlfS7JhKIfbh2HEf1r2LURAQZzhBNC29
	 y8Z4URhYJ+5Q6I8nGOz3J0gRTAMWnZ8TNm1Vmsv9LE7eF5mac5ngZUHVJG8JnFXU1MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792578;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZY//ANNtprYIt4tMjpsIX55JRTOzZ1NiRRBN9WRZDps=;
	b=P02mUjIroE0cOBL1lI0HDimkMkwah3nCd2I+w4SNvDhFe92N401jSlq/OYd2SuBtA50R
	 rWjydSyDHUvgEBFAWb4gwwmgLJO/nH3wqaVfSqYH/AXvanPJDlEYuBfccBYhxnZJNxcBU
	 4JIMmkM98gXMXkMgXAhPaF3zRzc42FvegPGZ7Sk7CgP63KZOyNYNsvAODLfKQR08TK5UT
	 TyqNPCxaOoIVbaLeA537XtNGbK3ITwXr/UGRuKMOw9ClAitS9K8P7ZOimAanTTaF6co3L
	 oZwl4WPyg0Yv7JSL8AVZUoor5sZJ097VCP+20q60BbYn3iholB9yEg8Job0EgAAvS8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K9oTD7/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A314D606A31F;
	Mon, 16 Nov 2026 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9oTD7/B
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 086B01F000C4;
	Mon, 16 Nov 2026 01:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792578;
	bh=ZY//ANNtprYIt4tMjpsIX55JRTOzZ1NiRRBN9WRZDps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K9oTD7/B141FLRIuq/Q09hqIcKL0oW6Lc1z2qC4Dgx+AwUWZXbuMQOCAbp2wvwOTY
	 BrsH0GjPlTi24/KZmUEZEWKSzUqrk3C0/sfe9jvH2eRwydd1vRsWhItlfwH1uMBem5
	 i2eBhsadY2v+kyykoriQ2n5vZcnmI6jy7bVitXrdf8NvZj5VZLdM9uJYavaF0mW0Sa
	 ElGnIxq+rPdk68ZE2PM8mtMSA600/kAU/qSurBJgFCh+iphwK3cINBntTd+sa/Bm3r
	 PQR2vhMzOuN02VvNlIm0dBrK3iTBhr5qKNdAcpoTIZkZe+4KDemhPcb9oGOr/aAuBr
	 C9N7whCVDq8hg==
Date: Mon, 16 Nov 2026 03:29:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 5/5] tpm-buf: Make tpm_buf_read*() fallible
Message-ID: <avpcfoiUi2nOEuV9@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-6-jarkko@kernel.org>
 <sashiko-outbox-215989@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-215989@kernel.org>

On Mon, Nov 16, 2026 at 01:09:31AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] tpm-buf: commit message says @offset instead of @value for
>   tpm_buf_read*()
> --
> 
> commit 1b879beddad8b2ec7e0adcfdce0e0fbb6825a4f9
> Author: Jarkko Sakkinen <jarkko@kernel.org>
> 
> tpm-buf: Make tpm_buf_read*() fallible
> 
> This commit changes tpm_buf_read_u8(), tpm_buf_read_u16(), and
> tpm_buf_read_u32() to return a boolean status and write the read word into
> an output parameter, updating callers to check for out-of-bounds reads.
> 
> > Make tpm_buf_read_u8(), tpm_buf_read_u16() and tpm_buf_read_u32() flows
> > unambiguous, and fallible by writing the updated offset to @offset.
> 
> [Severity: Low]
> This isn't a bug, but the commit message says @offset where the patch adds
> a @value output parameter for the read word; @offset was already updated in
> place before this change.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116005105.1573016-1-jarkko@kernel.org?part=5

I'll ignore this one.

Br, Jarkko
