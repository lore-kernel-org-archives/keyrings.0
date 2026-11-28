Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861395;
	b=wT+iyQ3YFgkzz9MhVZdwaZPKrXDPqKLQ0FZcSPqqriMc9rgD0e35uUtFCDfKuRLlfMWD
	 u8K2Yc1S/Mfk0Le1NPKh8+dH8sEDqiZLyC2O4smnx0V+9zOft0oEsnfmnWW0ujD77QyZZ
	 NSrHxv5rP5tXPZ+WhhKJ/Zq5p17s+BTOA3obU8bVD2a2zL40iJH/+8sE0F3Z5qcMWlfCY
	 U4uFFF1V0FTLV485r4pjkTlaPSZ9jrYXQ6zW+s3Eww7B56MIJBZHYKgUiaUVP5DQ0bnZn
	 DdOF9h0u78vFHsOAHLeexQqSRmJ1bNEtEOAc28ekbc2aA4yzE7J9cLkA1znd/bD/pOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861395;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/w6InKM/6AK1arBrGsZ1kaO6gqY5Udi31FAyUNrk+/M=;
	b=hKedCQsLMotr1MjP2ttzCrCnHhPt2woY2XOAZRoAzsIbid+++fpYqgczCvoBRxMvKmQ6
	 RRFsNAU7QZBiRtm4c/QisCMz8rQ7v+P7/Gw34p7g/w2J2otC+Oyk5feV7nvEfXDx7/FZQ
	 PLhZ7ZbsirmPtr9e2ILMnNeb8xuKvRnABahOS0v7V6mWxP5NHTPsbo3UiJhPKg51FSCl6
	 T37q2rtgRAWquQZsmM0toNH/ozbAHEjnBe6bMUPvy+ndoaQ/0GA1RRmx9KpcUElhR4LKI
	 pBW1NetjZWQze27ZXS+hZ6LN49JA3nkL2IMZRq7MlzlEcchie8pQC53NEdChWA27k9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKZ8GsfO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C3613606A31C;
	Sat, 28 Nov 2026 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKZ8GsfO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CEFD21F00893;
	Sat, 28 Nov 2026 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861395;
	bh=/w6InKM/6AK1arBrGsZ1kaO6gqY5Udi31FAyUNrk+/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKZ8GsfOCAkHPFr43+N+AhGdika2Q7dZn247Ftm32nCQRflhvf4S1WmMXDqDqrgOe
	 2wKKfREKtuyz635yhoy4XUw49dNWtnJfB+c4TzkCrxVsxgrthbTv42UHolW+jXtj9R
	 kR+AyWcY5Ak18V78nGgzL7CCtv/4nIKGlBSMdiKusta7mBCnKqpfHVGZ7CwrOUgzIi
	 avQvBzIH9EigzVfu1TuT8ZQxSNeRurBSPFb/acjP/mmgqhd2cQQNh5+5PkU5XjLZy1
	 zOXQArvAJLhyWCEj6wNrHOD7PUjSbNgwoSLrySlEWM+xNg7dNsobAC8RohBhyzdfdB
	 hY1vs1/DgMmuw==
Date: Sat, 28 Nov 2026 12:23:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 2/2] KEYS: Reject keyring creation with overridden
 credentials
Message-ID: <awqrj3Hhb5UVQZMa@kernel.org>
References: <20261127121433.2400766-1-jarkko@kernel.org>
 <20261127121433.2400766-2-jarkko@kernel.org>
 <20261128021108.3171324-1-maguicai@kylinos.cn>
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
In-Reply-To: <20261128021108.3171324-1-maguicai@kylinos.cn>

On Fri, Nov 27, 2026 at 09:11:08PM -0500, Guicai Ma wrote:
> On Fri, Nov 27, 2026 at 02:14:32PM +0200, Jarkko Sakkinen wrote:
> > If the current task is running with overridden credentials calling
> > commit_creds() is forbidden and triggers a BUG_ON().
> > 
> > Reject keyring creation with -EPERM when credentials are overridden.
> 
> Tested on the same arm64/KVM KASAN/lockdep setup on top of patch 1/2.
> Under override_creds(), lookup_user_key() with KEY_LOOKUP_CREATE now
> returns -EPERM for KEY_SPEC_{SESSION,PROCESS,THREAD,USER}_KEYRING
> without hitting commit_creds().
> 
> Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
> Tested-by: Guicai Ma <maguicai@kylinos.cn>

Thanks a bunch!

Br, Jarkko
