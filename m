Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793422167;
	b=A/b3VIxcGZRP55eXCaXBjkad7yGbYx5A6v2asF8+NIXtR+cG0mBQLZy4y8h8Oy0aDXSp
	 TUjXlemaVSkCr5lc84BFjeN6CH5G9f4jdhI/78rsyhQ66e8HOh311rW0A+KZDQ1dzAuy4
	 U0T5DjOpCJkj0KXl5ghjPsPyFWiSdeNKBtA2aSkzDfVh0aBVV4PjCQsArP331h33tBhrg
	 FOL6o0QuJOwQYK/1sNvL0tulM+u2Bc4Buq28fn1gDE/UPtmNIFb1cOeU6m031SoKHs/W+
	 CCVwTwt4LgVUK/NPaJgLlt9vdbO9aMLkLY/aBQw6/slCdvoS6uaISpFz0UicMwX/Adw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
	b=A+QuvNgyyzNY2Z0VpGWcu7g2PGtWRyLQuQPeFeM4Q1ps+wwvqTFpjpjUnoqnothxwZ8r
	 SXxPXeDQQq9PYW2cScStCzvEDC01DglNZa+fhFKnI9Mma4k+EUxbdJaBOPtJY9M/GaNeR
	 a09jtSIfh8YzELWljsqTNAereGTKi6jwFLzKJwmhGVZomVymTfr+S4to2IjPpc96ZBSP0
	 XCswT4+tVu9cS+4N0xEnUVXEZ+YKdvw+nB6ExFu+J1DvpRj1GZmNWR/SUKplYn+Nd8d7V
	 Yy8adp+dRGNfYjV0RhYP72KVWWGaVFZNO5EVzaDZIQ06+GcAQK57d6T1NFhXwP9zvOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
