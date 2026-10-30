Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373976;
	b=1pQbdOEahxbEtwHKIaCI9H2cNLNRisE6aW/2iAKzrEuPAVp3cnJvpgsDSGHC9Beb4v1B
	 NLu96eOa/LEAYUdW7C/zMYFE3xe61HcszYb603ixC3tP24r8c7uNW07MrrRGJPio3FvV9
	 6xLT1UZwOyVNwAj6Vpk/9JsCEyksMisNkk4+vPdAMJfNZmF0jGLU8Y2tRTw3HKOx4Kl3+
	 YjQwIV3FioSFyZeY8I5Hgzg1ibMelRTQnLS5gCmXlTsWGd1E40mui+hchESu9JRNrEarC
	 olNPch25KA9gZISATgaomGBfsmq0R4vttA43fw9VC9ND7Kp4f1ifiADIe2AzKjgsniw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373976;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZTDAFoMzoki0lGj3im6eq6fHjr+iK8nHBxEHx/uEBXQ=;
	b=PRnMOawnS1L8Pqa3s7wT9fcfJP1c9AsyQLQniYpWjLvwSJhGtQH9dSirjD33NzqT1Lcd
	 9fcwegtIK9jfM6RDg02nnaXPRufhgbeS9G9X/Egb5qQu8Qk7pmuiePtKc/Aucvvay/9Em
	 uazk+vf2ZMOOggQpfrhcAgwVDNB6nDervQK7eM4pergzYJgYHZgYaTGVRtLqP3BpGMpi0
	 HX/g5u5xN6gA7gnPffbwpAM916BMJ1XYClYjwVOBEIY1zikSAeJxKYoOt43R4ZxnM434c
	 mlH0LXxeItGHkAL+McxTTXdzS4loIY+eR3u512G+3NIqifM+1BZvZtQ1lSpbEgZxYSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+21PUll;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E8E9F606A31F;
	Fri, 30 Oct 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+21PUll
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 46BFB1F000C1;
	Fri, 30 Oct 2026 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373975;
	bh=ZTDAFoMzoki0lGj3im6eq6fHjr+iK8nHBxEHx/uEBXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L+21PUll239dfXohQc6EJmnY37vdJCe+8VKiskgo1Y3IPoy72fiWhP0sLAh4Je2uz
	 O0WPdloQID2cbfedc8qbnrIlKNFHLf61sAlfLRnfcc9MQpnafguaJ9Ux1wwtES8F3i
	 MsyxeD7nM92vrCYQsR3RlMqhNLJ8V4c5jET2jTAOBvPO3X0RbuC4d4tckIRYPtlQvi
	 km+Om2OM4QOjpbu5C+7xn3GC7C3pUAIv7HoNkGaWtHo8pac4uHaskZqJN7zMrpKQUm
	 QR9ndEvrrsSHN75XABSGA5K9eOLTQy82mdL5L5lNNLdZl6kP5TLTOxoPdy2elFO7Af
	 /rZ5IMI08NhfA==
Date: Fri, 30 Oct 2026 17:26:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auS3FOhwNE7iLosA@kernel.org>
References: <auPjLi6xocFw7r-k@kernel.org>
 <20261030061030.233-1-hdanton@sina.com>
 <auS1ClHZaIVxOCNc@kernel.org>
 <auS2CfAzpSozsJu2@kernel.org>
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
In-Reply-To: <auS2CfAzpSozsJu2@kernel.org>

On Fri, Oct 30, 2026 at 05:21:49PM +0200, Jarkko Sakkinen wrote:
> On Fri, Oct 30, 2026 at 05:17:34PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Oct 30, 2026 at 02:10:06PM +0800, Hillf Danton wrote:
> > > On Fri, 30 Oct 2026 02:22:06 +0200 Jarkko Sakkinen wrote:
> > > > On Fri, Oct 30, 2026 at 02:17:31AM +0200, Jarkko Sakkinen wrote:
> > > > > On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> > > > > > On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > > > > > > key_garbage_collector() has a design that is not resistant enough for
> > > > > > > workqueue lockups. The duration scales up relative to the number of items
> > > > > > > in the serial tree, which causes a reoccuring theme of being guilty of
> > > > > > > causing workqueue lockups.
> > > > > > >
> > > > > > Given cond_resched() the gc work is not a cpu hog, and given concurrency
> > > > > > workqueue can get individual cpu highly overloaded in short time, so what
> > > > > > you delivered is a half backed croissant, HBC, as you failed to make it
> > > > > > clear why lockup occurs when the number of gc items rockets up.
> > > > > 
> > > > > Please, read:
> > > > > 
> > > > > 1. Documentation/process/code-of-conduct-interpretation.rst
> > > > > 2. Documentation/process/code-of-conduct.rst
> > > > 
> > > > And: I'd suggest to do some self-reflection and not use LKML for
> > > > trolling. There's 4chan, Reddit and other more appriate forums for
> > > > doing that.
> > > > 
> > > Can you answer the simple question, why is your patch correct for curing
> > > the root cause of the workqueue lockup? Because it has nothing to do with
> > > trolling.
> > 
> > No.
> 
> But I will file the complaint at least if this nonsense won't stop
> otherwise. This is now second time where you give nothing except random
> snippets, neither explain nor help,  use toxic language, cherry pick
> and weaponize words from previous discussions, and generally seem
> to try to put other people in a bad position.
> 
> I did search over lore and there's a pattern of this behaviour.

E.g., in this case the constructive version would be to **sugggest**
of dropping fixed/closes tag. As I DO NOT CARE of closing a random
syzkaller bug as much you do.

I will repost a new version of patch with just that change. You can keep
your bot thanks. It has nothing to do with the usefulness of the change,
and whether I agree or disagree with anything. I just want to get rid
of your trolling.

Br, Jarkko
