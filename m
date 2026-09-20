Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109D3CF022
	for <keyrings@vger.kernel.org>; Sun, 20 Sep 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889729; cv=none; b=BGQzu8qk1kc4jfYWdhPUKOEFDLzYn6ZFLiFO0N0UmoNvQMZTU+CL9KWseySEtkspuwcDw4bQldwL72omTxcBCfKPvdMQ06H+9Ok9+Ydgd5HLy8bPTp0Cb6A9FtZg/RYmW2KC93fZL5kKu3J8cFRk9uu+f3gJLO6mYbn9tQQG0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889729; c=relaxed/simple;
	bh=DPiosEXUTgQ4JjvfnOhAGoZPwcUGQWKSSE59G1rv3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep/I5UM8Ta4CRzaUkviqty1Kz6T7icy0W51DdW/i5Wv80tp6bYAo53uH5VhsHFDQJr5Zk8DfEAZbcRNaUOu+t+a/JfDgz7wOtwns+DWkDpt/TF2+AB3poXh8E1MS/IQwK+OxUYE+PaNa3oDYXt2IIxb90N40t+ZTsCHYeHWtFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9Vt9o+l; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Vt9o+l"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso1307427a12.1
        for <keyrings@vger.kernel.org>; Sun, 20 Sep 2026 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889727; x=1790494527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30XeFg5Fl5QM8uZfDju7oAPFMP/eO4GBITZ0vmaOsbA=;
        b=n9Vt9o+lDWZxKsRBRt9ZYYT6+a3wHgPW2kWMxS61WBoTUIx3NtaVdvws762hZmWVIF
         fLy3E+5fwBX7yaQtgc+RxHa60Cwec/aDfreuqZipZ9t8L6LgXMNiEtwoEFbL4NQyR9Iy
         HtM7/4jzoQJQA1d5EnpD6HXAkOxj5Bdfn1745QyQitFZAgrcqRqLtEmVF64KkuqZcYAX
         t5nvMJfGdcRdTwYghiIqu9VCKovuKVIe0MrV6yVAaSN1yMYd3xyDJng4ziT1nawCv64O
         LeVRygSHoRKdmVPoODMJVkFi0dAK3pL7rF6kIQTS+M2it2FyeEW94NgUj+Mm3BJ4xnVa
         9MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889727; x=1790494527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=30XeFg5Fl5QM8uZfDju7oAPFMP/eO4GBITZ0vmaOsbA=;
        b=MXACdNIygAoVHkJTEhOUlLtcL0BmpDPqnRJrybmC9CYYLRd1m9fDcu5tLoMYWaUvra
         45HuQlDW/ZoVCi+NRivGu5B95BKAgV/4735Z7A2fWBXHqWVRg4QRqS2xbEATCdifUOv1
         ihMykwStV94wTgle16XEgPGuRA5anGvVV+05dD7T/e5WZjVEKEMj7SRgrR1Cel8OwqhM
         neTDuM9HtlQp44EDUut7LgvAXjFqrq5OarJd/d1TtWBEYh9G7XDExYpxEk8/8f1xup4Z
         A6iz2WgRzeoWVvREcE/JmmoBUU7fxk8M/dVJzuFqUIE2jaXlJMy7fVjYWdtNzrZx7b2y
         3TcA==
X-Forwarded-Encrypted: i=1; AKwUvBx/UYpzwQ87wLwwJZE/gAooQwdfrCPg95FpA08rgvGvxBWg3wOxzX+rjrmWOe6MddosgyXakrMNWA==@vger.kernel.org
X-Gm-Message-State: AFuF++l5+yjwgt6339rAsrEhl5FDo3/rLg9XioWU87d50WGoAYh3lj8T
	u1gOBbX8QErP86dG4lOaFvRz8D9HnFfwuWDFmby8m3cOJo0k55uwN/VO
X-Gm-Gg: AYBFou1FflagZQjFrfL1CeraRXoSL8F9mBbyTOPQ1HsFNhr8JDbgXg5402osOkHNUVE
	FBqOJ3hpLQVoWzKzj6PmfEx3/HORT0y3fA8W9bACYDF8l0HNHNRBV+h9rhO3WvkCobFyFdb2zKo
	umG26+ckJdAapJS/a0BnychyiShgh3MoYN9YsFARGZp8wb2LRvbODh+qlS/6am1IOgstAk0RQ0h
	IGxCWODnGON0fhMIZsn89Dj5O9A+zprAF3RGMLwthzjp/+ctdtq4IB5v0RfqDMuNON+bTwtlpEx
	GNB5pzUiDwUaqUCyD3QQauY+ND5ymzfZxNIqVoDelO7C7XxDTQiT+fFZu6v5jMU+MdXh/7eftwd
	7N8XpFedl2cNhC5rnDaq+Yg6ML9ZfpmP0G2W8xJD5UxGTjahWQ/2Skqevvz+hhpq1TnnJKuTzLR
	dn9u/WsP7xPGUDWl5bZ/uq/LmXP//ARv4scTppY1l3wUZ5WiCLAvDn2vYGkoePE9kPlEFD84XWs
	d2HCa89UILGovjQmUm91ejza4WPn3h0KI/87hXjBzB8lM1Er86ZMVshBL6JTbB2QRSI5lfa5AH0
X-Received: by 2002:a17:90b:4c02:b0:39e:2036:8243 with SMTP id 98e67ed59e1d1-39e54eb71f7mr11635098a91.25.1789889727412;
        Sun, 20 Sep 2026 00:35:27 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm8015194a91.11.2026.09.20.00.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:35:25 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH 1/1] KEYS: Account for asymmetric key payload data in the quota
