Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761386;
	b=Q3vH/OVv3WC1QT0DOL6TJYVHjMOqAK53UuQifX2sSIfXYAHsiGu8s8lUAq3LvwCp6Ah+
	 ron8SXKJK1krysVpnoRIidTTTXfn2jKBay6ySXeYYMASafWUDT0X0UkyJ5L3Tl+9cP3kt
	 nU3sCxrShadP4nAnZdLFNHnrk/PbdU4Xwp1+ahmn1L4EOmkhAwlJRMg5mjdbuvF3dRbeG
	 XwmAeiB5mJRPjsYTK77DvXRYAMv9W+Pb5fV/d96ExtXU+W4RUpPXMp1tZd5M6335O6EZa
	 /XreseCXc+enihPvYo3kMZYmzuxnqVkUm+J4Wi20834lQJNgKkHiVX5AxBq4rx8kY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Jnmx7teJGQZMRfarYN+PGQR+XtvXbKJdYdbknuTFvI=;
	b=Fj/e7mrtQIQvo3LcLQgmeyiMvR0oHSugVftIuZ9wj2Bi5NEv5naSmU1sphtd6aa4dAa1
	 WTwB+Mn0crqCbJEov4J4Gmavyd02Gyufq/eWZLKRKEJzHgopfWuov1Zo1CrmDollqucfe
	 093N/kcWODFZ0UOYwTMeIHjF+4s1LqImDWloF84y47GdDaiPs1UbhhnDlHdKQbFnCxxot
	 KyFTtnMBAL+9+YeaANc5NcFGkE6QHkFXzblJHgMTty7SPulDq3og/G8O7Lt8+aezR/aMm
	 OOYWlick9n+pwxk8mDI4PC4tSz6nfwKmmQu6kq1yBu7p7iDAxJg0K/alGyOCgIIy91A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT57FdzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB15606A332;
	Wed,  4 Nov 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT57FdzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6731F00A17;
	Wed,  4 Nov 2026 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761386;
	bh=7Jnmx7teJGQZMRfarYN+PGQR+XtvXbKJdYdbknuTFvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QT57FdzBdnwtlTZhmUAO7dObknWiQgLcYbsgNRfbWSWTVx6I/bgFx1ccChS9C9Lkx
	 MH26/og/UdSSjJdEiE+fiqiYCtJn+ENDKj/GtRH2BttjEn9FZIl9G69Ql2g1LCOJaM
	 VV9gV6oxDA4dbBYNuWGC6VA0ao1PitQy07oAwfe5OwuNDlQVG6aO/WFSHUNMNiznrm
	 rLVTU49gGoWE3v5OvhlTiOnKIyFC6vszGnMrMqQwB7dCnOptAlyw+N+m2JXn1B3B4Z
	 YRrrYrAGNj0A68RqrO8ueTWNTPna5fNSn1UNA0JKCAOjUayBggniTu4niE/KEUVRJB
	 pUQOmu3X1lRQw==
Message-ID: <sashiko-outbox-196569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/11] smb: client: Clear idmap/SPNEGO caches
 when the last session is unloaded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, keyrings@vger.kernel.org, "Paulo
 Alcantara" <pc@manguebit.org>, "Namjae Jeon" <linkinjeon@kernel.org>, "Ronnie
 Sahlberg" <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Tom
 Talpey" <tom@talpey.com>, "Bharath SM" <bharathsm@microsoft.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?bW9kZXJhdGVkIGxpc3Q6Q09NTU9OIElOVEVSTkVUIEZJTEUgU1lTVEVNIENM?=
 =?utf-8?b?SUVOVCAoQ0lGUyBhbmQgU01CMyk=?= <samba-technical@lists.samba.org>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-6-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:04 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] smb: client: key_gc_flush() in sesInfoFree() on WQ_MEM_RECLAIM wor=
kqueues
- [Medium] smb: client: WARN_ON() on keyring_clear() failure in cache clear=
 helpers
- [Medium] smb: client: premature SPNEGO cache clear in dfs_mount_share()
--

commit 1af6c60c9338c6ee58b722558872d2fff3e07106
Author: Jarkko Sakkinen <jarkko@kernel.org>

smb: client: Clear idmap/SPNEGO caches when the last session is unloaded

This commit serializes CIFS session count transitions with a mutex and clea=
rs
the idmap and SPNEGO cache keyrings, flushing key garbage collection when t=
he
last SMB session is freed.

> diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
> index 44c4072756804..3bd272c7d9fe6 100644
> --- a/fs/smb/client/cifs_spnego.c
> +++ b/fs/smb/client/cifs_spnego.c
> @@ -242,6 +242,14 @@ init_cifs_spnego(void)
>  	return ret;
>  }
> =20
> +void cifs_spnego_clear_cache(void)
> +{
> +	int ret;
> +
> +	ret =3D keyring_clear(spnego_cred->thread_keyring);
> +	WARN_ON(ret);
> +}
> +
>  void
>  exit_cifs_spnego(void)
>  {
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 346899da91eb2..7504cedf64177 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -590,6 +590,14 @@ init_cifs_idmap(void)
>  	return ret;
>  }
> =20
> +void cifs_idmap_clear_cache(void)
> +{
> +	int ret;
> +
> +	ret =3D keyring_clear(root_cred->thread_keyring);
> +	WARN_ON(ret);
> +}

