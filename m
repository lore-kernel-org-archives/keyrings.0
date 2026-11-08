Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142826;
	b=wGR3z3L0fLRVcbdntTf4KnPyRFvzi9mK81dV43z6WEryJTLymyXUTEGlbQo4jT3shhbO
	 PruFwDHtzQh3fBkbTzIIjhv4pOshQ2AHwekTpC/fBKhdUJaefB2S4bfVruWSvQwyukfuC
	 InQ/sZ0NrlKCmdBadd6vcptaDy+seMSsqKoiwFQF70Rn2PLoqJYews8ItLQIsMIwLxUMJ
	 iWZTx6EOBGrRdIVbmVBCQw2JJPk+nOlWj4W+JXf//42SZ5B6ssAoN6zpeSk8fQ50/cBTK
	 jv+iQxg2vlcgML6MdQ1IeyY2yoIb/Kmw1rH8Hv1+szw/mg2FiJakYr2XYdevD0bQdRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
	b=W8Hg4bxPmSy7taib78eszVOY502kn8+Feb43LN46kivZzIOJdPgWr8St4x43xGqwq5Ud
	 H/BtTuAJD74qOVz+/2WT71CcfeesuGxjQOhUv9cmAl7nzBXlouXZLItG2MxwXG+upbCvL
	 sO+CGenKAxAzauM2vosbqIGg8TRdF6C+nHyqsb5zYLXeqqPyqh4rwfQVub1fHYLQmmatf
	 dVaHmzn09Fyqp/dZ7Boccci+B71DtoTk8Q3kOm0Q+JF5kQOP6jUl3P0VEiNFUfcLnY51Z
	 jrvJsKK1nOGnChIsBOnpYk9CroRV+oz6xrX1rK7BInjXE1+P7DVBvZn1YhE4xxzu0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88114606A321
	for <keyrings@vger.kernel.org>; Sun,  8 Nov 2026 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88114606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b1015a4259so45234a91.0
        for <keyrings@vger.kernel.org>; Sun, 08 Nov 2026 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142826; x=1794747626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=NEt8TNJs6JP9BoXDg7rnJ+F20QyQc5NRQYgxlZU3sRUoaXEv/IVzqnWWf11uu2V+Ai
         lUtYTjuUCXGyyKbyNm/GqXcTa2jBPtl8Vwf3wxfZLFWQKYlo/8Xq2vAS3TN/UiM9khAo
         wnTZMpNN3nQcGWQ24x5ug24PXi8TuVLglrn6ZDn30jefoAQcOvkG9W3U7ZH1/JDfZZF2
         iFrkHMtTrYB8iluJ//NMdY3WnbHEevvP3uTLOByq34K+/TOrpSDQx3HJCFOgo7ZmJXeq
         I4EKrPmGBK3irLqcv4m9LsU/jvmqtbiHS3AIb/LbrMuZl4fwxhcHsoMSuZfF3VVvquzo
         umdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142826; x=1794747626;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=DCP71saBoMfVNKBzZPO33+IaYBoYDGW1zcCge7VatAchvV/yl24L62u+ZrmB+g6Abr
         Wfs0wVGNu0Z7vODTOhlkhp6Tfvx+NyKWyx7lWnacX9H1Nl+ldGuJlESNtlFa/fOm1NIF
         54HVJrp2fvYz5MAWMa3I5x8NIT8jOXkU7X4i1zVTH3tCNjMqgchxwyY4c1cGJY3voX9v
         9Eq3o8ndz6Fwjtjq+QTrkykDHm5ELVzR96LJ12lMtxch8U7Tgfmy5imBSw8jrffBnRKr
         WpGHpNUrpztMqmIDYmaSLSkKBN4oqO7cy5FEIQoNiLO0o7YBGkQ3VzlGivSvj5fFwGI8
         sYeA==
X-Forwarded-Encrypted: i=1; AL+hErGhVOVshJUBtqvOki9mEfOE4/jK9Iet4va6e6bgnZJZS54gGJM/a942dvLhRyn0c91V1mqXH6sYQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+jimltWgvi3aaEL5RLBK3sVb0cUHPPacYJa024sxk/3otFmbQ0
	leJAMGhEWJ2jAWJD7ThZkaQ6+S9YH3qG4Yov6H2zZ09HdQm4LTeNDv10QqIFKshd
