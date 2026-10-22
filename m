Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707024;
	b=2ePcJWEPP/DuUHvzO8qW0Fe8JqwuDf0kfFroab+Gq3l+lfQ0OqZakozxm4Nw+/KtzpcA
	 A/6WzVsEhYS3c0PDLUROadaymAver+Y9iCFvZqEjmemfRKxOreDxPKfr/sjzviRzr8oS+
	 wvoAbpxcCaEgcFZm7fTIDi5CvpjXpAyqDv28r19GNuNqAuA09A4a17hCVQXZ8u8P3rnhB
	 xWaK7iAP3TODFamoBKCqpeuywwys4aUHibjop+WVOv4WnIO5J8ETR0trkZTu84UAkKQ7Y
	 DwQrLBJ+yYrexzH9yesHZw/vH9eNPN8dCL5Cfwp/PDoQp1ntQfXZqoaHeu5Bk0gZqxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707024;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BPD8JkJHXHODhQVF9+MgJdtTWQmQDK/Um3JEAhipQJs=;
	b=c4LAfCc26hzZW9KxmVjza0+iAq5IoIsj2/zp0Q525NBUtm5tADwr1kkuxphEY1lW6onC
	 /9d1YX51OrnVf6tBTDEaNrdLyschU6T97mfihfpaBPpbCwR7VB0XB9qEPh3kZi02+SD7U
	 gnydYrBV36ukEUr/0wHPROHZz4SRalcb+e3KXI/vBeuVqOhqHGUlEqG5Y2CF3ORW6TG0j
	 iDFi6CqnyT5zFEsxu39pD99ziYpcZ8IH+Yw0rNIoBQ0ETpbNcQpcpz8BDMzSO/zCmqAWy
	 bqoxXoV5OYyBUn7ZgTTf1+HFwiTJfVG9DpksiOwNqXAd2h9qK2lAmaRap6goztAqslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlNUlvej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2D6D7606A31A;
	Thu, 22 Oct 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlNUlvej
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7C1CB1F01825;
	Thu, 22 Oct 2026 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792707024;
	bh=BPD8JkJHXHODhQVF9+MgJdtTWQmQDK/Um3JEAhipQJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QlNUlvejXTz9i/tJq5LSyOKBcSqVisbfZC07oj6HSLlYFdHGmt3yXFIeVw8/HWzno
	 KwlTmvi9vGsB825Uw2O1xybNMPHa3XbdrJokL+chWsCFxT7Og3IqAuO+aoCrxTMwPw
	 k8g5ALRXNp+qL56olf4lf+rZreH0s7fX7O69+H27TgSP1JWQfGQ41GqZQgndF0Ovkq
	 fTJhW6S0hVCR4kkeJ8vFHMbDS5ccKCPbxTSabrzC65PmZi8V3OdU5pxkFELMDgpbbV
	 EQV4zAxT81fp8gelv8YxgzqNXO/6m7ktGz5x70lmSFSbyROCCFg1FpNaF49fO4Jgcp
	 Phdnxhyva1hvg==
Date: Fri, 23 Oct 2026 01:10:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atqJzKw12w0MFOwQ@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
 <20261018070822.GA1904@sol>
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
In-Reply-To: <20261018070822.GA1904@sol>

On Sun, Oct 18, 2026 at 12:08:22AM -0700, Eric Biggers wrote:
> Make 'hash' u32 and make it adjacent to 'is_keyring' to get rid of the
> hole?

The whole 'is_keyring' is completely redundant and more like a glitch
in this RFC patch (equal to key->type == &key_type_keyring).

Nothing wrong in the review comment. I just wanted to remark this
dead obvious fact that I should noticed immediately (doing updates
ATM) :-)

Br, Jarkko
