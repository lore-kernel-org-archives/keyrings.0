Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4E415F22
	for <keyrings@vger.kernel.org>; Wed,  2 Sep 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341070; cv=none; b=sgQKq7dhJ7Jk5aRlMeY09/p9p8Asx+1jAkS8WHDuT9K6nIiPz4k1n+T6xdp1XGdO4mnxDZdpOMFXXuHwMUI4wx4igVxzkwAh6tM70k6v1+RhqnRzc2v3gw2/e6bvkA83q4H1FY3ZSc7uDFd7A3+ug3W0/1U5q2oozlfYiyKglew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341070; c=relaxed/simple;
	bh=dv1csfbz3+AfIisrDWKM/LTeMZoRYy6BRCz9NaDNXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWWKtQjCUcgxVOgYNMf8NzxvqlzPF6mB0wKq80iZPro66TzHy9VwVUVv7G/bBS4Wmr3ArcSnEUYaFJv+vajLmoCTNYEe8yP3hx/uxKxDz2TcYtf+tlNj1HEJyfqCozQrKQwzqrMGnmPbBNm8J9utyEMfGoaMyABRC3ecgJZl6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKn3S1rS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyYnDxPi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKn3S1rS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyYnDxPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788341066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QzyTGdGmNYHVJq7S368eFIeE6Ma1yvkdBRAoiX3kKc=;
	b=DKn3S1rSZRpSyl3FHhGxt3ILEWTihqGI/rG0tNTwpxCT7Yqj3fv6irbbb6Wcf6z9koP/go
	xZ2HkSvkh68ax3doeLn5uZHmhe7bzTaDLCMIJYUhmjkutd30ZTtA8kMSTSY9ZA29zX3NLk
	pJbHWyr3iB/ajVRzqIGSH1j+WKarnfw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-hAb_RCK8N3asatefHFgmdg-1; Wed, 02 Sept 2026 05:24:25 -0400
X-MC-Unique: hAb_RCK8N3asatefHFgmdg-1
X-Mimecast-MFC-AGG-ID: hAb_RCK8N3asatefHFgmdg_1788341064
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-481514be433so445342f8f.2
        for <keyrings@vger.kernel.org>; Wed, 02 Sep 2026 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788341064; x=1788945864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8QzyTGdGmNYHVJq7S368eFIeE6Ma1yvkdBRAoiX3kKc=;
        b=JyYnDxPiF2rPoE7R5j1x2Lv3ODL7MDYcdYu/6e58kZl+6RlY6Xk5w4my4eaCxLUYA8
         zPlAzzeAtMOv9B13xii8ynINbejCEVTZjtFmzgIlM9LLp776aO9BZeLI9HHlCFvRGXvH
         eKAZum0oe1RalaQrh1p30bYM8fFtx1+DgVrDJR9yhHpyI74zEWFp3Fyir9pnbouy5sy1
         R+DTB3gg7Y+paqAb2us/ns8Bg7zrtA7avzLIYuCaY43ld/hcPy64idGwDHsxUr3UbesB
         S/t5UG4GMdr43+9hepMt0/NnfZCzknTiNeEG1rgqH62X5uOCW5ZtzLDFzWdj9anitwgq
         /CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341064; x=1788945864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QzyTGdGmNYHVJq7S368eFIeE6Ma1yvkdBRAoiX3kKc=;
        b=AQ50dhLv2WOmrciMWwhtja0yuWbffQTvDW5GRTNpNmOAzqnYsE6HmDfkSuUUNhYekz
         br9T8jwrXKhu5kr7wHEjZ1/R2C0W1jcvLxDP2pIE8bx8r3dAd9ric0URsVTauedv8QD1
         7tZchKP7AJEHvybx7R3dMiXkyQI52Q7aRHpf9+45nZk/bfy3Pmt/dVAxZ/8FCsBEcSjH
         AifBqZdE/XXDftFuTg7p1xw7bC/sWKJOBH5F/Jv180EU5dFulY98e0kZ7sM2+ddWPFEs
         NM2IJjrB0TR+LvkwOHJHuM9uq3Lrs+uT+cZ7bC/lgDSWgDbYLcdRULT9FNR+IQXCivmV
         yL6A==
X-Forwarded-Encrypted: i=1; AKwUvBzyr76sgCqTfejNzfyIFkoJmVf0GKJAS4+fEF1Gu8o52iUBooPHbJf0zNgF0/F6bx0+bEXwJpN6rg==@vger.kernel.org
X-Gm-Message-State: AFuF++kOxaG6hKEgT0Wk22RnkExFZCs8OvrJ7BhiA8X6N6m4WZ9sV6k0
	mcMSk+7bfEtxyaffTg7Zyu7z3zkdPVORsjd7Mihg6ewcq6ZCl7Uqu4ogs3JBUEZELFgAGLWc4mG
	5PeGaeRxI6obSiFVt+I15PKC3574CgzREj5g4Wve9CKde7WLLWZ8jbZh4U7fK
