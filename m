Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9189314A95;
	Mon,  8 Jun 2026 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890305; cv=none; b=E2xgmhq3csbnasxUXezXdH2bvUAAHoohlsH0eknHxNgbV0NV0hibIr3kqS3yLgXhIClJwzXmWw7yVdfSeSsVaiGQCwydLHrWWicq86iBCD5uq56McN9qlrhogLg58TPKkV74pUyWGNAhISL1EiqdCEr72uAYpZHIgFmMZ1veYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890305; c=relaxed/simple;
	bh=DB2C3qhNqL1Sh2L4rOD00fc1fGbz3c6lth40ZkimSwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Ou2NYmhS6W6KJR9jh2rtJ7t3qksK/edhq5nzPiFEmE+zM4gQ2VP7md6fwmYTrLfprWBxFqpl5iQqj3dO2ZjLWEpE4n9J3hu1E9PTaENWSV4bWFc3Ur+dkBtKxO1cEXpcNd8NF2O0pzDmD5pe2090c3ooWAkhRVVWYnBXW9Z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiOOiRqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiOOiRqc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EC69D1F00893;
	Mon,  8 Jun 2026 03:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890304;
	bh=nywqWWTP2YNFb9LBdBNza4lliXJBAKQh0NIhiSqrn6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kiOOiRqcRf2h8AnDiLoqzsgeFQzMMyUX+bxZutlPi2efvQADsLNIV+5x2QzUidBt7
	 MCSKH0QAN0vM2LM4YpA9yas3BtX9A6r2muOHs2/wOYYTXYEZkTdAJfXwqA4G3w1exV
	 qFppc7nPwRVk0iSvZZNKrv3vugYHqberT3I5GBHHUMKwULIGYHgdlHTPeGZ6KSHQ7v
	 lpHdC/oBqe8JrSwZQhieAMIv0EqUlkiqnJw9JrGwAw03hrCSCB0RbQNIt3X7xPTFJp
	 RSG4aCS46AtENJbDhzrbIINEBtv5NCaNs0obxq5j/vwWFWlS+vXjosv1TjWCFsV50V
	 SJ8eoBrsn/0vQ==
Date: Mon, 8 Jun 2026 06:45:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Liu Mingyu <Edwardliu0214@outlook.com>
Cc: David Howells <dhowells@redhat.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] keys: Enforce keep guard when moving keys
Message-ID: <aiY6vNLxs5y5YOPX@kernel.org>
References: <20260531205059.mliu-keyrings-v2-0@outlook.com>
 <20260531205059.mliu-keyrings-v2-1@outlook.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531205059.mliu-keyrings-v2-1@outlook.com>

On Sun, May 31, 2026 at 08:51:49PM +0000, Liu Mingyu wrote:
> KEYCTL_MOVE removes the source link as part of moving a key
> between keyrings. key_unlink() rejects removal of a
> KEY_FLAG_KEEP-protected key from a KEY_FLAG_KEEP-protected keyring,
> but key_move() did not enforce the same rule.
> 
> Reject such moves with -EPERM when both the source keyring and key

"Enforce the same resriction in key_move() with -EPERM ..."?

> are protected. Leave same-keyring moves as a no-op so callers can
> continue to use KEYCTL_MOVE idempotently. Document the errno so
> callers can distinguish the protected removal case.
> 
> Fixes: ed0ac5c7ec37 ("keys: Add a keyctl to move a key between keyrings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Liu <edwardliu0214@outlook.com>
> ---
>  Documentation/security/keys/core.rst | 1 +
>  security/keys/keyctl.c               | 2 ++
>  security/keys/keyring.c              | 7 ++++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index 326b8a973828..6096ce6c63da 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -600,6 +600,7 @@ The keyctl syscall functions are:
>       A process must have link permission on the key for this function to be
>       successful and write permission on both keyrings.  Any errors that can
>       occur from KEYCTL_LINK also apply on the destination keyring here.
> +     If the key and source keyring are protected, EPERM will be returned.
>  
>  
>    *  Unlink a key or keyring from another keyring::
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index ef855d69c97a..b37bf1505ec5 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -590,6 +590,8 @@ long keyctl_keyring_unlink(key_serial_t id, key_serial_t ringid)
>   * the caller Write permission.  There must also be a link in the from keyring
>   * to the key.  If both keyrings are the same, nothing is done.
>   *
> + * If the key and source keyring are protected, -EPERM will be returned.
> + *
>   * If successful, 0 will be returned.
>   */
>  long keyctl_keyring_move(key_serial_t id, key_serial_t from_ringid,
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5a9887d6b7be..60c184bd9a8d 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1582,7 +1582,8 @@ EXPORT_SYMBOL(key_unlink);
>   *
>   * Returns 0 if successful, -ENOTDIR if either keyring isn't a keyring,
>   * -EKEYREVOKED if either keyring has been revoked, -ENFILE if the second
> - * keyring is full, -EDQUOT if there is insufficient key data quota remaining
> + * keyring is full, -EPERM if this would remove a protected key from a
> + * protected keyring, -EDQUOT if there is insufficient key data quota remaining
>   * to add another link or -ENOMEM if there's insufficient memory.  If
>   * KEYCTL_MOVE_EXCL is set, then -EEXIST will be returned if there's already a
>   * matching key in @to_keyring.
> @@ -1608,6 +1609,10 @@ int key_move(struct key *key,
>  	key_check(from_keyring);
>  	key_check(to_keyring);
>  
> +	if (test_bit(KEY_FLAG_KEEP, &from_keyring->flags) &&
> +	    test_bit(KEY_FLAG_KEEP, &key->flags))
> +		return -EPERM;
> +
>  	ret = __key_move_lock(from_keyring, to_keyring, &key->index_key);
>  	if (ret < 0)
>  		goto out;
> -- 
> 2.51.2.windows.1
> 

That would makeobvious that something is missing here.

BR, Jarkko
