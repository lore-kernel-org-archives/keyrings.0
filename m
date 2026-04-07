Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9B279792
	for <keyrings@vger.kernel.org>; Tue,  7 Apr 2026 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559676; cv=none; b=FB6sxdpWnNZ4IzJJqyJlVyl80xTmMzIKfu/bXt5+pAJuRdl1ZVpBgHxoadzBJ5iS8UcWeKE5/3ylbRm8LNKeoc4Wr6HJPAMPoYVTjHO6sRiGqrMXbbvrDwPj1oOKf88WLU9q1whQH/VkmU/yE/49dSTN1dtlR+zTnusQge4GzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559676; c=relaxed/simple;
	bh=or1JXDlBJr88ZPFVryF4PxDcmMnMGk31MxUjp1HQGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdHvq2DzdwMXnEZqJKbu4/bMm5bFLD4HsUGv+Pntpj3HRZzq0/o1AtHuoMuL+SWOtjMLA4ZLoAKcMEw9MWfxdtSNZVystleXDZIHlFERxvN/eA/p6Bk44jQQgpgULBTIveYJTDDeG9LfxmUsQcyK+1d8U5FGjcZCoAMClNfV+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BVgp+a2h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UKfZtvIs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qA8IdJKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LysQ9c8V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BVgp+a2h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UKfZtvIs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qA8IdJKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LysQ9c8V"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99B485BD36;
	Tue,  7 Apr 2026 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775559671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oXLKBYtaCCSbMWBda+nxyI4Nn65hTz2TbyxjesyuSE=;
	b=BVgp+a2hMv3tETDV+rR9kch9LY661rG6gG/nGImoQc+GuC4d6flbkjiWXxH7wnRTm0U20M
	5LtMnlL59Hb8Wl9q8CRbWSxrIMQBwrNawXdRfkjhDxV2jYade8lAzh3Eju4D5FK4La91Uv
	NImxRNZBi+0n638H/qDh7MoW0WCYKXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775559671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oXLKBYtaCCSbMWBda+nxyI4Nn65hTz2TbyxjesyuSE=;
	b=UKfZtvIsiO3FB8fMLaXkTmekdqfggL0VR9IAJ/K+MzJUVIotdHA9OZ534503T9FcjZvVxE
	h+2TNRuAWa2JUhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775559666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oXLKBYtaCCSbMWBda+nxyI4Nn65hTz2TbyxjesyuSE=;
	b=qA8IdJKIP1IEjzpOJmvlCMYX7wCu03qUGsEnRfmc9u/FSNyytXOsKwNsEtWuOatglxRwQm
	GV8DwwIzVJPGVwCZ1xBWQXl1iTbIC37Lgm2dMpr84X//XzVd/U3OHZYICbEYyLGmHS5SW7
	xW6/YM8ymwTVspOG5R2MXu5IQ+2M4hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775559666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oXLKBYtaCCSbMWBda+nxyI4Nn65hTz2TbyxjesyuSE=;
	b=LysQ9c8VZNrysxsUFJYO5ot3gJQ68lu1GmpT4jYOLonIGJQirvH2/VDKWv6O7tu2kf2kvy
	MK4Iz8A2fe5ul8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6BE4A0B0;
	Tue,  7 Apr 2026 11:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1fDIfLj1Gm3OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Apr 2026 11:01:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4BCD4A0A81; Tue,  7 Apr 2026 13:01:02 +0200 (CEST)
Date: Tue, 7 Apr 2026 13:01:02 +0200
From: Jan Kara <jack@suse.cz>
To: Anand Moon <linux.amoon@gmail.com>
Cc: David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "open list:CERTIFICATE HANDLING" <keyrings@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] treewide: Fix indentation and whitespace in Kconfig
 files
Message-ID: <dssmmmam4yt222rtsk7nmrnwf46ocv66kujo2k6vihgqxeunyz@zwg2j5pxre7h>
References: <20260407053945.14116-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407053945.14116-1-linux.amoon@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 07-04-26 11:09:34, Anand Moon wrote:
> Clean up inconsistent indentation (mixing tabs and spaces) and remove
> extraneous whitespace in several Kconfig files across the tree.
> This is a purely cosmetic change to improve readability.
> 
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 
> $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

