Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646722;
	b=xEJfJC4CH1O66wBtOC4VPlKpaQFDe9Em8Ye8JecNQgp/Feq706Djnd7A0D3t7KgE4WRV
	 WF4hqeJYhooAXi/yUzuEdXSPDcyLwifI3v9eYbd50bjDXYx0XnkoDd+E34WGZwHlJZb4z
	 JryNxSw9g3MhwrXIBO1qVBUsgk/gehcQapiU4yJmy706LIS2lkbmyPPSAn/5HgeXIK2ct
	 LbtsOvfmqfEnM+pY8G/xJh4S5pnSJ3Z5IsqT4no3Jz1Hx8sFJ6nNhT7oFbMku7erjbEQ7
	 qYOFMR/IiChPPnrZ7KY+rfmdSNBZ4lNOT+YHBUJdKOzpfI7CR4j8wQ5aujvFwgXYrsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646722;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VGH3sFmcU42qquXDtYciNX5LxGHJPncSwjL+hwrb5v8=;
	b=BJsm8g3e0CNh1kP0MC1HyFhVLuafxwbytL98seT+rsIAaZAXLzFywh6RRfvvQlUoUrUB
	 hHu5QZ3DTZES20HMXVhRNfAVZXOp+rIsmyxkzq9turkpbyPAVQir/JiALjbZIAD6mXMuk
	 XdYC4aio/nZ0lfuF23DITSGy7ZqWl09SFdcNLEhkT0iXa8MtFS9zGnxJPywIqM2DQcNFm
	 oK510arAWCe1D+qJr6bslBm9qrz20IVdrPCLCOP7fFLJxZ2sFQZNO/Ruazqz6YiugHB3U
	 wmkImCiXvAxsQ8J5sSEJLnKZV9nfkvbPidU+YoxtR8xhPwEAorwDWoMo2iOB22Y6LcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhTfE57Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 916B1606A31E;
	Wed, 25 Nov 2026 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhTfE57Z
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9194B1F000C0;
	Wed, 25 Nov 2026 22:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646722;
	bh=VGH3sFmcU42qquXDtYciNX5LxGHJPncSwjL+hwrb5v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhTfE57ZcqtNqq5+pKkkGtrrjM29O8jJ8C1zbOwwMxjnO2tEdcIIcWTiWk1mI7HkF
	 geG90xVYhlg+5RG5VlV+n5MQ/7uU2P1PssH6pZCfjRnNrfq+y59cG6FkRu9ytoSBVP
	 8s42EfZf7L3KjSdKA4I27plmGH2fiJmoF2916/GPWUZNO6fTXq3fMY30Bj/QGMCzDA
	 IX+KbmJFskcvq42919LLXe+U/gKP/NfkJod2sKtgtq5OcaoYUNVUqP476ZRSo9R+ES
	 R13SP9PEiVdpfcYbN8TiERoRTyhZRtbxVi/GvVCWCZE633xj/zsd2UVmAIWU2t8s2L
	 WffMwhIz/0qTw==
Date: Thu, 26 Nov 2026 00:45:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Guicai Ma <maguicai@kylinos.cn>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: Protect key instantiation and rejection against
 type removal
Message-ID: <awdk_qvF3eAjhSFb@kernel.org>
References: <20261124091243.1019217-1-maguicai@kylinos.cn>
 <20261125032605.1327954-1-maguicai@kylinos.cn>
 <sashiko-outbox-232506@kernel.org>
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
In-Reply-To: <sashiko-outbox-232506@kernel.org>

On Wed, Nov 25, 2026 at 03:48:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] KEYS: key_reject_and_link() locks key->sem with freed modular
>   lockdep class
> --
> 
> commit c70f356b6ccdc592f27c6c5e32e3b0a02a265eb1
> Author: Guicai Ma <maguicai@kylinos.cn>
> 
> KEYS: Protect key instantiation and rejection against type removal
> 
> This commit guards key_instantiate_and_link() and key_reject_and_link()
> with key_type_srcu and a KEY_FLAG_DEAD check, and waits with
> synchronize_srcu(&key_type_srcu) after pass 1 of key_garbage_collector()
> marks dead keys.


Please rebase v4 onto linux-next, or my master.

When 'dead' is true in key_reject_and_link() under
key_construction_mutex alone, clear KEY_FLAG_USER_CONSTRUCT (and wake
waiters), and invalidate authkey while leaving key->state as
KEY_IS_UNINSTANTIATED.

wait_for_key_construction() will then return -EKEYREVOKED via
key_validate().

Br, Jarkko
