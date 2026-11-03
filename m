Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675405;
	b=rptzfvX2Hel25xY1Cai9sSfZ3aUSqJFsd1cB/R/NPOCxY85PuMD8vMhRn1xVaDxTNhPR
	 83C/dq+i2xx6+Wwt6CJnes/E5c/1BD8Agtam+aKsLvPQWOApJPQ410TnCbdC6nDeQDBT3
	 eW8OVi5EdHz2cuGRddYnwQ3F5Qi0c2jUshDBUgcsJ4IEdMnGarUFDCInqoJ3zRBvfDAxT
	 ECEDXP2SjZwYMeZLeZn/1wgsA93NrCIcQjQu1lpn+ANKs+r/k3b7Li4zrro5Fm1YeiXy7
	 KnD90FZKP+RgliklsKysvo+AVTtWQk2gyzopMDkDDLgV9F9sKvjidJbpB628pv5XXlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HIZyPhytodsQtEet5c9WaasuzeTpmbemDJSiVg+XUBc=;
	b=3GZsxWHpjvNMtCGhfgbsLXAqUOgvgCK9qyLNUHQeMNNGpkT2pl71hqsnkmUJQkXShyqY
	 NHZfY+AM+QKgWgDByGFfCoJIUPevXtj3wxEpicUsvle8IuuJjo4sqxBpWTrQdfMULZNci
	 6W7KGxGIeUV9jFBUtn24TwVWHP3k1PfUIPSka9WvAvHNgO8zZBjYnaWWJ43hZpkPrv7Pp
	 J7Uim+X0KWvl77QEXluV8Gs3Jc2YiLt+80kyXZznaMZKlm1WBrQZ6KCky9m6OSgyAjQBL
	 rtTYBESDnDC6v8GZmkJ6oFKFG7bBdzax0m+ocJ9+fUDMW7sg2GdpzaG74gvcAaIzlyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7hYCxmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B44D2606A324;
	Tue,  3 Nov 2026 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7hYCxmu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B2CC61F000C1;
	Tue,  3 Nov 2026 03:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675404;
	bh=HIZyPhytodsQtEet5c9WaasuzeTpmbemDJSiVg+XUBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b7hYCxmunLIBqFWXKRy2wAjYsWJMFtlFfU1W8EDVZ29Bd8bwJEpjrfWNA6FlRZFUC
	 Q+jyh8rWD+uosdb+CJby5IGRjiiym7mVAlvCmWqZimAyQAWV5VRdjTxQCMxOASuES1
	 5ennmFyWEFxcHDXKlxE0efWZCzDhIoatvVCREjCWd/dxlNRqOp7QQHe8UD0AtyfEdP
	 7D8oMauqE8KyAIMHwIijZZEBVqGAdAHDiaPNKrjMFW+7cUVPlC1NMi1M9MAlRN5OGW
	 MVUNFabGwG8EEPfotCX1r4UJSajf28/jzSdmroidu52gGsmu7+RotcmlachcNEUXTA
	 ktY/feNy6Dl6w==
Date: Tue, 3 Nov 2026 05:10:00 +0200
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
Message-ID: <aulQiGvH_Ea8Q2-E@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>

On Tue, Nov 03, 2026 at 05:02:05AM +0200, Jarkko Sakkinen wrote:
> CHANGES
> =======
> 
> v2:
> - Used v1 as a test probe for Sashiko to detect the corner cases instead of
>   trying to resolve even the known ones beforehand.
> - Converted the client subsystems to be compatible with the module pinning
>   semantics.

I spent hours poking dns_resolver. What I have now is I think somewhat
acceptable or at least any other angle I tried was complete failure :-)

Br, Jarkko
