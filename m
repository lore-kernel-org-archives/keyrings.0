Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF72771B;
	Mon,  8 Jun 2026 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894204; cv=none; b=dGDLLbhaUmzLvix+o/KLbjk6nNHYeVtsipsp0sTYGeopurnlHsSS0Pn5gk22rMdY3Fa+gXnEJMzy5WLB81e7j8DXB+J79b2ihGIwXwygwECkMoXtt75SI6/Cbwhrw/LIOhxNprHjCReGGWu1IUgXawwRXInKDqr4qj1w3X5E0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894204; c=relaxed/simple;
	bh=BzR93OugnK/UHYsy0BXGO0X+GUsvO7oDw5TNuFrhnDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQNWyi0zPh5GnQ/Xaxmy32J15caP5/b4LtHuN4IDqlyyloVhNriEK7lOM3as2Tevg5EfbGvwgbl7mzKqAc7XcCCKl6Eg11JlDi2hwhBqMEPx4o4KMWy+S07l821iARotdUl2A9oK2ykeh806E74ztAsK7x7YoBuVLspzGVXLPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDqkEQ2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDqkEQ2t"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 21E351F00898;
	Mon,  8 Jun 2026 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780894202;
	bh=D7bR2Actc04Wu/D+QtrZit8ZhjBDPmXURUdiAB0RO08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QDqkEQ2t4umebVk9IE06l0QpQVoJM+Qsh/lsZyqrPgCib0N+LIeLFhBFr7BeZLclc
	 e+WSeptrkNiH4XLc8nlW4958/1WD7BeKsD28PhPwrOCe3WmRYK1lpcBUpEK4y4lZoT
	 dMELE/T5NQJ3/d4IhbRvR91sxD7QQ1qBzW3UXv74UqOu88vjTFUGs23YxMmGNeaN+d
	 21ttot1MEkf9uhAoRYO+Ie146AITTMUl8/Q9ZPPNkztcP4UrTxdyqJBiBfob1yaSEw
	 ztT3ikSRiJ1Ttp7IkgAkwIPh6Xh7pP5VFm13gpLlGXVpxPovFUAxlaULLuwxseq04G
	 D8Zu3gnnOZt8g==
Date: Mon, 8 Jun 2026 07:49:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: allow request-key path to be configured via Kconfig
Message-ID: <aiZJ94eugtNHcILD@kernel.org>
References: <20260607134928.2832202-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607134928.2832202-1-gary@kernel.org>

On Sun, Jun 07, 2026 at 02:49:27PM +0100, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Some Linux distributions (e.g. NixOS) does not have /sbin present, and they
> currently carry patches to replace /sbin/request-key to some other path.

Sorry but no configuration for introducing API divergence.


> 
> Follow the way modprobe handles this by making this a Kconfig option which
> defaults to the current /sbin/request-key.
> 
> Also changed "char const" to "const char" as checkpatch complains
> otherwise.
> 
> Link: https://github.com/NixOS/nixpkgs/blob/6b316287bae2ee04c9b93c8c858d930fd07d7338/pkgs/os-specific/linux/kernel/request-key-helper.patch
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> I did not update mentions of /sbin/request-key in documentation and
> elsewhere, as "/sbin/request-key" is concise while "request-key UMH" is
> more mouthful and less clear.
> 
> Number of distros that doesn't have /sbin is limited so I think it wouldn't
> create much confusion. Similarly, there are a lot of places where
> /sbin/modprobe is mentioned despite it is technically configurable.
> ---
>  security/keys/Kconfig       | 9 +++++++++
>  security/keys/request_key.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index f4510d8cb485..ee3c3d85fc03 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -40,6 +40,15 @@ config KEYS_REQUEST_CACHE
>  	  key.  Pathwalk will call multiple methods for each dentry traversed
>  	  (permission, d_revalidate, lookup, getxattr, getacl, ...).
>  
> +config REQUEST_KEY_PATH
> +	string "Path to the request-key binary"
> +	default "/sbin/request-key"
> +	help
> +	  Path of the request-key usermode helper binary.
> +
> +	  This program is invoked by the kernel when the kernel is asked for
> +	  a key that it doesn't have immediately available.
> +
>  config PERSISTENT_KEYRINGS
>  	bool "Enable register of persistent per-UID keyrings"
>  	help
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index a7673ad86d18..ac8f9d1a87ad 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -117,7 +117,7 @@ static int call_usermodehelper_keys(const char *path, char **argv, char **envp,
>   */
>  static int call_sbin_request_key(struct key *authkey, void *aux)
>  {
> -	static char const request_key[] = "/sbin/request-key";
> +	static const char request_key[] = CONFIG_REQUEST_KEY_PATH;
>  	struct request_key_auth *rka = get_request_key_auth(authkey);
>  	const struct cred *cred = current_cred();
>  	key_serial_t prkey, sskey;
> 
> base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
> -- 
> 2.54.0
> 

BR, Jarkko
