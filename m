Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884997;
	b=LnHofjv7l8jQjPS2kVRTNySp0B0N0YUCuMspypGma6mX7+ZZKY/lOr4nY+JE3uwCiRMg
	 /4MpIKWPsu9clNZKe5hffrFUhUlggSnieCfVoGr1xx2j0V1UkyVHMonsqjWIsMd7FV7BV
	 3tDj7wCvnk2Z8sImlY4Tk2m5flUaThAw5gdg6XvQUu6nX7AExOw1FDLxSt1CszazcS70N
	 BOpEKZAFfG2diplQNj8MYWsk9KeO9i4pFEEZydcL3iM6RSgv9s7OI+IEBgX/k/g/4Sn7J
	 FYNtxnMBihd6FArPGwnu3Su5MrM3Odj8DkFhcjYnwd4o7zs5CtplwJApB6rq45le9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884997;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qkZnkw+5zBWFqI5K5yP+g+0eLto2V0Whflqb3Y7dqZI=;
	b=3TnOp5GgFlK4QZom+CebIVeq6xxCz+Z6aud2EqvE+sRrSsdA9kAmu0I82Da5uuDJi/2L
	 3Ce+rihFRlz6g096HotAyIBQ7e5lg7OrRLrkizIHh35VC/u+dkIM0C/9S3RdiJ+jFh5Kd
	 RZGlJ2Ncy87ebzWkrUwOyxQB3eHuS2mO9xH5HS4c2ej6g5tbE4z0FMprMnyptaY2JDzBO
	 6xEaRqTK2InszbyDLurNORQRbdz7F+D2YXF1PWSKJEEfnwoL00nuN32Fg/dC3cyPkwSn2
	 ihewa6Qb0i7U6q7S4vTZTUsOTpWWTUAM+pL6ZQ69VaxaWlbB5Lg5OZqdPaoD+OK1Pxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9NFT5pV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1FB1E606A31C;
	Tue, 17 Nov 2026 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9NFT5pV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6BE111F000C4;
	Tue, 17 Nov 2026 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884997;
	bh=qkZnkw+5zBWFqI5K5yP+g+0eLto2V0Whflqb3Y7dqZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9NFT5pVuRPCUM8ib39qQwpY7mzfKcZ46mlEWErdcHO0bs7rSNK1+TZ/kEfuKsSCz
	 XvyccbJCcH/Uw3ekVoI1M84wEoaUyjV6OX7LuWD8Vs60HZAKT5SIsULUkn5SayonqZ
	 vAAfot9T7AZk76I7eVvlVlHqgGXTMK92HPPSgoj113hRYUdGDVos0Z3vm8tdmIBVqF
	 zShWMvhrmxkMWePQ7qSc2bcjbTI4W5eHxy4bVCmEoeC+JO22uZmanBQG9euci1QzAu
	 2HpO+TxfsPPwNEJ67fo4Y6WYqpQWiwWnb6iGDw1k2RDsIGUa5aYvGQxtq1YiPssI3G
	 B9uODPGyz/Kuw==
Date: Tue, 17 Nov 2026 05:09:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: William =?utf-8?Q?Chuang=2C_Founder_=E2=80=93?= Logarcheon <founder@logarcheon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lib/asn1_decoder: add KUnit test suite
Message-ID: <avvFgRqiYnBo9Q7c@kernel.org>
References: <20261117001711.47722-1-founder@logarcheon.com>
 <avuumVbCS2YQi4cv@kernel.org>
 <wzMUBnLl6Z2s-eoaXFHCl92wV6voRbr7imPSy9hdJzHqoxg3869_lCqHtMa3G5N3H0G9XfrGCW9Nzw0Vm0HCJhvNKkTUtUFDXuM7S821AIU=@logarcheon.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wzMUBnLl6Z2s-eoaXFHCl92wV6voRbr7imPSy9hdJzHqoxg3869_lCqHtMa3G5N3H0G9XfrGCW9Nzw0Vm0HCJhvNKkTUtUFDXuM7S821AIU=@logarcheon.com>

On Tue, Nov 17, 2026 at 02:39:37AM +0000, William Chuang, Founder – Logarcheon wrote:
> Fair questions.
> 
> Why at all: asn1_ber_decoder() parses untrusted ASN.1 BER/DER input. X.509 certificates (keyrings) and PKCS#7 signatures (module signing) both go through it, and it has had a length-validation bug of this kind before — CVE-2016-0758, in asn1_find_indefinite_length(). 
> Scope: the suite checks that malformed and truncated input is rejected rather than over-read, in the cases it exercises. It does not reproduce that CVE or prove the decoder memory-safe. That it isn’t vacuous: I weakened one bounds check in asn1_decoder.c to allow a short over-read. asn1_test_truncated_content then fails its return-value check — the decoder accepts a truncated SEQUENCE (returns 0 instead of -EBADMSG). The other 12 cases pass; reverting restores 13/13.
> 
> Why KUnit: it exercises the in-kernel decoder directly, with no
> userspace harness, and the cases can also run under KASAN/UBSAN
> (verified in my config). It is deterministic and is not built into production kernels.
> 
> Why in-kernel: the coverage travels with the code. An out-of-tree test does not run when someone changes lib/asn1_decoder.c.
> 
> I agree the maintenance has to be justified by the coverage. If the current cases are too thin to carry, I’m happy to strengthen or narrow them on your feedback.
> 
> Thanks,
> William

I'd start by learning to use the email client properly at first:

https://docs.kernel.org/process/email-clients.html

Br, Jarkko
