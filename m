Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174506;
	b=nWpFaWrKMecfHXUuZ/wleBm8obpn5hWx6uCisugcKIwz6wyyIfHbK+rBuiLK8r3z08pr
	 SuISXEPi3H1DoVl/g489rtkGTvvwSQ6a+eFZhquxhj7+jIsKx75E+BYHYU//C4objm/rc
	 IdK3dyx5aiqrHK4Xe34B2PUOeed1f0JFVbaChqWBD5VttlPzg/+xi9H6Fzw18FRwFIn7u
	 lvNS5K2ilm69i83ZhAQwewicnoXUIwflXvhQvgmjltV2E5cy2oJbWTDscwjCBgYBzwLim
	 GrLMshIlQ8uA1Q14NdOTdCDPsistsD52EBSMk7rQ+ZstwgJBWxaGD4SVq//NfbFqv9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
	b=Fw8pXqknJJvDDDrd0EMXcYTflZzvdLXpwC3/wCmEuyhYFGq3+tScTPI9UNmxLs3h4k47
	 QeXyWUsPC/lKmDO52yHWg0lIg9mN+LbJCW7HbT2kzUIb//ZqqsbXYeYW0SOwsT98XK2MF
	 VejAMM2G0O+osFkyOfpF2WwK/imNAPwPwppx8AKmdqtHDaK2ILCFn15cmeUGthjRIsrmj
	 AJgaHiA3K1spQeM5T0IxyeQe8K0j0alEB4ZXaJeSpXUOBGWfECHHUIHdNzxVmdwDntODM
	 vacV0vtl2WxtveENcA9qXirkbO1hBIpUNHgrt8HBCA9s7G0SGK0py6HaX4q9BtAzxrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE0606A331
	for <keyrings@vger.kernel.org>; Fri, 20 Nov 2026 11:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BBE0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c42888c50c4so111896166b.0
        for <keyrings@vger.kernel.org>; Fri, 20 Nov 2026 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795174505; x=1795779305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=W6WXLOxR59uIfbaLpHw1RDG/aYC7BEPo6GMxxJsEX9hnvcfGjS1k3ZxVFqUv0AFkjU
         0HKbTZarlk3QbD7la/aeB8WWyj+L/d5uqI0/Kldt/z/TyOE1+EH/09J3/nHTMQyK0IBx
         jSis/yb2mQuZrhseR1h8momD+rFSWBeTNFj84rX/cxm2Dnpnmfrw8z/DCwxAxLfXy2Ur
         mKJvD3oJuijaym9T8sS6/FoceuszJAg3EDkJLxqhHXEGmp09BkqY60UVtQ1/yZMV4Kcy
         hZHrQmG+9lVrEffHnUR4gsfHbCOME9UhqkRa+c6QImLe+mLEXqYh+04zjVrAMvWLEN3A
         JZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174505; x=1795779305;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=cNzIbVkxoX/YhPlXetPTJyVx7UVuhfjP3nWnccY5i8tULV7lzZJ5o+btmAZrjwJzlk
         STSwzd8V823D+r3rqVUNyzpQ5EQOm/CTKMGq4VoK47PgeHs0jDb40oRvrzuQmfNtoed7
         wcDVL1yzLcGQ2pczGrtnTEQBhXDE49ztJ850rbOX9bYE5Edcoif2IKVc7OjO2apUM/Oi
         LGtIJpO5Q1rCVSLYbZBNk8BT3KNJDmBRNZOJk//XBTQIQikf7OiGUDYNrQeryKkbKGtK
         b1M2R55LU3uZG/NkxIc+M12jnjJx2OZ2+QZtJlqYZYl1rsCVccQkTW7iflNoki/Oe6DD
         eL8Q==
X-Forwarded-Encrypted: i=1; AL+hErHObhptVHY8G+XhYCaUDDMjyDGpJrYYYIgcUpm38+1YK+72m45pAXG7FNukBJQOJqCSE7qleWCcpQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9CDRJhRA+LRgXjQyAO+fANH7muVE/NSPVD42AA9C7PUH9RByWC
	YchMzeQw1GDH/n3nQJAN1xlNjiWPSqek8nIVmN0DCXgA4DW9HVlB4RtlNb36Uzu0vkkMRsWvlQ=
	=
X-Received: from ejcmy22.prod.google.com ([2002:a17:906:5a56:b0:c50:5767:f11e])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e28:b0:c41:7e99:c6c2
 with SMTP id a640c23a62f3a-c513ac99405mr295016666b.44.1795174504655; Fri, 20
 Nov 2026 03:35:04 -0800 (PST)
Date: Fri, 20 Nov 2026 11:35:04 +0000
In-Reply-To: <sashiko-outbox-223014@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <sashiko-outbox-223014@kernel.org>
Message-ID: <awAwaJugal622uZf@google.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: sashiko-reviews@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	containers@lists.linux.dev, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 19, 2026 at 11:11:50AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does bounding implicit owner capabilities by userns_has_cap(ns, cap) break
> cap_ptrace_access_check() and cap_ptrace_traceme() for a parent namespace
> owner when CAP_SYS_PTRACE is excluded from the child namespace's cap_bset?

This is working as intended. Implicit parent-owner capabilities in
cap_capable_helper() are uniformly bounded by the owned namespace's
cap_bset.

Concretely, this only prevents an unprivileged parent task from
getting implicit CAP_SYS_PTRACE via ownership of a child userns
where CAP_SYS_PTRACE was explicitly stripped. Holding explicit
CAP_SYS_PTRACE in an ancestor userns (or owning an ancestor userns
that still includes CAP_SYS_PTRACE) still allows tracing.

This is also unlikely to come up in practice, since typical denylist
configurations would only strip high-risk capabilities like
CAP_NET_ADMIN and CAP_NET_RAW.

If we wanted to make an exception for ptrace() to still allow
same-UID owner tracing when CAP_SYS_PTRACE is stripped,
cap_ptrace_access_check() and cap_ptrace_traceme() already allow
same-userns tracing without CAP_SYS_PTRACE when the target's
capabilities (and userns ceiling) are a subset of the tracer's.
Extending that check across owned namespaces (similar to
cred_cap_issubset()) would be straightforward, though I'd prefer
to keep the stricter, uniform behavior in v2 unless there are
objections.
