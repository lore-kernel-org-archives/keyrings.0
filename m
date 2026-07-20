Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A233D7D7E
	for <keyrings@vger.kernel.org>; Mon, 20 Jul 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543711; cv=none; b=TiyyIp2Yjl344qiXvVgPDGcIMDq7ivbuyogLM3+YL2sw6UEdkomJX0RPROdmyAhoqwDbC7bR05dh1jR/I9zepLXQTztBxcmQZ3U4+so5nynbBkUyJCsqTdspW97ooCcaClQToedAM7rqb4T1MSYla7BYTrS4lFVgyw+7jRBUa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543711; c=relaxed/simple;
	bh=NtYCSfnijOuf43LYdvfcJWtyNX4MSCBqCUIVCWr1hfA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=AfcDAnAkgSVO9BkP/B12hDzllmbxmM99Wjugu5qGC7YkbetlMqwagLleqVojEmovuI+b65lqylQZxGE/023NXBr4m7RP7YPhmVsBm5ZhPfE/8gI/pclh/+l3rqe+ynlBTtOWw8HCxiFNSQ7u9Jf4kMeHQe4inp+GQV7xVOpLjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sZ93UBYX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sZ93UBYX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955484387cso8728295e9.1
        for <keyrings@vger.kernel.org>; Mon, 20 Jul 2026 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784543706; x=1785148506; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T/UHcnK0u2PtiV111f+vwISiyqebdZ1bRHYB6k/SjEc=;
        b=sZ93UBYX+HK2wIdKizFcZE7ea/tjsP+aArs+VDnPJNdtg0xItvGODHKsrV6V8G/wXd
         eQLhc9g972w5WyLqMkq9Vn4REKFIngtXbpt83hjqUkrChSL4p0ekjMrGBYoCm8oQ77zu
         u5DAMuDL/hFPEsIbcGrUbIO2UgwHdnIosD9WXY3Dw7CJx8PoKl78h83RBfuGWJy1Yesb
         jlH18pSgYX0ovOw7NDr5jbtDKCPxBOxR7rO/OknSdYBPshUpO2W8u1bUvgEko3/zbsLL
         DHbMIg0a8QaCg1SqJoBMM/buRlKz4s3oy6Hn4DHqUgUwZTh0r3lzvPLWfN5/mnZMHOAF
         1TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543706; x=1785148506;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/UHcnK0u2PtiV111f+vwISiyqebdZ1bRHYB6k/SjEc=;
        b=VLR+O5fdWYwd72c5ETnbIy0IlTB3BgEfJMPjk/4/ZjHWjf/eSJkRSeTYKsCk6vlIez
         4NdMJdmqdvxc8WTLbsD2LfLF5WqIdcoKLd4TP+OEpWF6B8OfMnATzTwAXd523cDHkc0h
         GPXneoNZhez5YgM/5pfgY9J3x4mVAAo6XMjuAmAe1xmcumpmgOvvs9qk+Z+k4AbfqruX
         FED3ReNc1pwjwyXx8xA+p9xjfT+FYjXhJuWxniB6NluwfC24fdAyr3dDHl2NDHJNR7jR
         +mrmSLfjoBwJhkoWZitMNzOo+B7vfOtWmEYn22mTs3e62c/dC1v24nsmwNEKW6SyCNRz
         F1oA==
X-Gm-Message-State: AOJu0YwCWYpddMaSjIQqN0v1SEPY80gPodeZe+ks3he17oIdt8tQqFgk
	zdE0WH+OedOB8nfCkPZI+km5LY0u1ZgDsk19wS8+CLMBcGE9TWTEcI82Fijn1Uc6gpA=
X-Gm-Gg: AfdE7clmr27k5AHES3QYGO0WOxNVuSDyFooZPzwuedatyXhnwEyRZXGqTrLFcyPyVaP
	3N9YW04UwzJb6bMxgthUP2cMe/aQpeOjRLWrNGjWREPiqosykhn7vdcjI+pJrRxISSDpxBskVRr
	jGuvPZqrLw8tSR8FvzRkSno5QoX+zLXOYrRIbOpRmyCPV+E8N7NLqn1jhju4AnxKSmVQhT1iCLO
	pJUnmurN5iQB0MjCGZTnbDljwbzgmt9rrhjk9Uel6SpZ7IEGtnMYve6vyNQn0mw5X8Xw/BBI/Ok
	hm5ilTVxb5+KW6rSD7C48+Gx8AdWpS3G8EDc42qhviHOe+jIcCzH5xPnZlRyfUBQFcxh2gkpMFg
	ssC4qTZVIUjMiKhPi3Bcgw2GeUMmPW4J+IVO+POgdTLhNd9tr7HSQjtg1AM3K4GUT61yUYug/aM
	EEe2hnYKl+BghIJBwRZD1xSCpEPBPHcPJEDp2UaW6SUawbjpPX0lsiIGhj
