Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11542135AD;
	Sat, 30 May 2026 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102928; cv=none; b=Po0CC8ryjU/nMujRBhcx3v4O1y3jCkamygvISBg/5LeOkB1BTKWPBTAZ1IrV5Bu6HPX70+/2mSGeD/rArPS7EOfQ98Aoz1GKi3cTos1PhyIogHVFhx2pWRhfVWfUBRFh7fBzNsn6NtjJoQPIaxeTI3HmNpOt9/n9a/WNslmz+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102928; c=relaxed/simple;
	bh=4+/yN9Vu4aHkmxWbtR3H0kgV7yqPfzo8V9Y4G4SxU7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld6NcsBw3cYK9iHn+myIGs3eo15YIi15vxkFsw4TmXEkZF5S27O/Atb2r2lQH9KUDs/vwdNzcuESfv23jiC20NPCPkAzfXcfeuB/Oz96IxrEkMfSxihvP5i4QsQPPInKJ2OUUEH0G3XEMsAcSdANeB8SYzAa9I/o+1ysiISqNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNaNCvbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNaNCvbT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7ABB61F00893;
	Sat, 30 May 2026 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102926;
	bh=o/iBMpILM5fjzGP147xpXcruSgUjLjBUlCRIN0zUHUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NNaNCvbTv2xRE+fjl+qVMnM3clvjNy7GKSxKVyQDCdPZWNsjTMOkrOs0e45chNOn7
	 vFXqOR4sF/BmahwraIs6o3AxNjbTyjvKCQnSPjuHwGjqFeksowLX7X/Lx0jmyFpP8q
	 3dqHZSkYPEo7M0YVJpD+yOLhtxyC3+5CyTTnNokI2kiFgMe78V+dKK2CF1p4Uv+JD3
	 Qr928BO7ic0ZUjGIUkLdeJ53eUoc4oJpnAW3OcTKmBozvdZzmN4IzrawEFNZz4NtRY
	 vz44t8ctnmed3fpMor3GKPXP+RX9yv8i1ZgQrf7NrKqEd9a67cq/9OFFXL4CUI5Sn+
	 sYuwEroMi+BlA==
Date: Sat, 30 May 2026 04:02:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, dhowells@redhat.com, ebiggers@google.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] KEYS: Use acquire when reading state in keyring search
Message-ID: <aho3CYdv8lQd2s85@kernel.org>
References: <20260529033406.20673-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529033406.20673-1-hanguidong02@gmail.com>

On Fri, May 29, 2026 at 11:34:06AM +0800, Gui-Dong Han wrote:
> The negative-key race fix added release/acquire ordering for key use.
> 
> Publish payload before state; read state before payload.
> 
> keyring_search_iterator() still uses READ_ONCE() before match callbacks.
> An asymmetric match callback calls asymmetric_key_ids(), which reads
> key->payload.data[asym_key_ids].
> 
> Use key_read_state() there to complete that ordering.

OK, so... I'm having a bit trouble understanding the exact concurrency
scenario you're trying to describe despite I think I get the fix itself
i.e. it is not pairing with mark_key_instantiated?

I'm a bit puzzled too why this was not done already in the original
commit despite introducing all the primitives.

> 
> Fixes: 363b02dab09b ("KEYS: Fix race between updating and finding a negative key")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> Found by auditing READ_ONCE() used for synchronization.
> A similar fix can be found in 8df672bfe3ec.
> ---
>  security/keys/keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index b39038f7dd31..243fb1636f10 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -576,7 +576,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
>  	struct keyring_search_context *ctx = iterator_data;
>  	const struct key *key = keyring_ptr_to_key(object);
>  	unsigned long kflags = READ_ONCE(key->flags);
> -	short state = READ_ONCE(key->state);
> +	short state = key_read_state(key);
>  
>  	kenter("{%d}", key->serial);
>  
> -- 
> 2.34.1
> 

BR, Jarkko
