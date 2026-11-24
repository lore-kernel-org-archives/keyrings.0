Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538283;
	b=NeAZPRVp2bMzAzzBkE1osYIFnP1Xqyla9J16jULD+Nt4plxxFnNQ2VCy+UWZje63Whmg
	 xlqEVpTqGJ2YaTfK4uEC6cfdPYtBn+LHirW2u8uaf4puhMh4UW4pl6BIfaZ4av6Q2vg+w
	 VABBErcG5IyfzUp3cXTYvD15uEP+UMcNbuYin3G+ZdRozaBBClajpV+wKQ5/nWX+A1d89
	 2QCyuon8wFtyMyLyhoo3SGYCfsFieSRvejM0TSZpy9RW7F+UyPZ4dYti4gv8yHKAoTLMK
	 /TQ/GiQZCIfKlngZk6JktLU+XCkvCWqhDe/M2GLpsWFyrZr9m1smJJYCABzpdPLRqvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538283;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zEWnkRahKuJva+EOdM9aoJAlXIBskSC96lQmEW7AFzQ=;
	b=FFF7AE03cSdBzD38IOpP3cfHLF/ImJVQDwqUItMtfh1LdMDPbZQ5s++IWzVW+CFOLU2+
	 Asr1fLgcerzpocHan3lXYmmKKkMrXC2nXUrRHgGA8jxUUgrlkgdNNNbdlcgNsGRsrpd8N
	 nICBZ1r3JB4o3S7rJGk2YKbv1UItu1PIwF4ebFv4puJrZ8fvsRoVMJo3UogpAy1Q1G/Bu
	 qhGiORsUN1yO3YlYwPihDht0MJb5LnJGKx/H+ns4J3I9vef/poref0pLtHUuX++MmIO3O
	 61j8xi8P8nTpw5bqfP1cEZ8a4t8UEk+ISue+1WGHvIY0w5r11i3Fro5RWAZ1TtDWFQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=v9YcfGyK;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83F606A326;
	Tue, 24 Nov 2026 16:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A83F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=v9YcfGyK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795538274; bh=gVNMqSzHWFVNsBvzejWuL1IJS9TsIWZJdXA/XbrBWyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v9YcfGyKwCXUY2FxrBRj0yodJwse7j9ISVnVCIxxdF1hIU4FWhYIdPDjTLHP7ek4K
	 pg3V6vtGF+Bha4u5Ina7ZfdHdd+kni2O+NdmSy3Eg5Deno2nb2tHLrAPKwx14xpWEi
	 QpwZg6TRNFUjJ+Ndgv0DRwChyQVEbWT/gfk8xnasqjRBMj5kC6lBVZf3WwGPQE9SWl
	 9L4rh5Q0Zfk4nbtkKFwHDRnAXLXaZ8x2ZwJQz96SPifWPWRKh8A2R9LqFJ9a47tVDu
	 dvOPZ29augFzVArx0VjSwI4qk150x2GdsH7abRvl2l3z9ElcS/DnJMedc/uhtqm1Sb
	 DmtZkDEQ+9HTQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 64804177; Tue, 24 Nov 2026 10:37:54 -0600 (CST)
Date: Tue, 24 Nov 2026 10:37:54 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Keisuke Tsukuda <tkdkei@outlook.jp>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>,
	"jmorris@namei.org" <jmorris@namei.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: caam: propagate protected key option
 parsing errors
Message-ID: <awW9YvoCRAXXiq27@hallyn.com>
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

Reviewed-by: Serge Hallyn <serge@hallyn.com>

But, it looks like these were both added by

  commit a703a4c2a3280835003d4d0eb8845bac0f1a6ef1
  Author: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
  Date:   Mon Oct 6 09:17:52 2025 +0200
  
      KEYS: trusted: caam based protected key

Adding Meenakshi to the thread to make sure this wasn't intentional,
and serving some purpose we're overlooking.

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
