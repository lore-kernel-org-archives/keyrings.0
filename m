Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709001;
	b=IXqwol0dYh0sHKfwzt6w+EuGhr/RnxD3/Cua57zzDI9833il5WWn3UFExMwMOpk2t3YE
	 1l8xCeimC4oWeEsQmkDcEOYHzQCajDQXX9QXIupE16E5vErcN6W1lVZ0klyFT1GMMAA0g
	 pNfDWsNAgwqAJjODel7CZnp2T4llYRO0tTDo0OQ6VMBgo22RlOlz+QFhJe/Q1fK1uOT/C
	 FibvgqDxuQH9C14+TVKMSiiiNWg/b8kaKKqjko9VekjxK5vrJla0+iwvt+pXAdLsp07T9
	 9SfWw2npnZfiGhfqTWQBWBX0UTu9EyrId1bLjtu6w86M7VoKTPm60Chsy4KqZwlPONg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709001;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=44+itDmYdIDZq1m1y3tMLBmpTy1usswVb9CLkDorUXk=;
	b=ko2mYiW/JKwRtYsmsUxEynu0kGWAlt5ElEGvvSWXzFOXDf7a56i8ZENuiHBF/5tmsK2S
	 Uv/jG+pQlTTIHvZqtWuWjkBb+4sPP2q2AyefTTlEFqGx/D/okgCRn4df/b1hrm0km6lD4
	 03LiMgHeiKKb6i9kpz0NW7YbqYENZx5WRCqCdDqK1xLqJOup8JZcLjfbzoBBOsCNTXDqS
	 Q1e2mphXDQ7h0/IcWHc7mafEh48rZXVoqq/lkUf5kVEhvMX+dXW1Jv/S73UzdE09PHwZP
	 9Vay9V/M7QBYwxQBH/LjXan4XdrbPWoOn8gHWs5t2q/s24MJOTyEMj6NXlR/F6YtgCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YxL/fGey";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F2353606A31C;
	Thu, 26 Nov 2026 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxL/fGey
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7D4F1F000D3;
	Thu, 26 Nov 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709000;
	bh=44+itDmYdIDZq1m1y3tMLBmpTy1usswVb9CLkDorUXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YxL/fGeyNanXqI/SWB0bmXra+66k/Y0eoThFxEuDWTtG8VnilgB9tDBnRVSh5ro12
	 tb3FWEhuSM9OkwEMaj0sUhydCFW4+f9dGYKjWmx6rSl4xVZ/Dx0BKas1TwpxKrNckr
	 Q5Q2jHqElBcmlvugK9UnGuv5aMiknonIwrvtaNayD+Z9sHM0eOCeIriEfGe2nxMI9M
	 zebQYYTRXidZQSVdQLOeUC01YN0vxf7yvgxGkY51Q7fUae2caL65IS688YWbQVaLGw
	 DwO3rCLnvnfQpLa8zeAf/Hyd8dIwPtJviclkObHpHTpAjBm0HZtIQbqpk0pydj5pzc
	 jDisSJIyHwVkA==
Date: Thu, 26 Nov 2026 18:03:16 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>
Subject: Re: [PATCH v7 00/14] nvme-auth: switch to use the kernel keyring
Message-ID: <awhYRJ3mktQEcQOQ@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <awhXg41rBQL982qk@kernel.org>
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
In-Reply-To: <awhXg41rBQL982qk@kernel.org>

On Thu, Nov 26, 2026 at 06:00:08PM +0200, Jarkko Sakkinen wrote:
> Without looking into detail to the changes, it'd be best if key type
> semantics would align with [1]. See the preparation patches for other
> subsystems.
> 
> I'll send updated patch set after v7.5 merge window. The only reason
> I'm not moving forward sooner is to gather as many bug fixes as
> possible for the "previous world", which LLM bots kindly provide.
> 
> Otherwise, this needs to be refactored very soon after the patch set is
> merged.
> 
> [1] https://lore.kernel.org/keyrings/20261112040242.247168-1-jarkko@kernel.org/

I'm not saying that this could not be merged first or try to put that
type of causality in place. The point is that it would be best if this
was prepared as size-fit as possible with best effort.

See e.g., S390 changes in the patch set above to see most complicated
upgrade.

Br, Jarkko
