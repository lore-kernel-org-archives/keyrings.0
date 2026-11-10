Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322309;
	b=2qxGXJ442JMCCzC4q6QBAR5SMqYyrU/mxaYI0bMcL1dIZ1SzM7/UN1mlHYOEWIapFGda
	 uYKNgp7MB1IKpC4Cs761+Uu7LqdPpySS3Lu8/7DFoD/pffaGktUYwsMHBBTmkc7Mqg/iH
	 +AFJzxf5gaTT/1sBYR5PDexPPR2D1uI4eZb/x4LGpPHGQGsfx5LzI1Bt7C0YrrFxQvPPA
	 Yyk8o6ccGtxeMIVAojcYpXZRJOTERN9+kXZX7MhjhUUnPgfm8jnMWcAvpOSd0aiD1K67F
	 eu66PspZsfHIPA2AKwOkosFLSeQDQ/+FhN5+MbScohQH4hg5Nb+KVFCt/Y6XcKv5X1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
	b=YozuyDByhONFKauWzWBYHEGiZLBJvu8jLyi5uChVOj0MBHFkzkNgAoNjXhdqkQEzgUYn
	 tCgITzLfJrNDunDX79Qb3FdZzC0uVk1yMIuvp4yrZlQWLsAjS4xqYxegxqf14i3RKQssK
	 caAvnNafIkPXa72GVv4dDMT3cbk1AGsncK5ZDEjkcUUhOG3FSI9mR3nomAsuZjviQVZu4
	 0K//HEYWs9AAtwhO/N62bGy347FmmeNUGHy8zpCuL6QSsrJi1YbHiFswejD1UwPGdk6eQ
	 0l87jClOI8YrSV3K6zmRwXlyqp4Tbe8HG+iQMehyedfGqXdR+t0vzkY6Ow0GYi3AxQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B934606A325
	for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B934606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so893052a12.2
        for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 06:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794322303; cv=none;
        d=google.com; s=arc-20260327;
        b=WHdSoWk8K0FjVLkGhj7yKgp0hjCXKP+uyUCNCdv5z8Y3RfzEy3S6tO8Oq+P1ZW3fXK
         pjgzFXBAi7BxgQ46a+aGCDPV1KHhkb6H0W4++fkD1ORfM0ilZs2UtatM7ErLtEtRRsYT
         V1Cy3J0Mzuh081xpapKrXVpmOB88hyEEibiwbepyKcm17SFdRWMpBW6WBlVGR/is/KO7
         O5GsOJef5HXWt9tSgebWPtg055bVnP6LzEDSBSZppZOw1ss7NXIZRfT/T+Wr6jevgBsu
         Lryvy4Xy8gJoYfK/lCkdikEsjASdPOi/6uu4vxdloacjzcLC77T8hLmq+Nj8/H4LEu9d
         /GGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        fh=Vo8u2kJCUgh1uBz3OLbmEHvwWqBpiXLnRI4E9CrpOLI=;
        b=CHiVeQI27UuGDbuLLTaYWYE8Rmsf64+GXjf1hBLFfJcrFzTno9E8edCVKJbsYckJ4Y
         0zAiLZaK00ZocwyNACzspP4XK47u76gFcOV7aOhMj0YVXjCXCT18MlRpNybrIPz23XTF
         4rVwbMEtuFL4urg/iR69Fmt65DGfWFh6aSU4x34mFMvT9R3dGFbAn/vGh3DUhYZsxT0L
         nIsE5CBB5hgLNR4+ixSxl3HUZDUmVYfFve10/iXBpYGARcjNj+6ijCw6MC9ap1I6HqL7
         Qz5JZRVzYLHoyb/csJqEQ4z0AfWps6IX+gm6kcqwk1JOc/lWJWbfACKqDYlmdVBo1oEF
         kKYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794322303; x=1794927103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=IL+8xDhWvbsY97lbmrxhet0Jxm/GEejFE1wA+kHdDdoy3r2HY0qfy9+Zo5tDyA1HCU
         92dTAWSC18xJKt+nqY3o9ZEOwugPfnvfyKVxgXTJccL+yGQZq3uA5w6FcKOdBgNjQCVS
         07UkwU1Ush9oWU9aQSyczjXfKDIKK13bz1vvPKKKZnAAbDJNUxO90oBj9mzTVwalm6uJ
         MzZxNoOFc+uElONJCp/htKG7NEjYziL9FbA761f4NJZqOMyMijk6azV7Si9VVAUAXV+J
         Tep1WbavDGNkRYBusn+me12VrKAKvlJoaba+qozCGl1bDCWa2Ghni1rfY8UzwuCjm2U4
         /4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322303; x=1794927103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=bivuIlkUMMafNiC2UiT9SPeFQCWmg4V3BTNRq1bpGEYd6Jaz0Umoq/U7Z/Rxi3MSQF
         OHAOZvQGNjpAoFBW334NaXcBIOWdfvTk7Z//G66k7LzfFZOzlF1fH/lOZk/Mlz3ug57W
         Ge4mC9jwL0+8QsLGlQPVU+I7nBNQgP3D3Gz15QiBL97yYMuKFQu6oC20dYtBS5RsvZK6
         Yqn3tV4WJV1PDzvRE+6XSQzXJN8eBFAryFBkmsPNe9DQduUD/3jcUwgZADPyAUZ/wqaV
         d3kA1g68qdpejma8CvzW8X/FVIPmLDt+/Po/vHXMCIEUC0AyroN8El8SSFQkDWfwPky8
         cNYA==