[Severity: Medium]
Can keyring_clear() in cifs_spnego_clear_cache() and cifs_idmap_clear_cache=
()
trigger a WARN_ON() on a normal memory allocation failure?

When sesInfoFree() frees the last SMB session while keys are cached in
spnego_cred->thread_keyring or root_cred->thread_keyring, keyring_clear()
calls assoc_array_clear():

security/keys/keyring.c:keyring_clear()
  assoc_array_clear(&keyring->keys, &keyring_assoc_array_ops)
    kzalloc_obj(struct assoc_array_edit)

If that GFP_KERNEL allocation fails under memory pressure, memcg limits, or
fault injection, assoc_array_clear() returns ERR_PTR(-ENOMEM) and
keyring_clear() returns -ENOMEM, causing WARN_ON(ret) to fire (and panicking
systems with panic_on_warn enabled).

Other commits in this series (such as nfs_idmap_delete() in
fs/nfs/nfs4idmap.c and dns_resolver_cache_put() in net/dns_resolver/dns_key=
.c)
log a ratelimited warning with pr_warn_ratelimited() and skip key_gc_flush()
when keyring_clear() fails. Should cifs_spnego_clear_cache() and
cifs_idmap_clear_cache() handle errors the same way instead of using
WARN_ON()?

> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index ec28f102ea08a..4503434942f97 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c

[ ... ]

> @@ -115,6 +122,14 @@ sesInfoFree(struct cifs_ses *buf_to_free)
>  		kref_put(&iface->refcount, release_iface);
>  	spin_unlock(&buf_to_free->iface_lock);
>  	kfree_sensitive(buf_to_free);
> +
> +	mutex_lock(&cifs_session_mutex);
> +	if (atomic_dec_and_test(&cifs_ses_alloc_count)) {
> +		cifs_idmap_clear_cache();
> +		cifs_spnego_clear_cache();

[Severity: Medium]
When mounting a DFS share with no existing SMB sessions active, does cleari=
ng
the caches whenever cifs_ses_alloc_count drops to zero prematurely evict the
SPNEGO key just obtained during the mount?

In fs/smb/client/dfs.c:dfs_mount_share(), when !ctx->dfs_conn initially, the
mount path sets up a session (populating spnego_cred->thread_keyring via an
upcall), queries the DFS referral, and then tears down that initial connect=
ion
before allocating the new DFS session:

dfs_mount_share()
  get_session(mnt_ctx, NULL)        /* cifs_ses_alloc_count: 0 -> 1 */
  dfs_get_referral(...)
  if (!ctx->dfs_conn) {
      ctx->dfs_conn =3D true;
      cifs_mount_put_conns(mnt_ctx) /* cifs_ses_alloc_count: 1 -> 0 */
      rc =3D get_session(mnt_ctx, NULL);
  }

Because cifs_mount_put_conns() calls cifs_put_smb_ses() ->
__cifs_put_smb_ses() -> sesInfoFree() before the replacement session is
allocated, cifs_ses_alloc_count transiently reaches 0. This wipes the SPNEGO
keyring and stalls in key_gc_flush(), forcing the immediately following
get_session() call to perform a redundant userspace SPNEGO upcall.

> +		key_gc_flush();
> +	}
> +	mutex_unlock(&cifs_session_mutex);
>  }

[Severity: High]
What happens if the last reference to struct cifs_ses is dropped from a
workqueue created with WQ_MEM_RECLAIM, such as cifsiod_wq?

In init_cifs(), cifsiod_wq is allocated with WQ_MEM_RECLAIM, and
cifs_kill_sb() does not flush cifsiod_wq before calling cifs_umount().
Background work items running on cifsiod_wq can hold session or tcon
references and drop the final session reference if unmount completes
concurrently:

fs/smb/client/connect.c:mchan_mount_work_fn() [on cifsiod_wq]
  mchan_mount_free()
    cifs_put_smb_ses()
      __cifs_put_smb_ses()
        sesInfoFree()

or:

fs/smb/client/smb2pdu.c:smb2_reconnect_server() [on cifsiod_wq]
  cifs_put_smb_ses() / cifs_put_tcon()
    __cifs_put_smb_ses()
      sesInfoFree()

When sesInfoFree() clears non-empty keyrings and calls key_gc_flush():

security/keys/gc.c:key_gc_flush() {
	do {
		rcu_barrier();
	} while (flush_work(&key_gc_work));
}

rcu_barrier() runs assoc_array_rcu_cleanup() -> keyring_free_object() ->
key_put(), which schedules key_gc_work on system_dfl_wq (a workqueue without
WQ_MEM_RECLAIM). Calling flush_work(&key_gc_work) from a WQ_MEM_RECLAIM wor=
ker
on cifsiod_wq will then trigger the WARN_ONCE() in check_flush_dependency()
for flushing a !WQ_MEM_RECLAIM workqueue from a memory-reclaim worker.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D5
