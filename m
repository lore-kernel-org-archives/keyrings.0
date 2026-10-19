Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452271;
	b=ASNWvggvpSe/ngp8VSBvUbnMjjB5oFlomsmoQFw8TSlIFQgAyCHfvr/2l96C2EE75i9i
	 W/Hdi/w1kDe5cqtyG8XNQ8N01p902Baij1rFOhOl/k4N/9XGX39bEbCNz7qmCW69vuSw7
	 v+zdNjH7yOBWkMkjl3tVXukfZYQnYd1dbTjIsABGYiTptE3sH38xNM2tqnpEyeeaBTIWa
	 5ZxRBnYxBwjN9qEtPE11gcZj80dRhOb0X7V00VnBYPcipwq6pMiJagJ21ckF5NSxQScXT
	 8hFHfB+EkrhXZBsDLJjFdyoX5hokFnc+u4M2yB00So0k83990W49OsuqKLojyoA9t3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452271;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=10eCjaMoOwpoINyqTdOdhi6Mz8qOVskSc0NuNTtMy2U=;
	b=XIGNycMAc4bR/29tkt8xvlEzHFTvOCQFOz4CbKUOMGpXiJYRhaph97wi2afGrCBzU8vc
	 ddZukydqkutw2a1YnKfuCp49tAmAJZ1j3vFrEl2TXRJjk078exu8kNRmTi0P/8l+KnMQ/
	 qMW0GQokUHQqXyJnoUAS3y1U1ac4e7oa1/m692Cl0geecvUR9OUA2SYQyXdmm3d65OOlQ
	 DlYP6jMnZIfQdycEfR3DkwIjx3GO5wBYma8055ipde4fd9la77YNK2qXlkocicjqd+PTj
	 jlNHicnwCv3x1n2i5lBpAx9mw21QNPHfp3hX3uYWKGCSiYeADeKFm4/qrwFOnQg+neg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bakaace3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD294606A32E;
	Mon, 19 Oct 2026 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bakaace3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A71F000C5;
	Mon, 19 Oct 2026 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452270;
	bh=10eCjaMoOwpoINyqTdOdhi6Mz8qOVskSc0NuNTtMy2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bakaace39seCT2ZID1tB3Fq7vSyjpWFjZ1HVCSBHouhQEaiXt6DwJFPi2wMv8GDTo
	 RJhsWg2MonTPnBzT5VpIm1D1DY6h86io/Q2ohXeeRbA4iYGEoiFMUB7JOxG2mGI4PM
	 VK0C2HVXc/NoTGwVSAimo3rdUtPHLpjMBBO8u163fD5NHQkCWnfTNmX2gOQ5DKPhPT
	 /Tf6QO6POJMlCkzBuzAx78L5Eit3ceA7GCvXvz7Nr6BO7u/N4eKjI1IfcQ2jFUUJQV
	 PtueLnFbS0KFOToipm/sPrjw7kK0/95zodzT0B4a7InueoiFNVuI6sdpXFXShQ3vC0
	 idLxjf8bz0UlQ==
Message-ID: <f35b0ff4-6479-4670-9883-77b3f918de20@kernel.org>
Date: Mon, 19 Oct 2026 16:24:29 -0700
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] keys: add KEY_SPEC_IPE_KEYRING
To: manuelh@nvidia.com, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/2026 2:40 PM, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> The IPE policy keyring is allocated unlinked, so userspace would
> otherwise have to scrape /proc/keys to name it.
> 
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> ---

I'm ok with this id addition, but why can't Kata use keyctl to find the keyring by name? e.g. keyctl padd asymmetric "" %:.ipe < cert.der.

If the concern is that /proc/keys can be spoofed, that would mean other processes are already running while the keyring is still unsealed, which seems even less appropriate.

Fan
