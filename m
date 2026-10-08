Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666F35F162;
	Thu,  8 Oct 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482166; cv=none; b=t1JfrpnWr92GybJmh11jepMycQuB7wyl75qhjJR7QgF+PkB7vSPwafVpuOBPzLlQdDglpRVIRyiFTstS4wkzcL2HPl6Qz6HLlR9MosE6Df2555ChMY2DVhfcdsZy8ovQ9Dmr/5oVrLc5Sft02mp3GHrOS8EGwtyg0LkVZiamJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482166; c=relaxed/simple;
	bh=HQZ4gFi5PR+FBjYSBtVkDftACIDoBU7AfOolqYic2JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Qi9ThWsZEhqZjolusdmLPYdViHhLOsCFJg6EU1dX6zXYx54Z9nJBnDEA81zIVNtTvQlMIR69YyzLi5Nwf935HLZ7mFT7PnBuCJR1YZQzk383IfPqM45kpKKPcwdz9b1ZwMgDTNNtLQEaadlALpeKnXCOnuWQHCaGHSc9pOUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfQvSAxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfQvSAxw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 920251F000FF;
	Thu,  8 Oct 2026 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482165;
	bh=fZWzcMj2XJRKRBpiesRoOZzWEEWA3zzLxuCOn1lzEiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OfQvSAxwvEl+kNKczSiVX6Ec+uaqfhu/AjuIalgqK0wnPjmRUYgc1lI4wMvfgYEJB
	 pncLVRJH6utIM8W/OMpgT/7P+fbVKqT2ebMldeHxvTxxcUYVqKFaXz5/42zE20Y7xz
	 quBNVuAA4WkYMnbInhQItAGczYYpO2JZdzGiN2EQlraOUsdyxISIljXJzYEBYoEjXH
	 FU8jteYlIM6r0VmkoNvDgnJe1mUyTEJESnS4SeaN/q0zX5optCQ2G1csm1OLcN8KnU
	 chlytDMMNIR2R3g20Dh4HARwlXTY/aqzNjUs3OypXzo/if/8HOsViiBUj0eur0WbMa
	 EykM0XTg4HCMg==
Date: Thu, 8 Oct 2026 20:56:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Protect the type name while describing a key
Message-ID: <asfZMToWNmQDTk4W@kernel.org>
References: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>

On Thu, Oct 08, 2026 at 02:30:06PM +0800, Cen Zhang wrote:
> keyctl_describe_key() must keep the key type's name alive until
> kasprintf() has consumed it. The retained key reference keeps the key
> and its description alive, but does not pin the module providing its
> type. The name is passed to kasprintf() without holding key->sem.
> 
> kvasprintf() uses the saved name pointer in two formatting passes, with
> a GFP_KERNEL allocation between them. With AF_RXRPC=m, a task that
> passes View permission before type retirement can overlap a privileged
> module unload in this order:
> 
> 1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
>    kasprintf() arguments and completes the first formatting pass.
> 2. While the formatter is delayed before its second pass,
>    af_rxrpc_exit() calls unregister_key_type(), which removes the type
>    from the registry and waits for key_gc_keytype().
> 3. The collector takes key->sem for writing, retypes the retained key
>    to key_type_dead and completes retirement. Unregistration and module
>    exit return, allowing free_module() to release the type and name.
> 4. The formatter resumes its second pass and reads the saved name from
>    released module storage, which can fault in string().
> 
> Hold key->sem for reading across kasprintf(). The collector then cannot
> retype the key or complete retirement until both formatting passes have
> finished. If retirement wins the lock first, formatting uses the core
> key_type_dead name instead. Release the semaphore immediately after
> kasprintf(), including on allocation failure, before copying to
> userspace.
> 
> Oops report as below:

Just a small nit. Cut just the snippet of the report that is necessary.

> 
>     BUG: unable to handle page fault for address: fffffbfff8054794
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100b0b067 PTE 0
>     Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>     CPU: 0 UID: 0 PID: 500 Comm: key-fixture Tainted: G           O        7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
>     Tainted: [O]=OOT_MODULE
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     RIP: 0010:string+0x23f/0x470
>     Code: 48 8b 04 24 48 83 c3 01 41 83 c6 01 48 39 c5 74 34 e8 f5 2e 5e fb 48 89 ef 48 83 c5 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38 38 d0 7f 08 84 c0 0f 85 d6 01 00 00 44 0f b6 65 ff
>     RSP: 0018:ffff888116307b80 EFLAGS: 00010246
>     RAX: 1ffffffff8054794 RBX: ffff88810a4a52c0 RCX: ffffffff8626be7b
>     RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffc02a3ca0
>     RBP: ffffffffc02a3ca1 R08: 0000000000000001 R09: 0000000000000001
>     R10: ffffffff893cfe57 R11: ffff88811404d700 R12: 00000000ffffffff
>     R13: ffff88810a4a52d4 R14: 0000000000000000 R15: dffffc0000000000
>     FS:  00007fad30f2a780(0000) GS:ffff8881fd7d6000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: fffffbfff8054794 CR3: 0000000104fb7004 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      ? __pfx_string+0x10/0x10
>      vsnprintf+0x330/0x1110

I would cut away the rest (what follows).


>      ? pmbd_probe_hit_cookie+0xee/0x1c0
>      ? __pfx_vsnprintf+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? kasprintf+0xc7/0x100
>      kvasprintf+0xe4/0x1a0
>      ? __pfx_kvasprintf+0x10/0x10
>      ? pmbd_gate_site_armed+0x14e/0x1c0
>      ? pmbd_site_is_armed+0xa1/0xd0
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? map_id_range_up+0x286/0x370
>      kasprintf+0xc7/0x100
>      ? __pfx_kasprintf+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? from_kuid_munged+0xa3/0x130
>      ? __pfx_from_kuid_munged+0x10/0x10
>      keyctl_describe_key+0x26d/0x600
>      __do_sys_keyctl+0x2ed/0x4f0
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7fad3103b7b9
>     Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
>     RSP: 002b:00007ffeda509798 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
>     RAX: ffffffffffffffda RBX: 000000000b61be23 RCX: 00007fad3103b7b9
>     RDX: 00007ffeda5097a0 RSI: 000000000b61be23 RDI: 0000000000000006
>     RBP: 00007ffeda5097a0 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000200 R11: 0000000000000246 R12: 0000000000000000
>     R13: 00007ffeda509b90 R14: 00007fad31168000 R15: 000055ba831cdd08
>      </TASK>
>     Modules linked in: [last unloaded: rxrpc(O)]
>     CR2: fffffbfff8054794
>     ---[ end trace 0000000000000000 ]---
> 
> Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to/from userspace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529cb77de5386f1f3a99905d4b7688c..5a5efa26ed0ece3a5ab22e37ad7bda7a5a744b83 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
>  
>  	/* calculate how much information we're going to return */
>  	ret = -ENOMEM;
> +	down_read(&key->sem);
>  	infobuf = kasprintf(GFP_KERNEL,
>  			    "%s;%d;%d;%08x;",
>  			    key->type->name,
>  			    from_kuid_munged(current_user_ns(), key->uid),
>  			    from_kgid_munged(current_user_ns(), key->gid),
>  			    key->perm);
> +	up_read(&key->sem);
>  	if (!infobuf)
>  		goto error2;
>  	infolen = strlen(infobuf);

Br, Jarkko
