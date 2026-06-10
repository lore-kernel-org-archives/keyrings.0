Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E92D3ED2
	for <keyrings@vger.kernel.org>; Wed, 10 Jun 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104877; cv=pass; b=FlrvSyQFnDoOE0Guac09GM8oJ9Z9gRtb4lIbtypCjeM6wtQdfuq1RYJ2f2iyCU6W1D4YI9Dq7IdH+t/jSZS+dwW3a7NxXKPGHcWl/51ZN3H8jQqpjTAqrkKIGx4xNOwTZwABqd4A8zRkjP+wmIsYSkgRG5BFHqWQ2jhE9oEQ6Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104877; c=relaxed/simple;
	bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llLfjyelIitcZbG+2jgT5iomjF/kATYLeRsSG3CzlUP5uDMb+4j148J8JpImjHdemm5OIPEfdVthyIfj2+f1k/8B4wRW9EOGxF0O0Xc4DOArxs5OsTenQcRaABpXbR7ZDsArBbwueNsVtbT0n3gxVWv1FzKVFdySdsHqjj6RRrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psJCRdF9; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psJCRdF9"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69dead44101so4088740eaf.3
        for <keyrings@vger.kernel.org>; Wed, 10 Jun 2026 08:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781104875; cv=none;
        d=google.com; s=arc-20240605;
        b=apq4pHG/pSvAFJPLmwNmAgN7c/XYzTKd/9Yp2lUINRWWwYDToj5jvKV1UtxEg1g4pc
         49ACQWjMjlJ9P39GGQ3q8+O2+GVJhvAnI6K4+RB9oOP8i+BGuCSnERnk+adHGlxTcvJa
         I/HMKNgsIcloP4rgjxHYyJscHH0IR7S1T7IkprdUJ0LgVH9WmM6MmscrWX6TY86ezcwS
         /EOXNtr/sKrzQDO4E2Lgi3sVurk4od+dpUSLyZDiVpGGUdtia6l+pAjLR8w78Z6CWsE3
         tZvRoenjcoacd/x3Ko4rfrl4fJHL9BQnQV5cnroGihuzpfDvRuisRJvUPgPsoxkB6SpZ
         gOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        fh=be7MTJyk4KJqa4maG5FBfmb514musDia/GVD63GQjY8=;
        b=B18UqSsvwHk/35/aeU0Yv74/J/59xDVx8LB/DeAcSh7I6FiQR5qJ1+B1ClRKaSVGnP
         6EAqv/XK9VAHYGmmGmTExLKHDZvWLxm5MdWcU1k4qY5L+qUVuOArgDnuKle5yW6t/yCq
         s1fJWrN9gnz76sLEtFMpoift0isQUl2n6psE3YmAHYTCFT4tTvjxncatme43+WNQ4jeh
         +t1NZuTBENZzem1XnevoSRn110d1piwWXbp2Fn7tdP0eCIA4O8N5usseFKx9P3UYVSdQ
         WyrYl8lfHqBgA0RDP8N2OujRA215QjcCx9l9T0EApNuOxU0/26AeRSflai9KNGQfoI8u
         5NeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104875; x=1781709675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        b=psJCRdF9EQXj29poYT7gXB9PXZ0BAs7z+LzdrzPpm5Ak7GDUD4xyyiEzs4+Q6zJZt0
         +6aPnr7CLXdLj3hz7r/5hiZGO5h0IjYddzVtG0wYM9ZSrsQiNZ6zyOKDF+eTyNVsparW
         iNexIdgkD/7eVLrmVVJAI3x3wKLWjGJE1kn8PETqC3LL1yLFNw7uoqyECGX9W0RG7ywl
         Q4q2id3dI0/fzUpxSJdElMQZWJZ4Wgq4kEb2wwvDdUzOd5Wi1WPAI+wJwtU3zpcGu0Ec
         E5eROjh9pwk81CZ8E7WXqaGeEcCQopK2548q1DtrffPBevLj9OERGpQxGQ11UcIv9PRM
         QKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104875; x=1781709675;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtHQLoifPt3NcxmLT9e1RJEkX1K3ehp5cC2XJqGznqQ=;
        b=BQ0P/uldBLSodgrGh4SXw3/sEcNIbIZOFoG5WjP7oiJP/LEa+ZsumXes0IYHWM08N3
         FzkRlK0SQrwC6fuyh+DADJxI+cbDXfH6l8IgKWM6s19fSmaQtrR/MzAvwk7bWhtLpc3D
         4jZe3Y//clm6f+hyV/X6WkZbTlRAQfJHuCEQjgIi3eZM378l95Cbf1cZKpFLdt0sv8MF
         s6nBT2BkBC+lKNL6OqTc5HnfILnp1/NGprYbWEz4ENwM94tEwRnW/Yh0hr6rOC8/vjPr
         8Ydortbg7Khh/77TgA8Q4+3GKyQb2Iw01vdQ1YCFG0t1ts8W+CHCfUR+mfftYzNzCKzO
         jr6Q==
X-Gm-Message-State: AOJu0YwTgFV7J8OojQv6Z+uu3ayWdqhR/yM+hKSyEgauRq2kp+amMm2O
	6vVI00I+u29GOnPT8+Za5X7n8KpXO1q4pnIJsdPyKMtPWOSPbi0h7nG/6IDTq51+F9gMUnXgtrj
	WttV4+LIWz/JoE2OBwDh4NMM/6aEp2mo=
