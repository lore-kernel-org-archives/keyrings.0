Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA44D9F74
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474059; cv=none; b=Y4sM5rgNb4ehx5KRlGlNBuBkcnPfMn1YpApnL3eodwGwH1XfmtlH9+OStT7n8XzDnhNHscURPSIN4Gby6n5qq0xnbB6igbDgKT2D8Y3NVtTuaO/UFDuck+VfGcJcTMATjv2ihzvOHjaenOt4Ha+362Wbs9Wb6BsniVhp13nLxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474059; c=relaxed/simple;
	bh=XcA+nLpj94/DJ/Rraklqza+8j4Qcoc86Vhgyq9rdRJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5JeflnDdAgc91zzUNOUMfr51t4NzM2TBXTCPrSdgdJR6fdz94m23yCfSpix+UHlBE9c2SB6gaMbDQ4wwMemm5/ihS9Xuyyv3of05Fa7gXuSwnsrNUng/c1R+6uiEzsfFrqvdG+cWZzFc6iPXMdHi86PW12iNxjACZiLCPZuVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZO275+t/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZO275+t/"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a980c01033so41099801fa.3
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791474055; x=1792078855; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qg3REX0qNPfLJEc1GEYkRVmVRk5EMast5JpkHxdhxbk=;
        b=ZO275+t/DUVWDWIWddvW08EnNAla5QG5HRaw/WrR2CPI/WlxsRzs1uvQxEr+eHKiX8
         FDYOAZcDR2GAklNBoF4mE5TJ/z/A63yoD66P6HYQd1N5jDO0Q98SYqsRS6L9dyftyNRi
         GwvyJgB9bxhujZ2cROIMYrHx35wWL8YL0A9shoeTr1WZ0ZftMIiqOBB23rjEGiJp4gqs
         LrFwVG6gMI/t1S0IfJdrrEw+e2bX51tk2pmPFtjof+UNsFidTWbZQSzxDtfcFX3hvKTX
         Y/NkkqgTW/s53r/Jd8tcZrP66P0zjYmU+xwR+TrGS52ogOddYFqEyO5FlEXVg/qIzYpi
         ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474055; x=1792078855;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qg3REX0qNPfLJEc1GEYkRVmVRk5EMast5JpkHxdhxbk=;
        b=MFV5aqOpxnTa6Do0VSJkkSKgm/forwHs6oNRwQ7FPFPpoJv028Ywf7bffmQK3FMCL8
         3JGowZHBJALitFeSSVwM8X60ozch4YUo6kYRBi4Y40SbLQxXgJJrL6tsD57fmnRS2VxD
         OEccseAuQ70FXoL/Ijtd9kyASJ3uQ+z4kIFSiKE/E6KlwVaOsJFkK3KCbQpYpI0KvHwi
         QnL2lxtMd/Y8i/2h6ocalhLpss4AHwtaElNnlSlP2LDLub7N3rLzjSyId79KutC38Y3X
         9Zd+bxj8CbgNOneEzIoPMeE3JL1QvFqI+a7I7WsT4vG3SwgZex6dpvzJy1H0sxHbJMOf
         EEOw==
X-Forwarded-Encrypted: i=1; AKwUvBwjPW72jgQgT9OFqyNxvZb5Q8RlJ5HvC0s6N5mgY2PJ0gg5Q4f5KgrhT/3adt6EyUN4rHmjc20h8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQFxJINyeVQnES2fZBf7qm4BahOsCcO1LhMJlwDZwX0ENOKvbn
	9vC5FKj/kT2ms9XdKBChdFT5prc2usmM1GEXwLD7QYR57CEicRE1cFGHHpB4NkSblLg=
