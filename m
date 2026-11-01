Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571323;
	b=4+OdPu1jRWjsp1SN6I7DLiz8odBNwpV1qU9E2l+tgPBjFFXzwzXbdbnTwuBcqvqinVCN
	 XirusC8gusP8diIp6qCEs4mO1vxjEMbkVBq1pSmCnKCGhaauO7JP1gmBpG37HXK8Zb4Vn
	 bvgVcf/x9dZWdLVZr/ud1gXle7uSBCsM3+YvPdRlIuP+UMT/LVemcT1Mu+yGLRsQzxydw
	 leRWN+GK3kDZbWUgnAat+nUEBzXS5APuSNxBE8H/JcdDW6OlCAMfj0XAgJnxuWZJtr6dS
	 c5rGIX0IY9OR47Z+IeUrpsUa3KdmDucTFZ0/+/xhW/TZyztLcqkcKM0SvsK1tmu0o7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571323;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=my3CA61mY/1wZ7LAKREqaXuJzGaLAWtRNSkSCjpW/eE=;
	b=xNuon4swn6/cQSYZ2huuQR8WgVJxuGG0Fd845rDEmaSp4wlOmFZrLSAHn4jdkjSwuKUP
	 BuwrUKe/7DPGjTemfuuV3/ISnegNPwFw8Zwsk6SQQvRbzp16Gy0EsDwx3nplbHSp2qAiu
	 UtbVH5D7jTTpVgVEv1o93HAwImyxZhqNvhjksrrxuwk/lLSh+z55EiVoot+yFCi+ccqy2
	 qc1lIIo5E32PsJHtyp32lBsP55M4P2npqun4U1WlQUWqsFjNXJaAY7oUCKwy6uy9GC3MA
	 vqvo3BUwLUoPRePsD5JBrBeLX34MDTIXTjEj/ibV095mOe0MgcWBAsa4yE/A/da4nQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ObXWC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2A606A330;
	Sun,  1 Nov 2026 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ObXWC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FE81F0093A;
	Sun,  1 Nov 2026 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571322;
	bh=my3CA61mY/1wZ7LAKREqaXuJzGaLAWtRNSkSCjpW/eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k7ObXWC6zlhzgQJ8mF8kh/UBP9R0v+gM6DTg5cp//WIM2AV0REv8Bmpq6Jh4og2VY
	 la92iMIbp3BuD1FSNlJ8cm45r9Xli1LPuqdss7IdHGMr5ymi6RWwuFwFzGc8BNz5rc
	 VCwALBUgNuqknU9TF7IVWa2CXsgwqkGzFLvq5MGAsLigS6dXQTuHeBbKgWJ38O9gxk
	 QQiVGD4wrKY9lwiZmlpcAk5JquFF5qf9yTzsd5LbGVGqckp11DcRxZIIoJ1YIlpZ4Y
	 gP/vZKs7jZghFQhMMLO1WbcE1TAGz7A9nWpXflRxNhdk7nICItlYLdVZj3Mjn5xSe3
	 nv5dEH0r/oZZQ==
Date: Sun, 1 Nov 2026 14:15:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v3] keys: Protect the update method check against type
 removal
Message-ID: <20261101221519.GB2689@quark>
References: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
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
In-Reply-To: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>

On Sat, Oct 31, 2026 at 05:26:36PM +0800, Cen Zhang wrote:
> Take key->sem before the first access to key->type and hold it until
> the preparsed payload has been freed. Once a key exists, only the GC
> changes key->type, and it does so with key->sem held for writing.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

But it seems broken that a key type can be removed while keys of that
type still exist.

- Eric
