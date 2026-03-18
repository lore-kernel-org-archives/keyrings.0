Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F353093AE
	for <keyrings@vger.kernel.org>; Wed, 18 Mar 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855384; cv=pass; b=lIS1cZ5bIncmjOhGCb+t+r06dtFn+j8Tb+O/7wo/njEqA3CJDF8+tMX+8PoZz5JXGXRzDKbXDWNErG+tAS9VCu4PZTLk1p5g31YBs4W7whtfhdO684F35U2SgeCYE+nfXDgm/3bJq4DeKcl5qy4OKoymnynLvf5hDconimW3aY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855384; c=relaxed/simple;
	bh=ETQ6eDY+SrtspdH+SID48Rk/pkOlNOXeML+vzVx/MB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWQiGASOaS691YPtjD0c1LgZ4Eyuhqr6Dk408eqonjfGH38j3xn2qGRvKe4VftX38aKRmenK7L8ibitVqvlnxYtk8z7nv2lNMIRny5J55svYq84P3VFE+kBHvL5wcwe6nCTJY/9pI2F0FZIoHvBbx+kFjoGktlPVXlPTJIzHZSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEKx2bEE; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEKx2bEE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so393625c88.0
        for <keyrings@vger.kernel.org>; Wed, 18 Mar 2026 10:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773855382; cv=none;
        d=google.com; s=arc-20240605;
        b=cIODE54sPnApPFxPYyLz+5stKrHWV83yepTzLexwyOGxU8BSIQvxgyOE9WUXd5QwK4
         vSsdd/R+JPhevxGnQsUsc5rq+mqk6gbaHsWIyS8a+GPyqVkjQtgeK8Rk96/By9Ai79Ea
         f6XibXalM0j+4bTtrgh0TRk/6v+esewgIhjkLMjlI8viWzW2ttzGmqIGh9sUTiKTy2ny
         G/aUHSCueqxrnz2+hFR70CpCRb5+QDyiB6qWMg5swADdZo4vTKBJmtcIz9ekbhyAorAy
         AbMUjC5fK7arVmLB9v7dqgXrRT/ikNhAUGHo7ZbxzOblSFUCuo7IAPc+k+jzcsliI1DQ
         unow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        fh=mTE8KM5D3wPjvAZc+dliYyFAASV4vyj34Vnwzbgc57U=;
        b=lNbMqMOvGx3ywxYOlBu+y6bZofqmgV0+0Xf2C8fPrDiyr54U2Z8w8P/4rOlKy7l++C
         zv1cgMcCaWcL9zm0SEDKQzqJXInwhf3spvJIqMnycwhOI/NX+LG7vYFX3W5zymDAaI6K
         +4+8Smic3tl8zQ31MZFu42lP0/zmKMTkzdWLUUa+e6cRWxFXu4QCFNDPUiigxAhphv3E
         qCf4XhdHwfxOwvPX/RJp6/gfRIhx6uzGl1/+LcssYt9teUCQgEUtvieN5VOwbtfIOM9b
         3z7VVJSgvYiCGe6aEicHLLxjdqIwstYtj9xeB9kxDkB/7Rw/n5lqp+Ru1dd1doHYpMF6
         l/kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773855382; x=1774460182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=AEKx2bEERz2f7/KhHE67goH75bm9Og/0PVyvWwlEceqQjFBei7zXZoBUWdUkoXEANx
         DR69Zal/tu31gALsnZSo/ZhVQNYDObJZYIrEtOhrRRBs3tJ4nlQ6oOMJFsIOnyZ6RQdc
         1KsGem0V/nyu45S9KijOPLujW5iOxOSXg+hCsrk9TT+q8drCb7OHSRhJzFeOd9Bb1GAO
         RVbkFi9+3HoA+dFpQNDpJa3Zp1lEK4X2ZtgcERoc6QZiVrtrVTym8PO1PBgO3hBWvOtG
         D1J7cXk0DH6mQrMS/PWC5/Pb77RM27ULnDEd+TWcEZmTFZtzK+IPM0yIL2cqN6JiG2Ch
         yZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855382; x=1774460182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=Jl+2DUXWQeAL8CbHUFAO9zRt+g6Vby2bqQhnl6pc0Rvql2F5IBXIpLPbdp6gvJBuNR
         EiTFg/S8/fAn7SYCZo29FhsQtDGiez6YFEj5/sfqN4W/rzGzjqdfYmzlRGzuItWNj0UP
         M40ryBF4WdY1wNb/Suzrk0e8DSWkTcT35h8lOEes3mop69kUCrGuuT0B7VNqbOGIvi/I
         ysBDy5puJYru5yjTUlN7+msfXur+hcLSyK5jCjVWy1tUxMHPoDsGdJLbilSUBNh6qUpq
         yKbLHqMFsOM9ciFmWAjU9RA2CW/FwlgNt1dvkzpSmK+bjvzxwxcJxR7C+UMHjOJwOQoa
         eA4A==
