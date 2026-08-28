Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24B286A4;
	Fri, 28 Aug 2026 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894274; cv=none; b=WuL2Po3MFP6OUn1vGjCCt01WdKD4NA1YPPDiFZDot1IK+llgxJCsHh5RSZOOnUQFQEzL7etwa/yurpPKNtWQCrXNQ40/8oWI9tTzlmSTh9wh+5YujViGpXQSVBlpf12qM0xMPqKo2ufxyaWejf9kH8p8cieJSqXJkhGZgIZqQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894274; c=relaxed/simple;
	bh=e3bL5cPiVURev0DJ4i3YdwmGMBnI/3H6tTBdChMhMtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4fUWYXouEmsBAW6JRpcIa28vWKh9PiawcnV29EA6w28TLr5H5pBh6CMCwm+p6L3wZE9zy+2ACukMxQSQAsZL9hqZ1v0TcFX73fLAscOHTZITgRC1bJDSp+1iqh9hXp6WZsLl5+bXz2fyZlnvLVvI8o2qo6unLn8b0xZy5LUznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPfrB0K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPfrB0K1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1357D1F000E9;
	Fri, 28 Aug 2026 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787894272;
	bh=0r54vq0N0PkyCiXhm1VxQAjwHvvZ9fXwCH+/yn5QCR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPfrB0K1BIR0jQTPAbECJmRbtd71O9tGy+6kCUnAucmQGqg6boy0P0Ae70gOqXAt3
	 lBfunW+QffCbdvxPUeIH1MBFy3K1hWbcjmQcNK/0YCwUYL6FCptNq/HwMk5Wke8uUl
	 LG/raS0S927Lwf2LfblM8PFjkx6/WEDDp3NhG7HqTVeiBU1TAaHiCTGZ7B/rF8GfZf
	 xRA8QxZ+WGXbY8NPIyiJkToWgyX9UzRerTjkvy0nP6wBiBOiV5+AuI7rxgjScrGeaI
	 7+vSnJU1hFogHyvBtPUv2TxEFjtLdNPtpKmXbbikHhDHkx+KgTdS1TbBdCxg6Ivzlf
	 WeQKx7tc+YXeg==
Date: Fri, 28 Aug 2026 08:17:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: co <co+6a581c4284f721d4@bugs.sh>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] security/keys: out-of-bounds in tpm2_unseal_trusted()
Message-ID: <apEZ_LqXdIZfJS15@kernel.org>
References: <jS2KwfrOeQPAnc2xZL0obs0OW3eVUUvpe6Yt@bugs.sh>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jS2KwfrOeQPAnc2xZL0obs0OW3eVUUvpe6Yt@bugs.sh>

On Thu, Aug 27, 2026 at 12:42:08PM +0000, co wrote:
> We found a bug reachable in:
> 
>     path    security/keys/trusted-keys
>     crash   out-of-bounds in tpm2_unseal_trusted()
>     commit  2709dd5ae32f ("Merge tag 'sched-urgent-2026-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> Config, environment, the sanitizer report and a C reproducer follow.
> 
> == Notes ===============================================================
>     If you patch the bug based on our artifacts, a tag would be
>     appreciated:
> 
> Reported-by: co+6a581c4284f721d4@bugs.sh
> 
>     Everything in this mail is validated by the reproducer below.
> 
>     We also hold an LLM-generated root-cause analysis and a candidate
>     patch. The patch passes an A/B test: the same reproducer panics the
>     unpatched kernel and runs clean on the patched one. Neither has had
>     human review, so both still require validation before you send or
>     apply them. Available on:
> 
>         patch.diff  https://bugs.sh/b/6a581c4284f721d4/patch.diff
>         report.md   https://bugs.sh/b/6a581c4284f721d4/report.md
> 
>     This is an open science project. The code and the full set of PoCs
>     are not public at this moment, as we intend to disclose our findings
>     in an ethical way.
> 
>     Happy to test patches. Complaints and suggestions about our work
>     are welcome at:
> 
>         cedalion@bugs.sh
> 
> == Environment =========================================================
>     Reproduced on  2709dd5ae32f ("Merge tag 'sched-urgent-2026-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
>     VM setup       https://bugs.sh/b/6a581c4284f721d4/run.sh
>     config         https://bugs.sh/b/6a581c4284f721d4/config.gz
>     poc            https://bugs.sh/b/6a581c4284f721d4/repro.c
> 
> == Sanitizer Report ====================================================
> BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted (./include/linux/unaligned.h:48 (discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:408 (discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:595 (discriminator 1))
> Read of size 2 at addr ffff8880125db7aa by task exploit/149
> CPU: 0 UID: 1000 PID: 149 Comm: exploit Tainted: G        W           7.2.0+ #31 PREEMPTLAZY
> Call Trace:
> dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:595)
> tpm2_unseal_trusted (./include/linux/unaligned.h:48 (discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:408 (discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:595 (discriminator 1))
> trusted_tpm_unseal (security/keys/trusted-keys/trusted_tpm1.c:928)
> trusted_instantiate (security/keys/trusted-keys/trusted_core.c:196)
> __key_instantiate_and_link (security/keys/key.c:446)
> __key_create_or_update (security/keys/key.c:941)
> key_create_or_update (security/keys/key.c:1021)
> __do_sys_add_key (security/keys/keyctl.c:134)
> do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> Allocated by task 149:
> kasan_save_stack (mm/kasan/common.c:57)
> kasan_save_track (mm/kasan/common.c:78)
> __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
> __kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5337 mm/slub.c:5362)
> tpm2_unseal_trusted (./include/linux/slab.h:992 security/keys/trusted-keys/trusted_tpm2.c:119 security/keys/trusted-keys/trusted_tpm2.c:384 security/keys/trusted-keys/trusted_tpm2.c:595)
> trusted_tpm_unseal (security/keys/trusted-keys/trusted_tpm1.c:928)
> trusted_instantiate (security/keys/trusted-keys/trusted_core.c:196)
> __key_instantiate_and_link (security/keys/key.c:446)
> __key_create_or_update (security/keys/key.c:941)
> key_create_or_update (security/keys/key.c:1021)
> __do_sys_add_key (security/keys/keyctl.c:134)
> do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> The buggy address belongs to the object at ffff8880125db7a0
> which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 2 bytes to the right of
> allocated 8-byte region [ffff8880125db7a0, ffff8880125db7a8)
> The buggy address belongs to the physical page:
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
> ffff8880125db680: 00 fc fc fc fa fc fc fc 00 fc fc fc fc fc fc fc
> ffff8880125db700: fc fc fc fc fc fc fc fc fa fc fc fc 00 fc fc fc
> >ffff8880125db780: fc fc fc fc 00 fc fc fc fa fc fc fc fc fc fc fc
> ^
> ffff8880125db800: fc fc fc fc fa fc fc fc 07 fc fc fc fc fc fc fc
> ffff8880125db880: fa fc fc fc fc fc fc fc fc fc fc fc 00 fc fc fc
> 
> 
> ---
> The report format is based on syzbot bug report.
> 
> This report is generated by a bot. It may contain errors.
> See https://github.com/n132/cedalion for more information.
> 
> For any issue with this report, reach out to cedalion@bugs.sh
> 
> If the report is already addressed, let us know by replying with:
> #co fix: <commit hash>
> 
> If the report is a duplicate of another one, reply with:
> #co dup: <lore link>
> 
> If you want to undo deduplication, reply with:
> #co undup
> 
> 

ack as for acknowledging this. i'll look this on monday in detail
(my work week is over and i have weekend activities).

Thank you for reporting!

BR, Jarkko
