Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21573415F12
	for <keyrings@vger.kernel.org>; Sun, 18 Oct 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=Wr1DNPLMVdSdKUK3zYWanAGUekdEtfse0U1lCsNe33DwXYEvnVL6tf9rDPqARO5OEq8YGyn5J0/YwbIDIqMMFuZRMmI0/pCHbdNr0IrluHpVkrNaEN4HHuK4Tnziv1LzeRSScI5cqHttR7Y0ly46xdnTtFWEwiRvKjz/M63mD2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a9761758adso8915911fa.0
        for <keyrings@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=eBBGUzujxFcTxLhZhE1H0pFzPSGNkk0moHh7vYJ1CTO1fmSMAtxalo05W8v5/FfTYK
         Yf8wNnRzr58Ce5qlT27AFB4mmygF3AeX+GcsurvI6bPA6aXSPdoQIXg9aZYtaHVH1BUw
         CqZOVXH9NJQoaJRJ50sZVu1mjib0Yr6M/Kc4HfH6Darn4jvll60CDhsSjmEYi8duq+NM
         YQHZezvSjDiftiOAP6KO2+Pqg82fQ40qjVwqkVkBcxpIfOBl5hawhyYoUyoMyCf/ZQVv
         19hRgZtNM+UlGrxGzBBwzWHIvs4bOIdzmnwaP5jluzaHycJZCt1WpyDS1UzKf80I1DF+
         NHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=mcIIEo4JuH0IOw8cwFPZNuWn6sBOh4QW2aycu+ao/C4=;
        b=ZJ1e+l6bOBE3fp7HPA9Mbz04G3442N+jb7SllpazFw9sxnOV591oQuP/38HflO7uwX
         EK6tEUBT0ZMBvn3LWYl9y9VUPD9zy66wQw9thVhQbj/uBeUDyT+e1eVWWWaU6H9o41/B
         YbvfUM2nG2/s+cUgXbM3CcfdoS9xXFhuVFta28yg6gMgvMM83k3GDQ0U0ybY1IjsSQyG
         Enr7teaKYtYjZSws/udqbIZ49oD/xoW0IHDHHAZFTfwwPwvPL5a2Ug9IbL0I1DAXoFH4
         r0bKkVpC5xvzSUYtb1/WR8ypfcAZ1PqsQCfOVXRLWvp0pjGDXpkqmPrUToqqODlcuBVJ
         tLmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=mnmfdPblXv+Q0xI1AZIPyxRvAnhxOjTfIc4cQZcW3qOZZPT2e/Bvfwaj5r4FIMJdQs
         chrisZei9vk8dUqDndEZOs9mr8uTA0fZjqW2VHVweDEq79f0yt2vC+VB7QaweibE0bXk
         lqbnNtu+XRrD+8w6W7DtAaYvxmJ64kwno7sHIOX8pJDTcH1ZleQwMXNMa6J6DAt8s1Zr
         A4/et8qBItbdVdgxCLUzVYelZJzuMyZCIU2m38OJqQ9K1ADKWMJAYz04kLw5rZEQ+4T6
         9fJMU7A5SxQHV8wtt5raZ6x7qRTpzHG1W7cIdyXXQ4T3pVe7LRo4xZS6PAVim3bvdffW
         8ZAQ==
X-Forwarded-Encrypted: i=1; AKwUvByutUlbh63ZNhKoLLPzfqXQROScs8o/lDt9alMgfYZJpbI72YzIjE7ZUKFGUvlQZJEVMa/ixlPlbQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfoJSEgR+q221eNnklm2NuD93dLFvykxe/9u5nyCoRWiI2JazX
	aFwe8vR1xJfTtNrhdacoodobGlumYi1fm3rgF0/t+bwZlI8vHR2XdKt2sUM+lxBuhOwlNUqPNWf
	hJzLxQnz9/3eFpZX80961Q1HXeR0Huf8dRybbotJg
X-Gm-Gg: AYBFou01r6FIPP6f1iIsJd+4FZfRemUQReUckAYTC8GsaZybtOU7IBL6K5h3SD9IOWi
	83L0ES9R3So/DLmjyitZSKD74M6WxOSTTD6G3NIuFax0h/cD1WW+exQzMEZj1GNwVGAf8EIW3rd
	8t7GusR0T8so9xkqhU+yAzvAmLfowD01uxx65pyPGRvGuO0nQ/BVCchA3VcOLayNOaTpCtJrpWV
	TFxbi7CxefNMqOJAYKD6R1P+7jLvE39R6suJ9nHWQu//Bic2Rc050SnWGQfAuNM6NC20KIYf87o
	p9eapzGrLOx+YXH7DXjCT1AFoE+OhVezbaEq3jkbzW2VknURetle
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
