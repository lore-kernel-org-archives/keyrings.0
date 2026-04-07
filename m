Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A61A9FB0;
	Tue,  7 Apr 2026 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572665; cv=none; b=BsfE/JGKoZkIj4VqTEW80s3Ett+GET9FltJMdL2S3CVoAZWqyQIhrdnmY8MdnEdFOyU/FiKgZQi0hiWg0WtQYKh540taJQv7fc3Erm4T/71Lczp+lsspL6hyRqwEak1h3zKt+opaEWp1a8uhnVORGzHXOxicfrNoRRdqebdmXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572665; c=relaxed/simple;
	bh=qcwFe61yYk9/XUZijcBTHdiaZcYiATYoWR8d6pB509M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA8aSSqmGnJNdrI0btkEyfkHp66UBBi9S6Rz5ckU3KDFCRoVKiUJnAqv3gqShWxZHor/7TEixGQZ5EkfXl8Fo6pWYJfuEM2MWbubzDiMQw07gWMfh/NongO44uPjUBqKKueJH21HKM5dOpLox47M2phPTEpTRPl5M10cJNgWhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1aYYWfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1aYYWfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A1C116C6;
	Tue,  7 Apr 2026 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572664;
	bh=qcwFe61yYk9/XUZijcBTHdiaZcYiATYoWR8d6pB509M=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=m1aYYWfgF/eFXk/afD3YzfALOhQ9KLQpxC0RKhl7tRHY/yF84K3UnhNOR5oOTe5Yh
	 qFs+epdHRiQl7rM/NOKXBYYn1VL3y160pZBKFiOACcODp2GPE8WlvnfABMkwDXtz1r
	 v7iuEMvECHtA2msunmgR6rFtkxeCMxRlNKAGT/PgnzyhHUIO3Rh0VmY0D6hLc5NC1Y
	 QEhIABtmIND7sPL52Tr2RHJc5MiWyvnsd6RD1hQD7pMZLCz9IsN+/fY7ZaAM8cRSQF
	 8EIXaztizpEiFdcMpfGZ/s+ORHlAk27DWD2/5eRDPtbIqBf7ynQkCRwHaKJrmEQaU5
	 WRCNMuzjePmWw==
Date: Tue, 7 Apr 2026 15:37:36 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Anand Moon <linux.amoon@gmail.com>, David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
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
Message-ID: <adUWbw60LyIMaDKg@lucifer>
References: <20260407053945.14116-1-linux.amoon@gmail.com>
 <2w7il2oprhkus5eyuxj3alzlsstp4yv23gazmxfmofzikqllrh@uwsx5nbj2hwv>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2w7il2oprhkus5eyuxj3alzlsstp4yv23gazmxfmofzikqllrh@uwsx5nbj2hwv>

On Tue, Apr 07, 2026 at 09:58:56AM -0400, Liam R. Howlett wrote:
> * Anand Moon <linux.amoon@gmail.com> [260407 01:40]:
> > Clean up inconsistent indentation (mixing tabs and spaces) and remove
> > extraneous whitespace in several Kconfig files across the tree.
> > This is a purely cosmetic change to improve readability.
> >
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >
> > $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> For the mm section,
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Looks correct to me for mm also, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Cheers, Lorenzo