X-Received: by 2002:a05:600c:4504:b0:495:495b:9248 with SMTP id 5b1f17b1804b1-4954a3d0cf9mr143689505e9.4.1784543705762;
        Mon, 20 Jul 2026 03:35:05 -0700 (PDT)
Received: from smtpclient.apple (213-225-8-251.nat.highway.a1.net. [213.225.8.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495516c68fasm193931675e9.1.2026.07.20.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:35:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 Fabrice Derepas <fabrice.derepas@canonical.com>,
 upstream+dcp@sigma-star.at, jarkko@kernel.org, zohar@linux.ibm.com,
 dhowells@redhat.com
Date: Mon, 20 Jul 2026 12:34:54 +0200
Message-Id: <1EDDC226-1CDE-4A17-968D-EBA26E81B596@sigma-star.at>
References: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
To: Fabrice Derepas <fabrice.derepas@canonical.com>
X-Mailer: iPhone Mail (23F84)

Hi Fabrice,

> On 19.07.2026, at 18:41, Fabrice Derepas <fabrice.derepas@canonical.com> w=
rote:
> =EF=BB=BFTwo correctness and type-hygiene issues exist in the DCP trusted k=
eys
> implementation.
>=20
> First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
> without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
> a payload_len larger than 128, the subsequent do_aead_crypto() call
> writes past the end of the p->key array into the adjacent p->blob
> buffer within the same struct trusted_key_payload -- the caller's own
> input, not unrelated kernel memory.  While not exploitable, this
> violates strict array bounds and triggers static analyzers.  Fix this by a=
dding a validation check against
> MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
> matching the checks already done in trusted_core.c.
>=20
> Second, calc_blob_len() calculates a sum in size_t that truncates to
> unsigned int on 64-bit platforms.  Because the DCP hardware is only
> present on 32-bit i.MX SoC platforms, size_t and unsigned int are
> functionally equivalent in production, making this truncation harmless in
> practice.  Nevertheless, updating the return type to size_t (and
> subsequently updating 'blen' in the seal/unseal paths) resolves
> type-narrowing warnings and improves overall code hygiene.
>=20
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys=
")
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
> Changes in v2:
>  - Reframed commit message as correctness/hardening fix (Richard, Jarkko)
>  - Changed bare return -EINVAL to goto out for consistency
>  - Added Fixes tag
>=20
> Compile-tested with arm-linux-gnueabihf-gcc on imx_v6_v7_defconfig
> with CONFIG_TRUSTED_KEYS_DCP=3Dy (W=3D1, zero warnings). No DCP hardware
> available for runtime testing.
>=20
> security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trus=
ted-keys/trusted_dcp.c
> index 7b6eb655d..c078adebe 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -69,7 +69,7 @@ static bool skip_zk_test;
> module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
> MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zer=
o'ed");
>=20
> -static unsigned int calc_blob_len(unsigned int payload_len)
> +static size_t calc_blob_len(unsigned int payload_len)
> {
>    return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
> }
> @@ -200,7 +200,8 @@ static int encrypt_blob_key(u8 *plain_key, u8 *encrypt=
ed_key)
> static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)=

> {
>    struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
> -    int blen, ret;
> +    size_t blen;
> +    int ret;
>    u8 *plain_blob_key;
>=20
>    blen =3D calc_blob_len(p->key_len);
> @@ -242,7 +243,8 @@ static int trusted_dcp_seal(struct trusted_key_payload=
 *p, char *datablob)
> static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablo=
b)
> {
>    struct dcp_blob_fmt *b =3D (struct dcp_blob_fmt *)p->blob;
> -    int blen, ret;
> +    size_t blen;
> +    int ret;
>    u8 *plain_blob_key =3D NULL;
>=20
>    if (b->fmt_version !=3D DCP_BLOB_VERSION) {
> @@ -253,9 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payl=
oad *p, char *datablob)
>    }
>=20
>    p->key_len =3D le32_to_cpu(b->payload_len);
> +    if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE) {
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
>    blen =3D calc_blob_len(p->key_len);
>    if (blen !=3D p->blob_len) {
> -        pr_err("DCP blob has bad length: %i !=3D %i\n", blen,
> +        pr_err("DCP blob has bad length: %zu !=3D %u\n", blen,
>               p->blob_len);
>        ret =3D -EINVAL;
>        goto out;
>=20
> base-commit: 6d41c11ef3044788902a05e292cd7f0a9c7a8157
> --
> 2.53.0
>=20

LGTM and thanks for the fix!

Reviewed-by: David Gstir <david@sigma-star.at>

- David=
