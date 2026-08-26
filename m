Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057D34D929;
	Wed, 26 Aug 2026 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725215; cv=none; b=OVdYgPWAyK/eLx2KZRJOpJVtaqL6WscX+xvpF2A6LLqGqeztCXNJXzyJ77s76KrQVww6xUUYlyGKYVrMVpZUZP75XTHVhCAs0bMikMo7WvT5XyuJmOh5+bGLPBeQmfnCd9o1ccjSo9+IzDjYpkzRUBOSjm+pGmr77EaQA8rH4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725215; c=relaxed/simple;
	bh=69J0C7vWgA4YhGTfrqYGfcMY/7C9S+kfSZCE/erspnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNZEz2t5gmoUprWSW9dTwLg5BZXavWLpJe8QUMW4Q+wcVlsx2ofncJ+7md+dYHeeIPfXd9WObrumPRY8dHqbwz+QjJxR6ko1mIZS9yBvTP3xKWV7NnyBPpeP6YYtvm7RCATd57ywkeKEmYgrMBsVs87OrGTiwd87g/NMAHeQZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stxZ+4ZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stxZ+4ZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523631F000E9;
	Wed, 26 Aug 2026 06:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787725213;
	bh=/LvMPMna5hKuhGjcZq5XWX9ceVv09UjGmdSKxDhqAGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=stxZ+4ZL5VfRo1bfNf+/rzIdJVVYctzfErI4+qCZdLk7Yh2krU8nv8sXPGIMpuRu7
	 MD7oGRAOG2OmW+tirga4W5Q2OsHga5zXiDBAu2gRKyl0USZuVqgBJyvnK8uS/kFRGc
	 B9sdVcjTb5lvLZjYO736Vpm+UoQZYGKChWaNzv9E=
Date: Wed, 26 Aug 2026 08:18:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sn0x-sharma <sanketsharmacsec@gmail.com>
Cc: jarkko@kernel.org, James.Bottomley@hansenpartnership.com,
	zohar@linux.ibm.com, dhowells@redhat.com,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org, w@1wt.eu
Subject: Re: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal()
 before memcpy
Message-ID: <2026082651-portal-valid-da58@gregkh>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825182919.15943-1-sanketsharmacsec@gmail.com>

On Tue, Aug 25, 2026 at 06:29:18PM +0000, sn0x-sharma wrote:
> tpm_seal() computes storedsize from TPM response fields and passes
> it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
> validation. A forged TPM response can set storedsize to 4086,
> overflowing the 512-byte blob by 3574 bytes into adjacent slab
> objects.
> 
> Add a check that storedsize does not exceed MAX_BLOB_SIZE before
> the memcpy, returning -EINVAL on oversized responses.
> 
> Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
> Link: https://lore.kernel.org/linux-integrity/

That's not a valid link :(

> Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>

No need for a reported-by: if you author and sign off on the patch.

And we need a real name please, not an alias.

thanks,

greg k-h
