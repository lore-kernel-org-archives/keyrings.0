Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF34263F5D;
	Mon, 10 Aug 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375799; cv=none; b=NKnuygUN1xuY5ERq6L/TZfTmau9gpODQQ827YcnI3vZDW5+BpQrcouR4d0oyFeaw3hhC47JZFp+osRB5F28VsgxZG39ceEmS2zNB0gJicPLIPAe3G4jmykB9j3Mciv6lwY9/Nc8Snc5WMY/872/L54a5Mazpkn8+HDP7oVh1ks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375799; c=relaxed/simple;
	bh=rqpUc/GmvWE1R2/gEOiucTnIWfFLCJKnxafkPt8jObQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Eoe8VUjVe1iC+nOoegkPat7Ud2FsNSDrHSNCaHumoP99xMUUwBk+N6j7gGdGz+M8xKgtXigPxEVjcK6Mv9DjKv7wQOC8kmUZwDo/w8dFMPvducNVRzUuaTDxAzQTxm16UKTcvrSjhWGtNw4FQ4Kc0SSGLo/wpPq1+3TCYO8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVQTE9Sx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVQTE9Sx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0627F1F000E9;
	Mon, 10 Aug 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786375797;
	bh=eJHxMoAsHSsVZqOYcaAsiYvNb67TlWtmkhnQradvAgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVQTE9Sx+ZOo2ET1ufSAOSNyChsbD8cKAdhf/0TXwWaeQt+616jOgS0ZYgtLxkSt4
	 PCypRg32Ftwi6LvwaukyEqGNG0GjUwIf1XlNG/jIX2aS8XYRX/h80qaHjyPSz8QB/n
	 0rNZcXY5vDjqnnwjZFpRbqvyTufeeQX5MZNJLyt9k80DXwlbBrL8dz6g8FhzH4NVhy
	 2D7A9Rk66q+8tC5aQc2kfo4qJd9nsWYT7fxE1Ih3/rDAGwUzmQkXDtZeib3DIppQyY
	 fr4odB4h0oW7q7pODzB20eeYAc/EpwbEq+4UEaNQ4JLS1LFAwPkU/O29imjhqx/IEE
	 GYkzTvZfgSpYQ==
Date: Mon, 10 Aug 2026 18:29:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/4] kexec: add CRASH_ZEROIZE to wipe secrets before kdump
Message-ID: <annuciDaFKSHYObm@kernel.org>
References: <20260731154608.153258-1-linux@jaseg.de>
 <20260731154608.153258-3-linux@jaseg.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731154608.153258-3-linux@jaseg.de>

On Fri, Jul 31, 2026 at 05:46:06PM +0200, Jan Sebastian Götte wrote:
> When kdump is used to capture system memory after a panic(), any secret
> keys currently in RAM end up in the dump. Add an opt-in atomic notifier
> chain, crash_zeroize_notifier_list, invoked late into __crash_kexec().
> Subsystems holding secrets can register a callback to scrub them.
> 
> Callbacks are run after machine_crash_shutdown() has already stopped the
> other CPUs and disabled preemption. Callbacks must not wait on locks,
> which will never be released.
> 
> This is a best-effort, defence-in-depth measure, not a guarantee.
> Secrets in flight on the stack, in registers, in DMA buffers, or in
> other places in memory are out of scope.
> 
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
> ---
>  include/linux/crash_core.h |  5 +++++
>  kernel/Kconfig.kexec       |  8 ++++++++
>  kernel/crash_core.c        | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)

Not a request but for me 'crash_wipe' would be more intuitive than
'crash_zeroize'.

What do you think?

> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index bc087124cd78..5c7207c0bba1 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -5,6 +5,7 @@
>  #include <linux/linkage.h>
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
> +#include <linux/notifier.h>
>  
>  struct kimage;
>  
> @@ -34,6 +35,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>  static inline void arch_kexec_unprotect_crashkres(void) { }
>  #endif
>  
> +#ifdef CONFIG_CRASH_ZEROIZE
> +extern struct atomic_notifier_head crash_zeroize_notifier_list;
> +#endif
> +
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..92ab0a69c8ec 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -179,4 +179,12 @@ config CRASH_MAX_MEMORY_RANGES
>  	  the computation behind the value provided through the
>  	  /sys/kernel/crash_elfcorehdr_size attribute.
>  
> +config CRASH_ZEROIZE
> +	bool "Zeroize secrets on panic"
> +	depends on CRASH_DUMP
> +	help
> +	  Wipe secrets (e.g. kernel keyring and memfd_secret pages) on crash or panic.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade0..d3a7763e2759 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/objtool.h>
>  #include <linux/delay.h>
>  #include <linux/panic.h>
> +#include <linux/timekeeping.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -33,6 +34,22 @@
>  /* Per cpu memory for storing cpu states in case of system crash. */
>  note_buf_t __percpu *crash_notes;
>  
> +#ifdef CONFIG_CRASH_ZEROIZE
> +ATOMIC_NOTIFIER_HEAD(crash_zeroize_notifier_list);
> +EXPORT_SYMBOL_GPL(crash_zeroize_notifier_list);
> +
> +static void crash_zeroize(void)
> +{
> +	ktime_t zeroize_start = ktime_get();
> +
> +	pr_info("Wiping sensitive secrets...\n");
> +	atomic_notifier_call_chain(&crash_zeroize_notifier_list, 0, NULL);
> +	pr_info("Done in %lld us\n", ktime_us_delta(ktime_get(), zeroize_start));
> +}
> +#else
> +static inline void crash_zeroize(void) { }
> +#endif /* CONFIG_CRASH_ZEROIZE */
> +
>  /* time to wait for possible DMA to finish before starting the kdump kernel
>   * when a CMA reservation is used
>   */
> @@ -142,6 +159,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();
> +			crash_zeroize();
>  			machine_kexec(kexec_crash_image);
>  		}
>  		kexec_unlock();
> -- 
> 2.53.0
> 

BR, Jarkko
