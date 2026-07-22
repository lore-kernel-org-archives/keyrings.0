Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590645A292;
	Wed, 22 Jul 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734181; cv=none; b=ePklpJGU43oSEkSpfBXGyYxhRhXsPWPVHTXa4pLUZWKCo+p6nXwO7XD9u1RnhSRaZjQuRwpekmJYicoqPL8LgrWrjD15Hs1QvOUV4K97nb/AVgD41CubgdS4/rOQ71RJ1oauRbYPLMW2E0gXK2AbFjCD7CjYp3xBxD4bxo3vLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734181; c=relaxed/simple;
	bh=KRZ7jSVXPG07u3iEJwh2GqUvHVhdlj7HV1kHpA0w7FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Lv1HJ5vpuB173t0WFSzPhWxVvEYOPw0y8OhAs9ge30+6ntRs55n4QqT72CEuvNfd02DEIT51I4mkQg14Iogux5lM8JMVz1Z/pT+NxHizGBM/G7Y5D8dvftqck3f4eg4ZUbbRQKfO0rPFStf7jNDP6hjpHH75FvS+Gh6FE/ZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmiPnMdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmiPnMdd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D2A211F000E9;
	Wed, 22 Jul 2026 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734171;
	bh=1dG8/slgIIsIELLRRrEi2KjmBulSNoH2tpSJ0p9eyWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmiPnMdd1GTcVxlNPpUXh05t3vsLvr4eHjFlCUQAujjCz2mwcCYkaBG+tKej/aMwl
	 +VdMco9hVDAHwcrRyF/gtRahov8SfTH+Ym8hzYqPcNXcE0m64pL/08Usfati7GGaLJ
	 6UebPOvOmDSesK7mDefL+pXNEvtFN087FF3sd6nQGUOMQfdjoFSDsbhHVIT/++VFL0
	 2Rh3H+R3assGfeXk8w1hqjNBSoKn4mjiDaUhW79JguDjjvZmYEh+hYXFCzh3Mb9Bp3
	 euxsHM8SWGD3ciERwI4FGy+1b6aVniPHK1trj/55KFti5rMsPnhJZB6fln5mJi1v5u
	 4EeOlxffozk2Q==
Date: Wed, 22 Jul 2026 18:29:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Gstir <david@sigma-star.at>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	upstream+dcp@sigma-star.at, zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: Re: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and
 calc_blob_len() return type
Message-ID: <amDh1y9FJxtAsaBc@kernel.org>
References: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
 <1EDDC226-1CDE-4A17-968D-EBA26E81B596@sigma-star.at>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1EDDC226-1CDE-4A17-968D-EBA26E81B596@sigma-star.at>

On Mon, Jul 20, 2026 at 12:34:54PM +0200, David Gstir wrote:
> Hi Fabrice,
> 
> > On 19.07.2026, at 18:41, Fabrice Derepas <fabrice.derepas@canonical.com> wrote:
> > ﻿Two correctness and type-hygiene issues exist in the DCP trusted keys
> > implementation.
> > 
> > First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
> > without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
> > a payload_len larger than 128, the subsequent do_aead_crypto() call
> > writes past the end of the p->key array into the adjacent p->blob
> > buffer within the same struct trusted_key_payload -- the caller's own
> > input, not unrelated kernel memory.  While not exploitable, this
> > violates strict array bounds and triggers static analyzers.  Fix this by adding a validation check against
> > MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
> > matching the checks already done in trusted_core.c.
> > 
> > Second, calc_blob_len() calculates a sum in size_t that truncates to
> > unsigned int on 64-bit platforms.  Because the DCP hardware is only
> > present on 32-bit i.MX SoC platforms, size_t and unsigned int are
> > functionally equivalent in production, making this truncation harmless in
> > practice.  Nevertheless, updating the return type to size_t (and
> > subsequently updating 'blen' in the seal/unseal paths) resolves
> > type-narrowing warnings and improves overall code hygiene.
> > 
> > Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
> > Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> > ---
> > Changes in v2:
> >  - Reframed commit message as correctness/hardening fix (Richard, Jarkko)
> >  - Changed bare return -EINVAL to goto out for consistency
> >  - Added Fixes tag
> > 
> > Compile-tested with arm-linux-gnueabihf-gcc on imx_v6_v7_defconfig
> > with CONFIG_TRUSTED_KEYS_DCP=y (W=1, zero warnings). No DCP hardware
> > available for runtime testing.
> > 
> > security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
> > 1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
> > index 7b6eb655d..c078adebe 100644
> > --- a/security/keys/trusted-keys/trusted_dcp.c
> > +++ b/security/keys/trusted-keys/trusted_dcp.c
> > @@ -69,7 +69,7 @@ static bool skip_zk_test;
> > module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
> > MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zero'ed");
> > 
> > -static unsigned int calc_blob_len(unsigned int payload_len)
> > +static size_t calc_blob_len(unsigned int payload_len)
> > {
> >    return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
> > }
> > @@ -200,7 +200,8 @@ static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
> > static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
> > {
> >    struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
> > -    int blen, ret;
> > +    size_t blen;
> > +    int ret;
> >    u8 *plain_blob_key;
> > 
> >    blen = calc_blob_len(p->key_len);
> > @@ -242,7 +243,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
> > static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
> > {
> >    struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
> > -    int blen, ret;
> > +    size_t blen;
> > +    int ret;
> >    u8 *plain_blob_key = NULL;
> > 
> >    if (b->fmt_version != DCP_BLOB_VERSION) {
> > @@ -253,9 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
> >    }
> > 
> >    p->key_len = le32_to_cpu(b->payload_len);
> > +    if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE) {
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +
> >    blen = calc_blob_len(p->key_len);
> >    if (blen != p->blob_len) {
> > -        pr_err("DCP blob has bad length: %i != %i\n", blen,
> > +        pr_err("DCP blob has bad length: %zu != %u\n", blen,
> >               p->blob_len);
> >        ret = -EINVAL;
> >        goto out;
> > 
> > base-commit: 6d41c11ef3044788902a05e292cd7f0a9c7a8157
> > --
> > 2.53.0
> > 
> 
> LGTM and thanks for the fix!
> 
> Reviewed-by: David Gstir <david@sigma-star.at>
> 
> - David


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

And applied (not yet pushed, will after end of my inbox)

BR, Jarkko
