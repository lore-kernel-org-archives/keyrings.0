Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314327;
	b=cwYOCXXheQRq/MP78CktRqCF5gdJHLtsWLV6iU3uq3es4Ou8goyZ22Qg8EE0K+mEMtLM
	 HgHwkX/JnIhVXUa/1BVGFUp5fqZnocW7ndmV67kbOEqjiiPgmXAV147SyNaEcSeivbOpU
	 DpafHoHZfqB0PU93qa0QwkYQm1dJEFGJqgYTSh/CLhFFszQ+PvC1BtRbtbn5DXIXemBP+
	 PGcll9sI8K+s52g8JT6FoPVrP494uHNp0xAMeOhPU6FD2KoykLaGKgXrOQL2InZk9ms/G
	 GRUKad0j1g/wByaSHTYsRU75cUBAvzE3dIW2hwfLTyDR6glkHThM0YHFennpRgbvS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314327;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UtxQPNJVvCRCJ8xKxxB4BqMSxW31vYFHbHnKu/HOBlI=;
	b=UBWo9DIbtPmC3OYNF6OJIH92Ahnn718U1RkkKG/y9xbH3osJM3f8WXQDpeQopaaFcEvY
	 8vtCL0pSZQdcLjSZyXS7s9HbzVkYAfaClWWUJxucJUPU17ReBmIjvibJ+kyoPts8jTt+q
	 Ujk0DJuXtGdUk/k/wlq4xCvCEijdDSjdcrS7HSJI/XDZu58gOdSN48dfofFqK7SnAxoA5
	 KCgRK+7b0UctGZoZpUyIJxoiUh+b89De/k4dMo26T11mF3y0KEGn47O+wjq5chANTnp6I
	 SPagRTp2U1G5Gd+Dj2nc34f/Di5CAy+nzJ5DMttW05NBNyECuJt4gUZuOPz2oL6O4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0wiSgDS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 178CB606A31C;
	Tue, 10 Nov 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0wiSgDS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 643101F0089F;
	Tue, 10 Nov 2026 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314326;
	bh=UtxQPNJVvCRCJ8xKxxB4BqMSxW31vYFHbHnKu/HOBlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0wiSgDSjQhRE+F1u4BqIcKMjdYjyPkQzm+Vy7qwbabwEzH6f3+x1IlauoVCx78eq
	 VJrex8fgvNtYbbw5ZDVDvWMMZKnXrUnfQVUwVFbTBCekAOs/AAXe2VW2aJaGyjXcea
	 p+Nc9px3K3KbyDCdoRDq2Aj2pPjXX42NnJTd24pvrYe2RPIPNc7BbW5OmZllPxxGUU
	 Z+PZNRZVKp6wJD7kDTUNtcyfDvCMPT/P5lJ6LcfVIA5UIIlQXfghFFMijn2Hh24udy
	 8fjYcr6U17dTvxGx2r4LzLUKuMq8Xqs825f0LXTs4zuXbSS1B7GtujVGSfmXDrBF3y
	 MNMoSH/C35DxQ==
Date: Tue, 10 Nov 2026 14:38:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avMQUxnlSwnSNYYJ@kernel.org>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <20261110110034.0a46b9f7@pumpkin>
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
In-Reply-To: <20261110110034.0a46b9f7@pumpkin>

On Tue, Nov 10, 2026 at 11:00:34AM +0000, David Laight wrote:
> Hmmm... how can that fail?
> bool[] is just "\1\1\1".
> I bet asn1_encode_bool() isn't inlined - where the compiler would optimise
> most of it away.
> 
> It is a horrid variable name, asn1_bool_true[] would be better.
> 
> David 

Agreed.

ASN.1 deocoder (scripts/asn1_compiler.c) is ugly but elegant (it is) ;-)

Encoding side, well... It would for sure could benefit from some fresh
thinking but more like a turnover than fixing up few variable names
here and there, or addressing other cosmetic/minor details.

I'll put a remark on this to my personal TODO list. I'm doing a couple
of such turnovers for keyrings ATM [1][2], which will keep me busy still
for a while. This is my "post-LLM" strategy now at its core: "when you
see a bug, fix the vector".

If you have a great "big picture" idea on how to do encoding better
overall, I'm happy to look at such patches.

[1] https://lore.kernel.org/keyrings/20261110053323.2936729-1-jarkko@kernel.org/
[2] https://lore.kernel.org/keyrings/20261108222719.304712-1-jarkko@kernel.org/

Br, Jarkko
