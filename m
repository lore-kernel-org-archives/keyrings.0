Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4E3FFF9D;
	Fri, 25 Sep 2026 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376556; cv=none; b=iojOprUhKvNuw5AxLRCqOnGslTeUgDM0C9GC+n3KPPL/tYXv33fbymK82qcFGr+WqeiyhOaSfam3xYJxQyaW4/t0LFRjOkc+uZazJBRUB/1xaFSUa5jMwlF5i5kjBue1P72TdqaQnuRPLWp5xjC2KxEuVx9OSWcvV/5ZlsBr2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376556; c=relaxed/simple;
	bh=Y95UQmeT/ukjLgSezHbUyqHff6vAEDwkJco7fGSM0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/V3qgu1iWm86i6rUiIwopSuwvHLTafzZq5Wp1uEPCMH1sS3fTF2LsRzQcg/uUdJid5MuVkaM9T7XQkVB0DPVQ57KjQViWM0lSSouKQadAcSLtAd3kyE/lA5su5jibXPz0cLI/wVV0cOTbgx1s2JwqgeKMZK3H4OeNwzYxqLhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaafAq5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaafAq5M"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 706D91F000FF;
	Fri, 25 Sep 2026 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376555;
	bh=TkaMhPcU6EN6kseIWAWRa1q3PMr7Fv4dOgRgKGXTDnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RaafAq5M511Ogj3VnsexZWp3/jc59DqjKSNhfxE4IQYF/6p9yKlIRcN/Dhljb09v9
	 pFmtRJa9m/qoRIuVblqBOBeoD4cdBh/fcgrMxhYiT399NGkPYOf5qiNUuWfX4xQXPL
	 7YwsbvvyS2q+RIBleu7mZu/ntBkqs7BwuejqXQuqsa/MvApIKJbqNhTvx3SYmdkwkr
	 VWjgHC+QjdCWJ8OLqmY+friWmUhN47NWSCTJNL00Kwuf6wH6y6UIYGrwMw8TchLrzq
	 eKisgXkeGnIRB/zauYD+ZE3ItU+IjpilRCeETeweO9ERZc4D4QiB8IzdzBDHKrJdBt
	 roGKG56hDaqyw==
Date: Sat, 26 Sep 2026 01:49:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] KEYS: trusted: Fix blob allocation size in
 tpm2_key_decode()
Message-ID: <arb6Z3s3mLu45Bau@kernel.org>
References: <20260923173506.41519-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923173506.41519-1-sgarzare@redhat.com>

On Wed, Sep 23, 2026 at 07:35:06PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> tpm2_key_decode() allocates 4 bytes more than needed. The ASN.1
> callbacks tpm2_key_priv() and tpm2_key_pub() provide the lengths
> of TPM2B_PRIVATE and TPM2B_PUBLIC, so ctx.priv_len and ctx.pub_len
> already account for the 2-byte `size` field each of those structures
> starts with.
> 
> I noticed this while reviewing commit 114f00d738f1 ("KEYS: trusted:
> Fix tpm2_load_cmd() boundary check"), which correctly reports
> ctx.priv_len + ctx.pub_len as the decoded blob size [1].
> 
> Let's allocate exactly that amount, matching the data copied into
> the blob.
> 
> [1] https://lore.kernel.org/linux-integrity/apfoKo-BdwaLXtkT@sgarzare-redhat/
> 
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 01f18bb37047..a9b8a31a637c 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -115,7 +115,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>  	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
>  		return -EINVAL;
>  
> -	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> +	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
>  	if (!blob)
>  		return -ENOMEM;
>  
> -- 
> 2.55.0
> 

Yeah, we talked this over so not much to say about this:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

Br, Jarkko
