Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255218;
	b=JK9FTFrw57/VM30MuBVLKOL6rxUjljwuSivpy/DDsHv7KGoWnyFDNl2ILyWnGryniQsP
	 zi6H7Ksr3gsYFPpV7v6jEh7q/+RdhCOjwqHhMg2scjC7bbNI7nVjl4FCBeWkPfmf14O/+
	 aqJSMvxLomW90Kf0zDn93HhvX93o4599p0lOIjAdJ0/y9GKU/o6hyNYe+pHARooYsbg10
	 /waED8Xxsf6iSTS3CvxkwTlUcZKGUj7OB9VlNa6nYavUrUwnhyI6QW+vdRR1/PAH7uGlX
	 AIH8QzNnSPC7jlnWoJFPNBpL17uGLNYNuvx/BNuh7NzTplj+4YhHBsZ5A85ZYt/jj2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xYFObom8zsiGEQuhVglZG1bpAfVlitRP0q/hqkQpdvM=;
	b=ASylhvzIUEamDfwLghhoMdaJUu3u7NRFOGYmXNLjgE1Oegrs+VZ0vf64Q2KsG3ZlGBZ6
	 HLi8DisqE3OPg788I8pni6SdZw5uHIOJanWM9Z6SgQe0fYFRnrrQN7YdEmoy8uZLX/avV
	 Fr5jDKxkK5AoURswxPhIhToV3CXZQj70ZVng1vdhqo5j8Ld9dDUJEalvFavCi6lWWRe5M
	 9+MXkDOlag+dU/yBha67QOuJF+fK8cavHepmwbF0+XmGYQ8BKeX9WacTxI4AV2lzllmqG
	 PCj9GmeBSuvvvQKyPrO5f1eZ0mFE6ISgxf8srFMpirJtkrqSYqKEvV0E91JMFiQZdTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8OkgUON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 18878606A336;
	Mon,  9 Nov 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8OkgUON
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 681E51F008A2;
	Mon,  9 Nov 2026 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255217;
	bh=xYFObom8zsiGEQuhVglZG1bpAfVlitRP0q/hqkQpdvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H8OkgUONsFRo6QDUBZ4FZBSV8wFduhlSZ6mYkI4VZCh74ojgmRKa2l0nsvFjnuzGN
	 rYqZAl2bGTI4ergczMBf7qiGC2KYVWnX48rUM9brnFTIhfNNqm4I+biaYTsCaC3/rA
	 1BNwkFXRXgsJZIYW7i7YULSQxRxfSZ5a5hnRs8uWp//D9UuJrtzOlCgnyFCgEfYsp2
	 Gzk1VHCQ4/iAxLIOGWh3G3oVVecYZf51wg0eUljThGbn9Px3y6j5vrnxpmV6HRJRFv
	 wfSjvjxpjJaUaGf4tTPdOerBANlR0tuh+6qivUWj9BaIK2rTKcgc0cNNMxObJsjqvH
	 SdTj0AkUNEtfg==
Date: Mon, 9 Nov 2026 22:13:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dan Carpenter <dan@cryspen.com>
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
Message-ID: <avIpbqYocfnGV5eb@kernel.org>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <avHelQ1nxsDVcQkZ@kernel.org>
 <avIjqp3n29DKkpPp@stanley.mountain>
 <avIoVVFxZ8PTniEz@kernel.org>
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
In-Reply-To: <avIoVVFxZ8PTniEz@kernel.org>

On Mon, Nov 09, 2026 at 10:08:58PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 09, 2026 at 10:48:58PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 09, 2026 at 04:54:13PM +0200, Jarkko Sakkinen wrote:
> > > 
> > > Are we migrating to C23? I've not followed this too closely.
> > 
> > Google AI says that we will adopt C23 next year or the year after.
> > I argued that it would be would be after 2030 but AI said, "No, there
> > is too much juicy stuff in C23 for kernel developers to wait so long."
> > 
> > I don't have a pressing need for this patch to be merged.  I was
> > just playing with some compiler related tools noticed this.  It's
> > the only place in the kernel which uses "bool" as a variable name.
> 
> I do think that bool is not great choice for a variable name; in fact
> it is quite horrible choice. But since there is no other force than being
> horrible name, I think I'll pass...

In order to put this in a proper context, I meant that bad variable
names are common.  I'm not blaming patch author in particular,
especially since it is a local variable. It is just something that
happens all the time; occasionally.

We could merge a billion patches like this with no other effect than
causing extra merge conflicts in backports. So the net-effect is 
more harm than good.

Br, Jarkko

