Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351D3B47E0;
	Sat, 10 Oct 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660989; cv=none; b=Ah44J4H88CMOaqIY8KT/azFU/o9vi89DbxI+wSE997zoCEPoCH0Lxv0U3kQSNxwjSHaKyb4VChxtE76P/uTIfTdgQ6Gsd61KLpcdcezZfzEgMRRyPDOFVy3clgettlTc906aZzuGRDb8PPZQ6ngRGc+XXHUZnJsWFqbEUlCzf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660989; c=relaxed/simple;
	bh=stnjje7PBXd01YDuAcQKSJb1uW8u71kCPSetpCVnaUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwP840rOQOorXWLGOO0nlYX5UBxXRKHD38EkjwM9qwj5DF4utUzZKGlCCdwZeNur4b8KMmvfOcKlT6hBXaELKE0QM+BId7MkRgq0/JJxjMBpSfU5gRckfSTFWlFK4dZhbNA6uQSe3hSb5i6YrPVPj2zX0DGEpbioZgWs3xPLgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4AcsFY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4AcsFY2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 51CB21F000FF;
	Sat, 10 Oct 2026 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660986;
	bh=QymdtBP5gtYjoGrKNw/Pyt7UqAhfOCYaTv/txRxsA3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b4AcsFY2AsaFCtnfU1RcS15nJ54eufCwm1IMhlBoTd/KaeYABUElIOkhqIRvXfUy4
	 cNq29Rmt2jORjxvxycgP499h0cGUGiOzUNvc5MCK1+NTxWuf2/i12Z5movyV8Nq7jG
	 ickYQr4NzlZKqvcvV5k+a1C8RVYM308tIlg//683ju7mCQ4orTMc9ZHlfXQxVOAvJd
	 sIAVQow8DDxaNZIUDSWCslieDoNnH7JOu9S1yXG+IyCsoe6chOerWAQIVo9boN4Hp1
	 irBDz7A8MnBANiiG3QcstLP5xXhSslVHMvbQ0BjZkF8oNmI/YqbBO01vo7WQruM+kH
	 6j3DKDWa3CqJA==
Date: Sat, 10 Oct 2026 22:36:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: adrimg3196@gmail.com
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH v3] KEYS: Fix key_reject_and_link() race with keyring
 restriction
Message-ID: <asqTtizyto7y2wYn@kernel.org>
References: <CACO1+RT+m==BY+ZPkE+fo536D0qu3wog4xE1dfuXQ56g+=Qv=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO1+RT+m==BY+ZPkE+fo536D0qu3wog4xE1dfuXQ56g+=Qv=A@mail.gmail.com>

On Thu, Oct 08, 2026 at 02:03:51PM -0700, adrimg3196@gmail.com wrote:
> The restrict_link check in key_reject_and_link() is done before taking
> the keyring semaphore, racing with a concurrent keyring_restrict()
> that installs the restriction while holding the semaphore in write
> mode.
> 
> Move the check to after __key_link_lock(), so it is done under the
> semaphore, matching the pattern used in __key_create_or_update().
> 
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into
> a keyring")
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> ---
> Changelog:
>  v3: Add Fixes tag and Reviewed-by; resend with clean patch (v2 was corrupt).
>  v2: Resend with full patch (v1 arrived without the diff).
> 
>  security/keys/key.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 1234567..abcdefg 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -590,10 +590,17 @@ int key_reject_and_link(struct key *key,
>  	ret = -EBUSY;
> 
>  	if (keyring) {
> -		if (keyring->restrict_link)
> -			return -EPERM;
> -
>  		link_ret = __key_link_lock(keyring, &key->index_key);
>  		if (link_ret == 0) {
> +			/*
> +			 * Check the restriction under the keyring semaphore.
> +			 * keyring_restrict() installs it while holding the
> +			 * semaphore, so testing it beforehand races with a
> +			 * concurrent restriction install.
> +			 */
> +			if (keyring->restrict_link) {
> +				__key_link_end(keyring, &key->index_key, edit);
> +				return -EPERM;
> +			}
>  			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
>  			if (link_ret < 0)
>  				__key_link_end(keyring, &key->index_key, edit);

Thank you!

I applied this.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
