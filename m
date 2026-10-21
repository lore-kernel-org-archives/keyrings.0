Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611205;
	b=fclzxoqPDy/ezCeAdT8hUwKfk6385bWw5nE0aEFDdmIk9GNSzPgtIGnt0WquXpzmRsTp
	 EutrItWCyXWY6P8MOC0LR47ZbzbBy8ygnJeX/xoucytiJOzkL2i4hIlWfPOAtXgaO0urh
	 c6NsRLci+RHqaKSeACRZSDoKa9uwKmDn2zvNOJcwLURsZBSOz1sj+KzAKe8Py1OgNvm2z
	 ut0hbEDasIo1HYAcw3wTApukxEss5OzSIf5ePK3tq9jYIngCTFYV1VpZX/ysnskMTguHG
	 G10fbRT81pn4yLkesSdI77EmZiCx4NY6tyRpiFQXlptxEmzlPmmuMsbYm/YPZwCeexw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b8yWziCxPxZ/ZbetLpUsalbteGE5UbPHNN+gc/KJSls=;
	b=I7iUfZAn1nuaoFfXNIoKpep82xMDLUlhPTDiGUckYbJkHAAjJA8NdG9YcngQHMIYY/9C
	 uAJZzfl4+r0Xuebv1wC1cuS8fucT81vbXQkGQmJE2jeHhgL3ikTKhftjhxnDrSj1/2t8N
	 SmV0wYpVBe5wLQuX2jVdxxnNXAfJpkwDmZCTB+57i43qSKiwGySb3lcN7Lf8pO+G7Xxwz
	 gBB622vQciFBz+IIpAtqKzxaUL99uNL5dChFYv4/4eqqLJ2xhGOe5MtuK+LSkWoIH4A1T
	 4HW1EuDPAuewvgB4m0Md+eUZCrQlbCvTS6GIY2L2KYyq0EV/XEBMCoVTxA702Ee7s2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWRYHms6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B68B2606A319;
	Wed, 21 Oct 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWRYHms6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C9AF11F000C1;
	Wed, 21 Oct 2026 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611204;
	bh=b8yWziCxPxZ/ZbetLpUsalbteGE5UbPHNN+gc/KJSls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWRYHms6wArweWHxh5+JTkyuGTS7V3wEgJmE7ExjfYPcoyxQ6LnQGcSCKd+JLAoZS
	 eOs2ZvaxhWjDzY2a168koQlUWGqh3IzENFcu3WkDpYLMLl8EugZPHvEpna1vqBUUYX
	 mWjoa6660JcIO82BEdOJD+Y4TVVZPEID4S4EXRbewedBugGioBgf4jHuDDLdYB9w0Z
	 W3Szc5A6+6cfeP4IjPEsE+t0oWgSTeQYlyRkdibyBB+MQTSPUl0gtS9yjCZ3zBABuI
	 cuFHEwPzTA0Q8kjCcTU4XGGH/RaOEYE4IjNqN8yDPoSFBy2xsYaBMWPlZfB2rl1idp
	 tmVJznRPCwqDA==
Date: Wed, 21 Oct 2026 22:33:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] KEYS: rhashtable bug fixes
Message-ID: <atkTgEwRQfh94zeV@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
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
In-Reply-To: <20261020174325.2229448-1-jarkko@kernel.org>

On Tue, Oct 20, 2026 at 08:43:18PM +0300, Jarkko Sakkinen wrote:
> My patch set that migrates assoc_array to rhashtable had some LLM
> scavegend bug fixes. Unfortunately most them where either plain wrong or
> not in the right scope. The bug fixes in this patch set are by human
> labour constructed fully but they are derived from what I got out of the
> original LLM source. Thus, they are tagged as LLM assisted.

I guess these are ready to be merged? Eric do you have something for
this revision? I already sent -rc1 pull request i.e., I don't mind
to update it if necessary but otherwise I rather would just apply
these.

Br, Jarkko
