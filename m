Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D8359A81;
	Sat, 10 Oct 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791665447; cv=none; b=r/wER/q61OlA7rQmp6yoW4/yv2l72tGN3k+rh7dQg/Q6fpDGc2vXfll75YV80+zuTShuXvyQlNwpBM90gwJ/AUG/2e6fd2NcVOuP1JdiYqtMxlpMXph/bIdO3e95QEy9kDN/DZHbBb6c0CBuVF+LRvLMCH51SejoElEDF1pemQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791665447; c=relaxed/simple;
	bh=rmVAilQeWkl5we9LBhjSiRFgWd6NY0cKWQ0ZYZHFwa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2kcnzsQeYF7P7bwmFnWOIjuS6ouIPvLl0RwjcCQXC/DmCFsgIgVo9c3T2u4OTtjMwygZ7RbA23A84gfIaQSfw6OaK3DbarS3SEjQh1IFVmA6gL9RYS774Wp94FvEjtJlqY4aHHnQw//AV5bgtZgXxYbXgjJklGiVR44kPYOF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akl7m70R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akl7m70R"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9652C1F000FF;
	Sat, 10 Oct 2026 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791665446;
	bh=X0Q45XJ4iggMQCr/4N98LuVD5wDJk4kXpIcHEMRsaWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Akl7m70RmTXTcMnrP3KwETYDNh5Rboo51U1QZ5eQYSHe0vUr3E4YlyAzDpc/ZmDiU
	 fDUy6LdruKbc3t/LZLmgIgTK0o7iLT3S1TJY1Y+IL1tjinMf2PsOB0H8H/reLlD8gA
	 1F/nE9on5Hm5jHAzpd5lkb0MVjT3h2a+s6iILdd7rnb0bfevxIwMhfJHMKZGt/6bTr
	 wPVnkGLWc6isXlnJUu+44+spE+QrztF2MsgFD/gpG0lPxOv8+tImnvP+opTfGKkTOo
	 Fbr+xx72fbNL74hNQK9LuwQLhTAkdvhkJurpTuZcQ32c0k5MUmD5F9oY5K/NHPqA8J
	 m+HkA5S953oFg==
Date: Sat, 10 Oct 2026 23:50:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, sergeh@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <asqlIhgBFnybHIBT@kernel.org>
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>

On Fri, Oct 09, 2026 at 01:11:59PM +0800, Cen Zhang wrote:
> Named keyring lookup must keep the storage containing the owner UID
> alive through the namespace mapping check.  find_keyring_by_name()
> reads keyring->user->uid under keyring_name_lock, but that lock protects
> the keyring's name entry and allocation, not its separate key_user.
> 
> A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
> another CPU.  If the keyring holds the last reference to its old dynamic
> key_user and the ownership transfer succeeds, the following ordering is
> possible:
> 
>     Named join                         Chown
>     find_keyring_by_name()              keyctl_chown_key()
>       read_lock(keyring_name_lock)       down_write(key->sem)
>       load old keyring->user
>                                          replace key->user and key->uid
>                                          up_write(key->sem)
>                                          key_put(key)
>                                          key_user_put(old user): free
>       read old user->uid
>       read_unlock(keyring_name_lock)
> 
> Chown neither takes keyring_name_lock nor key_session_mutex, so it can
> free the old account between the pointer load and the UID read.  The
> lookup then reads freed memory even though the keyring itself is alive.
> 
> Use keyring->uid for the mapping check.  key_alloc() initializes this
> inline owner UID and keyctl_chown_key() updates it on chown.
> The existing name lock keeps its containing keyring allocated throughout
> the check, so lookup no longer depends on the account's lifetime.  This
> also matches the owner UID used by the permission check.
> 
> KASAN report as below:
> 
>     BUG: KASAN: slab-use-after-free in find_keyring_by_name+0x577/0x5d0
>     Read of size 4 at addr ffff8881128ae2ec by task keycase/500
> 
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Changes in v2:
> - Trim the KASAN report to its two-line fault summary.
> 
> Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f28218ec3f12c97630d1c76939af7eca..46f774be72967a9bd16b0ddfdf323eda36edeff4 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	 * grants Search permission and that hasn't been revoked
>  	 */
>  	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -		if (!kuid_has_mapping(ns, keyring->user->uid))
> +		if (!kuid_has_mapping(ns, keyring->uid))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))

Thanks.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