>
> > ---
> >  certs/Kconfig | 16 ++++++++--------
> >  fs/Kconfig    |  6 +++---
> >  init/Kconfig  | 24 ++++++++++++------------
> >  lib/Kconfig   |  2 +-
> >  mm/Kconfig    |  4 ++--
> >  5 files changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/certs/Kconfig b/certs/Kconfig
> > index 8e39a80c7abe5..9d2bf7fb5b9e4 100644
> > --- a/certs/Kconfig
> > +++ b/certs/Kconfig
> > @@ -6,14 +6,14 @@ config MODULE_SIG_KEY
> >  	default "certs/signing_key.pem"
> >  	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
> >  	help
> > -         Provide the file name of a private key/certificate in PEM format,
> > -         or a PKCS#11 URI according to RFC7512. The file should contain, or
> > -         the URI should identify, both the certificate and its corresponding
> > -         private key.
> > -
> > -         If this option is unchanged from its default "certs/signing_key.pem",
> > -         then the kernel will automatically generate the private key and
> > -         certificate as described in Documentation/admin-guide/module-signing.rst
> > +	 Provide the file name of a private key/certificate in PEM format,
> > +	 or a PKCS#11 URI according to RFC7512. The file should contain, or
> > +	 the URI should identify, both the certificate and its corresponding
> > +	 private key.
> > +
> > +	 If this option is unchanged from its default "certs/signing_key.pem",
> > +	 then the kernel will automatically generate the private key and
> > +	 certificate as described in Documentation/admin-guide/module-signing.rst
> >
> >  choice
> >  	prompt "Type of module signing key to be generated"
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 0bfdaecaa8775..74110311968aa 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -78,7 +78,7 @@ config FS_DAX
> >  	  --map=mem:
> >  	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
> >
> > -          For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
> > +	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
> >  	  file systems DAX support needs to be manually enabled globally or
> >  	  per-inode using a mount option as well.  See the file documentation in
> >  	  Documentation/filesystems/dax.rst for details.
> > @@ -116,8 +116,8 @@ config FILE_LOCKING
> >  	default y
> >  	help
> >  	  This option enables standard file locking support, required
> > -          for filesystems like NFS and for the flock() system
> > -          call. Disabling this option saves about 11k.
> > +	  for filesystems like NFS and for the flock() system
> > +	  call. Disabling this option saves about 11k.
> >
> >  source "fs/crypto/Kconfig"
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 7484cd703bc1a..6fea1453c2941 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1036,14 +1036,14 @@ config PAGE_COUNTER
> >  	bool
> >
> >  config CGROUP_FAVOR_DYNMODS
> > -        bool "Favor dynamic modification latency reduction by default"
> > -        help
> > -          This option enables the "favordynmods" mount option by default
> > -          which reduces the latencies of dynamic cgroup modifications such
> > -          as task migrations and controller on/offs at the cost of making
> > -          hot path operations such as forks and exits more expensive.
> > +	bool "Favor dynamic modification latency reduction by default"
> > +	help
> > +	  This option enables the "favordynmods" mount option by default
> > +	  which reduces the latencies of dynamic cgroup modifications such
> > +	  as task migrations and controller on/offs at the cost of making
> > +	  hot path operations such as forks and exits more expensive.
> >
> > -          Say N if unsure.
> > +	  Say N if unsure.
> >
> >  config MEMCG
> >  	bool "Memory controller"
> > @@ -1125,7 +1125,7 @@ config GROUP_SCHED_WEIGHT
> >  	def_bool n
> >
> >  config GROUP_SCHED_BANDWIDTH
> > -        def_bool n
> > +	def_bool n
> >
> >  config FAIR_GROUP_SCHED
> >  	bool "Group scheduling for SCHED_OTHER"
> > @@ -1625,10 +1625,10 @@ config LD_ORPHAN_WARN
> >  	depends on $(ld-option,--orphan-handling=error)
> >
> >  config LD_ORPHAN_WARN_LEVEL
> > -        string
> > -        depends on LD_ORPHAN_WARN
> > -        default "error" if WERROR
> > -        default "warn"
> > +	string
> > +	depends on LD_ORPHAN_WARN
> > +	default "error" if WERROR
> > +	default "warn"
> >
> >  config SYSCTL
> >  	bool
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 0f2fb96106476..4b0026954a370 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -589,7 +589,7 @@ config OBJAGG
> >  config LWQ_TEST
> >  	bool "Boot-time test for lwq queuing"
> >  	help
> > -          Run boot-time test of light-weight queuing.
> > +	  Run boot-time test of light-weight queuing.
> >
> >  endmenu
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ebd8ea353687e..10a4ce4247fa1 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1304,7 +1304,7 @@ config ARCH_HAS_PTE_SPECIAL
> >  	bool
> >
> >  config MAPPING_DIRTY_HELPERS
> > -        bool
> > +	bool
> >
> >  config KMAP_LOCAL
> >  	bool
> > @@ -1435,7 +1435,7 @@ config ARCH_HAS_USER_SHADOW_STACK
> >  	bool
> >  	help
> >  	  The architecture has hardware support for userspace shadow call
> > -          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> > +	  stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> >
> >  config HAVE_ARCH_TLB_REMOVE_TABLE
> >  	def_bool n
> >
> > base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> > --
> > 2.50.1
> >
