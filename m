Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373710;
	b=tx7EWv6Lcb3FqZ1/lj8xvAt8Hu5fAGMDzATQY322ns1l6XBPWxYV+ySD3Wg56U04IK7y
	 JulTjTQkZ3pRitURphcYDp1j4P/mWAUQRW17YZCq/IyVgHryq7ksAW5Ez39WmhVSfUOVs
	 mDGIgtgMK6SvpaQ99+RaWaLWKSAVT6fR8/kmeYQTf2V+voQ60Aowjte4ROZT1bwJZrxEz
	 W28o4wLOrUc5KuUiTqCQgFWgFCLefks5G2uWl6brLI2+Iq6hsJuyiyN2VR2VQUUDJYlr8
	 UUjEkSdW2mrNbdQdExMPcB354ys+xDH9L9KOonoVFdSLcHfB/RbJCP50FmFIFsVMCXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=E56a2+p9VCJwHd0a41Tnzv5fscjKjmr+8haNzbFDc8o=;
	b=DwuQ9pA4B/gq/fkjuKGaln66UOhpH7piCnqlyk8qgSW+vx8JkiA+yUr0vqdxcxtPa8VT
	 QR2WUyKsoXBBvLlVXP+2sm6q9QsRXtsPgYUhY4V1DaBufxpbK1uyPIpb4llbTaR4YTHom
	 zYtt2t4C+VhsIMYSTrhISe6nlk5vWj3FbyCCekKkbxQ/rsYvFs56RGIpedttvUo/dwiJT
	 Tth3heezaNIZquSiWhkAHLkPevTZmETpjgdJTAU8MNPBzwxET/nT6kb6HBFQX7SLKWC3c
	 PgNoLa/06zmXRM8SAFpTJeib7xqHzBvVu0lVPxzOUWA9pnWt/TQ3BqbO6JZYVTsgkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3NrU0q2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CAC70606A321;
	Fri, 30 Oct 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3NrU0q2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F3FBE1F00A15;
	Fri, 30 Oct 2026 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373709;
	bh=E56a2+p9VCJwHd0a41Tnzv5fscjKjmr+8haNzbFDc8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E3NrU0q2uNfQ53ZRQUoNi51gkjMyRbH9eIQ8LdwCcYganpvAITNqe5CHhhcUCAnKQ
	 775KXWr6bW5j1B965Ph+FOzkz9yGtyYwsxwTMue44/TH6Qig/+Cu8cEOTXjMrKaZfr
	 uHo1dmBqCkKzW/RHNCF6df4pWKE4+7McxxszBOI7vTCG/wSLs1M50yUKcEz5LsXyCq
	 imNYEG9MsWcwrnkYdBn+U1+P8PQ/F72SvLlflvN2CnZJTgSXI2Wuld5ejsraggFEdM
	 4O8HhMFfo8iH9+fgCctZJPz6xt94umSeO2S2ebmoH1lyA+JzlxPmO6NEyB9XQdYJxr
	 Jce6cafvGSARg==
Date: Fri, 30 Oct 2026 17:21:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auS2CfAzpSozsJu2@kernel.org>
References: <auPjLi6xocFw7r-k@kernel.org>
 <20261030061030.233-1-hdanton@sina.com>
 <auS1ClHZaIVxOCNc@kernel.org>
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
In-Reply-To: <auS1ClHZaIVxOCNc@kernel.org>

On Fri, Oct 30, 2026 at 05:17:34PM +0200, Jarkko Sakkinen wrote:
> On Fri, Oct 30, 2026 at 02:10:06PM +0800, Hillf Danton wrote:
> > On Fri, 30 Oct 2026 02:22:06 +0200 Jarkko Sakkinen wrote:
> > > On Fri, Oct 30, 2026 at 02:17:31AM +0200, Jarkko Sakkinen wrote:
> > > > On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> > > > > On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > > > > > key_garbage_collector() has a design that is not resistant enough for
> > > > > > workqueue lockups. The duration scales up relative to the number of items
> > > > > > in the serial tree, which causes a reoccuring theme of being guilty of
> > > > > > causing workqueue lockups.
> > > > > >
> > > > > Given cond_resched() the gc work is not a cpu hog, and given concurrency
> > > > > workqueue can get individual cpu highly overloaded in short time, so what
> > > > > you delivered is a half backed croissant, HBC, as you failed to make it
> > > > > clear why lockup occurs when the number of gc items rockets up.
> > > > 
> > > > Please, read:
> > > > 
> > > > 1. Documentation/process/code-of-conduct-interpretation.rst
> > > > 2. Documentation/process/code-of-conduct.rst
> > > 
> > > And: I'd suggest to do some self-reflection and not use LKML for
> > > trolling. There's 4chan, Reddit and other more appriate forums for
> > > doing that.
> > > 
> > Can you answer the simple question, why is your patch correct for curing
> > the root cause of the workqueue lockup? Because it has nothing to do with
> > trolling.
> 
> No.

But I will file the complaint at least if this nonsense won't stop
otherwise. This is now second time where you give nothing except random
snippets, neither explain nor help,  use toxic language, cherry pick
and weaponize words from previous discussions, and generally seem
to try to put other people in a bad position.

I did search over lore and there's a pattern of this behaviour.

Br, Jarkko
