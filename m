Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243304;
	b=maAB12TFO9tUhmmLzI0p/7UhCwT0pKpxCJ73sWlWU8BB/p0Wke5ShP7Uvn27wxZlQQ+m
	 gJsLN6LzU+XjkMQJYeGrU1oPiBcPTnpOYF2MW6SjOoGwdfaCV5Tu8IkeWc9EvO5Y4V/2O
	 j9GwcsFruL6OXlC4DngxnOe1wkHwGFKEuEIK0+AdKCXbqMvncV+4HSU9j96Bx7IzeovbS
	 PN2q0ZSnCr124p1pEXx8PgZPItfCRxC5H4qhG6U6RzMP+54Tj8xzaHwbOiLah/h0BE2ED
	 vgQxtQHMo8tLawA/Tadgb3GtJehP7eU89qKkqj9SrttgNzTpjJpgsua2WlS3N02wQNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243304;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RZoJfglwKFToArss3TUEpUKXU/qeKSC5zoL0lWmh6UU=;
	b=pSI+0plzfNwc7S8MFJpeSF8Z8WZx/RfeN6sT1vOfaWaZaqx2CZfeVijb3PXy01f0QG5b
	 LMQa8UVMxZR9MEbQ0UFOb15S0IZ5MMhN941yOICqBYNY/M9PIvjpzrVj2AX73RvoR7lMl
	 08fXpuv/uo2dexXBZ+YZIglmpo5zlF593o2Uj4ZTmycgUbDtQqRbOfdMCFOezPb3joLud
	 ezhJRneItHqH4xmTkNIVQ3D/vs7g4No6U16kjTKzttvxuUquYMKu46RzlT/5hrO55Opcv
	 AeDAemFK1LQkCY8RfI19XEmagkTWTUDMVLLWpzm6yt6ZwHYIe4PjSKhqN/Qao3V5OOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCucmVYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1BDE0606EEAD;
	Mon,  9 Nov 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCucmVYD
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 230751F00933;
	Mon,  9 Nov 2026 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243303;
	bh=RZoJfglwKFToArss3TUEpUKXU/qeKSC5zoL0lWmh6UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCucmVYD06Ll8e6P1oYMf2gpvtzbvYsGzZpFEQPA3eC10kS+SaXNutTO+XDxSR/ZH
	 mkf+PdJhv2uEemtkNv6fdw/Zk8xs5bWUJ3ZSrILsez3k/aLjQtI5Kop/42Ao/Mfl36
	 4fGQ0DEveWeem3njc5dSg4e5usyo4ReO2BeEwnRC88m6RXUc9Wk+w/VtJKpb0PX2GG
	 JODKPzivXOdZ2/SuSh4XLkGmo1341/FAqb6YG6l+IB5QObNrWTZYnm2MNv4ORhym5j
	 t/FFd/UL4cEqMzk01PEZs87QaXqjtqGyiJjC05Ir2y731JTpJFfqTPmezXlCR2ob7Y
	 gwkK3o9SqUMIA==
Date: Mon, 9 Nov 2026 18:55:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc3
Message-ID: <avH65PuHHOJkH3oY@kernel.org>
References: <avH6lqK4nq9j5aKs@kernel.org>
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
In-Reply-To: <avH6lqK4nq9j5aKs@kernel.org>

On Mon, Nov 09, 2026 at 06:53:42PM +0200, Jarkko Sakkinen wrote:
> [GIT PULL] KEYS: changes for v7.4-rc3
> 
> The first three bug fixes are side-products of the rhashtable work, which
                                                                    ~~~~~~~
								    :
(typo)

Br, Jarkko

