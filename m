Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434548;
	b=fLU5UNWsok4+len1q+VNsXvO4py4ikt7BAY4gQaJaPO51fAGinfhCxk9Jb6ONQkbQ3yL
	 MU1jQ//2nUzIrmms9cFH5g3DubI8bWSBauzMOoKlHMMnheTjv1Uze/kxwJ66a93Bo2go+
	 Eo7AYeyiUKoaUNYG0oOnmr3gwCMuM0g0b6KCyP6xWMZE0/lPbOcXkJbqA6kc+c/eWz9Td
	 ytNg5Z9Srub5FNXIVxjUT+rST2LoLen/CZhsHTMu9hhNiuYAngjVo5gPVkTXsI2rhdHZT
	 Ovp09atCuE0IkN5/infN+KAfuwnMmz/nUGuUDfhPgoIqavf3f4PyLvZSBxWhLRaU64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=27il3oOcwKVvNVhkDfMHuekSAptIeJEU0HuNxjreV+k=;
	b=ZHhzchv8O5lIBOrXO5m9mNPgFDt3NZO6mFeF8w/7dG3CJdqFJ1C1/2SdlGhcBLh6dig6
	 fGOzNCHLUL7dTqWDKmctFFROJ8ZzZ8l5+mCJ6khADI630srIEr+THvZW8ltRma7xuLJ2D
	 ALJzy4wddasktTDLzRlivSMoOBIwNEHwRcQMmYZM94lQbMCYnOBUNcpDVSCFRMo6HDDkn
	 NLccZ9n0T3aGmOiBweIRFvx+fw65Wm66rP+R5RHSI/BYjDQJ+6i3q8e2yW3L4XC84ZRfU
	 fmwMP/IKvD2+n1has7InQVFnByurrCBoY3Y6yfQRZAOk3E9CeGdK1vuAlNt9yhkDMBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIbNthbe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 22827606A31A;
	Mon, 19 Oct 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIbNthbe
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 124C21F000C4;
	Mon, 19 Oct 2026 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434547;
	bh=27il3oOcwKVvNVhkDfMHuekSAptIeJEU0HuNxjreV+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PIbNthbeDBD6GZGFfuuN690hURo1zqrCinFmn1QmwDajpKCvt7JBg94SDrGejZmLx
	 VIVkHFGIky5xdmJuDJ33OiKfwqDcFYktRDn+yNbI3unnr3rQMTHdDX1prrS1yl5aSl
	 o4wnUVULaynoQz3vjhVVcsL7L3ToTxeH+i+gSdYmG1iwInu2Hhfq5SwL1Q5mSKbS3t
	 Z+69cT1vnekHTg+ub5P8OUXhJ4rJzB3hjRDyKJbYGTlf4K/V95CYo77iUkDMTq07w5
	 /2QPY/AY89uWkWSjHIQvK038ZfSsgTEFS0uSVXROEQ32XTSz8vjG9JmzvRLFXuMlA9
	 nMR60ICmpYqeg==
Date: Mon, 19 Oct 2026 21:29:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] KEYS: rhashtable bug fixes
Message-ID: <atZhb2Gv9Xbvcjkw@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019181732.449591-1-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:20PM +0300, Jarkko Sakkinen wrote:
> My patch set that migrates assoc_array to rhashtable had some LLM
> scavegend bug fixes. Unfortunately most them where either plain wrong or
> not in the right scope. The bug fixes in this patch set are by human
> labour constructed fully but they are derived from what I got out of the
> original LLM source. Thus, they are tagged as LLM assisted.
> 
> Changelog
> =========
> 
> - v2: There was enough tweaks that a sanity check round makes sense just
>   in case.
> - v2: Addressed issues pointed out by David.
> - v1: https://lore.kernel.org/keyrings/20261019142516.300040-1-jarkko@kernel.org/
> 
> Jarkko Sakkinen (6):
>   KEYS: Expand key->{datalen,quotalen} to unsigned int
>   KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()
>   KEYS: Prevent overflow of user->{qnkeys,qnbytes} in key_alloc()
>   KEYS: Prevent overflow of quota in key_alloc()
>   KEYS: Reject @datalen values over INT_MAX
>   KEYS: Verify the key identity in __keyctl_unlink
> 
>  include/linux/key.h     | 6 ++++--
>  security/keys/key.c     | 9 +++++++++
>  security/keys/keyctl.c  | 2 --
>  security/keys/keyring.c | 6 ++++++
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> --
> 2.47.3
> 

The benefit with this slicing is at least that backport conflicts should
be easy to resolve, and if I recall correctly all go to v5.10+ stable
kernels.

Br, Jarkko
