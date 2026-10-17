Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6693AAF56
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223269; cv=pass; b=fLXE/94bNU/PJgKrJdzjSCgHRU7shK/Kpky2WkLpzXsAzX3lOpIjLGFJ12NMZEMW9bvByznXuDybE0griZ837solMrOyMXlprVvYl5mel2O+aeecp1wWS1RDGiSyIXJXlDQF/N6dn+Sy1nR6me3LdWNJhG4RsnBOwu/BdA7HJJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223269; c=relaxed/simple;
	bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGCjp4NdOnAmezJIIJPUPQDsegOR7ulz6br+HbAeiEXLyL2zhzW85W/VKtLImYd0gG4nXO8h0N8z70054c0/CfrIPf5QZdEvfr4EbOV/7qLllbbCeHK59Gt92KoL4x4esGzpHQYLYrOe3cZAyO+H4oDQKTI7mCKemK1oeJOoBXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehNE3iKR; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehNE3iKR"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8a83d2706fdso4667367b3.0
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 00:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792223267; cv=none;
        d=google.com; s=arc-20260327;
        b=RmqnhONlMCd3rieUTTqa4CBMVndEz2F2a8Pks+5ZSpLoSbePk5pM9zxMqbHL7xxxm+
         GzX3MbMRxmx4dKWKvTGCXJHmL4ZBTpgd54MXcx9GpYMlqxtpa32WL0v8mTpijljTFgbt
         VA6602lFVwOxCCoO5ppFTrooVJi+6C7YpYF0ProWrFucW3KseSVethOniLzvKb2tE6Pv
         /MDOKsBQrzg1Q5pS3IV/JJaLxbAyEuORA1nL3tE0mYUJYnkWBYVqXLkBLS0/vFLS62MF
         om3ektAT7XizuoYChhbchI4UVzwqCRuCmaxKLea4lLSPh8hRkB/6UPAmIpk9vpP/nkxA
         mJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        fh=E/T8i/y2opiI8L0ZGR6nzdWmOEwPodItOB7fQgMGKHY=;
        b=qztkCDUKqqC93r1szD4Cg9VWmMZ1xXv7Wl6SsjhN8Fwpegayc5RN1a/sxoyw+5PwPw
         lqGQmiXFgExi0W+7CxHSjIpnXuVXsZHRJBsD8RHeo5YGdy8T+AXj9DoHLrZXhzmKz5ji
         kLcGXxhzOdcUetOdxiBxH8pAe47RiYZLGmfTN7LPpp2WKZ/h4ruausarfo7wAl8ALpSx
         k8mknF2fvKz+rBWAzVzQ+Xes63EdKK5clBQdzGj0WbP5R1GHH9wI+6aMszfjHD1aMzbn
         jYVNc8yR/z8RwmzIfhgKraxcxQ3ampFPMGmxS6Phacw/LdAlFEiBoWlRJjf3ZiNU3oA/
         pT8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792223267; x=1792828067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        b=ehNE3iKR1FMemamaIhf7rKzmpTd6aUjpZVRlTnXw2rT2KeZFGpgrwgod4rnjB0KvfO
         O2RP9TFeydIiUuOuRXr9PVaK9SLUsxZ5ioS8yddVbtOZ1jBsLkR7RSGBiIhFZD+R1lxz
         aoUmGubuN1e70vklWPW3ERDyQC+I8z6DaR2t0h1fWqcxrEgGL1MUZVa0sYhUFA2YP5hk
         FXUI6VrPBFi3snLVMYVXR4j5vDaGH/n+L1GjQ95+H7A3Kp+du7aa3JLdrUjhyLkzG4H1
         Pmvy2oL1DK79enzif+W4ZD3rz/3YWvSQSSvDiEVwLJK4Er6SmlVw5AXwvLzSC3DD6mvD
         y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792223267; x=1792828067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRWmAlIfs3iswnjnTR4TzrAUiVQGOccDgG6x9wZmrjY=;
        b=FdEWgY8/W7fEyz4JkjriBZj9SqDR2I+YUWTJYP3RV/fR9FZs1elRn9lAzDFOEX+4ob
         7fZcuejKb7wQJ1HAusopNjBp+USbncRKW6wg8dShh6CxfJRTz0iLuzQ5X6DHCfWc7PB5
         /Rtwbmy7W3gy5+lnGNAwRN8qgL9ysBU2XiD1XQbxQvIJVjdtiakqCjubN4V2r3HaKKjf
         dQvTx4SVdKnMfysCGwdXp7/4c77z6OrAS4JBGfDCAPBdRdQq9XQTGXoSLflXZZGcY1+9
         5sXB5j+ZjqeBJ64MHTaq3iU7BZrlHgaA20nvYTx4Upb589yPhlKKU0J+5FPcHtuzK3sO
         pghA==
X-Forwarded-Encrypted: i=1; AKwUvBx2fFrUf8Y1g+nZRDwFBM3IqjvcMQIUfOVO4bZSHzxuhNW5zaNlq8I9LrDFWT58mfqEpxttQ0qU3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtBsjaZU5znHJJLWA6I91v0TsUo6zoQWPuvUgVRGHpLsGUJ6vQ
	2NoUi38mvr4eRPefNHe0BFSZVFW2ei26jaotXgk0wJlDTV15vzNVgIM4Fd21l51+yy2nmb01p51
	1V1HgkQEKsu/lffkYckY+7NAVBrLyAao=
X-Gm-Gg: AYBFou1Q4xbnYVs92oc42rV9ew0SmGyqvp/tyHKUPgQ4fIJdnKZTSyulLSM8mLHshn7
	RCqsdeJkIQfFm8W7YY3kWCoBqf7BkUtx1F1F4DPzjBDEMUDucpeW+VzDVnI3WCGrApgISiTeZmG
	bdi6B9SrjQQcn7bMagosIfgUbu8UVF85G1hAUVMldMEqolf71QTIaJXwqLw+YQ5urvntmKX7eab
	dtcy62YY087w5vMkubjgmp90icgsbUSmhbLHypkEoysUS08M0Esmylwv7uhadeWwtxVaayhzp4t
	RqHf12TEsFNiZBtT8AtKiIJwgIaoubmZ5n0Si4hC3p2aOsk1YPSIg0rHRp3SGvto/102K4DKN6/
	cHPRDeSIc3g==
X-Received: by 2002:a05:690c:f:b0:8b0:ac9e:14f7 with SMTP id
 00721157ae682-8b0f2164c94mr7719657b3.28.1792223266956; Sat, 17 Oct 2026
 00:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol>
In-Reply-To: <20261017035156.GA29318@sol>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 17 Oct 2026 15:47:32 +0800
X-Gm-Features: AclHuK-HpdMP-grbZn8KpuFXmo2CHX60pojXLGdBgVLSQqCwngEWAu1uK5ALbG8
Message-ID: <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, sergeh@kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E5=85=AD 11:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Don't key_serial_next() and find_ge_key() (used when reading from
> /proc/keys) have the same bug?
>
> - Eric

Thansk a lot for the reivew. You're right =E2=80=94 key_serial_next() and
find_ge_key() have
the same issue.

I'll send a follow-up patch to fix those as well.

Thanks for the catch again.

Best regards,
Cen Zhang
