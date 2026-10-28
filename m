Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202966;
	b=Vg5Gt43ozpEv+eDa9t+Kyq+v6Pd32rOEEhUze2gX1b/Zp8xvTZU6wwf8YTxu7AkPINcx
	 x+FQDsEDn+xJbNtQrddbU6z8yNqd3y2mIRhOVoEW1yboJaPJRbNmNH7vryZPS5CyjcfJD
	 8yEok6loYzb7ldittVtTEGG2wCJl6LRwxUZELrXSwZt/tLT9+tqp9w8zTSpJFMWe42iDr
	 RBsbhlAw78r3sPMq6a5ARK4VGefAqiKnhxiyXEVOR5ozhNkq4O17OFyLi6x5TIqHZTs9S
	 N2IwBJLtQSaul1K0BaFa3N7AhfJGTNBFDLiK2v+c5eOCu4a9pxwwD7N3BY1pXCH4zQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XEte9deMkeckVaA8ApPdXdNCM2Wun8V+QFtnoRsKKwE=;
	b=NrRLf9+X+GRRjxWC+DhBIRODerdI4H/Q7SxNhvdKmMHX1OR5vsdc2svIFne169pvXV1Z
	 4CsvQS4layQMSOxSRu9jTgO7Du3IsB7Vh8hT2Ng33YsyBHA9u5Zwk5JBJey8zxRh/Nn74
	 JkRofOWED0gOHGQU9WmFYWBXs8VWVSHvnAyeteUJq+b/vXlFuu3x1lirzx0E9X4wr4QsA
	 uqCyQT7umsgqoajHveL74mtzOATtWjULVyX4wPnU4PsWdT2QevihFWLcg9RtUeCU9Nc2E
	 iAgUKd+sdDWJbIy9U2A8xCyJV2Mx6e8z5vV0cHyvhJmn0LHGeE6a3/NEoMZ56Uzssxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuyFOKmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A7A46606A324;
	Wed, 28 Oct 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuyFOKmV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ED4F01F01825;
	Wed, 28 Oct 2026 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202965;
	bh=XEte9deMkeckVaA8ApPdXdNCM2Wun8V+QFtnoRsKKwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuyFOKmV7NGZYhOkrld6JNAlxsGMz+aPPE0uWeh1CtrEqQZKhmPwR420qGcbd9UiM
	 0K7k3qu+vw3hlmZLDccgSRZL49E4ygOP3+jahSW5xfQLbukdoFO9XPFxw2HmS1kzO7
	 cHQuT0OEqKJu4Raev09ZQERuxeY5o5LuQTjiNXXOEzY9c1mBhTUWO54RjizXX/bCWN
	 Ji946MRT0L47pjdw8jZWn9TJlhB0Vsz+0ADLHYyy/nZ7wYPbYECVLOJLxP/BHIajch
	 icmK/sfLq4lafmy75G04p5J9t6O9VC43GFk6ZgAXpaBFRpmLXNfU2fV1Lje2DUA7LL
	 mZ4GZ3O6ULl5g==
Date: Wed, 28 Oct 2026 17:56:01 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	edumazet@kernel.org, ncardwell@google.com, lyutoon@gmail.com,
	tpluszz77@gmail.com
Subject: Re: [BUG] watch_queue: RCU/info_id overlap leaks kernel stack
Message-ID: <auIbEZv5macfZ4aq@kernel.org>
References: <CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com>
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
In-Reply-To: <CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com>

On Wed, Oct 28, 2026 at 11:41:35PM +0800, Zhiyu Zhang wrote:
> We have a short source reproducer, exact config and QEMU results. In
> accordance with the kernel policy, we are not posting the reproducer publicly.
> We can provide it privately if a maintainer requests it. On the vulnerable
> baseline it normally reports the canary, stack/task pointers and two agreeing
> KASLR anchors within a few seconds.

This is public nobody cares. Likely I could make the reproducec with a
couple of prompts. 

What if you instead spent some time with your "short reproducer" and figure
out how to make equal reproducer with bash and keyctl? It's a good
habbit and helps to check the relevance because you have to think things
through.

This announcement is just total waste of time and energy anyhow.

Br, Jarkko


