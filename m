Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AC27A123;
	Sun,  7 Jun 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862111; cv=none; b=Bkt+izekD6DabeRADyuahD3J/PSrg2iv2EP/oI7uRXB1zlTG/YMcTQdXeX+HPQYVgmgUJ7nGlR1Y4hAeR8f8+4ibdkwCb0430L4CUteaO5kGAx1JDSieQo1pTFp1xOhpFxmioaSHV8Z6o1eB6dG5cqCKaCRyhQzyPUx0Gvx6cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862111; c=relaxed/simple;
	bh=mpVvvdu39f3e9QGpdhuNdovvOEnND/EbDt7YM4OjMUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE++9YvN39SYS+a+8TX7YJ2mYNnqu8+N6PAMOpyAGQeQdk/s9/wRotyHnegkGECW2USqjCAVlZxoonDuRA0ISIys/EhAZhGAU0u1kIaoFWbrZ5rSOp7Iu/0vduA1kB5JLg8yldpHBMPb4Y21/71nPIjVm+/pgkYuF7eZaptFsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=bAPfQ/tu; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="bAPfQ/tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1780862101; bh=mpVvvdu39f3e9QGpdhuNdovvOEnND/EbDt7YM4OjMUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAPfQ/tuB+7bR+T/kj0gFoU9/nw2Itma3ZQUT3QQjsdCcJMP9RX0WFPYCi6WrZMQC
	 ob7V2JUrzqpR2bYXr3gOqx8d4ixeI9hQ1QlwvEj0fe/bwzSHwoTJCs0TvbNf4jNNWr
	 wglYTRBXMIhRGS+TBGPFfRhZFz/sw7F53fuiFK39gHo15PEjRhFHucy1eBlgkj/V40
	 TLKbLW1S17CYMK0yGoRaacciY3/3qeXsHIqgwFqd3pzlX1jGEhqkpIbH7YVLrXP4hr
	 WoQ6hW1UTlrww0l15zKzbNmvY4ZhU2lp3vapYrTaJ3LvdSTulcz4XQ3lT7lhleWOjx
	 m7iHRcJHWDwRQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 44EABCEA; Sun,  7 Jun 2026 14:55:01 -0500 (CDT)
Date: Sun, 7 Jun 2026 14:55:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Gary Guo <gary@garyguo.net>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: allow request-key path to be configured via Kconfig
Message-ID: <aiXMlSqJtZdZqwJ2@mail.hallyn.com>
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
> 
> Follow the way modprobe handles this by making this a Kconfig option which
> defaults to the current /sbin/request-key.
> 
> Also changed "char const" to "const char" as checkpatch complains
> otherwise.
> 
> Link: https://github.com/NixOS/nixpkgs/blob/6b316287bae2ee04c9b93c8c858d930fd07d7338/pkgs/os-specific/linux/kernel/request-key-helper.patch
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

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
