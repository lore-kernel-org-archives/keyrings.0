Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507348A2C6
	for <keyrings@vger.kernel.org>; Tue,  9 Jun 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018138; cv=pass; b=fIXzvPgIK9lToaqraj+VlDbtd7TcTphlPMNkjmq6rhEWvVQDW1nsLMizm6NXorJh2EfMNqz4k8MyvQV1zrAE9KxS3zAIhFuOajjxrEr+ctnzFOFVioBU/waC/duae/ITZ6+hOwMEZvn5hNnS/xYZoSvW6MC6+9Hi8697KtMcQTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018138; c=relaxed/simple;
	bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llIir6QxdvGHtAHexkZytHW2RAzeuE2YkLoyq+ghIrUo/rCw5fpsIgtVMuYj7nHejvIU/mloRLryzYxJQIdOGggVpuea29NdS1qbheEvL6BP5iIuxUNvuGtv9e8H4YSUT/7lftMhZsztdWpmvBGjdnyo+U4liFBys1besDz1Rgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROnEOxsA; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROnEOxsA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69170548d0eso4472347a12.2
        for <keyrings@vger.kernel.org>; Tue, 09 Jun 2026 08:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018133; cv=none;
        d=google.com; s=arc-20240605;
        b=J2woHAX5ViFEmygFUt83x3S4qpA1EJJuWmVa6S2PPVTUUXVJZebD16tSzDy319DVvs
         G5oBP5UvfkmdRBBd01HGmox5a3TBV0Ci2zM2k5R1h7CwffzjBgsc3tED8l7k14zf5evI
         Jfcdil9bfdLG30BLac+RdF0s2fjj0Ne8IUjgIPQ9S5ii07fxPM8lUCvwRB193L+X3ODl
         2Y6bvm3qJb1k86b17Rwe9UMU5ys+kN53F+RiKWyTku4uGV9KK6zB6pRLLMh/sOBJXq3L
         toUFFy1ZzjNccvy7l+NWlyF0vykAIgLFz+odJBT7Ekik8VuhTdAFlwrobIUCZdSJRCL1
         PIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        fh=NQ6fyi3SnjRfoFvVNhRu4s5zfahOWkjk0NppNCgXDIw=;
        b=kKrwHNwlJD8s6A9b8n+3Hhzd0N0rvgmIouhSuaoAdn1Y0pWV6DNtohox4GBP4Csm+C
         qB186acQiKPzvd/qHE8e5crVvckrs6V9CxChB1KfM6Cj1d6cogfDPVSMOVG4muJDP/Cb
         NqINUZ63JB4nlcpdtrJwdLaXepmXCMKPmObFd5RhKBot6rwT8BJT35FybEr3OAI2rcJu
         kPW/J2yyCC9e3ZhSxNIpCErAtd+p4hBqRpdLNzO0c26c+JyjBkL4XHC+9/Mg2dcsv6Yb
         O9z/Sz426PR9ymoJqOLro1LLmGbKAW4+xpelCcLWTPX7bhGMtrbH17VtS3Y2+dF4r6M5
         jW8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018133; x=1781622933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=ROnEOxsALENQKer6pwqR5Pi6AY9FW5mhmD391bWe1k2/P6FM5CuCm7YpSruXaPsXYa
         SVXNw/hEYfn4HrViA8JArFyCEknOBOCpklb99bXJFU7P7vWwkt3+XwrqQv31GxhBW66b
         LIVPBY1fkuqmrGiwnpOrE9BwboM2S2YV+B1DZsEMbH/N5LeJ+ZTJV7bDcv7j1SSUAPQv
         Adix8/UdZ8xIzRiH3FeB2Tuo5Ak968lw9ZSAmYyivOUcM9jgjx2vj5Lu3Kl6w2jyYSae
         zjKO/2qUkX0A8qesAcj9Tmf7zisyW07svGgP/zbGChhxc0PgrvrgDMXIhg8Eqbd4d+jX
         xMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018133; x=1781622933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1j7iu+o5kZq++XxgNCC2TIdJygR3iwb7JsnnVDK8I8=;
        b=XkrwA11sEo2aM8llVWKHZPsFL103/fhTAgPYM+weBG+nPN1vrmxTqUeCie7yH9Cfvg
         SKcjtTvCZrKkIZQEfE06u9U1NIPtrhbuZ0wANUSnMJe739DkitEHezrfr2dtMFdxRKQs
         5R/SkGRY8sgHy+klEiKn9w4riRWwVmkZov1+py4WPiGfO+5N5jLzjLj5/32nPzq/4UYj
         js7pf924cMysBU20XeMtrybULTF5FnmaVDqzD2sbhU3w91rOLXL8cyVXurw6/VMjVeQL
         aIQ1LcACvdnVubZlwOIrzwOSdI4+r+KqKDm8fdTXFhEvH/RfZrJnqnTIfbzAYWMSERhs
         NKhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nHCuSAvSqwP0z1YbYBKcvP6FazAlrXPpJtnDvsVdSRbvWqiDqXZ9DVTHl2bnK3i70lU/DbMTPxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8O25EBExnSuFaC23OSI7rIfT2PSOKIY3ThHi77wd5lCFg8Pu
	yfbJ93/ywX0CcINCLx7wyq2eTCSbFbvEyZEtmDO3NeZnDpaNI1wWq7ktOajwxV8ITi5HvDI1VL3
	f3q027aXG7tsSz+HEw4TsU7N9LnA1LA==
X-Gm-Gg: Acq92OHJQJn/a+w5Uk4vQc/uZsDB149pHgoE1C1CpqsDWfRqvxEBV4sZhCO9va16/mJ
	SX7y8ZqKTa5XmzzAIB9xXzESw07XvlQ8AhhvyDxMomRIgl4L8SAIR7peDAryONuk0g8s0DDU/oh
	1HVdgZAUByZyO/5dOrgIwMci+I8wrxP9ZRqnWSqLjS5Tzudj55G5zRXt3eT6CtC+DcLMpL9tLqt
	Hq7ARB4qu/VPZFz4i1Bvqc8g6xF1Z2hci55/EvoHocKGO+SBgIaYjueQZyflWcvS2u/F+ylvP1z
	0vLIiUP/9T3lD/g/xMadJN3lvfilL6N/ia/8pb4gttyXQFJWDFP0F/8qFJTPMzJx1U7JhR/Maoc
	Mb3zAu5Qd5x3OJKBBMgQfmy0ipyHS
X-Received: by 2002:a17:907:2712:b0:bec:5865:6c63 with SMTP id
 a640c23a62f3a-bf37234ab8dmr718710066b.26.1781018132938; Tue, 09 Jun 2026
 08:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org> <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
 <aigoZeoqygyBYCbR@kernel.org>
In-Reply-To: <aigoZeoqygyBYCbR@kernel.org>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Tue, 9 Jun 2026 16:15:18 +0100
X-Gm-Features: AVVi8Cd53HY8Byh_1TfSIUUalquq_E9RxBK_dmxQm119rFisNv4Tp0HsicGdC1I
Message-ID: <CAAMeuQTue5bkbhjYLjsRCnB9=KBifsPNQ=ZRVp+wCh2TiXE7Uw@mail.gmail.com>
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko, Vlastimil,

I will send a v2 this evening with the commit message reworked. I will
remove CVE references and frame it as hardening rather than an active
vulnerability. I'll also drop the inaccurate skbuff_head_cache
comparison that Vlastimil flagged.

No need to strip it yourself, I'll have it out today.

Thanks,
Mohammed
