Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622171;
	b=N14Pk7iwsHiGtHDQ53ZJVwiV5cU8xjvmX7B2eoheVyWHqji5mXeJ2qflB0QBlyUkerzI
	 i7Z6k8ZS2Lim9/6fl37F91XMx6rUs80Q6eOXqg5sXaeDFAlNw2VLvqcn4NKMrqvR+wUJo
	 bJRR4t3YvCRDOzRF7Sbr/WkqaTdrxWS6Z9F7kVbHhmzSBijMx2bbHprn4YEXwTumaL0F6
	 L7lbn8igTVaCcFtydLzLTG/Ppkv4TkY7ye293xbWXr0FvtHFPpgFsi81x3QLLlWD3JEH4
	 wgmcteM0aqig/+VePqk+xoZ2Vi1FYUSBeKwcdTNfrE+xKjPn97oIoGlY+VyzzVnMrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gepjhEh5Sov+Q7ZXXNj29uJsGq+uGav7cLAnMb9XsEg=;
	b=mm1L2fZizYbPAs6Gdj0gDsmlKgb2HE4Qz2fx9yAQF/lnjxIZKlo7PrcJgl6w+0SeH+0A
	 hpHkNlBkWJkT7OEc48C+xW5ERUMFpNFg7mLPLGe5P2Id0I6z01qV6+NqofHBZYLb9Yjj5
	 AjOp0eGyiie09OC58RoFMujVIwBKNfEL2LRNvUB1NqHW/5Lx3h0o+5aZv6dNYA3a57b+V
	 poNJee+TcQaOYjgdFW9cycARzrXCdcRFGWOv5NseMKtB9B4wCd9LekRBQXxPEwEVDGvh1
	 uGPu9mx3L514trrPXEmm58gVJ5WIbnAfn49qiesw6/bFdtA/gxCT6FDjqBch6FmhVWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vGAKyc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5774606A336;
	Mon,  2 Nov 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vGAKyc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1FE2E1F00A20;
	Mon,  2 Nov 2026 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622170;
	bh=gepjhEh5Sov+Q7ZXXNj29uJsGq+uGav7cLAnMb9XsEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d7vGAKycyuLLecvUu89gLjDJ6QO09PpM4G7Qn88jrm7im/52Eqem9mzUAAseoe/OQ
	 RcV/5wNmE6BTbAd6UdkWrr/cmLCXR9sjUAyAKX/GBHzgm71SCmjnBmUFaWLHevjpXo
	 HpXP+w13Z4dWFXoPoJWu7gO31YcxTSqv26l10fFtCWSUPjXEeujX+t2hE3byIziebn
	 /0C1od3lyvs/O5eCXxl7qx2KT4sYy3ztYU2AeIlZLtH69yyqgkCdjS4FhHsaYbdm98
	 nRa2MzOuPp6Xbq4ivjYeSiGAN/oZSru0ZJ6G65iB4oSiiDqwK4031kQPr+jr98a43O
	 TzYSun7uSI/tQ==
Date: Mon, 2 Nov 2026 14:22:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] KEYS: Pin the backing module for struct key_type
Message-ID: <auiAl6vN0ZRYa3ET@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-3-jarkko@kernel.org>
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
In-Reply-To: <20261102121518.1197453-3-jarkko@kernel.org>

On Mon, Nov 02, 2026 at 02:15:13PM +0200, Jarkko Sakkinen wrote:
> Add the owner field (populated with THIS_MODULE) to struct key_type.
> 
> Pin the module in key_alloc() and keyring_restrict(), and release it in
> key_gc_unused_keys() and keyring_destroy(). These functions are the entry
> points for keys and restrictions.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Missing suggested-by from Eric.

Br, Jarkko
