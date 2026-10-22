Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702390;
	b=q7a74pnuvVW88ZXD+ZBjMc5a/nsSXeiLtBOezgTvWD0hA3ADmLATVUHLCLq8MVkEQWMR
	 TFb2gJLg1gHFgp7uvkYkPeylnhBZGC5D76hVJQpm/RyYINhozHRp+Th1MJNPmAl+zyA8X
	 7mtCapB4bBEnb0Qhq2DXx70y+6zbSsh6A2tylk4wOkm25tUTZ2/a4Gci1Li6tXaZiGYGr
	 IRx8UCZY42HM/f4aZiKlggVBVsWAB3yVff/XZ9NQQ3EWfxbMmliGMTLfZ9E2Ln2dIdteY
	 Tvl7h9HY8AA1ZV3Dja1hdoNAvI06Ni5bFuq0LFboi5e12ChnF+7b4SPQ4tcsr139Dcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pyXXHEMbLUAsTR9Tom3Mr/KVXRKAq/9KTTxqx3eAuPc=;
	b=mm6+mQ1wurvdlDgkp7FOL2mpQOqCsU54IpJpvlboKvdaGZzx1U/KUmmklHg8+jvt80ac
	 qUzpb1yrIT67AOVqwOw4K6f3JdaNKbp9o1nJtR0KPKaA11nMKQ+JXFdpBGeTRwrti8FVV
	 kEEHsyjMoBuYkfAQvwjBiWtyDWJmtI2LNMA6eHn44hmB9yOyPPTUcBoR4mRTRHI7Ydy/i
	 qx9ti/p0NFgAfWuf0C18cGstPzZggBIHCdtEOu49D9MmNDnXCxE2QiHOlOlVDyw8OCSMb
	 rAjhxCt3cBuOM4BAp0JRyLp4RnW5bpQXL4xUV40Bta21eXvJQxEvU6aejtAFVl4Ywyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZUMCxs5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 562B0606A31A;
	Thu, 22 Oct 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZUMCxs5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 50D951F01825;
	Thu, 22 Oct 2026 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702389;
	bh=pyXXHEMbLUAsTR9Tom3Mr/KVXRKAq/9KTTxqx3eAuPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZUMCxs5s5EnJZN/SnY9lhAXDJoWwu079HUbQMrdZxMJx91ac2DIMaRur9jg3XkPP
	 RiJgcuQcm9c85LclMgfSPfSKSKdcVYOu8aCcjO8hzVTxwKYL6cgjq84XcV5xnyfCTj
	 EzvENFJr/sI7iSZffQDRLA1dwGGwxfzpkeBMCZQDl4CVw1V6Tz/sjSOyahsnsP4c5F
	 KkeJV0hbVsV9w2ztFdrk+w+sYeo7oMcGJuuqFlWamjXiqZi2tgFxwsIbOGjIabZWWm
	 w1wsL/jECIn5fgV0p2OT9BkNKqREQ5BQRYUcY+Ax/4xZ5ZWc7W1RbugIdOfVEkPnzD
	 aeaR/Fm+IsJCQ==
Date: Thu, 22 Oct 2026 23:53:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc1
Message-ID: <atp3sgtYEQ1z0Dd4@kernel.org>
References: <atjKs7PTN8CgndJg@kernel.org>
 <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjouh66VCZjhUedb+wkRTWB0vsoDjU3N0huGsiYXQ5S0A@mail.gmail.com>

On Thu, Oct 22, 2026 at 10:06:56AM -1000, Linus Torvalds wrote:
> On Wed, 21 Oct 2026 at 04:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > A patch that Kyle Zeng submitted addresses a critical bug [..]
> 
> Note that breaking local KASLR is not a "critical bug". We just call
> it "Thursday".
> 
> Breaking KASRL locally is trivial using just all the normal local CPU
> timing attacks.
> 
> KASLR is there to make remote attacks harder.
> 
>                Linus

Ok, that's fair and makes sense.

Br, Jarkko