Received: from mail-vs2-f8.google.com (mail-vs2-f8.google.com [74.125.227.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06A606A31D
	for <keyrings@vger.kernel.org>; Sat, 31 Oct 2026 04:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA06A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE
Received: by mail-vs2-f8.google.com with SMTP id ada2fe7eead31-7cc2c327e1fso283688137.0
        for <keyrings@vger.kernel.org>; Fri, 30 Oct 2026 21:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793422161; cv=none;
        d=google.com; s=arc-20260327;
        b=iHagKK4vZDewQbRBtgUdBzT3p1zZ2yDPh46E914V6wnLhRYIl9IdAXop7WS93z4d8P
         XnhYnKHGF5dH8RvdZZY22/etJLKti6OVdz5w31lY4KBfXt9GjlMVUTi+iSmcIFi3hpmM
         PZDlcJvDidTWP+qrkYGS9SVnqFfFn/IXW06/sRqPOZZ5aiSkCtMxTz3DKdGvgb0izJzr
         PSxnLil9JtoCq0czAPzXM7kGe/Bq53K+CTaKMWPQ+jvj8xGQxy7ezgsI6bId9H5ebCE2
         2prx+y1ACWtRQ46gKoezUSTq0HNDsI8FzbrF7HiAcqzJ4sFSacuRApvi0YVqy291RaNk
         yWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        fh=llvh2BHFjN589b0XE9JLHniZx3WqLbLNBn5K+chAC9U=;
        b=b62JbWclGqY2J4agKt5JAsN7j+BHLwj0fUk00YR44Cnh+3JAnrBVJ+BCq7a50C3x8O
         69fA5z0P7CCvhaX1AQSSMer4QL7g72arLP6ClHWqcZDbrv6pn4Yp7Lamn/JpzSpMeyxO
         HdSv3RPfWtR7wk2MG7HHOXYkZp5HlxlA1lc0dZRHzPKJgxHrXFnJcnDQCb/748Lpubvg
         rJ2MCLpjXa3IVyfbGzYgvLeYaEzUeYg7Y4TEsbhUrHog1oRP/3o72Y0RRIL+vudbdz8h
         TBhScjLnHCiydVoXJHgAznZB+CVhxV9PJsxJunBemPdBiFwIL08TN2yjey2p4rtkHd8x
         NqTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793422161; x=1794026961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=xfBSgSCEWJzIq7AjGQNCQPuTQvYK9qaFK9vqMVQWIAIMv39PJy/essix3RXjual/6v
         Y8dbuZiPFSm1jVVOKX5CNi8r1q2aBVTe0QdmS9cvpBkLQuZbERj1Ork6wSqcNQbh1wbC
         rzjz6sc7IGnuv3LGlNMD3FOBjyrnRL8ma9bHG+a3/mihH1wtmgYJap54Dol9LO5qFljY
         ENzU8SACdZFhayVjas109bcVz2o/g47bUZ2M14spABocCEBJ00nuckG7kn4YxoCGAXYw
         x+HC1hxg10v1kAz6hB37Yf1/HHCcpDCfoNxTKzY30aMk1V5ze2Sg9djLqmaByVCbtzt3
         hHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793422161; x=1794026961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=tPCzSF5WiNxzHiagQcJ9foM6NsEHDlQH6ej4qMX6NuZdeaheNeo5I5rxer8JsFhuKg
         tjT3HOIxFMvetcvCKdmWDU5/YKNWzWgJhXbKLWb66x5zsPhaMo8PrcBV2TRkBDLOBBzr
         BzrdIJ9/j8WyWPfwgmwngZUNZ6h8V+Gya97ppfK5IycTbRZqZ2fKEoLANjj3wBB+e9dm
         KkuO967YEnHG640fHIRXj98QfUIFcQN8ji6fgHTAV3+kZGn9303bFlvmtqBhPyZZy+IC
         2NXXChizJI3Sw7AZPNsqBa6YA245Kaw67AHrrAiL8SbawE1RbxwecM3AkFtn16N2EjLa
         +HoQ==
X-Gm-Message-State: AFq9FYLvomvZ5Acb3BVFuQ6IOIyt0ZWA9y+q3cHdPabeOcXK/+HKhoSA
	vBNZt0xFl9G1+uLAx1tFx+tTIx1jxZWdxi6nEt456iujdqZ1sm7RcFmEzcQwLaiIBVgB3pROSwp
	O1f3ZNE7bdV9Vs/9e8qkFJz9wyhGLJg==
X-Gm-Gg: AYBFou1iOn3+IvvjwfFfz2i1/W5XXzX0Yj8UGpUMPbMt97Mec1Z7F8NEjFdmqkJm0bT
	MXVjPguOanQqCrXKWh4xlYRIuCt93PhbiKpKoGwgLWZYvjM87AGRjKpWJ/cKSryg/AMtQ8yOSTL
	Nv0R+3DFqk2cjeIIrBM1sBEy18wuV2P6qab+0cRSZ4KVHUUH9fbDRMahm7zEWWHEZcbYZaQtpOw
	pDlKsbnMl51ligmW+HxAzxptPjlkKZmINB0R1Dz65WmvfZxzSWMmxxursQakkSQ/1eRkiZgewfU
	f//M7zcWwVUnMM8G8TvGirHtZj6VXXEptcF/3geYTMzn/Oa7gQcZYSb23gBi7a7uZTy0W4nkl2s
	lkDLRYstJLN13UZx1lGp6WOvdiUL7CLDxBDVDhNPc3kj4bb0zMLVrMr09gahvkrEdzPGw
X-Received: by 2002:a05:6102:5106:b0:7c1:e804:3c91 with SMTP id
 ada2fe7eead31-7d072c398bdmr1240318137.8.1793422160846; Fri, 30 Oct 2026
 21:49:20 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030173930.40948-1-permissiontogallop@gmail.com> <auTfZL8RjQqT8uiW@kernel.org>
In-Reply-To: <auTfZL8RjQqT8uiW@kernel.org>
From: Gallop Permission <permissiontogallop@gmail.com>
Date: Sat, 31 Oct 2026 10:10:36 +0530
X-Gm-Features: AclHuK-FdSUYVJnYySxi8P-Zi8EKZ3CeyjPrglCec33fiP5ieEc_Yb5Fdpv6Yas
Message-ID: <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jarkko

1. you asked: What does "key becoming positive" mean here broken down?
    Here key becoming positive=E2=80=9D means the transition from
KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
    after the type=E2=80=99s instantiate() succeeded and the payload is pre=
sent.

2. And on the second para
    For an unrestricted destination, construct_alloc_key() still
pre-links the under-construction key,
    so concurrent request_key() calls for the same type/description
find it and wait instead of
    starting another helper. That visibility is what deduplicates construct=
ion.

    For a restricted destination, the patch skips that provisional
link until the key has been
    constructed and checked. A concurrent request for the same key may
therefore fail to find
    the in-progress key and start a second helper. The keyring still
holds at most one link for
    a given type/description; each result is offered through
key_link(), and only a key accepted by
    the restriction is cached. This is a duplicate-work tradeoff, not
duplicate links in the keyring.

    KEY_ALLOC_BYPASS_RESTRICTION callers are excluded from the deferral,
    they keep the existing provisional-link behavior and bypass the
restriction check as before.

3. the rationale for the code change will be to stop an un priviledge
actor with write access to
a restricted keyring from bypassing the restriction checks.

As for the points raised by sashiko ai (concerning
potential outer-search bypasses in request_key_and_link)
im going to need some more time to verify them and fold any necessary
fixes for v2.

Best regards,
Anvik


On Fri, 30 Oct 2026 at 23:48, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> > construct_alloc_key() pre-links a newly allocated key into the destinat=
ion
> > keyring with __key_link(), bypassing __key_link_check_restriction(). If
> > the request-key helper instantiates the key with ringid 0 (or any keyri=
ng
> > other than the restricted destination), the key becomes positive while =
the
> > provisional link in a restricted keyring remains, so the restriction ne=
ver
> > sees the payload, potentially resulting in a policy violation, where a
> > user with write access can inject keys which are restricted on the rest=
ricted
> > keyring.
>
> What does "key becoming positive" mean here broken down?
>
> Also I have really hard time on reading the second paragrah as it is,
> let me count, over five lines long. I honestly cannot say that I
> understood what I read. I tried it three times.
>
> If you understand your fix, you should be able to nail it.
>
> >
> > Restricted destinations lose the provisional-link deduplication while t=
he
> > key is being constructed. Callers that pass
> > KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavio=
r.
>
> The second paragraph should be reformatted and there is no rationale
> or descriptio for the code change.
>
> Br, Jarkko
