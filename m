Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239404;
	b=m6SxWvCdzvBLlWlkkp6o/xaZBLaTjYnpMsIvpOV18ArfmyMa33o+t3Tl+J4HOLuSAuL6
	 957be2DmiSs55qZ4di57CZMe0s/7e7AvtueSAmz76CLinFHyRMzdITnWuIIMBJYzEORGT
	 U+J7u3V0LkTXYBlUNH2lskRw37fBQRz9BjAyjmX2WLTYGELNGc0DjL9BGoEywRYBwOp2D
	 pD1f9jUgRymxVLZlX2Uh3+qLl5EDU36FsbEG75J929ctLmKevHsXRKC/gX6TFnQSFD32T
	 NUYBarLuhZ7FtRJzym4AB/njbtD7EgRVHiu/kR3oeiK7CgPACTR/MHk3RayParfWjyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239404;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=heCZ3eMofqJRMaoiKgFonBBuGwXdpA0ncbgdWxOVWmI=;
	b=lWseqUZ0MM2sFYghyufyyO1/1pgGndSnN30iqTEGhaUH1pwmpZ8O8inevZRJaT7PVdym
	 +k42ZT43sa70/HnmlbFnKVF69l9bDDSv72Xplf8AZiQz/3Lb1Ixd7GeV1iXNTP68qrXCc
	 s5VEQTMToLX1YeFp3j+/LmvphoHu8TBJsa6q8Xf9/HFBF+TdBd35j3McoOANvqIuCZdm1
	 yoQy5JBgMneKslO60aHwxbdNwT0gmb/cwTTb/8lqxCo4d/s4fCWN3RGq7TkLuGDxcmvtI
	 FiTnfzPfmCq3oxd9ebKpqFoKORfKsf75V8JVdWBRK72wcElU6Hm1+QgapUh3fYd0Xwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqWHOhTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 39F0C60A3804;
	Thu, 29 Oct 2026 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqWHOhTT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 673CF1F031EB;
	Thu, 29 Oct 2026 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239403;
	bh=heCZ3eMofqJRMaoiKgFonBBuGwXdpA0ncbgdWxOVWmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqWHOhTTcf6QIuZcK/x0TMs+EcUhDMPp11aPWuxXPxZnyr0IXjFBvYMG+LHgVZ8pe
	 omDP4ow7pGQx3zhqQWu4Gh8ytUqqD3TlVrwTUR+oAVMK+ntDyPIvCRoYf8l4k1UYBD
	 fE60x3cb9sdzKump8KVfJcVLpi6jwHu/DFdYgXTvaQ0XQetezeRL4yVqpShyLef1yo
	 grFjlR7qvJktrnLPyjepzb7BUiqpXd0S9SeDVXrT/zIAhmbz6fkBveZm878qYfaeUC
	 y1Fe1PBiheKQ28IYyF5rJRIVN91wbkzR419xzOCKXqty+ffSt6t1XvMT0Oh5ePxfBG
	 Ezy7vNJAJjLzQ==
Date: Thu, 29 Oct 2026 04:03:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auKpZ-BAJ3B18DiX@kernel.org>
References: <20261028025306.2063007-1-jarkko@kernel.org>
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
In-Reply-To: <20261028025306.2063007-1-jarkko@kernel.org>

On Wed, Oct 28, 2026 at 04:53:04AM +0200, Jarkko Sakkinen wrote:
> - x86-64: chunk max: 125 ms, total time increase: 5%
> - aarch64: chunk max: 235 ms, total time increase: 6%

Oops: those are for unused and expired on x86-64.

For emulated aarch64:

- unused: chunk max: 388 ms, total time increase: 8.2%
- expired: chuk max: 1372 ms, total time increase: 1.5%

Br, Jarkko
