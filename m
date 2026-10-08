Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5438F938;
	Thu,  8 Oct 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490457; cv=none; b=iy0XIsnmWKb73g1o/5cv2YCNm+UmEBRxWaVwJnGn/gCSYk2+FaeIIdfd/sn/4xN6Kvom5/7T/nz5PkjXgl+jRDwFIPEJTjEMcV2CmFutyyYQqAhcjmgFyUZDekwDqRIWWokHkV+XTmaJK84ecLcjDxrbMtnBqt7Rc4MxjnEh9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490457; c=relaxed/simple;
	bh=/8+SsgMl/gY+XVrnSDPWsbKUI5qnGzjJ0GkJ45qi8IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUu6hnogAgW0aeSyZ7pU5Y3p6JL0kkY+yHkhxMIIDL5ZCaKnJR+1cLNLHurs+AeFBDNp6z7jxz+GW464o8EzqRyjttZVB/djUDsYA69V3SGR4aanD+0rieuoBy4ivznVjslJ9mmacPmAipoIAIfZ/gEzLob+2w13Vr2lo4v1ZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewRBuql4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewRBuql4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 77ACF1F000FF;
	Thu,  8 Oct 2026 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791490456;
	bh=/NvnKHGXLbk4VmzkNLmmAbjoTKJnn7D79cYkpetkRc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ewRBuql4wYZpPouliH3MehegGnURJ4j7KuLBe7UVrtM47KeFQRtLMm38Zb7JD47h7
	 TGl2assaxvcs5Wq7FA9BrsEC1K1txyCLVGuZUkDc3BY90rDB4qn3btQqHfktusxd9W
	 dxsklBgYricHywKAnHX8oFsEyGxGH+y7wrZP21YDAFQ1QsApLbqy0yzC+6AFShEh/y
	 N2Wq+IDbv0U+fJ3mI36H28xoqda2v/EAbLUIagN7GFRtPX+5S8qFnktGsAK1Bk8bRW
	 S5wpsr2zBvksbpMvgojYjhrKC7vOLHLNyvxOXfDRGWwrbHgcGQjBznhSChAaNOegME
	 ezE9AsmIEDDSQ==
Date: Thu, 8 Oct 2026 23:14:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: adrimg3196@gmail.com
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH v2] KEYS: Fix key_reject_and_link() race with keyring
 restriction
Message-ID: <asf5kyDXUQ3z6RMv@kernel.org>
References: <CACO1+RQ5KXAAbjpiQ=cs0wLZ=z+=JQbW_-pgG+BM0f23W112Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACO1+RQ5KXAAbjpiQ=cs0wLZ=z+=JQbW_-pgG+BM0f23W112Tg@mail.gmail.com>

On Thu, Oct 08, 2026 at 11:18:02AM -0700, adrimg3196@gmail.com wrote:
> Jarkko, you're right — v1 arrived without the diff. Here's v2 with the
> full patch.

And it would not be your fault if it had gone to my PR as I have
ultimate responsibility for that part.

Anyhow, put side-notes under '---'. It's a good place for these
as it does not get pulled into the commit log.

For single-patch submission it is also great place to maintain
changelog.

> 
> The restrict_link check in key_reject_and_link() is done before taking
> the keyring semaphore, racing with a concurrent keyring_restrict()
> that installs the restriction while holding the semaphore in write
> mode.
> 
> This is the same pattern that commit dd3ea3fc ("KEYS: Fix add_key()
> race with keyring restriction") just fixed in __key_create_or_update()
> by moving the restrict_link snapshot to after the semaphore is taken.
> 
> Move the check under __key_link_lock() so a restriction installed
> concurrently cannot be bypassed when linking a negative key.
> 

Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")o
> Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> ---
Here.
>  security/keys/key.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -588,10 +588,17 @@ int key_reject_and_link(struct key *key,
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
> +			 * concurrent restriction install (cf. the fix for
> +			 * __key_create_or_update()).
> +			 */
> +			if (keyring->restrict_link) {
> +				__key_link_end(keyring, &key->index_key, edit);
> +				return -EPERM;
> +			}
>  			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
>  			if (link_ret < 0)
>  				__key_link_end(keyring, &key->index_key, edit);


Looks good to me, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
