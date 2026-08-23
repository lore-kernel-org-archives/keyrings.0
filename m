Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1973126D6
	for <keyrings@vger.kernel.org>; Sun, 23 Aug 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504959; cv=pass; b=urluXUdFPXIion/rke3P3LfxOeQUyLeKYyJUrNwHUhrYy/Jkp+TjsIXYbsnqxm1l5Q11NF928MhE/2uCuSYD/4rwDFhdsgYuDM102m5KBqgN5h03G9X6JBBvvC1XyBuvwBOkAfil+ZDzsIagTA9N1ECcEOqhLR+8FCI/btgBBxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504959; c=relaxed/simple;
	bh=itMVIl8kjKv2VCbCaSXMZ/x3RTJsv3lLHgMUnBhYGXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN6shknbHaEKy4ZMWSDa3oIL2dbFZc6yDaYjC34J/2X5t+4L3Kp56v/bTeITpJV2iuJWMB9wFlsnrA1g3MkmquJnOD9G+GL34nvvNl52e58hGs+dAIjOS9PM1a8MtNrUzcKXyaAdnXLuL1KEiIuMJ051brklVWMq0iko5DVFg3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMVHseqF; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMVHseqF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so499739a12.0
        for <keyrings@vger.kernel.org>; Sun, 23 Aug 2026 10:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787504951; cv=none;
        d=google.com; s=arc-20260327;
        b=kIcGdmjFCpSGx1dy647sZlq8i7D9vH2QVff/7DPf0BGlYbJPw0kCkDEdYCABmU9Kgg
         JIDg/a+rZptlvIbYwNePyJaq723uapgrgEdWe4DrJpqYsiYOC9t3cNjE5B7Lr92CzLvk
         0HOU1ttSTerVJWOx0h3ie+qoNaBIYwZewSkwZa8pFRdVSECzHVr+sQl+LpYNtwywfmfh
         45iy/IN/sIQlwqR3pGpsdYNJ0lFKpq4Z52dya18tISS0SwlhdVKylXvfvJKBgzagwqTl
         Cyao5W4mVfBcSGhMHyZU7KsMUNLlj/VA+AMTH1A6GSD7I7eZyAQ4d6lVMtXedbBP0IfS
         Cb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Ew0GfwCM5ob+3f/HY4ZnldkvVWbQyMAy09B9SDr9jM=;
        fh=5y5Oi+xbVpBOzHfusrOn2JhwGNu/IxNT1nG8CKkdWpk=;
        b=jFyw1MRt41vAaXEDxtfi8aessBWhiunfFlku9BKyApVEJKKETWLgYBRGiHKWfkTy6B
         ybIpPsTDOffoWrUu48+H6x4Q4SyndMC9LAD8riZRAPFGMQqbTHdUWSYWKZYHt8ChPgqj
         ygUiGElS0eVbC7bxeHf46C78Bup7mKxz3A/o+A5xUYGVHix/kgKKAXoRZb7rELXWPmvG
         pWFxwSPi7VFZntipCxteWrMEhKwsi35VsfQPG872Y5eFNJ2mqCf3C28GoG7w29+qrp/s
         jbfQMh06fIcfotLMnwAtNv+m+yCNE5+2IPJAe8n0RBujk3Xh9IjSBtLGh72YU6dSDMKl
         4NCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787504951; x=1788109751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ew0GfwCM5ob+3f/HY4ZnldkvVWbQyMAy09B9SDr9jM=;
        b=RMVHseqFCfMxSuGnyaG/aFJ7HQJLrHkSs+3xbFdAlWAaT/x74zB+mwTDn5DxWsZq9V
         pFfhKSxMd12bVItSKHOoqL3S2hKPhfppPs0Gm4xl9v734/auHcCgw1RXj4FmZdhURTgM
         PcvSTzOPIOIbK8ROdrqVNamDFftakvu3KTR+JsfWyCtASKJFiUcUSIQ1OL8iJf6DDhtK
         I9z3kKxDA72Oqv73j0UT1Jo0Ez1FUJIIIy2H+4oCRtqczm+fhkAaUcDRiggtES2frqhV
         fmtoEbd0juiELkc7whfAN5Gx3ybCGwOO6S2Ub1Jtj/MjonbwgYoiznYUjUHSeNLArGu3
         p1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787504951; x=1788109751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ew0GfwCM5ob+3f/HY4ZnldkvVWbQyMAy09B9SDr9jM=;
        b=Z8NLnQOEZ+BbIRe9MTKMWuU8Fyv4hNo7MJalTlb7VVGeokv/5kspDQ8KriQsUULpw+
         47AAqlwRx28kpvHxvNFPFiQtaA8ZblRHgQPQnDAd4oTmYk4B0GmEvW8AxOsXjW/ywGXA
         4n/ORmsGaCX2Zxa7tcFga9yad5ioUgF9gkrjf/y57UlCvEovtpwATmIKyoctMrk6tX8i
         s2RDns63+lLglK0Lbum35+1wRt1JO2CZPYQkdL5nwKOPP445ufb2ztVoZ7uhbbWwtI47
         fhmbt9GzpJMiOSDko4+uMhtPn6t6IWqrFw/BS9+N99cMJfY3pkYmAQkpYPpWHMWAae1C
         C7oA==
