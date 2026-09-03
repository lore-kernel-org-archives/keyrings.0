Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6754FB9C6
	for <keyrings@vger.kernel.org>; Thu,  3 Sep 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458657; cv=pass; b=UELHUUdX2sFeA4aITlhLhz6YJZW5icdrS8RORwUU1ZRjFmlh+fbv7KyWkA4AAjXzl/2k0uvJKoB3btTNq12xCWD4HNUN4ff3T2YndWF8xVAeO8OSan0xwqIu8Dh3sS9Vg3rXsL4CYsVljPGrpVkFtuH7RcTj/Mr9EJdxihGitFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458657; c=relaxed/simple;
	bh=rBhnMpnlpQJIqe45e7mghY2bbrkfay04f++iDuWUl10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZSWmhJp5U/VAo4HxX2nFVgYMubivfkxTZtmc9kBJk139mb3Wbd/ClWbuXAKTTKvzVgHz/o3Ws/CWoOwliJSheVGHn+FmBr2Zy3mXmKlKj4ObJFOJGEIACcRL17aiu3EzA4XYqiAdCXuuyWwEMIqvJVCNC1Mmc+I9fEtuThav8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RccCEGpi; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RccCEGpi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a615ab11b5so7350a12.0
        for <keyrings@vger.kernel.org>; Thu, 03 Sep 2026 11:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458655; cv=none;
        d=google.com; s=arc-20260327;
        b=Oh8oonExIpTKAvOjdO1MQ2rwUtSn24NqplGgztxmq/9xQOUrb+hcVKFkLW4wKmXOi4
         WYJmDM2BFZ39FaBPK2jsbOu7pdlWuBFGfSKibizilx9O8tBaV/BN9EOaA6+DaD5tJppR
         xjoqtR1y53J88MDli9kyYcnbuNBtYDhtfhuHk/uZffUxVfK4CfgeOedTqrS+l5WANE6z
         oEKjIF65C/fohThpoIuNQxmYqI5Ws1+7fJAzNa1F3LOL5tW9Su5HQsmFQDcXHxICXwmC
         pRCAvE05QHP2YvrlWCW8sO1Fhm0hu5u6TP//6HhVUzJlM45cQYcgIMDafWYoPe5xrl1n
         FrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        fh=GicwVhCIjDPShLoLNywiU3yxZwe4FS3OBgicwI0547c=;
        b=dDsOo07zVdryheeTHTO+eRkS8ClCgfUIfwIEzUfKyWSS8cigLwDzjQj9jsIWDGXjW+
         AyG2EgarXeQAwz5T1nD/+3Kms2RK8kk7OfBCbJMsSjEYeKi+auGrni7cqKPZwbvKo3bQ
         K4yqqCk7IK9UjTjsSyru23kGxmncQLFvzKQfv6wiUiGzhWsigKj4J+341tn+1V0Vu6zu
         6pxvf3aHli0bCqeHHeHMoI9eVxQ/o/huCeER6NNKxqaRW2ZceNhd6gSSv8X0cqYd9mI9
         ebX7NT9YqRxOo03e2/gpoI7FQ3xz/IV3mwwGRYDct4ux+MO0L+5OltIb+dY5+16HtRHn
         aQrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458655; x=1789063455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        b=RccCEGpiA7D7Pf/qAQaHVXLmcQu4HvtTYkDZDCl9EtQa8UOUSWjX7VNEbGAToiTY3+
         1K8kZCa/pTbhlPrZlOZIXKz0XXv9xDSv+qWrTBbcyWDD7iZvT/xdng91f/FAYq5JEuw4
         vs5PeWxL1VX6hcuU3w54d3Gi/USbAs7D3k9Qurdvj0zwujivEJ2rzi/2HEPEMjbwruub
         7ePUCfV84U4s+4+TjRX2UyaBJh8XJexp2mioen6Q5yE8ezRjYCf7jiPHi314mMQHGWQD
         lHA32d/k/KNYFlTGdCD4R3OzjfDGuCT39rErJLZaMgRnJihS8DYZlSg0Wgd80oryWxlK
         BAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458655; x=1789063455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        b=Gx1ka3TWGlFBSUJEBO+fYB3qMbUdpa7Oh7+PC/KGNpWWLey4wG0rV2EsEXpKVV44Ee
         llcELYgMz7eRAO+i/af/7RwvJ7sFGLI8tqjAQR5abnMnZIRNbdE9AiqmhSU8DIIPXlf1
         qcg6j0k9JY5hd0TwD/wJmaOW9c1IMW2mPYxTcm/E4yNf23XIjx5xL7QAbuf8nzQocO6L
         9/b8wCv0r5O+g4ZZe4+9p/o6mXegnrmJuvXSUSmCPuYl8z6VRdqskM82qeMDcbLk6vGO
         sRQ3vl90/dbCw/9YmO2CcCJqEwHy29chz99fvYWKdzsHrOk9ibJMhiOYpB0GDIsaJUBL
         4Q7Q==