X-Gm-Gg: AYBFou36tl1izfCndVoTBDfwjKmH5X6FdSzRn0SVz2xRpkyqgfYgsAE90j8EPR9BkfN
	lRSEsA4gwLDXqDjtZiFAJHkRotNQoepJX96EyDOX5B5bakjeqkU8SZGoJwcQeuFcOkJEF4JLCeA
	4JVrnpOfIG5pL/EsgV698/UHevBLQKzPzwKRbO8i2Cm/QTbgHlKWYbU5g+fap/WxgyQsVQUibBx
	LLtYSejeB75NNKe+3M37DRPjrsbkPA0hBNjza5n1SuT1/CwfHQav1lpGgO684F9m/dpNMUyWaEy
	vv7W3SMYhnjNUGDc0Q5Y49e42DcMdFOkPqi16AhgJYIV7GioLzYFu5pGjDWkg90b2w4EeYhUNW+
	hF1AYF2VLbkiWkkeWpR8CTWFmu5C/YnmQA6O2XcO1sCxV/U7kxwxQGhqSTKKl8k+9kV2BKzQscK
	WsBtx67326B6ozRUnay0vexgeDsZVw9pj+tiaiS4IzWaNU6JrjhimKMn5z3oQGV2wVkVq8ZZZxC
	zjw+cn4l0jZJnLvRqWXKtVNIU2FcRP86qalQSX7t7078JIv8/hrdHtyyfXG/GLRcoEpI5kg6XHh
	ipmpjP9RYgx51y3ZASvdHWymXf0lCQ44llej
X-Received: by 2002:a17:90b:3c8f:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3b12d5d4c16mr1111842a91.65.1794142825530;
        Sun, 08 Nov 2026 05:00:25 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127970954sm2986180a91.15.2026.11.08.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:00:24 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect pkey method checks against type removal
Date: Sun,  8 Nov 2026 20:59:31 +0800
Message-ID: <20261108125932.77081-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au3fT5HMq7IF-M3e@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org> <20261105193632.34363-1-0xbeac@gmail.com> <au3fT5HMq7IF-M3e@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 04:08:15PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 06, 2026 at 03:36:31AM +0800, Yuansheng Yang wrote:
> > Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
> > runs without key->sem, so key_gc_keytype() can retype the key right after
> > it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
> > keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
> > reading, check the key->type->asym_* method they are about to call, call
> > it and release key->sem.
[...]
>
> This is a transliteration of the source code changes. How this helps me
> to quickly understand them vs reading the source code changes and
> skipping this?

It doesn't. It just repeats the diff.

> I'd like to know what is that you are trying to do by doing those
> changes, which is the higher leve question. You should know this
> already. I see pretty much the same thing done for those sites so maybe
> that action is what you want to describe. Action taken, why that action
> won't cause any harm,  enumerate the coverage and address that it is the
> full coverage.

The goal is that an ->asym_*() method is only called while the key's
type cannot go away. The action is the same at every site: take key->sem
for reading, check the method, call it, drop key->sem. The GC needs
key->sem for writing to switch the key to key_type_dead, and
unregister_key_type() waits for the GC, so the type and its module stay
until the method returns.

Why it does no harm: the early checks stay, so the errors do not change
unless the type goes away at the same time. memdup_user() and
copy_to_user() stay outside key->sem. And key->sem is only taken for
reading, so only writers on that key wait for the operation, as they
already wait for ->read().

Coverage: nothing calls ->asym_query(), ->asym_eds_op() or
->asym_verify_signature() except keyctl_pkey_query(),
keyctl_pkey_params_get_2(), keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), and all four get the change.

v5 describes it in that order.

> The above looks to me as if someone had literally prompted "translate
> this source code change to English". Neither much effort thinking  done.

That is close to what happened. I used LLM assistants (Codex and
Claude) to find this bug, while looking for other cases of the
KEYCTL_READ problem, and to draft the patch and its changelogs. I
should have said so from v1. The v5 changelog says so, and what they
were used for. I have gone through this description myself and can
answer for every line of it.

> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I'd drop this as technically it is not part of the bug fix and then you
> have pretty much symmetric action. Helps at least with the description.

Agreed. v5 keeps that check. For the same reason it also keeps the early
asym_eds_op and asym_verify_signature checks in keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), so each of the four sites only gets the
down_read() / check / call / up_read() block.

Keeping them also fixes something I missed in v4: for a key type without
->asym_verify_signature, such as turris-signing-key, KEYCTL_PKEY_VERIFY
with a bad input pointer returned -EFAULT instead of -EOPNOTSUPP.

I'll send v5 right after this mail.

Thanks,
Yuansheng Yang
