Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D043F0BE;
	Sat, 18 Jul 2026 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412804; cv=none; b=rSkH5i/OnotgSeYVwl3+Dh9ThJW4r7AvS4hInW4fb6CVePtbkgZd9386gZZpbZMCznIlmjwZgqZQilJlAbB7qCEH/4wHn7tClhkJYBaNbsbgZhSPB9E9WatT1IfZ0iDv7prRI/hS51oDwoxIuiBQKjf1W+LLoIT1Iy69n0t5Jj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412804; c=relaxed/simple;
	bh=T1aVrs5IooVqJkzM5Q7sf4lS/ZoqHn3ANDDuG7Z8nTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgj8bH3/CqBgdfOSb/Vg/Gth3BqcEiHuZysJw9q2Q6vjQSihUNpNial7ylW9pL/DMbflC9zM2+Y3O56zFAxD/XvEz81lVitgxCiOqmFzNjTlLSvOEMvjNGxWHh9y6FfMdr2vAEf1PuYyDrFUwQn1SO9nWV4GuE7ytV7sHZQUEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NctKCYEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NctKCYEF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3BADC1F000E9;
	Sat, 18 Jul 2026 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784412802;
	bh=+poMI5yAUMXafwr4PcPVpvR2i2P1N1Nx1E/ctOpCmrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NctKCYEFuG3CsQOkj6114Z3ZRQvBBNukMUCN30NShr1xKUe0PlJXYPhTSLjFbO5CL
	 DUv77aIO6u1lqyynR5HGfV9AmXvacVWqSvs+9QUpkVnfSCfyzOZzRV0+Fp3fH+piZt
	 tf8Nbm3UO2ng2xItGaMjq0TKIOMi8Me1gPGnka7d7/dsV2PLl1iso8QBCJ+X2YCQg5
	 M5Yg+6osaaaYVlhbW8KgPu5ip8cDpngEjOMzYaqHUNJYh28MabllcghEg6LpS7pAxu
	 E9g3Flpo0rfZo7ykKOz51/X0LinGuBOOl2Sc4T8ks3ZskS2BkfIlubvMI+DS4YFbnt
	 sy0/jc9BRna1A==
Date: Sun, 19 Jul 2026 01:13:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Fabrice Derepas <fabrice.derepas@canonical.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	david@sigma-star.at, upstream+dcp@sigma-star.at,
	zohar@linux.ibm.com, dhowells@redhat.com
Subject: Re: [PATCH] KEYS: trusted: dcp: fix key_len validation and
 calc_blob_len() return type
Message-ID: <alv6fmIKjTBguKFE@kernel.org>
References: <20260718202820.1890313-1-fabrice.derepas@canonical.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718202820.1890313-1-fabrice.derepas@canonical.com>

On Sat, Jul 18, 2026 at 10:28:17PM +0200, Fabrice Derepas wrote:
> Two defects in trusted_dcp_unseal() combine to allow a heap
> out-of-bounds write in kernel context.
> 
> The primary defect is a missing upper-bound check:
> trusted_dcp_unseal() reads p->key_len from an attacker-supplied blob
> with no validation that it is at most MAX_KEY_SIZE (128).  It then
> passes p->key_len + DCP_BLOB_AUTHLEN to do_aead_crypto() as the
> operation length.  Because p->key is only MAX_KEY_SIZE + 1 = 129
> bytes, any payload_len above 128 in the blob overruns p->key.  On
> implementations where AES-128-GCM decryption writes plaintext before
> verifying the authentication tag, up to 330 bytes of out-of-bounds
> heap overwrite can occur before -EBADMSG is returned.
> 
> The secondary defect is an integer overflow in calc_blob_len(), which
> computes its sum in size_t but returns unsigned int, truncating the
> result on 64-bit platforms.  This allows a crafted blob with
> payload_len near UINT_MAX to bypass the sanity check
> (blen != p->blob_len).  Due to a second wrap in the expression
> p->key_len + DCP_BLOB_AUTHLEN (computed in unsigned int at the call
> site), the len value that reaches do_aead_crypto() via this path is
> at most 15 bytes and does not directly amplify the OOB write, but
> the integrity check bypass must be fixed.
> 
> Fix the primary OOB by validating p->key_len against MIN_KEY_SIZE
> and MAX_KEY_SIZE immediately after reading it from the blob, matching
> the validation already performed in trusted_core.c on the Opt_new
> path.  Fix the overflow by changing the return type of calc_blob_len()
> to size_t; update the two blen declarations from int to size_t to
> avoid narrowing-conversion warnings, and update the pr_err format
> specifier for blen accordingly.
> 
> The seal path is not affected: p->key_len is validated by
> trusted_core.c before trusted_dcp_seal() is called, and the
> blen > MAX_BLOB_SIZE guard provides defence in depth there.
> 
> Exploitation requires high privileges.  The unseal path is reached
> via add_key("trusted", ..., KEY_SPEC_*) with the Opt_load command,
> which requires write permission to a keyring that accepts trusted
> keys -- in practice CAP_SYS_ADMIN.  Additionally,
> CONFIG_TRUSTED_KEYS_DCP must be enabled. The attacker must also supply
> a crafted sealed blob, which in the typical dm-crypt use case means
> either physical access to modify on-disk key material or a prior
> compromise of a privileged process that writes the blob.

This is hypothesis of an exploit at most.

The change look while but this paragraph is way too abstract
to qualify for anything.

> 
> How this was found:
> Found by applying the Squeeze Loop strategy ("The Squeeze Loop
> Strategy: Catching Coherent-and-Wrong Artifacts with an
> Author-Independent Executable Oracle," Zenodo
> DOI 10.5281/zenodo.20787816, 2026) on its C terrain using
> deductive verification.  The formal proof of calc_blob_len (12/12
> goals discharged) required a no_wrap precondition on payload_len;
> removing that precondition caused 3 of 6 proof goals to fail.
> Tracing the caller path confirmed the bounds bypass and the missing
> key_len validation.
> 
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> ---
>  security/keys/trusted-keys/trusted_dcp.c | 13 ++++++++++---
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
> index XXXXXXXXXXXXXXXX..YYYYYYYYYYYYYYYY 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -69,7 +69,7 @@ module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
>  MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zero'ed");
>  
> -static unsigned int calc_blob_len(unsigned int payload_len)
> +static size_t calc_blob_len(unsigned int payload_len)
>  {
>  	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
>  }
> @@ -200,7 +200,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
>  {
>  	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
> -	int blen, ret;
> +	size_t blen;
> +	int ret;
>  	u8 *plain_blob_key;
>  
>  	blen = calc_blob_len(p->key_len);
> @@ -242,21 +243,25 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
>  {
>  	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
> -	int blen, ret;
> +	size_t blen;
> +	int ret;
>  	u8 *plain_blob_key = NULL;
>  
>  	if (b->fmt_version != DCP_BLOB_VERSION) {
>  		pr_err("DCP blob has bad version: %i, expected %i\n",
>  		       b->fmt_version, DCP_BLOB_VERSION);
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	p->key_len = le32_to_cpu(b->payload_len);
> +	if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE)
> +		return -EINVAL;
> +
>  	blen = calc_blob_len(p->key_len);
>  	if (blen != p->blob_len) {
> -		pr_err("DCP blob has bad length: %i != %i\n", blen,
> +		pr_err("DCP blob has bad length: %zu != %u\n", blen,
>  		       p->blob_len);
>  		ret = -EINVAL;
>  		goto out;
> -- 
> 2.43.0

As said, code changes themselves look reasonable but the commit message
is painting a picture of impact that this bug really does not have.

BR, Jarkko