X-Gm-Gg: AYBFou2X9Fm+WZ8ZTSZ9ofiP+5urmIzVlDGdi+XKeQDUV6hw/uDVql2eosQiszgIHd1
	+2pTWJNxNuFasXJUTPiz2948R9pbXOk+dFYLCLJZilFiYZLNIZoLVZzab+ieEQyP9cktBqsnkIK
	n+Crgt1XAw1XbhVuXc/N1CwPbG36leviWz+tT6B65yxlL1MxQ/z6A/BHHEsL8m/hAiejBNMRKB7
	egWacKV6hJbfLkU8lVoIQJZI4mFjztnHYVFhzOzYW0SHCDZ7R06JIEjwRBVQcZIcHLAV6OLdUv+
	HFODd1dpLNCZ/XTc6MIVzXy3SJU2AWf++4m7pm3CV7odNqDSIG5eNjDdYBwAxlkSxiOd88fL0Eo
	8BQBx4TrdMBukP9PpGnY3p+MCn5+BCaq45yWu3qcm9nhrOw==
X-Received: by 2002:a05:6000:454c:b0:485:1bcc:67f8 with SMTP id ffacd0b85a97d-4851bcc69c1mr3651064f8f.13.1788341064194;
        Wed, 02 Sep 2026 02:24:24 -0700 (PDT)
X-Received: by 2002:a05:6000:454c:b0:485:1bcc:67f8 with SMTP id ffacd0b85a97d-4851bcc69c1mr3650988f8f.13.1788341063712;
        Wed, 02 Sep 2026 02:24:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm6406811f8f.14.2026.09.02.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:24:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:24:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	co+6a581c4284f721d4@bugs.sh, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan McDowell <noodles@meta.com>, 
	Ross Philipson <ross.philipson@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Message-ID: <apfoKo-BdwaLXtkT@sgarzare-redhat>
References: <20260901205809.2028454-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901205809.2028454-1-jarkko@kernel.org>

On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
>tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
>payload->blob_len. Address this by passing the decoded blob size to
>tpm2_load_cmd(), and use it for the boundary checks.
>
>Cc: stable@vger.kernel.org # v5.13+
>Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
>Reported-by: co+6a581c4284f721d4@bugs.sh
>Closes: https://bugs.sh/b/6a581c4284f721d4/
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 67225dd562a9..01f18bb37047 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -99,7 +99,7 @@ struct tpm2_key_context {
>
> static int tpm2_key_decode(struct trusted_key_payload *payload,
> 			   struct trusted_key_options *options,
>-			   u8 **buf)
>+			   u8 **buf, unsigned int *blob_len)
> {
> 	int ret;
> 	struct tpm2_key_context ctx;
>@@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,

	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);

Pre-existing, but is `+ 4` here useless?

I'm not asking to fix here, just noticed while reviewing.
Maybe we can set *blob_len earlier and use it also in the kmalloc().
Not a strong opinion, that said this LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

	if (!blob)
> 		return -ENOMEM;
>
> 	*buf = blob;
>+	*blob_len = ctx.priv_len + ctx.pub_len;
> 	options->keyhandle = ctx.parent;
>
> 	memcpy(blob, ctx.priv, ctx.priv_len);
>@@ -384,10 +385,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 	int rc;
> 	u32 attrs;
>
>-	rc = tpm2_key_decode(payload, options, &blob);
>+	rc = tpm2_key_decode(payload, options, &blob, &blob_len);
> 	if (rc) {
> 		/* old form */
> 		blob = payload->blob;
>+		blob_len = payload->blob_len;
> 		payload->old_format = 1;
> 	} else {
> 		/* Bind for cleanup: */
>@@ -399,17 +401,17 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		return -EINVAL;
>
> 	/* must be big enough for at least the two be16 size counts */
>-	if (payload->blob_len < 4)
>+	if (blob_len < 4)
> 		return -EINVAL;
>
> 	private_len = get_unaligned_be16(blob);
>
> 	/* must be big enough for following public_len */
>-	if (private_len + 2 + 2 > (payload->blob_len))
>+	if (private_len + 2 + 2 > blob_len)
> 		return -E2BIG;
>
> 	public_len = get_unaligned_be16(blob + 2 + private_len);
>-	if (private_len + 2 + public_len + 2 > payload->blob_len)
>+	if (private_len + 2 + public_len + 2 > blob_len)
> 		return -E2BIG;
>
> 	pub = blob + 2 + private_len + 2;
>-- 
>2.47.3
>

