Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879134;
	b=XeRu00XBrwT6myNNBiw6mnFMTabVk6Q8YotpWJza+a0cfeJL3/48jGDQQnYvcFNNZQEF
	 Y9MA08VPhf9hy6VbrCpNxmc55ofzz6TW8yMtjLsixF2KeDrR5F7GdB0iDAx6ytEnastqP
	 CWWB5drxoagGER6c9mWdfK3NRmpfvZUn18RTFOp9PDukWf/Cwnn8F7hJFDHOAEX/TXYIM
	 bX84nW+xXn01/ypu6UBaRQHb5nVq6CvdbI3Mk/UMk5H5AVGg/K42Gx8ZdH2m9EENfSM2o
	 vlvG8+fUky/Q+Z1QjpR+ARUjGpJhf1L7j4LhcEw4G+O4esIgEpIRIqCNNSWHaoFeltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879134;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FSATrtqTe+Hp8ZTFCzKXdijMWCUS5fJG4ywDZMNT+98=;
	b=b70sGIQntlrUqDCo6eBt+0pFVEy4sEDAzG9fmZxoZA7lom3C9w715Di5LE7suDVd+RUT
	 vIAL1IYKzIWwb8CMiwygbTE1cj8ZL2gtglnPVhQURMoss772T4AVylggXtxwqX1dhLsTA
	 ShYxTYY3yNL+RO6TNR+7uEId9lvDZ4mfJi8PngWmRiC80ceRD6wKBmUZWYbtRNu3SzKX1
	 6mSu/6nuIWeQB+pc3qcZl6/QzjOjtwz3tFXCLpLnZZ/m6z1sm2Xp3n9fqfIBKjQOZR9r1
	 UOxx/GVYa2I7Wi6EyCHF18SQfPuvrv+YygtmyCvGF5bH20gQkhygx5F5eIZ0PmUJRZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PW/zG3x7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EEB16606A31C;
	Tue, 17 Nov 2026 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PW/zG3x7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EF51A1F000C4;
	Tue, 17 Nov 2026 01:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879133;
	bh=FSATrtqTe+Hp8ZTFCzKXdijMWCUS5fJG4ywDZMNT+98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PW/zG3x7Sxhqm1odMXLzRLWvcJS+wrJ1Ndam7vElrOL6TAyf7YglRIsywE1X30wQi
	 iC6qct6DNtYf4tyq7W6X2KrHjOnuMXyeDeAFyJvEaVijqizs2bGy5nzGr06SkJG36I
	 JDCcxfwtoKy1v5HIeKOWYG18jBZ0+QfFLTD7+n4JrwZEkZ87sJFVgBg6bKUDx6f9Mu
	 7aL6AFsFnqr5AOwXfBAdfWN28JBsa8UV+Dzx+/JgMTWHNFcyXiEKNcXNDy82gvaNWJ
	 7z6G4/to+/afx8E7+tw7k069KpzKLPbrsya4IqevqNbNiVc87BEGRFpzY57j0SdBLp
	 aVwaV/lQ8papw==
Date: Tue, 17 Nov 2026 03:32:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: William Chuang <founder@logarcheon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lib/asn1_decoder: add KUnit test suite
Message-ID: <avuumVbCS2YQi4cv@kernel.org>
References: <20261117001711.47722-1-founder@logarcheon.com>
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
In-Reply-To: <20261117001711.47722-1-founder@logarcheon.com>

On Tue, Nov 17, 2026 at 12:17:17AM +0000, William Chuang wrote:
> Add a KUnit test suite for the ASN.1 BER/DER decoder in
> lib/asn1_decoder.c.  A tiny two-field grammar (SEQUENCE { INTEGER,
> OCTET STRING }) drives asn1_ber_decoder() with well-formed and
> malformed byte strings and checks that valid input is parsed and each
> class of malformed input is rejected with the documented error code
> rather than over-read.

1. I'm not convinced. Why overall?
2. Why KUnit?
3. Why host the test in kernel?

Br, Jarkko
