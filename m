Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183433F36D;
	Sat, 17 Oct 2026 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792209119; cv=none; b=h/gxS947nLlkNQNzCxU6Wg+oRxQRWl3RDO6SEmZUkiQcdFyhbWyzpewI4UA/QcIYZS1nDPESRMSBGBGrLOQ3PByOd6FPd15Dp2WTjsVZ7oflii/JtTvtFLUEOZ2y61mUAM+hi5W1QQqhLaJNpOrHyhm//UbPecAY4FYf2aH5bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792209119; c=relaxed/simple;
	bh=0kHNInWyrGfHzOywW9v3xN4Fsow3y55nnfmUA+kTdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji0SPC38hEohKg6/t6WCcfJ3cok39H5nCPAKL3YvANSzLtkYglRQm7H2WDtcd5ntGm7SlkwMyNprSHsyxdlY4kLdGUwNfvFO9vAUe2briAsLga7cJREdpnYnlXa/3SD8T7JW6I9khhX1+usjwVcdaPxEUAunSvfFubhiVi3Ep1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7y1VIsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7y1VIsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB22B1F000C5;
	Sat, 17 Oct 2026 03:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792209118;
	bh=nqqN35sbkhZOuTBZGbPNKsmFPTIVSQaOD0LYbdzQJxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g7y1VIsAVMF4gZEZk2dZRfko0UlOYz9FuNxxMmhrKTDPA/EMjMeRzQjWlpCaQjtdF
	 wFIj6mBTQjrdOC7shJgtVETdev9KQx7+yDjSgiVg33262ruIQkqHyBG1QyR0ROv7p8
	 17NQfSY/09EUNnV1bHAi1HGLHBgu+cjNORi6bDzVp09fQJSasYcetDOHCHheoToKXV
	 /NZ35/ad4lf1eKg0ZO4ugDaE8t0I8EAjEeh1Z1omVXnyJYKk4XR9thuS9dJtZRqdM9
	 Hi8k5bS+sro3TSoUjXxbGyC6TgV40wticKnHhNbTLoZZWyPLodHQzOroKrQAn6pfpZ
	 udyhBPHzqKf+A==
Date: Fri, 16 Oct 2026 20:51:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, sergeh@kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <20261017035156.GA29318@sol>
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

Don't key_serial_next() and find_ge_key() (used when reading from
/proc/keys) have the same bug?

- Eric