X-Gm-Message-State: AFuF++lYyXQ/gsBhA0cFHgh5XslgZbW+YtNrZqbC7AdqvpPDq50Rz4RU
	rqKQyQ5icajqaMeBZtUHw1faXnK626tW7+eSwu0rSSyZ2AaJVP+rRAtYWvjDDhsBlzHOBxKxRw6
	HaA0e9ksf5RZNkpYo+Pmo4ul5j3zHkcpen9//tzZpRg==
X-Gm-Gg: AR+sD10GPjum8mC4CZQfzK0lQB9qZ/xYlub+fHT5TPZAIdM/jEX5ghl0ka5hLvyOcWe
	VEQ/+Wu1XV8ZOimVaoMSau8jqGY9dDysoYWuDfJuuoJoh7B16SFURH/44DNy6Rz4OgEdXcaNTg6
	0Ybx7hFWJ00AMZEYJ6pumhuF2GiesmN5qvVdqCBeBSW9SWqZLiEBmWDo+Rirg71h0qhsAPxZgYY
	aYavLCP7Pcgg5I5I18YL8O8F5CWsHSHVxdP7Kg/o+x+5avdqXW7HfO90uNLyl0klz3AFdtO9uF8
	kGNk5E63FicAY8NqZWR8JSoSN0uONikVQKjyuXQC3l7gWx2k2bmmoWiQ7yNaL4k/6vVML8LvKg=
	=
X-Received: by 2002:a17:906:9c82:b0:c21:960c:ec22 with SMTP id
 a640c23a62f3a-c246a5f7cadmr1239580466b.2.1787504950520; Sun, 23 Aug 2026
 10:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823170448.3856516-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260823170448.3856516-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 01:08:58 +0800
X-Gm-Features: AcwNN1VKvmVBYbz_9ZPvuLINUsiIIiyXGQdsdooXNhXiw-N31or08t327nSrJOw
Message-ID: <CAAo+4rX9=K=cdLCESxG03D8XoLRx0PjNLhB_cDSOB4mn0Ne4hQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Fix key_user use-after-free during ownership changes
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Serge Hallyn <sergeh@kernel.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:04=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> keyctl_chown_key() replaces key->user while holding key->sem and drops
> the old key_user reference after releasing the semaphore. The /proc/keys
> iterators and find_keyring_by_name() instead dereference key->user while
> holding unrelated locks.
>
> This allows the following interleaving:
>
>   CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
>   load old key->user
>                                 replace key->user
>                                 key_user_put(old)
>                                   kfree(old)
>   read old->uid
>
> Serialize the namespace-mapping reads and the pointer replacement with
> key_user_lock. This lock already protects final key_user removal, so the
> old object cannot be freed while its uid is being read. Keep reading the
> quota-owner UID rather than key->uid because those values can legitimatel=
y
> differ for thread keyrings.
>
> Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  security/keys/internal.h | 10 ++++++++++
>  security/keys/keyctl.c   |  2 ++
>  security/keys/keyring.c  |  2 +-
>  security/keys/proc.c     |  4 ++--
>  4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index b7b622bc36a1..741d547ba5c4 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -70,6 +70,16 @@ extern struct key_user       root_key_user;
>  extern struct key_user *key_user_lookup(kuid_t uid);
>  extern void key_user_put(struct key_user *user);
>
> +static inline kuid_t key_user_uid(const struct key *key)
> +{
> +       kuid_t uid;
> +
> +       spin_lock(&key_user_lock);
> +       uid =3D key->user->uid;
> +       spin_unlock(&key_user_lock);
> +       return uid;
> +}
> +
>  /*
>   * Key quota limits.
>   * - root has its own separate limits to everyone else
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529..c17924609317 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1036,8 +1036,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user,=
 gid_t group)
>                         atomic_inc(&newowner->nikeys);
>                 }
>
> +               spin_lock(&key_user_lock);
>                 zapowner =3D key->user;
>                 key->user =3D newowner;
> +               spin_unlock(&key_user_lock);
>                 key->uid =3D uid;
>         }
>
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f282..49f4be934525 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, =
bool uid_keyring)
>          * grants Search permission and that hasn't been revoked
>          */
>         list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -               if (!kuid_has_mapping(ns, keyring->user->uid))
> +               if (!kuid_has_mapping(ns, key_user_uid(keyring)))
>                         continue;
>
>                 if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f1..8d6d26652aab 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file =
*p, struct rb_node *n)
>         n =3D rb_next(n);
>         while (n) {
>                 struct key *key =3D rb_entry(n, struct key, serial_node);
> -               if (kuid_has_mapping(user_ns, key->user->uid))
> +               if (kuid_has_mapping(user_ns, key_user_uid(key)))
>                         break;
>                 n =3D rb_next(n);
>         }
> @@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, ke=
y_serial_t id)
>                 return NULL;
>
>         for (;;) {
> -               if (kuid_has_mapping(user_ns, minkey->user->uid))
> +               if (kuid_has_mapping(user_ns, key_user_uid(minkey)))
>                         return minkey;
>                 n =3D rb_next(&minkey->serial_node);
>                 if (!n)
> --
> 2.43.0
>

Sorry for mistakenly sending this patch twice.

Best,
Chengfeng
