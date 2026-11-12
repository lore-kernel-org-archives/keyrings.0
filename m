Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452027;
	b=p6rF1tHTba9/8bURdHm1Bta96MJySKuXmKKdxgNbdS/EqlEUpBNvFsxvFeDv7jnnHApe
	 yo/v033iM/lCur49JKyXHGdkUZwSRKOrC1e7IS4SlvRXXVEPemPrh3pbj0bRwRtyi2mEi
	 B+Xfv9VM0a+ANIl380l9fnQVhLDyklqlVnQTC9Ii/Kv0d+z3YerkpJqX7yNQ+wn4CvquR
	 q/AUc+jynr/5n3aFTSadwLdpUaKQ5Y5PmkLn9N4P4cXf11sjhXOHxgxi5HPTErbuskzV/
	 IoxYMNzlqSt44ZzmheVWAH7NcSeQsxwAFyVyiir79Xx0DxqgZzQlJvP94rhvq4JfTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452027;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=laEHbKjRx6UGZ83WAETWyeGMdYjR96+Q9+DRe2CkpWM=;
	b=TXw2Lkszkx02nwsH+V94DBQBxkEqBcJan+Fp3S+vY3xCjfy02bLsuFml0lAOvSqta6UN
	 JS4VDbiwMbWgsaYfzzvuEJRbVeJ3tkGPjhQvQ5/IRHnJYpiynj4ElYoEL5zXxlcfmOhxF
	 qZmnJ3F6bOdVsESdyA9TuklhrEC/Ed82ez5XTIz+ZigGeNvt2RbCOaNfgxocy+W0yirL6
	 /dUCuzfi+/izpOvhJIhHoSFtiRBwJQbAFYccYiHo7H699WoY6EJFd6a6gc7nTKOp9rDRn
	 YqSiOAwdW0ombJzP0eBnHI1zSUNi3/uvt7+A4MJwtzRn+Y1H+F705dF8XOlfmKoSXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thcmsk3n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B83606A335;
	Thu, 12 Nov 2026 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thcmsk3n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C81F00A06;
	Thu, 12 Nov 2026 02:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452026;
	bh=laEHbKjRx6UGZ83WAETWyeGMdYjR96+Q9+DRe2CkpWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Thcmsk3nCAaNGrh0B9hAvjc9A/dpu6nVzwiYBzSv1IQZGch06h9mXo8LVXmmRGBGa
	 TQB9QvHsnN7Yozx8luFXmhQoS3Mr3/QaFdMKvtY0l6GHHsXscylNh2XhfdaQM/YmCf
	 aaOYqucZLIR9X/3P2cC9VAcn6p/G0cijuUSbAaklRTvejXKj8CgyKpXFJ0sH+XxK4X
	 mAVxDPxnRj5PoDEm+VFBjfstF0LgenNnZQkKi3oc9RzFlO8ORtPf/btp0XvWN76AV5
	 DmbxjN0wUMiK+nWCJEM2gPYxR+REIPeztD35A+Scyovggnw1/LzbDxlKxHl7PSya5d
	 A/sy0Nvnu8DwQ==
Date: Thu, 12 Nov 2026 03:53:42 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: cznic: avoid slab-out-of-bounds write on short
 Turris key reads
Message-ID: <avUqKeNDFgeCx9Hi@solitude>
References: <20261109212632.2437881-1-graypanda.inzag@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109212632.2437881-1-graypanda.inzag@gmail.com>

Acked-by: Marek Behún <kabel@kernel.org>

On Tue, Nov 10, 2026 at 06:26:31AM +0900, Junyoung Jang wrote:
> For 0 < buflen <= PAGE_SIZE, keyctl_read_key() allocates a temporary
> kernel buffer of size buflen via kvmalloc() and passes it to the key
> type's .read() callback. Only after the callback returns does it check
> whether the returned required length exceeds buflen.
> 
> turris_signing_key_read() clamps buflen when it exceeds
> subtype->public_key_size, but ignores the clamped value and
> unconditionally passes subtype->public_key_size (33 or 67 bytes) to
> memcpy(). As a result, calling KEYCTL_READ with a smaller non-zero
> buffer (e.g., buflen=1) writes past the end of the temporary buffer,
> triggering a kernel heap slab-out-of-bounds write.
> 
> Per the key_type .read() contract, only copy the public key when the
> supplied buffer is large enough to hold it, and always return the
> required size.
> 
> Fixes: 0b28b7080ef5 ("platform: cznic: Add keyctl helpers for Turris platform")
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
>  drivers/platform/cznic/turris-signing-key.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/cznic/turris-signing-key.c b/drivers/platform/cznic/turris-signing-key.c
> index 3827178565e2..af414e236de2 100644
> --- a/drivers/platform/cznic/turris-signing-key.c
> +++ b/drivers/platform/cznic/turris-signing-key.c
> @@ -46,12 +46,8 @@ static long turris_signing_key_read(const struct key *key, char *buffer, size_t
>  	if (!subtype)
>  		return -EIO;
>  
> -	if (buffer) {
> -		if (buflen > subtype->public_key_size)
> -			buflen = subtype->public_key_size;
> -
> +	if (buffer && buflen >= subtype->public_key_size)
>  		memcpy(buffer, subtype->get_public_key(key), subtype->public_key_size);
> -	}
>  
>  	return subtype->public_key_size;
>  }
> -- 
> 2.43.0
