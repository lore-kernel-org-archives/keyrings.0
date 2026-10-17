Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B33148B4;
	Sat, 17 Oct 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253997; cv=none; b=jHM4Z7VbwcsdVnp9QmsJQl3iBa2p1loFnHn2XhTJvmzzl1tEzbsxgPwsKaesLmQ2kfjYzuaei8UWPcsXfL5I6JscHJCs0XT2Vo53rcH9UBA0tNz3Hcg7kNlWqOJI1Z6hXGUjRkDDkoatUVEBWXLvYxEwA5qEGbux1TsT9O99C9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253997; c=relaxed/simple;
	bh=H3h+/XJBm90L4yWF78CctE8u2K/uHt7GPg73IjdoBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwjqTMkfGpIA2fXZsEmqy701+ShEskC3jhsuR8B8Rcg0hRpuR+ZqzUcbH8K2yy5RAYtmxmUcCqUgB9d/ZnRA0eYBKMDY9lSY3lZ2Ff/Ib7ShgaxSDrj3oNs7WrNHwTLLUuQ6qmrjKGXY4ABx67yHHOIRTFmf8KMqOs/jndYBLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9uxqpDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9uxqpDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432851F000C5;
	Sat, 17 Oct 2026 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792253996;
	bh=NkvmSmzMUtp5UIXHHshWv4X5CNVlPpRWp5WuWjbaiNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K9uxqpDaFo1/yJZcnbSl/RyB0oY3m5Clriz3QV/Ir6eadVbrEh/TKEmpPRYBbKbO8
	 DO7uRl/6kLSWtJin7KA7ozaeR7EgEPQ0GsRZYMdZtvbIS9LnTsxzE1h3pA57V08fDK
	 3AfgnkAI286pz4+u68pWPekwlcKt9PndYbGKa4u0zTgSDvBFwFT5xUn10jImwftCHe
	 o5vOr3i1+CKVbLdkuWulE/5TjtTbh/gD92gQ78ZMyy0kVlyyl1e+DIU4jhu2e3lCrn
	 0lB2Cfw6bzbR9i1duE8H8xYM5fTevnKxjfxUMHxNzXyKGy/IhvvhwdhDGdi/y4bnHW
	 pOXoGIC4O6rwQ==
Date: Sat, 17 Oct 2026 19:19:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Cen Zhang <zzzccc427@gmail.com>, dhowells@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	sergeh@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <atOgKLjra7xg19HL@kernel.org>
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017035156.GA29318@sol>

On Fri, Oct 16, 2026 at 08:51:56PM -0700, Eric Biggers wrote:
> On Fri, Oct 09, 2026 at 01:11:59PM +0800, Cen Zhang wrote:
> > Named keyring lookup must keep the storage containing the owner UID
> > alive through the namespace mapping check.  find_keyring_by_name()
> > reads keyring->user->uid under keyring_name_lock, but that lock protects
> > the keyring's name entry and allocation, not its separate key_user.
> > 
> > A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
> > another CPU.  If the keyring holds the last reference to its old dynamic
> > key_user and the ownership transfer succeeds, the following ordering is
> > possible:
> > 
> >     Named join                         Chown
> >     find_keyring_by_name()              keyctl_chown_key()
> >       read_lock(keyring_name_lock)       down_write(key->sem)
> >       load old keyring->user
> >                                          replace key->user and key->uid
> >                                          up_write(key->sem)
> >                                          key_put(key)
> >                                          key_user_put(old user): free
> >       read old user->uid
> >       read_unlock(keyring_name_lock)
> > 
> > Chown neither takes keyring_name_lock nor key_session_mutex, so it can
> > free the old account between the pointer load and the UID read.  The
> > lookup then reads freed memory even though the keyring itself is alive.
> > 
> > Use keyring->uid for the mapping check.  key_alloc() initializes this
> > inline owner UID and keyctl_chown_key() updates it on chown.
> > The existing name lock keeps its containing keyring allocated throughout
> > the check, so lookup no longer depends on the account's lifetime.  This
> > also matches the owner UID used by the permission check.
> > 
> > KASAN report as below:
> > 
> >     BUG: KASAN: slab-use-after-free in find_keyring_by_name+0x577/0x5d0
> >     Read of size 4 at addr ffff8881128ae2ec by task keycase/500
> > 
> > Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> > Assisted-by: LLM
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> 
> Don't key_serial_next() and find_ge_key() (used when reading from
> /proc/keys) have the same bug?

With just a quick Saturday skim, yep, I think so.

> 
> - Eric

Br, Jarkko