X-Forwarded-Encrypted: i=1; AL+hErFivPijFijYZ/rS0hkdTKJtL5ZEzM3xUlA/vSAhZu6pLbLce0Nnha7cEsAvKdKT3n3k+gqwGMZHCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/mZzVX+7YJqMkzPxZOKZGk2NMIzysCgH6PDgfJzstMuhCtRih6
	OLc6E2IW35RiGIjcfTFTK7ph8a/YIRKTID5n9wwlAdE057MkhLHNTTdm/TWPKl4WZwj0Z+Fksdv
	gMfk7yUXlowImXBv4R8cHZ6kXidgOJ4ULEt66M4uO
X-Gm-Gg: AYBFou22m9xU77S2LM76RQtF8G5p3jAPkF//VbXoobiu3K/Hg/jLyW02hQMVCazP7GI
	A49krwX9XhwN12YJtupV/77wAMSPubjpYa7COo2QePFbi0RPBKhTGipD45S7qwvGhHyDNKojqFx
	3hD8B5B9J1m21IYShqW5+m0IN3aHvLbdAfF9rY1teqh1FjqdFZvMc6pty+/red8/ubi6ICViD3V
	9pEog6Y4SdWPJq60fttIslECk5wW+SGo5VWaZTmq0A0zb4cOzPg5lXDIp3o5fmFnnfe5+yhIef9
	oouF2apg9nw/Hvp7ORJPDXSyREnDEv7qAVW0O5hGozD+RrOTsqLee9Rzve21P8U1ZLFhzAU35Dx
	kRLnWMw9eaagsLD/MY3LHgfngElF6atGDHPilQUAEx+kEgZxDSsNnmAVaNb9Cqu5fDUps
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3b166cd4924mr2650628a91.19.1794322302909; Tue, 10 Nov 2026
 06:51:42 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144205.2404088-1-mic@digikod.net>
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Nov 2026 09:51:31 -0500
X-Gm-Features: AclHuK9azAwCWCYb7rf35P_Qkz1YTwRFSpYVlH2tFTGhGa4I1jRp_1554UKlQOk
Message-ID: <CAHC9VhQ7xMe8J+wRYK98Lw-Ff8dg=wJNEWgJp-MOqFixeZkiZQ@mail.gmail.com>
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
>
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
>
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
>
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> This is independent from Josef Bacik's series, which reworks this code
> to close other ways around the CAP_SETFCAP rule:
> https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@tox=
icpanda.com
>
> That series still computes the creator's CAP_SETFCAP with cap_capable()
> and cap_raised() in cap_setfcap_level(), so it would need the same
> change.
> ---
>  include/linux/user_namespace.h | 5 +++--
>  kernel/user_namespace.c        | 8 +++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Looks reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
