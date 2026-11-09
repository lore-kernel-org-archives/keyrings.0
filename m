Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236057;
	b=oWYRg8UUkac9Pg6yh2u5kRfyHGS5g5usNohl60THlyVPgPJPL/cLnN90FwdhbeaDOILm
	 e7/fNkexzttqgNPK4bK9nYfRfnmk0n+afCNWGL2y4gmfsX2Fm13esvkRiK6TKjksULR2i
	 atwy1w0AmA5MEVo361YOYQSqQlVtTuGOFIRkwirv9N/4isPY8tvbYR21GMCET/glgCosI
	 a8lHtgvw+g83nw00OeraA7ECf5H+PT46pPOikcT+m5O5Kmxarwmjeh7nKUdzhJwR+YYao
	 oWlllHQu1r6VtPp9Dq1QARKhdFLy74KUy7vXvwzrxkvUQi+xzfQx22zSE1tU6RqXsMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236057;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XmnGczbXYjhMau5pClTNznbB6TrB8qkoC+tW5+pwPRU=;
	b=hN7/cDWoUkz3pGRgPRLHNZG0zgqvzAY+FpT6aYW4PbLl4OOgombCnZWS24mB5iBKJwEQ
	 d/j4lKcm8nSWkNMnGf05lSTMoMnJm57QYi/dZZBTUglQLnqHEy8JiSdffZ4jR3Avj4OD9
	 VHn0Z0EXj9nPxjF9VbcTQQvLLBRS6oeSkIytC1/Q3kkxd5qMHagsdFPgIkdYKkmlUs916
	 MZSbpiHr37ELzQPagpMaHo3jRhdBfvo9eD5VtA2Nmt2showpXIU+CbIF48pk6I6lLeDBx
	 0nr5+jT1ysX6hA3ck5hEmYUy5BFhq7cJaK9kT4xd/w0lL3v2XOGFp89zmodNetB1VdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/G+5l+c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 776AD606A31C;
	Mon,  9 Nov 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/G+5l+c
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 81CCA1F008A1;
	Mon,  9 Nov 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236057;
	bh=XmnGczbXYjhMau5pClTNznbB6TrB8qkoC+tW5+pwPRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e/G+5l+ctv3J4J0FYrueBwuIfte2OJnEDjqerU6oHlHphbKsGleKpF5f2yCGRMLCJ
	 EZmGlYwMicZdysQOLmP1xdGaIJ/ZBUYvS4P/UnhJJl/HHPTyXrXvhj4bCIjuDPYHQy
	 hgyBRWR2T5Ms/cCS02V9zHPZF5kUyTEhXSZBZNY+DQCfIp/lHfkWJAGx9GcBtT1OC9
	 +UqwoHW6MAObHfPNtuA2PqOSarpRfsuepvFba9LTL1pZykIYfx1C9BR9aEPVMYKenZ
	 g0461zjxGf7VXLRduVUY1OdqLqht0w1pA3k/u6P+pSPNoM+SycpkGMGG5sTKCZHXlR
	 GXFRDyFNbFBJQ==
Date: Mon, 9 Nov 2026 16:54:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avHelQ1nxsDVcQkZ@kernel.org>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
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
In-Reply-To: <avFcjHwnh9mrOEnz@stanley.mountain>

On Mon, Nov 09, 2026 at 08:39:24AM +0300, Dan Carpenter wrote:
> In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
> to avoid a conflict.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec676..2d6cc53539c8 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (private->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> +		unsigned char boolean[3], *w = boolean;
>  		/* tag 0 is emptyAuth */
> -		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> +		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
>  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>  			return PTR_ERR(w);
>  
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
>  	}
>  
>  	/*
> -- 
> 2.53.0
> 

Are we migrating to C23? I've not followed this too closely.

Br, Jarkko
