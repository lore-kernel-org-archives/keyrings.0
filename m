Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542382;
	b=gaV6A1eOtiMl3zbosmI70tahFDOZqkbDjaExvvWH0DJmCv7L/1xH4giU9qWyUaxBz3mt
	 01gg18nUBEirMy5+Rm0ARieppyKOaQ0NMHNIRFUAJMqVffaHqtjNTGE5PR/SijnAiDEGu
	 GReml72XL3VDLOZrllxq13bX7QUYd/aUn8FagCV6ndUkdvLI+struoiLUbMfgTRHWblbj
	 3IWnjnjYqnzW0D/iXHnRzGZdCJZzf0vWVbyjfyXZ1rQTBypQBZiMG6DjUFBPCJY2cQ+2i
	 HXApfGqeycOt3gwSIrpwUU7MyftbIaH/btZ+cRFagl13e6KtwDyQ/PVady2z5xlwC0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542382;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FtwyRunQCEsyMnm8dmDweruaeZpOuMpydLkc7kMsNrU=;
	b=FlkZo65w/ynVnqmiHgMFwRHXa0/VLDe6tUbeK5WsMokS/YCxvdOl64wbZHtMb3Xp5/Tp
	 hiNznREXaTf3C3JkORHpxkAR+lr6nEhVK0qJvJpOGm0sH5Lwhzj0EAhhATZXkThtl+mwa
	 CiHaz0kNzx8t5Jg8nQkQKK2INz9p2iBeHkJdEDf3q8j8EY7MSeQ0WVxig32PEBkU7mK63
	 9krJwM8sEUUG6ow6b78mTXDIlsldkdn/WQvFZ7JUQTgJkDITyKLhTN3525CcaSkWvTDIA
	 4mbdqkja3RWTjJkZ6dUi4r+y7n0AlQ6dNSPg9fsk8QsUvI3d0kqbaEwk3gLWzCWIJQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFsDa3b9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4D17C606A321;
	Tue, 24 Nov 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFsDa3b9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E25021F000C4;
	Tue, 24 Nov 2026 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542381;
	bh=FtwyRunQCEsyMnm8dmDweruaeZpOuMpydLkc7kMsNrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFsDa3b9oxSH71lwzZS+Z7yNKMd4gsRq4hLYSTo1YhY6DO6gjbxP4v9GdDibtVyxf
	 y+jINC5GmPhV5eYUPdqS5QC1Xqik+tXZ8DN8Z/ZqVJtyqsKwXB9b4TCCEs3IaRpuvE
	 sMLSHxWU0+1UuNLUfHuhqKVFoeCpb2aW0CYOMKq8uAIYpONe5VWM3sFSgO1F1O9SB8
	 9eEXHZdUs5Xe4F/SXHYdOkCgEnLzv5ENlJlQ4WkhIj5kWjZCJ1KIu5GIkG0jdvYfFj
	 s02GYkZ+pmk50djdA1HdK4jGxuKIoQqzBO8eswLry/KRh4dj/Uis0dXrFs7MUmIHVv
	 ZSlWTezePmBIQ==
Date: Tue, 24 Nov 2026 19:46:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Keisuke Tsukuda <tkdkei@outlook.jp>
Cc: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>,
	"jmorris@namei.org" <jmorris@namei.org>,
	"serge@hallyn.com" <serge@hallyn.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: caam: propagate protected key option
 parsing errors
Message-ID: <awXNaSZVTxqbB1TY@kernel.org>
References: <20261124155310.32044-1-tkdkei@outlook.jp>
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
In-Reply-To: <20261124155310.32044-1-tkdkei@outlook.jp>

On Tue, Nov 24, 2026 at 03:53:39PM +0000, Keisuke Tsukuda wrote:
> From: Keisuke Tsukuda <tkdkei@outlook.jp>
> 
> get_pkey_options() returns -EINVAL for invalid protected key options,
> such as "key_enc_algo=GG". trusted_caam_seal() and trusted_caam_unseal()
> ignore this error and return 0. The trusted key core then instantiates
> a key without a blob for "new", or with a zero-length key for "load".
> 
> On an i.MX6Q running a 7.4.0-rc2-based kernel, adding a key with
> "new 32 pk key_enc_algo=GG" succeeds, but KEYCTL_READ returns zero
> bytes because no blob was created. The key cannot be saved and
> reloaded.
> 
> Return the parsing error from both paths. On the patched kernel,
> "new" and "load" with "key_enc_algo=GG" both fail with -EINVAL, while
> valid requests succeed.
> 
> Fixes: a703a4c2a328 ("KEYS: trusted: caam based protected key")
> Signed-off-by: Keisuke Tsukuda <tkdkei@outlook.jp>
> ---
>  security/keys/trusted-keys/trusted_caam.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 6a33dbf2a..33000d7bb 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -110,7 +110,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
>  		info.pkey_info.is_pkey = 1;
>  		ret = get_pkey_options(datablob, &info.pkey_info);
>  		if (ret < 0)
> -			return 0;
> +			return ret;
>  		dump_options(&info.pkey_info);
>  	}
>  
> @@ -142,7 +142,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
>  		info.pkey_info.is_pkey = 1;
>  		ret = get_pkey_options(datablob, &info.pkey_info);
>  		if (ret < 0)
> -			return 0;
> +			return ret;
>  		dump_options(&info.pkey_info);
>  
>  		p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
> -- 
> 2.50.1 (Apple Git-155)
> 

Thanks.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