X-Gm-Gg: Acq92OHAXeasDX1qiO/j2mOiC71tnNlyP2b6/Y3yF3k2cnzCoEgtCDzrlUuv1fom10a
	IgPLPEtkmY8qwhNrBjqYYujrCbDo86Nithuaq37Fwt8tCCz0AKBMyhA26PEXPikKMSABoy2s0Aj
	y3tTPNhUaCYpMhDod0t0puSnTPnzbnBtm6vBpek+io+yMPObFzRcMSwV8EnRG+e4lftY7S/mOxA
	wIFf2YrU3NFyrh7TthR7hZG4/uzXoZwKGGN71WHVQCWH4F7h2XD2Ga+6teTYVTj7oPUopQVudb9
	PJAHeh9PWTs48ze1LCfvO1Gh9X8Hkvlhi2ULSS2t5jz1yoCVKcIiflfF9aXEeDSy9s4CXQQI1Y7
	4SQ==
X-Received: by 2002:a05:6820:1611:b0:69e:428d:136d with SMTP id
 006d021491bc7-69e68b4d980mr14150343eaf.19.1781104874827; Wed, 10 Jun 2026
 08:21:14 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 10 Jun 2026 10:21:13 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 10 Jun 2026 10:21:13 -0500
In-Reply-To: <aik5YaJhjRuOKE7I@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org> <aiYynOxFk3LuK4LA@kernel.org>
 <aiZTIzGg_peDVo1M@kernel.org> <aiZWPSJZyFq4nmxf@kernel.org> <aik5YaJhjRuOKE7I@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: eee sss <eeesssooo020@gmail.com>
Date: Wed, 10 Jun 2026 10:21:13 -0500
X-Gm-Features: AVVi8CfC8AQgLb_bEt_ndD4zhPQKCDXtCnb5DgT1cKQL4HY7OZ04EqHMa4bFBy0
Message-ID: <CA+TOyfjifw5yiZwUmd3y7t227cTMpXxT_JNe0FSO-NYzhqE75Q@mail.gmail.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Jarkko. Sorry for the delayed response.

I checked the commit in for-next-keys. The updated commit message and the
cleanup look good to me.

Best,
Shaomin

On Wed, 10 Jun 2026 13:16:01 +0300, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Mon, Jun 08, 2026 at 08:42:21AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 08, 2026 at 08:29:11AM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Jun 08, 2026 at 06:10:23AM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > > > > > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > > > > > auth key before copying an instantiation payload from userspace. The copy
> > > > > > can fault and sleep. If the request completes and revokes the auth key in
> > > > > > that window, the auth payload can be detached and freed before the
> > > > > > instantiate path uses it again.
> > > > > >
> > > > > > A request-key helper reproducer can trigger this race. One helper child
> > > > > > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > > > > > requested key and returns. KASAN then reports a use-after-free from the
> > > > > > stale request_key_auth payload in keyctl_instantiate_key_common().
> > > > > >
> > > > > > Give request_key_auth payloads a refcount. Take a payload reference while
> > > > >
> > > > > Please, name concrete things accurately. I.e. 'usage' in this case. If
> > > > > you have a name, use it instead of obfuscating generalizations.
> > > > >
> > > > > > authkey->sem stabilizes the payload and revocation state. Hold that
> > > > > > reference across the instantiate and reject paths. Drop the auth key
> > > > > > owning reference from revoke and destroy.
> > > > > >
> > > > > > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > > > > > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > ---
> > > > > > include/keys/request_key_auth-type.h | 2 ++
> > > > > > security/keys/internal.h | 2 ++
> > > > > > security/keys/keyctl.c | 24 +++++++++++++++-----
> > > > > > security/keys/request_key_auth.c | 33 ++++++++++++++++++++++++++--
> > > > > > 4 files changed, 53 insertions(+), 8 deletions(-)
> > > > >
> > > > > So first, couple of things.
> > > > >
> > > > > I'm not going to test not that well documented involving OOT driver.
> > > >
> > > > Oops, sorry typo. "not that well documented reproducer" :-)
> > > >
> > > > But it is cool we just then need to draw the picture.
> > >
> > > I think I got this:
> > >
> > > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > > ---------------- -------------------------
> > > create auth key
> > > store rka in auth key
> > > wait for helper
> > > get auth key
> > > load rka from auth key
> > > copy user payload
> > > sleep on #PF
> > > helper completed
> > > detach and free rka
> > > destroy auth key
> > > wake up
> > > use rka->target_key
> > > **USE-AFTER-FREE**
> > >
> > > So nothing really complicated here, is there?
> >
> > Send v2 with the code changes that I proposed as we want to the change
> > as ergonomic as possible.
> >
> > Use this as the commit message:
> >
> > keys: Pin request_key_auth payload in instantiate paths
> >
> > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > ---------------- -------------------------
> > create auth key
> > store rka in auth key
> > wait for helper
> > get auth key
> > load rka from auth key
> > copy user payload
> > sleep on #PF
> >
> > helper completed
> > detach and free rka
> > destroy auth key
> > wake up
> > use rka->target_key
> > **USE-AFTER-FREE**
> >
> > Give request_key_auth payloads a refcount. Take a payload reference while
> > authkey->sem stabilizes the payload and revocation state. Hold that
> > reference across the instantiate and reject paths. Drop the auth key
> > owning reference from revoke and destroy.
> >
> > [jarkko: Replaced the first two paragraphs of text with a concurrency scenario.]
> >
> > And it includes also the remark at the end.
> >
> > BR, Jarkko
>
> Nothing heard so I pushed:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=for-next-keys&id=9feb0bb3468e863b2b82a2eabfaeec4c7c44b90c
>
> It has the commit message change.
>
> BR, Jarkko
