Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621970;
	b=rkudtd0lyqi2FuhMEvn5ej5DKU6grkDZn2tjvAE9PFq2a8s/lYdQ7N3M7nDl+F0BanPF
	 Ks3M3jgWuichUOl/RsIhbEjDrKcTh4iCsmBRCbvFn26zt7Bb8F9wLB6JJGsIJyAlHXBA7
	 +fHP+JG5TkyCfQ+r9fhJL/s8lVYbCoqmfQNEA0D497prwpfEStRB6Ha/VQLArx9sdxZN5
	 1YL8n41TZguGBIwz+DvffW202iXn9N6CMKDEJ8YXFSXo56Li7hGUYS5v0tFd+WBAsSAff
	 E0MumZSQqbz0B/KGO+75p+XP/WFSBPtZ0MUGlUVa+n0oO2NSewTxLBN9xa2ocuLLkeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621970;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BfvqbiLIKBc21OlWW9dUVyXq5aPIqBZABvNUTfTEyVM=;
	b=nIFsZYfFDl1rnS/YI4Ej/w8e1Zgn3BWnOT3CQhkAsev2mE0MRdBJx2VwWXL7rIJZM+m6
	 VfmWUs5/CN1nT5Jd21I4BXtaGLbKL5r1FlXC6B1Yc8zeYIEL0g9T/NpRThZo5xuuBZaMM
	 GBUULVc6bKfVfkp805OraCuDgOE3ggoHCEOomfAbaYsORCo7TrMZNrx5X+NqjouKsXI7L
	 1wdwlu7ufu29CAEzhYm0yrkFBza4qfPhZSe/68d2I1vySCcId+P3P5KRDx3kjaGGsQR65
	 dVY+NKXmw9yGwXXi3X5jkPxIUzFdw6LjBPSCKkH3sNS/OoiHYGuykQoVT0FMPSqvLpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D7M/LoSa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0F43F606A32C;
	Mon,  2 Nov 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7M/LoSa
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 163211F00A16;
	Mon,  2 Nov 2026 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621969;
	bh=BfvqbiLIKBc21OlWW9dUVyXq5aPIqBZABvNUTfTEyVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D7M/LoSau+Rr+G7JgoYZfNzDPNVKpsA/41tOcvUbgzAllt3YkeUTprYGqkNOLx+MM
	 c0PXOdoLGiJQo7dTcz9UU55QZ6OIiZ0A8jBCS1eUW1Pp9eq1Q+g7NCzz2A8ep3QtXO
	 gD3WLG1FxqdQiqjSvz105e0917Yb/diZ/Z8bA+MmNjgufwloI7BYj8J3qwDgykQdpP
	 UqX9J+P7U320y3oyqk49Kx8CBw8ufIO9CplUVzy7d9TX6zk9o9M47acKaPFUC/99VL
	 yfIc2K2yDxoDMnnsKjt2td38PTWD2eJ5iQok4z/jr8TMeIOg/ecuFKlFSuH/d5Vc54
	 FXr7mq6x2AkoA==
Date: Mon, 2 Nov 2026 14:19:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] KEYS: sanitize the garbage collector behavior
Message-ID: <auh_zhPyeYWspJSb@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
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
In-Reply-To: <20261102121518.1197453-1-jarkko@kernel.org>

On Mon, Nov 02, 2026 at 02:15:11PM +0200, Jarkko Sakkinen wrote:
> 1. Remove key_type_dead and replace it with the regular module semantics.
> 2. Replace variable size workqueue items with fixed-size 64 key chunks.
> 
> The first change has user space visible effect: rmmod semantics will change
> from always succeeding into returning -EBUSY when keys or restrictions have
> the LKM pinned.
> 
> Jarkko Sakkinen (4):
>   KEYS: trusted: Disable sysfs bind attributes for TEE driver
>   KEYS: Pin the backing module for struct key_type
>   KEYS: Remove key_type_dead
>   KEYS: key_garbage_collector(): process in chunks
> 
>  include/linux/key-type.h                 |   6 +-
>  security/keys/gc.c                       | 249 ++++++++---------------
>  security/keys/internal.h                 |   7 +-
>  security/keys/key.c                      |  46 +++--
>  security/keys/keyring.c                  |  84 +++-----
>  security/keys/trusted-keys/trusted_tee.c |   1 +
>  6 files changed, 148 insertions(+), 245 deletions(-)
> 
> --
> 2.47.3
> 

cc: keyring

Br, Jarkko
