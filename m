Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894681;
	b=z0gxg7IIT7CvEhnLubanGY0mxpI6CcX5DqeG+jldZUWXE6nk9pOcyGG72TseSj1u7hnt
	 mCqoaLl/u4DBZWcuz9CUqIz61kxbc7dRxm5243VFM370OaqM2osHnSsKpXiGZyczX+8g6
	 ncRS+KJkAnfrPH/TCd/RviPfWQRiX6L3No3wlKTotBbHJm0JetlH+4lWGCE5Wo1fdgvp8
	 eaiCr6ZXMUfxHBhcAxFHhGfam/TDBJauOSzwoeurpc7nFoIFo5qOOEOmoIUfe6IyOhpJm
	 wnO2cxZnNqEPlU46phMckx/elJLPkjKfP0N16G85+jwhuMUTVVftQjYKpBZVSGJ4ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XRo+9xB+oh8S0Rx8RxvopOwEmLItymY1nHGmltPfYUg=;
	b=OF5QOU1qzYks4zFG5V24v0NUPZuZtUIdzV0dDUqCZosk5aySsAe28waeFFkJp7jlxLkw
	 yWRKNGBDg4/mIiwfCEkiWt1WN3+fkLuw4qNVVbNyqCjxr9Zz/3pcx8Shza17Dt3bO33A/
	 m+OpB5w7zyUJuslZM2Y0Fhgm6lB2F9bZwf/aL34OZkNfzxPm9OXa+aW9cI5R6bdY1QoUv
	 y4uxDs89UkNRSRcA+upEDcqTvZ9NfXqXxIVM3bCMDF4bI5bPevf/DSglKlB8Ql30810xI
	 zgqZrhCNoBytUi2bFoAogcAhnjDrEcqbKjSiaKVwfrVtC9crhXHWc2KbgoSSEb1afYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oV6CHipU;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0E606A31D
	for <keyrings@vger.kernel.org>; Sun, 25 Oct 2026 02:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B0E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oV6CHipU
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82380b0f55dso868906a34.1
        for <keyrings@vger.kernel.org>; Sat, 24 Oct 2026 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894680; x=1793499480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRo+9xB+oh8S0Rx8RxvopOwEmLItymY1nHGmltPfYUg=;
        b=oV6CHipUXqX3uSguvm8Foh58xy6rgrbqrlZCyHvp2uif8Utqxx/swkC0xoMHR9cEFM
         RvuWdAXYYgXfnoW4WzmedcxODWxOLutqgor/rmdQ5boa0qzgRFzgHH4TAhYtG788RmIy
         IOjefGKTm//12Dhds3W3zBUfAZz3HXMUCy5jUdOVW4MOKKdkd8to9VFPscnTeENi04Ng
         +jYBZxlJOc5hIcyOlxt6aSXQsEu8DYOaWDaM8BDncDSDDzMpoytHjrwhefYoDyXJJeex
         Yeg4fQXxJIVbOqYIZl3rNnOgW+RlruTTlvHpvb63KlFzxmR/qGjE3luzAQmGJtvd+mWE
         y4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894680; x=1793499480;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRo+9xB+oh8S0Rx8RxvopOwEmLItymY1nHGmltPfYUg=;
        b=Sdr/QvcWBGCxvIlVk1FKaySWnTvI4eRcSnI7lT//X8yXAL033B4+Ovvk1SE31ZNtS7
         M0OFeYb5GHUM/XhN3OVoFTdA1lIxWLWFl0a7/RUjyHzci4Dr/7PZyhi2otP8rYwtLBly
         R0L2ryPTxCcYYu27JvJnLJPzUJ1voCP/C3i70IwCzvxjTaSufx0kL+GhRiXEYjbcuofH
         q7KV+D4lOHTAGf1C69cAWPbDhUpdk9jXnaO7Ebr3/HE5D6grfBiu++a6P558eOWqZSaI
         au8jrbRr6AtXXMAGbRazhQLxVv748MKcGWtgGUsMV/j1BoNQgOsUxEHN64gEFDxrd303
         o7sA==
X-Forwarded-Encrypted: i=1; AKwUvBxEDrb02KuRRVLBR+Il5a9hj38XfotlsWYSXASeWwG+U69C4mopl4/Gl/eXFqeQ5rSqgQV0mtm9aA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLtxXlyOY+5gsHon333kM1xQPpCICa7u3XUPn0/DNi7DlnH0EGr
	E7/QKYc5lr9txXq0B4gM2WAMpf0S00Q/byiySWOwxccfFVQIM4sbRiHi
X-Gm-Gg: AYBFou3DLM/XVypBVhcajRW+w8ITvD4zpWnVAaADk41A5yCc89FJRs3pPZv1fMsYC+D
	7mHWIyDUEvJCR94kU0kQiOBJy6efu3y2BovvL1jGEzBtYP6zwdUlJcUZ9MtkX90OAR15M39G6iL
	6enh88B1KDJO51xYqpNKWFf3loUtdLVWN2xaCKmRhchJKo1n7tD23pRB4YgPf0rcNfk/dhoIyrC
	3U9b+Kk1AjW6UHsSxszb4Oq0Mr5vZEG2XYIGwaLQvqyLKmNEIU49hgaldCCip0GixEyl9qr4H0a
	vryjrkrMQld1RO/oP1ZHzmeWU75PAXM6oTPaVOjbFgjIRffHAuEPrEhU0wEtkqAxXnewDdqU51b
	kVW8hv1alTZfHTqPq0jtBuzh0ipyc73xGKRSxX8Rzku0DQ9mCekn3cwAzSno05eVKaoQf5vOKIj
	8MoUxtJnuuElrLPMRwYIFUUvR+xTpRcOioKdwVBF4NYDbMbGvbpFTXUATnhKpwTue8nmOl20JEC
	yeQCiPCRwHI7fGeNb+a1fM3e9SVPTuIOhqqXB9GlOOZK8+pt2ppZf308WV+OcIjnb9WFv8=
X-Received: by 2002:a05:6830:4494:b0:814:b62d:3122 with SMTP id 46e09a7af769-850fe112da7mr2774207a34.22.1792894679793;
        Sat, 24 Oct 2026 19:17:59 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb64a8c4sm4058115a34.15.2026.10.24.19.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:17:57 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: dhowells@redhat.com
Cc: Leizhen Zhang <lzsx618@gmail.com>,
	dwmw2@infradead.org,
	akpm@linux-foundation.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] insert-sys-cert: fix use of uninitialized pointer with an empty System.map
Date: Sat, 24 Oct 2026 21:17:50 -0500
Message-Id: <20261025021750.519884-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008164137.3671294-1-lzsx618@gmail.com>
References: <20261008164137.3671294-1-lzsx618@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

Please drop this one. The uninitialized read only happens when
insert-sys-cert is handed an empty System.map, which a real kernel
build never produces, so it is not something a legitimate input can
trigger. I would rather not add churn for it.

Sorry for the noise.

Thanks,
Leizhen