Date: Sun, 20 Sep 2026 15:35:15 +0800
Message-ID: <20260920073515.64399-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6abaef5a35f2eb9d551a16817df12f786346b7c6.1789801335.git.xuyuqiabc@gmail.com>
References: <6abaef5a35f2eb9d551a16817df12f786346b7c6.1789801335.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Thanks for the review.

Sashiko reported the following findings on the patchset page; they have
not been posted to lore.  I looked at both against the tree; the
mechanism they describe is real, but it is not reachable by an
unprivileged user with the default quota, and the root case is not a
privilege boundary.  Details inline below.

The tree is crypto-2.6.git master at 10396a2d6d41; line numbers below are
for that revision plus this patch.

> 1) Does this code overflow key->quotalen if pub->keylen is large? While
>    prep->quotalen is a size_t, the internal key->quotalen field is an
>    unsigned short with a 16-bit limit of 65,535 bytes. If a user adds an
>    oversized asymmetric key and the quota capacity check passes (for
>    example, for the root user, or if kernel.keys.maxbytes is raised),
>    key->quotalen will silently overflow and truncate the length. When the
>    key is later destroyed in key_put(), user->qnbytes is decremented by the
>    truncated amount, permanently leaking the remainder.

The types are as stated: key->quotalen is unsigned short
(include/linux/key.h:216), prep->quotalen is size_t
(include/linux/key-type.h:37), and key_payload_reserve() computes
"int delta = (int)datalen - key->datalen" and then does
"key->quotalen += delta" (security/keys/key.c:376 and :396), so a charge
above USHRT_MAX would indeed truncate.  So the truncation is mechanically
correct.

It is not reachable by an unprivileged user, though.  key_payload_reserve()
checks the quota and returns -EDQUOT (key.c:392) *before* it touches
key->quotalen:

	security/keys/key.c:389
	if (delta > 0 &&
	    (key->user->qnbytes + delta > maxbytes || ...))
		ret = -EDQUOT;
	else {
		key->user->qnbytes += delta;
		key->quotalen += delta;
	}

For a non-root user maxbytes is key_quota_maxbytes = 20000
(security/keys/key.c:29).  The reserved amount for a single key cannot
exceed that: key_alloc() already charged desclen + 1 + def_datalen and set
key->quotalen to it (key.c:248, :272, :292), and the key_payload_reserve()
delta is bounded by the remaining quota (maxbytes - qnbytes).  After a
successful reserve the key's share of qnbytes is desclen + 1 +
prep->quotalen and it equals key->quotalen, so it is <= 20000 < USHRT_MAX.
The overflow value can never be committed; add_key() just fails with
-EDQUOT first.  In our testing, userspace sees errno 122 (EDQUOT) from
add_key() of a roughly 65000-byte PKCS#8 key, with no charge ever recorded
above 20000.

The root / raised-maxbytes case is also not a security boundary:

  - /proc/sys/kernel/keys/maxbytes is mode 0644 (security/keys/sysctl.c:26),
    i.e. only root can raise it, so "if maxbytes is raised" is itself a
    privileged action; root is not the boundary we are protecting.
  - Root does not need to raise that sysctl to pass the quota check.
    key_payload_reserve() selects maxbytes with
    uid_eq(key->user->uid, GLOBAL_ROOT_UID) (key.c:383), so the global
    root already uses key_quota_root_maxbytes = 25000000 (key.c:27).
    A user-namespace root is not GLOBAL_ROOT_UID and still uses
    key_quota_maxbytes = 20000.
  - asn1_ber_decoder() rejects a DER blob with datalen > 65535
    (lib/asn1_decoder.c:197, -EMSGSIZE), so a single key cannot grow
    without bound.  sizeof(*pub) + keylen can still exceed USHRT_MAX
    for a large but legal blob, so root (or a raised maxbytes) can hit
    the truncation.
  - The direction of the error is an over-charge, not a bypass.  qnbytes is
    credited with the full delta but debited with the truncated quotalen at
    key_put() (key.c:659), so the remainder simply stays charged against the
    same user, who hits EDQUOT sooner.  It cannot let anyone retain more than
    the accounted quota, and it does not weaken the check that protects
    unprivileged users.

> 2) Can this dynamically calculated payload size also overflow the 16-bit
>    limit of key->quotalen?

Same reasoning for the X.509 side.  The new expression is a sum over the
objects the payload actually retains (public key, parameters, signature,
authority key IDs and key IDs), and each is bounded by the same 65535-byte
DER limit.  For a non-root key the whole sum must satisfy the 20000-byte
quota check before key->quotalen is updated, so it cannot exceed USHRT_MAX
either.  As above, only root (or a root raising the sysctl) can get a single
key's charge past 65535, and the result is a self-inflicted quota
over-charge rather than any kind of bypass.

So we don't see a security issue here and would keep v1 as is.

That said, if you would prefer the byte accounting to stay self-consistent
even for root or a raised maxbytes, it could be handled by a small separate
hardening, e.g. having key_payload_reserve() reject a reservation larger
than USHRT_MAX (or widening key->quotalen to unsigned int).  I left that out
of this patch on purpose: it changes core quota semantics beyond the
reported bug and is not needed to close the unprivileged quota-accounting
bypass this series fixes.  Happy to send it as a follow-up if the
maintainers want it.

Thanks,
Yuqi Xu
