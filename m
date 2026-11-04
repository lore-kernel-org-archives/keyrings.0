Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803799;
	b=5aiDr+Ss2nOdUbfu8fUy6bqkD1gqI4mEXLyY+nBb/5P1IYY1AulnlqOFT1Ym/7qkwVFV
	 yz/hkN13m4nKEDr9HaGi5mzhaE8v/4hD6HY1/K80tWt9Ne+uZH3bPL4z0PMcv1y5jf5st
	 +P8sWTuUnv/BUOqKtxBD2bq2/D0JCF5KSQhXO+ZV1k0XQGZ+RIa7yhXZnwStORa1694d6
	 jJmky93gNOB4kgfQ1j3nclInME5pZApbXhqzBDFUWC2QS7QqGpbRHxX33U3eBDA1EoEJt
	 ju7OiK4IiOLgn2L9kZbcN+rK3/6Jy1mF75DFpWm5GVustYWh+M1c4N0jeUF985o+/3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803799;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nj54x/PQdCgAxP/mlDRhP4+MFQGS04Hb6AKl7jhv+pk=;
	b=w32SFoLvB1Y777Mv4qb7uW2HpcHb4mJqV5XHUBdIIuWGLIlukArlFxXUfg7xdbIxJxLK
	 7VpCHO/sJ4pJkhoMeiFt5eyN33/fmtUSpHMJwKCJBvDn5CIpFZivR7MvXv2hRLx2obTLX
	 j8mogGQ+qannfk89zCdKc6HyyjB0IGbajzU2ShOeL6pTtNy77N0fl8C3CQ6NtR5g168D6
	 LSJTVq2uKbSM+RVJvjzGNnD8jSLZi+/ycS4SzBvu7PRzhi5AfPf4ZCdNmmEKSuajX3D8i
	 XmveI2KXm3galIGdj5SBOXHkUXeyff2LjPEQ+VrSTbd0j1vOx3cT4Z5Wok71sUYW2Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuEPdpeb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B3A31606A31B;
	Wed,  4 Nov 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuEPdpeb
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D7CDC1F000C1;
	Wed,  4 Nov 2026 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803798;
	bh=nj54x/PQdCgAxP/mlDRhP4+MFQGS04Hb6AKl7jhv+pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GuEPdpeblNIZZEPu2ifH16aCWebHTCYB3smAwlR/AXyp+TJESinIa0Vfik3JWt1/C
	 0UsJjbplxrG0JJgz/hyOWsrwK+bzcZPLiHl2lpOd/ftlGWd0OyMY11zH/uqre1D7Uy
	 +Y1Emxiux9evaxMo5U1xW2gf/LWSVi83mv51/2uD5DoBEJWOZOZXWVTf5vWByY7+Y3
	 I8QesgFEeWj9oEEh2keVirWcTnrIOStOmkFantGTIGLkUhskO5n7vt366Y9jUO+It/
	 WnEOFAXjPbPialw9fPWbLw5o3P1sDJ+JgkG7nTp4EKp1CLxqO6KPB2MCkUpU05Th63
	 YVoSSxRHGwu/Q==
Date: Wed, 4 Nov 2026 16:49:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: BeaCox <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type removal
Message-ID: <autGElNh_zwYK6dm@kernel.org>
References: <aun7J2NGn57RGS5J@kernel.org>
 <20261104021414.50696-1-0xbeac@gmail.com>
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
In-Reply-To: <20261104021414.50696-1-0xbeac@gmail.com>

On Wed, Nov 04, 2026 at 10:14:14AM +0800, BeaCox wrote:
> I saw your "KEYS: Pin the backing kernel module for a key type" RFC.  If
> that lands first this local fix should become unnecessary; I'm happy to
> rebase or drop this patch, whichever you prefer.

So that will never be backported so in that sense fixing these issues
is fine.

Br, Jarkko
