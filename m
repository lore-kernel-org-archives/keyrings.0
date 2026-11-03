Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709126;
	b=cqieUOTrWZV1lwetVDuLV/ELvTJHQNxQZzIIAk4AmxnJTSoYI58iC72snp0vrNMfhhHB
	 kL99nfL1K6fMToZwpQ/UVyzNAqfEQTHzuhBwcVb13SVtYuX3gTUnfuP9I0eQhWOQlmX1p
	 aXsI2k+8mlbcoi4571lfmNoe2peZgwXcTPCLO2K8tBIbJ4n7oOGQyeDwF/WnmK6Enoz1G
	 mCqowUKbICaP4UOOs7Yhiyl3GE4QpoV8/7prJyC0tWuaT9bP/ZB/Q09IDLa63CGnGkiT1
	 r6PAD2wxPOajMLn9BRGRARb4kLezcKPUC78boSt2xyBFmsXLsUjXpbxgwEnZBQWxZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709126;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vNgtK7lGHCz9LwG+wPYlReYbeCzYfwEWPD3BP1IN4LE=;
	b=m73Hrn5j1fvDJbZQFCpap52J2tWawyudwZhNyc6eHEw7EfR4N9BzllV6ZxvAVP1CHorn
	 5TiArOHh9LqydUZIir+03DkMJ02VtyOV7shBb0mzS1aEKCUMCVQitDn149cyi+qXjH2k/
	 ZL2Sz5ooipSy25qNSeP4eCQogrl2fhPWvQmuA0evEfdtvZt0wQNJij9L10tbR4KKvy8vP
	 QIXYCvgibakLQJhi+g4D+Ueaerj4N/NKrPPGXSzNJN5XG01zXEh9Ly3yep/v2FP2agBOv
	 SLBRfPZ9QfmNqfugqzTvpkKdpkCOgVf+/cuAOa1Jv0z47RoC4Zxit2OPbrjn2XjcpvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mLPu/ku6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 23BBA606EE97;
	Tue,  3 Nov 2026 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLPu/ku6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 70D511F00A1D;
	Tue,  3 Nov 2026 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709126;
	bh=vNgtK7lGHCz9LwG+wPYlReYbeCzYfwEWPD3BP1IN4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLPu/ku6948/QTLgjw3vZx1vOlB6oQ72IwH4q93Gkq7etWdTAGPrRp06/Sc1dysqM
	 6Apz0b9R5xo96kSkA7eZlFfjhQ/DZ7GxfWVVRLEkfCVIxJ8VWn+y8lJO+y6v8oWrSJ
	 tG+UigoZ5V7DqLgO+eUBWd3N+pnyNgO8Lvh1J9Jn0hSDBGsxuL+VPvzl/mODJE/Xi2
	 YnXMecwNjsbsZxlqe2Xzr6rSCdFvwaNw+COXp0jLtPmnIH0lCq/26e24ylNEqsk88T
	 evBu87A5qAuhuGNHkQ0e5FNA8r200giX+gXJ5k4q0V+ZgNYNsuMYC4Vkf0QEez3GNS
	 oRNTnpSg4xhbg==
Date: Tue, 3 Nov 2026 14:32:02 +0200
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
Message-ID: <aunUQgG4CvDerMcu@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <aulQiGvH_Ea8Q2-E@kernel.org>
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
In-Reply-To: <aulQiGvH_Ea8Q2-E@kernel.org>

On Tue, Nov 03, 2026 at 05:10:04AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 03, 2026 at 05:02:05AM +0200, Jarkko Sakkinen wrote:
> > CHANGES
> > =======
> > 
> > v2:
> > - Used v1 as a test probe for Sashiko to detect the corner cases instead of
> >   trying to resolve even the known ones beforehand.
> > - Converted the client subsystems to be compatible with the module pinning
> >   semantics.
> 
> I spent hours poking dns_resolver. What I have now is I think somewhat
> acceptable or at least any other angle I tried was complete failure :-)

I have another approach that does not hit heavily on AF_RXRPC and DNS
resolver. So probably better to hold and judge the next version when
it comes out. Regardless, reviewing chunk processing independently
would help and it is pretty well benchmarked change too (with a test
that is publicly available).

It prevents workqueue lockups happening while not doing any significant
hits on throughput.

Br, Jarkko