X-Forwarded-Encrypted: i=1; AJvYcCXqTM2wP7CGzYlP8Fhc2Kt/SK642Z5iG3Q3RH8iZy/j9AOYPqrpgvXL8G1pFL4ACWe8vCArgt1JBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxy41gFoDCEujW2T1gIcKsLvXpqXu24IIawTn9ggViTWEicEvN
	qOvtSMhNNGyYaCV+H0pytc0Hom2aKTUosSLntJhoN4HkRYzF5aJxpG/34u357tk0HSZWmReVuA9
	4w0nM0Iv3pWyNlVjR2f6YfbrUrvXPNMAztibd8KD7
X-Gm-Gg: ATEYQzyjME8mEbo8/KDciGeXqwVU0nw2F1j74kBFBuq9+0p+M42Ut6RfRiaUnMIJbFX
	aaI0fw4FAFx7bQcpVhrQ2kPLkKGcIbUU/Psy0YOpZR0o5yPyHiLtqGvupJHGf9l+SOyC+Obe8Pb
	4mVWiNjSGjCre4oV398x1AdSwEJUBQsyL9LeDRlO7qL8ki/j8qVdvkS0Y0FCjgjn0lZd7PDuayB
	uzcA1n9LaQhVOn9UGqLflV0jhQKagCHcZhe3GJ5K1WprHEamukAZprY/vpMRyY4oEEKZ/bzBFRJ
	eFCVhQ==
X-Received: by 2002:a05:7022:102:b0:128:e2a9:d97b with SMTP id
 a92af1059eb24-129a71c3221mr2167012c88.42.1773855381476; Wed, 18 Mar 2026
 10:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192526.782202-1-jarkko@kernel.org> <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org> <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
In-Reply-To: <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
From: Chris Fenner <cfenn@google.com>
Date: Wed, 18 Mar 2026 10:36:09 -0700
X-Gm-Features: AaiRm53CRvkQ4Q080Fnyv4js1FR3nt9n7ROPC-ZktGzrj5RdGkL16HIOocsid-Q
Message-ID: <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Jonathan McDowell <noodles@earth.li>, Eric Biggers <ebiggers@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies if my long message derailed this discussion. I meant to
support Mimi's concern here and project a future vision where
TCG_TPM2_HMAC doesn't conflict with other features.

More concisely, I think that:

> tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled

is not a compelling argument for removing TPM as an RNG source,
because TCG_TPM2_HMAC is known to have poor performance already
anyway.

Thanks
Chris


On Thu, Mar 5, 2026 at 7:37=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Tue, 2026-03-03 at 23:32 +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> > > My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> > > TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> > > threat model it claims to (active interposer adversaries), while
> > > dramatically increasing the cost of many kernel TPM activities beyond
> > > the amount that would have been required to just solve for
> > > passive/bus-sniffer interposer adversaries. The added symmetric crypt=
o
> > > required to secure a TPM transaction is almost not noticeable; the bi=
g
> > > performance problem is the re-bootstrapping of the session with ECDH
> > > for every command.
> > >
> > > My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> > > punts on checking that the key that was used to secure the session wa=
s
> > > actually resident in a real TPM and not just an interposer adversary.
> > > I wrote up my understanding at
> > > https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> > > long-form opinionated take :).
> > >
> > > Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> > > August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> > > compelling reason to make a security decision. (There could be other
> > > reasons to make choices about whether to use the TPM as a source of
> > > randomness in the kernel! This just isn't one IMHO.)
> > >
> > > The version of TCG_TPM2_HMAC that I'd like to see someday would be on=
e
> > > that fully admits that its threat model is only passive interposers,
> > > and sets up one session upon startup and ContextSaves/ContextLoads it
> > > back into the TPM as needed in order to secure parameter encryption
> > > for e.g., GetRandom() and Unseal() calls.
> >
> > Neither agreeing nor disagreeing but this patch set clearly does not
> > move forward and I spent already enough energy for this. For better
> > ideas the patches are available in queue branch.
>
> Jarkko, you totally ignored my comments below.  I object to your removing=
 the
> TPM trusted-keys RNG support.
>
> Mimi
>
> >
> > High-level takes don't move anything forward (or backward), sorry.
> >
> > >
> > > [1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ=
+XGmkQj=3DrMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
> > > [2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-=
jarkko@kernel.org/
> > >
> > > Thanks
> > > Chris
> > >
> > > On Fri, Feb 20, 2026 at 10:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > >
> > > > [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> > > >
> > > > On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and =
thus its
> > > > >    use should be pooled rather than directly used. This both redu=
ces
> > > > >    latency and improves its predictability.
> > > >
> > > > If the concern is the latency of encrypting the bus session, please=
 remember
> > > > that:
> > > >
> > > > - Not all environments expose the TPM bus to sniffing.
> > > > - The current TPM trusted keys design is based on TPM RNG, but alre=
ady allows it
> > > > to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" b=
oot command
> > > > line option.
> > > > - The proposed patch removes that possibility for no reason.
> > > >
> > > > Mimi & Elaine
> > > >
> > > >
> >
> > BR, Jarkko
