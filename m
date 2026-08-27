Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A72FC893
	for <keyrings@vger.kernel.org>; Thu, 27 Aug 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834536; cv=none; b=aYrY1/5XdJmEZ4dcRXdb/ly9nk6XVFeyY0UsVocef2NzdctRpERPJrOuWJlBR1h5TRn2YSg1HbhFguSSxt9jF4CCV8raUzmoMZ45b45tMKedG1u9+YDDxqKSIM1tKcE6xLOmoxAuudVMylDOhJPnNZdXsX9Tk8jknL4pWzeqwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834536; c=relaxed/simple;
	bh=6UdXvmcxiyNgsz6+w7pMYno+sCHdZX6CqOByXzxekDs=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=kzI0FrEUNQMskyZCCv3a5xVfXQbS8XisUs7y0w9iQDpLae50vT3xlxLZHC5hfpKqkTvtRUVv9s4wGxSVQ51X+zzE8HEltmJpm60M01Ywi9U7PSypxCsm+7UhTcXQjngwQ1DAc3Tk2mJ5CkiJygvKqqhC111pajVyb0M4eY5dG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=LIwHcUZ2; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=aQx50E0u; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="LIwHcUZ2";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="aQx50E0u"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834533; x=1788439333; bh=Jcox8l/ThO6XMTGwSm
	80cpy3q3O7GlZqpuHdohAJm6g=; b=LIwHcUZ25iy/mXN08NFMVB7qwIFGlwzQBGUD+eGqFQgHM
	fCHO0KP1JEU+emQY1POT/5+gZTR+a/QsGw1gW/P2mjm3HlnqH1CloTdWaoIS4prCUmTAUWTiseI
	tjRV6OOI926wf+ZerFsqnkj1QYdrqrx8ItEVDGhppmRTWg6kNuHVa7h1WHc1/EShqh57BDyXxJ9
	8mZzME2BuBbcEM9tF3SqnvyVJ5jfq0GYxQMATZ+Frdc0ENugzAaz52xr5lu/ypCPaxTCNjiOD4Y
	yRrkbQq0gK0A8Dnom1fgyx9fPsplWaPZQpp/+fSGskpMm94t0e/5PrdqiwpaXxxIb+SS6CRw==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834533; x=1788439333; bh=Jcox8l/ThO6XMTGwSm
	80cpy3q3O7GlZqpuHdohAJm6g=; b=aQx50E0ugIVquDWiN5ftWUoNDdaOWWhgFulABPwYVmOls
	iYQSlarDLs/Xh5LSililP+ZbdIqReFIXUuimtMpBf9Xr7pWxmIy2fkVEHlM8aGDPG4sm4zH7lUC
	p3pc9vRE+UA64Il+17YnXt8LR5ceeoQuYyehezcYHMak+tFzyHsLzUb5J1QpVuQSgTcUG0rqbBR
	AiY7TBbRai43MNa67fbSJinZIPY6zY7RcK1Ge3Jfy8RoTy3gqruqxRyx9SW/La+2qhoGHhfgM/I
	IJrYDoVpKz3FKwGXmGTOaHLnDZ2E6Wa4hlCll+EcfzPWqSVjuYL0GnWNInAKTAAyDdDrISQA==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+6a581c4284f721d4@bugs.sh>
Message-ID: <jS2KwfrOeQPAnc2xZL0obs0OW3eVUUvpe6Yt@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:08 +0000
Subject: [BUG] security/keys: out-of-bounds in tpm2_unseal_trusted()
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    security/keys/trusted-keys
    crash   out-of-bounds in tpm2_unseal_trusted()
    commit  2709dd5ae32f ("Merge tag 'sched-urgent-2026-08-22' of git://git=
.kernel.org/pub/scm/linux/kernel/git/tip/tip")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+6a581c4284f721d4@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/6a581c4284f721d4/patch.diff
        report.md   https://bugs.sh/b/6a581c4284f721d4/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  2709dd5ae32f ("Merge tag 'sched-urgent-2026-08-22' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
    VM setup       https://bugs.sh/b/6a581c4284f721d4/run.sh
    config         https://bugs.sh/b/6a581c4284f721d4/config.gz
    poc            https://bugs.sh/b/6a581c4284f721d4/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted (./include/linux/unal=
igned.h:48 (discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:408 =
(discriminator 1) security/keys/trusted-keys/trusted_tpm2.c:595 (discrimina=
tor 1))
Read of size 2 at addr ffff8880125db7aa by task exploit/149
CPU: 0 UID: 1000 PID: 149 Comm: exploit Tainted: G        W           7.2.0=
+ #31 PREEMPTLAZY
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
tpm2_unseal_trusted (./include/linux/unaligned.h:48 (discriminator 1) secur=
ity/keys/trusted-keys/trusted_tpm2.c:408 (discriminator 1) security/keys/tr=
usted-keys/trusted_tpm2.c:595 (discriminator 1))
trusted_tpm_unseal (security/keys/trusted-keys/trusted_tpm1.c:928)
trusted_instantiate (security/keys/trusted-keys/trusted_core.c:196)
__key_instantiate_and_link (security/keys/key.c:446)
__key_create_or_update (security/keys/key.c:941)
key_create_or_update (security/keys/key.c:1021)
__do_sys_add_key (security/keys/keyctl.c:134)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 149:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5337 mm/slub.c:5362)
tpm2_unseal_trusted (./include/linux/slab.h:992 security/keys/trusted-keys/=
trusted_tpm2.c:119 security/keys/trusted-keys/trusted_tpm2.c:384 security/k=
eys/trusted-keys/trusted_tpm2.c:595)
trusted_tpm_unseal (security/keys/trusted-keys/trusted_tpm1.c:928)
trusted_instantiate (security/keys/trusted-keys/trusted_core.c:196)
__key_instantiate_and_link (security/keys/key.c:446)
__key_create_or_update (security/keys/key.c:941)
key_create_or_update (security/keys/key.c:1021)
__do_sys_add_key (security/keys/keyctl.c:134)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff8880125db7a0
which belongs to the cache kmalloc-8 of size 8
The buggy address is located 2 bytes to the right of
allocated 8-byte region [ffff8880125db7a0, ffff8880125db7a8)
The buggy address belongs to the physical page:
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff8880125db680: 00 fc fc fc fa fc fc fc 00 fc fc fc fc fc fc fc
ffff8880125db700: fc fc fc fc fc fc fc fc fa fc fc fc 00 fc fc fc
>ffff8880125db780: fc fc fc fc 00 fc fc fc fa fc fc fc fc fc fc fc
^
ffff8880125db800: fc fc fc fc fa fc fc fc 07 fc fc fc fc fc fc fc
ffff8880125db880: fa fc fc fc fc fc fc fc fc fc fc fc 00 fc fc fc


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