For the fs bits, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  certs/Kconfig | 16 ++++++++--------
>  fs/Kconfig    |  6 +++---
>  init/Kconfig  | 24 ++++++++++++------------
>  lib/Kconfig   |  2 +-
>  mm/Kconfig    |  4 ++--
>  5 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 8e39a80c7abe5..9d2bf7fb5b9e4 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -6,14 +6,14 @@ config MODULE_SIG_KEY
>  	default "certs/signing_key.pem"
>  	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>  	help
> -         Provide the file name of a private key/certificate in PEM format,
> -         or a PKCS#11 URI according to RFC7512. The file should contain, or
> -         the URI should identify, both the certificate and its corresponding
> -         private key.
> -
> -         If this option is unchanged from its default "certs/signing_key.pem",
> -         then the kernel will automatically generate the private key and
> -         certificate as described in Documentation/admin-guide/module-signing.rst
> +	 Provide the file name of a private key/certificate in PEM format,
> +	 or a PKCS#11 URI according to RFC7512. The file should contain, or
> +	 the URI should identify, both the certificate and its corresponding
> +	 private key.
> +
> +	 If this option is unchanged from its default "certs/signing_key.pem",
> +	 then the kernel will automatically generate the private key and
> +	 certificate as described in Documentation/admin-guide/module-signing.rst
>  
>  choice
>  	prompt "Type of module signing key to be generated"
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa8775..74110311968aa 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -78,7 +78,7 @@ config FS_DAX
>  	  --map=mem:
>  	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
>  
> -          For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
> +	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
>  	  file systems DAX support needs to be manually enabled globally or
>  	  per-inode using a mount option as well.  See the file documentation in
>  	  Documentation/filesystems/dax.rst for details.
> @@ -116,8 +116,8 @@ config FILE_LOCKING
>  	default y
>  	help
>  	  This option enables standard file locking support, required
> -          for filesystems like NFS and for the flock() system
> -          call. Disabling this option saves about 11k.
> +	  for filesystems like NFS and for the flock() system
> +	  call. Disabling this option saves about 11k.
>  
>  source "fs/crypto/Kconfig"
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 7484cd703bc1a..6fea1453c2941 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1036,14 +1036,14 @@ config PAGE_COUNTER
>  	bool
>  
>  config CGROUP_FAVOR_DYNMODS
> -        bool "Favor dynamic modification latency reduction by default"
> -        help
> -          This option enables the "favordynmods" mount option by default
> -          which reduces the latencies of dynamic cgroup modifications such
> -          as task migrations and controller on/offs at the cost of making
> -          hot path operations such as forks and exits more expensive.
> +	bool "Favor dynamic modification latency reduction by default"
> +	help
> +	  This option enables the "favordynmods" mount option by default
> +	  which reduces the latencies of dynamic cgroup modifications such
> +	  as task migrations and controller on/offs at the cost of making
> +	  hot path operations such as forks and exits more expensive.
>  
> -          Say N if unsure.
> +	  Say N if unsure.
>  
>  config MEMCG
>  	bool "Memory controller"
> @@ -1125,7 +1125,7 @@ config GROUP_SCHED_WEIGHT
>  	def_bool n
>  
>  config GROUP_SCHED_BANDWIDTH
> -        def_bool n
> +	def_bool n
>  
>  config FAIR_GROUP_SCHED
>  	bool "Group scheduling for SCHED_OTHER"
> @@ -1625,10 +1625,10 @@ config LD_ORPHAN_WARN
>  	depends on $(ld-option,--orphan-handling=error)
>  
>  config LD_ORPHAN_WARN_LEVEL
> -        string
> -        depends on LD_ORPHAN_WARN
> -        default "error" if WERROR
> -        default "warn"
> +	string
> +	depends on LD_ORPHAN_WARN
> +	default "error" if WERROR
> +	default "warn"
>  
>  config SYSCTL
>  	bool
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb96106476..4b0026954a370 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -589,7 +589,7 @@ config OBJAGG
>  config LWQ_TEST
>  	bool "Boot-time test for lwq queuing"
>  	help
> -          Run boot-time test of light-weight queuing.
> +	  Run boot-time test of light-weight queuing.
>  
>  endmenu
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687e..10a4ce4247fa1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1304,7 +1304,7 @@ config ARCH_HAS_PTE_SPECIAL
>  	bool
>  
>  config MAPPING_DIRTY_HELPERS
> -        bool
> +	bool
>  
>  config KMAP_LOCAL
>  	bool
> @@ -1435,7 +1435,7 @@ config ARCH_HAS_USER_SHADOW_STACK
>  	bool
>  	help
>  	  The architecture has hardware support for userspace shadow call
> -          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> +	  stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>  
>  config HAVE_ARCH_TLB_REMOVE_TABLE
>  	def_bool n
> 
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
