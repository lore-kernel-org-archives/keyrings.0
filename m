Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718421;
	b=mjs+uzs91wj02dORC9/PiyS/wsxdVALAETNQz9BPBQrjqoDq29iJTfJ4y8vLZHR0BXkI
	 vo7EYtJe6WLgzc+76o8B2mBaoQ+r9jiwLVNEt447iWCsMfdlOvr8BuMLsGGN5nyIO2wm+
	 Y1qHAuc5j1IXqQddKpRDd1GxoKFwszPzjZs7TvIAeG3V/UwOolF/jp3wGgBtJvbXbEf0n
	 kA1h3/Fk6gCj6KCEjbeuA5aZHYjTNPaeluE9R0YA5N0G89rmywTDYdLaOMKkIwKmVzuq6
	 RPFiNMGinfbYmbCHENWvqOk4ise122RIrorM52jQs9fzbZKvwTT8YelXzrCIkdIDe9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718421;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YbrNDNA7Gcfkbdl32WyCvLbc/Oe5bmLKHXgwy/OHXVE=;
	b=yeoVHunodSD+vEMDd8OwGxfinZwEI6eEIjPwhVew+BSZoZRj7N7VaXnH1V4ilBeZugEn
	 ghNMLoy23Bc9nI5Q77ogv7ZS3+RsnwE7PT/1cKvzmBS0OUL8D2w4IkkFnpvHTBrZ4TXaC
	 aBW/jsICMbo7TX468znRh7Y2WJsnwzvoOKUVxbOtNFTMWRGpt63EayjlhCm4sX3YIlxzb
	 j384v9vBAOpBu7g8jiu+IiMW6WDr9jGAzdsvXxnzaLJEXaLXjhxc2udlcOKJNVsf3bWFV
	 tHI4+1OjTPSNgYleKrER3S6LLm5DPksZmBlt5MYDXTHc647JOhaT+W9Mxiw0vLpU5jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpRX8ZMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7B407606A78E;
	Tue,  3 Nov 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpRX8ZMz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A52F91F000C1;
	Tue,  3 Nov 2026 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718421;
	bh=YbrNDNA7Gcfkbdl32WyCvLbc/Oe5bmLKHXgwy/OHXVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SpRX8ZMzah8B58Ck71GNqt39bwbs0F6rjn5LH+qYQQvZQQRn02b9kiuvvKddVrk8j
	 Acc/509p5TDRezSb28LPDRMvEyBrTLFXUTL6RmAoBfPONXrsyTajJ9MBibadgxJIiB
	 QzqKtH8d50o+uFw5xBbLakR4U0U2Cy/aywSoct+04pmTIuK++KFczvrTX04ina3Wlu
	 2Bz2Y4K+COfJIcnkP5XnYIDKxq9Cpl4oFmx59jqXGgABhKG7ba2F/j26/FFqA5BI9P
	 Rj8O9PFPzZd5sx9TWaDbDz4ONSxHtfMOOE15hHkxKtoa36MCVnyN6L4zQ3rn6V4Z/h
	 97+XsheP6jgTg==
Date: Tue, 3 Nov 2026 17:06:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
Message-ID: <aun4kXCJDtYomzpu@kernel.org>
References: <aunNj35KmcAC4ByH@kernel.org>
 <20261103030226.2685251-1-jarkko@kernel.org>
 <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
 <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>
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
In-Reply-To: <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>

On Tue, Nov 03, 2026 at 02:00:19PM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > > Please don't do that.  That will cause the AF_RXRPC module to get pinned in
> > > place by outstanding connections that haven't timed out yet.
> 
> Actually, it can be done if the rxrpc and rxrpc_s key types are moved out into
> their own module upon which rxrpc.ko depends.

Hmm... I'll experiment with this, thanks. This was useful.

I also have an alternative solution that I'm still finishing up.

I think I'll just work on both branches and try to draw some
conclusions.

> 
> David
> 

Br, Jarkko
