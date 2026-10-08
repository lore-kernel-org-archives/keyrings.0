Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B23AD518;
	Thu,  8 Oct 2026 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482242; cv=none; b=kPRXlpBaqOmEPdGeBi2rXQbVs46NVBdOnXURUlbwlsJIf8y4POLALjgOFAP13HW69jDUzK4gjFfsVbJolDLr8ZRFnX/63J4mErfgkvafkUsqSsyA+2AGTfhfsan7qofgpkdK7HbZnKKdk2gI2sGpJF0wCioq2aYJkrTg+ayJqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482242; c=relaxed/simple;
	bh=ARACZaJWZi6XvED7B1ko9+K4pNkaiSXt1Cyp2r+vidI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvXu2SUyZdNyMX8B/YSHDub4HfM9xjDovMD3E9lbBSyVXeBHwzLnCDb4/HvpR3LjnO4grtKwAt4HN3dhoAbFvEaMSX2fM/QYeqU8jd2fm8kZ5gPIlsxPn88Z1KKbkUOqEH3vTIFevckz71Clnwl+jntSkyMkHTIiTClV3bfWC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3cn3B+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3cn3B+3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 11DED1F000FF;
	Thu,  8 Oct 2026 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482240;
	bh=wXKO4mA2Pv6Ty2TKma1XUjYTYNEMbxIkaVkmM6+j5PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3cn3B+3poQeQztWT2Q42rdQK9TJWkhlUSCiBCw42r1d8o89fWBhEEpvGJlEH307R
	 OJzGtb2Mhrn0CznVleLi0RUXJksQlfBfqk341tDSI5Sef8w7UaO76wwtaPZYlWlog2
	 Y4C+JjjIxyWurFbKLeonlPBZiV7plU4yl8fPdODEne00MgFKF48q+wOdahZ4kyZgjr
	 NwgwHK8yEWuBuamiNwWvfuZvMs1o3jPnuEZ+mVbqF8fEmhP8YyJN5jqDp+/8eOuUWO
	 ex2ONrX67W7Bwxy/JYKqut3rPQOGAM+PwbnVG8bf6jPnFItK2JoBBhwv6Am1VaEWFZ
	 sLBXFcqg9sOjA==
Date: Thu, 8 Oct 2026 20:57:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, sergeh@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <asfZfZcusHMRiUYY@kernel.org>
References: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>

On Thu, Oct 08, 2026 at 02:30:46PM +0800, Cen Zhang wrote:
> Named keyring lookup must keep the storage containing the owner UID
> alive through the namespace mapping check.  find_keyring_by_name()
> reads keyring->user->uid under keyring_name_lock, but that lock protects
> the keyring's name entry and allocation, not its separate key_user.
> 
> A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
> another CPU.  If the keyring holds the last reference to its old dynamic
> key_user and the ownership transfer succeeds, the following ordering is
> possible:
> 
>     Named join                         Chown
>     find_keyring_by_name()              keyctl_chown_key()
>       read_lock(keyring_name_lock)       down_write(key->sem)
>       load old keyring->user
>                                          replace key->user and key->uid
>                                          up_write(key->sem)
>                                          key_put(key)
>                                          key_user_put(old user): free
>       read old user->uid
>       read_unlock(keyring_name_lock)
> 
> Chown neither takes keyring_name_lock nor key_session_mutex, so it can
> free the old account between the pointer load and the UID read.  The
> lookup then reads freed memory even though the keyring itself is alive.
> 
> Use keyring->uid for the mapping check.  key_alloc() initializes this
> inline owner UID and keyctl_chown_key() updates it on chown.
> The existing name lock keeps its containing keyring allocated throughout
> the check, so lookup no longer depends on the account's lifetime.  This
> also matches the owner UID used by the permission check.
> 
> KASAN report as below:
> 
>     BUG: KASAN: slab-use-after-free in find_keyring_by_name+0x577/0x5d0
>     Read of size 4 at addr ffff8881128ae2ec by task keycase/500

Similar nit. Not sure but I think even just having these two lines would
be sufficient or is there something that follows that would be
meaningful?

> 
>     CPU: 2 UID: 0 PID: 500 Comm: keycase Not tainted 7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x93/0xd0
>      print_report+0xce/0x630
>      ? find_keyring_by_name+0x577/0x5d0
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __virt_addr_valid+0x20d/0x410
>      ? find_keyring_by_name+0x577/0x5d0
>      kasan_report+0xe0/0x110
>      ? find_keyring_by_name+0x577/0x5d0
>      find_keyring_by_name+0x577/0x5d0
>      ? __pfx_find_keyring_by_name+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? security_prepare_creds+0x4f/0xb0
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      join_session_keyring+0x89/0x310
>      keyctl_join_session_keyring+0x81/0xe0
>      __do_sys_keyctl+0x3c6/0x460
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f562a4817b9
>     Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
>     RSP: 002b:00007ffcb80b34a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
>     RAX: ffffffffffffffda RBX: 00007ffcb80b3638 RCX: 00007f562a4817b9
>     RDX: 0000000000000000 RSI: 0000563212976004 RDI: 0000000000000001
>     RBP: 00000000000001f5 R08: 0000000000000000 R09: 5200000000000000
>     R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>     R13: 00007ffcb80b3658 R14: 00007f562a5ae000 R15: 0000563212977cf0
>      </TASK>
> 
>     Allocated by task 501:
>      kasan_save_stack+0x33/0x60
>      kasan_save_track+0x14/0x30
>      __kasan_kmalloc+0xaa/0xb0
>      __kmalloc_cache_noprof+0x251/0x630
>      key_user_lookup+0x181/0x530
>      key_alloc+0x164/0x11e0
>      keyring_alloc+0x49/0xa0
>      join_session_keyring+0x296/0x310
>      keyctl_join_session_keyring+0x81/0xe0
>      __do_sys_keyctl+0x3c6/0x460
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>     Freed by task 502:
>      kasan_save_stack+0x33/0x60
>      kasan_save_track+0x14/0x30
>      kasan_save_free_info+0x3b/0x60
>      __kasan_slab_free+0x5f/0x80
>      kfree+0x236/0x5a0
>      key_user_put+0x57/0x60
>      keyctl_chown_key+0x5a7/0xda0
>      __do_sys_keyctl+0x1ba/0x460
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>     The buggy address belongs to the object at ffff8881128ae200
>      which belongs to the cache kmalloc-256 of size 256
>     The buggy address is located 236 bytes inside of
>      freed 256-byte region [ffff8881128ae200, ffff8881128ae300)
> 
>     The buggy address belongs to the physical page:
>     page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1128ae
>     head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>     flags: 0x200000000000040(head|node=0|zone=2)
>     page_type: f5(slab)
>     raw: 0200000000000040 ffff888100043400 dead000000000100 dead000000000122
>     raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
>     head: 0200000000000040 ffff888100043400 dead000000000100 dead000000000122
>     head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
>     head: 0200000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
>     head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>     page dumped because: kasan: bad access detected
> 
>     Memory state around the buggy address:
>      ffff8881128ae180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff8881128ae200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     >ffff8881128ae280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                               ^
>      ffff8881128ae300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff8881128ae380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>     ==================================================================
> 
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f28218ec3f12c97630d1c76939af7eca..46f774be72967a9bd16b0ddfdf323eda36edeff4 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	 * grants Search permission and that hasn't been revoked
>  	 */
>  	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -		if (!kuid_has_mapping(ns, keyring->user->uid))
> +		if (!kuid_has_mapping(ns, keyring->uid))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))

Br, Jarkko
