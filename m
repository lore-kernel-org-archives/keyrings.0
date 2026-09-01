Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79862383C93;
	Tue,  1 Sep 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269433; cv=none; b=FnZgSaXg9eNDQZcDz3j7dc1S0kDe8Z2tKV/gqqCMfhmFjkRD6cTP4jz0+soophGwx3YYG/qxOUhEVnwstoY1tZ3ejqMOY9GD+gSLVsGk4eGibXqsbmbC1JdW/lggkm5Qk7LH1BLsa2ir8h6veQcSHjVvxhixVFfrO9yJmUgAzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269433; c=relaxed/simple;
	bh=O9WHREr9BPWQkUYzuzB9Vacqtpd2xznMaYHzQNKjSx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j75ZHWNL5pGYrKhqwEkXcuXgdt7+zHUsOQFGr9O1Jw/NeAJ93qy/hg5Ex1DYGMjQUIqzh+edCq6fQA6kQTQiGex5JORFFfo2+zPw08TR2y7OuQQMabu+OUXcxfkHAfwwJuND2rWzeegLTq7w9zZlAwM8KUzqEF4Tb6bGrC06z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBfk8E0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBfk8E0/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CEB031F000E9;
	Tue,  1 Sep 2026 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269431;
	bh=YbJKsihIEL3iTlpT0PPP0qrj+KIlUNzWEvcENpLfI7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBfk8E0/QAGRWE1agjQVpoFkg6Z3SrRc4rdi12/+YH9u6prI2qocDME2IhTBsz/2W
	 TEWBe11fYXVTqQ2kkDRUJCVJhjysut07rtr6SMyoIJPHKYFQVX63QMR0wIYaMbfXji
	 NmP0Vb/d6PgTsdQmOV6xMXJJTk1Qz4Hk4n8uVmhZdt88yrg4I9DHVPju7y1J03K2Yg
	 89/5ZZD3xnc3A06XfKjq4nfU+/IKKMGPwWVYl0F+CrGufdivse7DHCmHS1gXrrRgQf
	 aecp+bPCOWHmI5ej/WhVhc/kk8Oe3P3cfzir+eBwIvEmEYUSsVscF7Zz7EJ8zv2NuF
	 9fJDaNXasIzDg==
Date: Tue, 1 Sep 2026 16:30:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: set persistent keyring timeout before destination
 linking
Message-ID: <apbTc9BisLTqBaE_@kernel.org>
References: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>

On Sun, Aug 30, 2026 at 08:20:26PM +0200, Karl Mehltretter wrote:
> keyring_alloc() links a newly created persistent keyring into the
> namespace's hidden register with TIME64_MAX expiry.
> key_get_persistent() sets the configured timeout only after linking the
> keyring into the caller's destination.
> 
> If the destination rejects the link, the registered keyring retains
> infinite expiry. It is exempt from key quota and can remain until namespace
> teardown or reboot even though the syscall returned an error. At most one
> such keyring exists per UID per namespace. Repeated failures for the same
> UID therefore strand only one small allocation.
> 
> This is reachable from unprivileged userspace: KEYCTL_RESTRICT_KEYRING on
> the destination makes key_link() return -EPERM via restrict_link_reject(),
> after key_create_persistent() has already registered the keyring.
> 
> Set the timeout immediately after creating and registering the keyring. A
> later permission or destination-link failure then leaves a collectible
> persistent keyring. The successful path may refresh the same timeout again
> without changing its semantics.
> 
> Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested with QEMU 10.2.1 TCG. The reproducer set
> /proc/sys/kernel/keys/persistent_keyring_expiry to 60 seconds, restricted
> the destination with KEYCTL_RESTRICT_KEYRING, and then called
> KEYCTL_GET_PERSISTENT. No LSM policy was loaded.
> 
>                       syscall result  /proc/keys expiry
>   i386 baseline       -EPERM          perm
>   i386 patched        -EPERM          1m
>   x86_64 patched      -EPERM          1m
> 
> Full kernel builds completed for i386 and ARM926, and for x86_64 with
> CONFIG_PROVE_LOCKING=y. The x86_64 reproducer completed without lockdep
> reports, warnings, or bugs.

Please describe this in the commit message and delete most of
the text it has. This is the motivation part.

> 
>  security/keys/persistent.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/security/keys/persistent.c b/security/keys/persistent.c
> index 97af230aa4b22..0eca8c5758434 100644
> --- a/security/keys/persistent.c
> +++ b/security/keys/persistent.c
> @@ -63,6 +63,12 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
>  	if (IS_ERR(persistent))
>  		return ERR_CAST(persistent);
>  
> +	/* Set the expiry now: if the caller then fails to link the keyring to
> +	 * its destination, the register is left holding a collectible key
> +	 * rather than a permanent, quota-exempt one.
> +	 */
> +	key_set_timeout(persistent, persistent_keyring_expiry);
> +
>  	return make_key_ref(persistent, true);
>  }
>  
> 
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> -- 
> 2.53.0

BR, Jarkko