X-Gm-Gg: AYBFou1MH2yl8tvr8e//ZvHffQUOb4f+PuMdYse7lUlvaT147wcyIqIkjkmyacME0I/
	hc6D/+hoN0+lB1lkoLZ7vGl809TzeIhRx32+rnrhdYGXv7PMoj4VsHMI1JwKXRo25cjhEJ5lGpj
	sr62em1R4McgXb6SoWccw0A1M6mnsVjInJ+nn1noNf/QXqgjIbftVk8XjGKE9JzQUs3qhIjEsPc
	mWydpqe4CJ4b8qFSowdrlm/x8bPq9GHVuzGdZTC/8PG3m7xfrNmuvKmF3R92nI3I6/cjz8qcXTZ
	Q8ymjVxvTdyeV4hOWoz7B4WsVe7/nQ6rt6vsk/GcocVHDEN4xHrRt4xsWVcJMZA4zq4wu311hCo
	ZwOXo5hiey799AkcukQsEgKz4MDKPG7yn8HbfDSXf6FV7hFN/5LzSpFePVg/ilpJL+W8LU/Ffkh
	Ob7aLcfgboo7UHvxb0s4M7VaR6FWh0C891HKMnwx/hdq09ZLEpFtGTUeZbf2pTGQmRDO8P3uLmE
	R3lsMkPF6KlZw8=
X-Received: by 2002:a05:6512:a83:b0:5b8:fa05:e49c with SMTP id 2adb3069b0e04-5bcd0702f0amr2360032e87.34.1791474054654;
        Thu, 08 Oct 2026 08:40:54 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd309dab7sm1398142e87.75.2026.10.08.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:40:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Thu, 08 Oct 2026 15:39:30 +0000
Message-ID: <179147397027.4.15064782992163283819@toxicpanda.com>
In-Reply-To: <asehZEWAwsJcbqvM@hallyn.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 08:57:56AM -0500, Serge E. Hallyn wrote:
> Would you mind describing what other solutions you considered?  I've been
> looking over this set since Tuesday, and finding it hard to reason about.
> (Part of that is certainly the nature of the problem, and it's possible
> that this is the best/simplest solution.)

Everything we looked at kept the state in the cred.  We model checked
the variants before writing the code, and these fell over:

- a bool per cred for "had CAP_SETFCAP over the parent when it entered".
  It breaks on two hops: setns() into a namespace that maps 0, unshare
  again, and the bool says yes for the second namespace.  Hence the
  level.
- checking only at uid_map write time.  That misses setxattr of
  security.capability in a namespace that already maps 0, hence patch 4.

We didn't look at keeping the state on the namespace.

> If we replaced the userns->parent_could_setfcap bool with a ref to the
> creator's cred, then at both setns and write we could check the actor's
> credentials, right?  There are probably issues with that specific idea,
> but that's why it would be good to see what else you've considered.

Checking at write time alone doesn't work: once a task is inside the
namespace its cred says nothing about what it could do outside, so a
joiner and the creator look the same.

It does work if setns() refuses to join a namespace that maps, or can
still map, the parent's uid 0 unless the joiner has CAP_SETFCAP over the
parent.  Then everybody in a namespace has the same reach, and it can be
a level stored on the namespace at create time instead of a cred ref,
which would pin keyrings and the rest for the life of the namespace.
The checks would be setns(), the map write (opener and writer are in the
parent, so a plain capable check), setxattr of security.capability, and
ptrace.

The difference in behaviour is that the -EPERM moves to setns(): a root
task without CAP_SETFCAP couldn't enter a root-owned container that maps
host uid 0 at all, where with this series it can enter and is refused
only for the map, fscaps and ptrace.  I can prototype it if you prefer
that.

> Of course UID 0 will always continue to carry privileges even with an
> empty cap_eff.  Here we're stopping it from writing filecaps to uid 0
> owned files, but if it can open a 0 owned file on the host, like
> /bin/sh or a systemd init file, or ptrace a process (in a child ns that
> maps parent uid 0) doing so, it can still cause damage.  My point being,
> we do need to keep in mind the tradeoff of keeping the code simple
> versus the realistic threat of the problem being addressed.

On the same kernels, the restricted root task can copy a binary and
chmod 4755 it (it owns it, no capability needed), and a uid 1000 user
runs it with a full CapEff.  With SECBIT_NOROOT that setuid copy gives
uid 1000 nothing, while the fscap file still gives it what's in the
xattr on an unpatched kernel.  So SECBIT_NOROOT is the case the series
adds anything for, the same case db2e718a4798 covers.

A smaller version is patches 1, 4 and 5, with cap_root_level() moved
from 2 into 4.  I built that and ran the same flows: every route that
ends in a file capability still gets -EPERM and uid 1000 gets nothing.
The uid 0 map writes refused by 2 and 3 go through again, but the fscap
write after them is refused.

Let me know which way you'd like to go and I'll rework it.

Thanks,
Josef
