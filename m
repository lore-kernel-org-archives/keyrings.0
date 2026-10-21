Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590689;
	b=kMY1Jgjg4QzmmgCVbYarIDxUGsFv8iE42H/ed93lif9x85KRWdtQOvYOTq8bPtFfNNuu
	 JOl1uT5o508CLrikJJ6KbJH7PNyuqpMEtyf8Rfq4kxSNBgRZhnOwFjncacOw43MmJuNTB
	 zVrUasPgJm/+sWQ1xnejSv/DNaz/XgtD1wyFgpDeOecnUslzRpfK0wvC0WkIdJQY6iqgq
	 Osoy89JQ9bQ4LB547sKorPUtRZlIqj56RymNwdXnn1tfY6OIsyAJn6dg9iUG79V/MM5fY
	 4D8qNqNwRn7OP5Jb+P/uGL77lnAGd5n7i9iTsNe/WZ/TZF1eLuN66fejy0kSf8lzMpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590689;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Xd64Zq1uLWmEwdyiZowwwuTEWgkyHj5f3A34g4v8y3Y=;
	b=4eZ5AlifmnzdEaVbH4A2k+SwGPdBk5ri+bEfU6FArMXhC4OoD+z0HwCFrYxq6+cqyd61
	 IPWhzh41oucN2w/tTP7Dj6qFrLcj2n7q7wlTgycAj2i6bHSTcDPBPCbJPJFmbHfcoKQ+o
	 fjNdUMm5vzvGRO4ke7p84VmfZB3ZDxlO1ZRQMpRAPZvi5h/ELZh1N6HctYKADhU59mmub
	 3oAejUU02++YF6TRGzIWYA+de2sYko+mW9p6mYg1HYw2euaHOdnb8B2pnQX8Mk+k1A810
	 IBgYBPwncCEwkkaKmMyO+SaJhrZtbZ0+yI/mD0oeajaG2nBmTCJLtXjLn5nsX3o6lsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M38LlApZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71286606A31B;
	Wed, 21 Oct 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M38LlApZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3548E1F000C4;
	Wed, 21 Oct 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792590689;
	bh=Xd64Zq1uLWmEwdyiZowwwuTEWgkyHj5f3A34g4v8y3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M38LlApZrpXFiacDZE9ySkfj5c6ajkf4gvB2Pa7UUmcfbUdqoBkwfm9zRduZknNMS
	 MDKf1B8wmRO7vwOEnU+kygKL2NDifbyMGONaEmViNUn7/ga960ByN0Wy0Kq5K8C6Uw
	 ribD/vGXNXFjZB1X2yzgkLQ2TaKHJ/vqKVEUA5ZE3bYwQ4ZpH4uIRCLVF/hYmNddQE
	 t0yopF93FuxlxVCpLWJ+ZuDVmaLXRuJg0q9rpdOVEdw5f3OgTltq1NPpJHm0M2EavE
	 kTdJGtHHv3sdOsGbXzbJ/sCcxY1MN3W68nPUGdp8RQfvNknWSekMzbMxVB/r7idlPE
	 L2joG/asf4NKg==
Date: Wed, 21 Oct 2026 15:51:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Fan Wu <wufan@kernel.org>
Cc: manuelh@nvidia.com, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] keys: add KEY_SPEC_IPE_KEYRING
Message-ID: <20261021-kerbholz-kindheit-skurril-c3ebcdab0653@brauner>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
 <f35b0ff4-6479-4670-9883-77b3f918de20@kernel.org>
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
In-Reply-To: <f35b0ff4-6479-4670-9883-77b3f918de20@kernel.org>

On Mon, Oct 19, 2026 at 04:24:29PM -0700, Fan Wu wrote:
> 
> 
> On 10/19/2026 2:40 PM, Manuel Huber via B4 Relay wrote:
> > From: Manuel Huber <manuelh@nvidia.com>
> > 
> > The IPE policy keyring is allocated unlinked, so userspace would
> > otherwise have to scrape /proc/keys to name it.
> > 
> > Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> > ---
> 
> I'm ok with this id addition, but why can't Kata use keyctl to find the keyring by name? e.g. keyctl padd asymmetric "" %:.ipe < cert.der.
> 
> If the concern is that /proc/keys can be spoofed, that would mean other processes are already running while the keyring is still unsealed, which seems even less appropriate.

Why do you object to a reliable and trivial way for userspace to
interact with a security sensitive kernel keyring in a dedicated
reserved namespace just for this purpose?