X-Forwarded-Encrypted: i=1; AKwUvByDoScawYXx2DHrqp7hgEGbpyvmckRzzHe6D2QbCAak+womVglXof+SUfOrJGn+JuXwvRKaNcubiw==@vger.kernel.org
X-Gm-Message-State: AFuF++lUvDkdnkOvTGOZ9kalDWLuv4vqwDWh1wV60kf3kOW3QnVK4SGh
	gHYBQnPR1OpIhgBeW1c4Xf+twVZZ5JN+MTUmBy/xwA9Gi/ZcIrcPBw6bQSEkLM6NUlCopLuAkFm
	erOpLe/61hNobVCmiMgN+edasBYkIOtg=
X-Gm-Gg: AYBFou2m09uCjrOcAESGuUQS7oxB7eeyw73qnG8EUQuD/9tzoa5s+R3WpwTbn89oIAP
	xLxp8zgGiMWdWbnlHiT59Iyv3kUREGTuAisRZO2PFRJwCUCrTUB1BRIiNeoaQy8xcdmPwkzPVX/
	f5ML90TUQZfy2sZFUCcsgI5pqTrgY6k7eZfEgocrNMd2JEGHtNXuZpYtSe0xjVyZvHY4GJzKJWI
	lZwXj5TTfbzKCo6EshGWrxIZ9QBr0r0vsm+KLNeoVbJ+CnJqFIZDYp2QZGRRWHPgUpFZvfa8fOP
	G5UPMKM7Fj/TCHnkKMMjuCzLvhFSHovLvUoADRKky8ASd7msxCY4ZxyVWzSJstMS6pZj0iWb1A4
	=
X-Received: by 2002:a05:6402:440b:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a6818d6c95mr5674598a12.0.1788458654598; Thu, 03 Sep 2026
 11:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823152858.3839939-1-nicoyip.dev@gmail.com> <apC0xGqWTIXTIgBU@kernel.org>
In-Reply-To: <apC0xGqWTIXTIgBU@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 4 Sep 2026 02:04:02 +0800
X-Gm-Features: AcwNN1Vixc56lPwOlEAr0jNOgKZcPkT3QtgHqPSwQ2VM7-p1rr5p9dczVDYtyP8
Message-ID: <CAAo+4rXK_MpdsSbmuu+oHP2STUxApG2XRBkKUcpvcTKETEznOQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Fix key_user use-after-free during ownership changes
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Serge Hallyn <sergeh@kernel.org>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:06=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> I hope you don't mind that I sanity check a bit:
>
> =EE=9A=91 git grep "user->uid" security/keys
> security/keys/internal.h:       uid =3D key->user->uid;
> security/keys/key.c:            if (uid_lt(uid, user->uid))
> security/keys/key.c:            else if (uid_gt(uid, user->uid))
> security/keys/key.c:            unsigned maxbytes =3D uid_eq(key->user->u=
id, GLOBAL_ROOT_UID) ?
> security/keys/proc.c:           if (kuid_has_mapping(user_ns, user->uid))
> security/keys/proc.c:   unsigned maxkeys =3D uid_eq(user->uid, GLOBAL_ROO=
T_UID) ?
> security/keys/proc.c:   unsigned maxbytes =3D uid_eq(user->uid, GLOBAL_RO=
OT_UID) ?
> security/keys/proc.c:              from_kuid_munged(seq_user_ns(m), user-=
>uid),
> security/keys/process_keys.c:   uid_t uid =3D from_kuid(user_ns, cred->us=
er->uid);
> security/keys/process_keys.c:           uid_keyring =3D keyring_alloc(buf=
, cred->user->uid, INVALID_GID,
> security/keys/process_keys.c:           session_keyring =3D keyring_alloc=
(buf, cred->user->uid, INVALID_GID,
> security/keys/process_keys.c:                                            =
   cred->user->uid));
>
> Have you audited these and reflected against your current patch?
>
> BR, Jarkko
>

Right, there are more sites that take and dereference key->user but
not serialized to prevent the UAF. I am going to send a v2 to protect
other sites affected by the data race.

Best regards,
Chengfeng
