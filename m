Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE92628D
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468796; cv=none; b=jbg9s1AMmz+G9yvlF7/IAOueFecOs5m3ich938sq6rKJgdOlAHbsjVs19+3yGVNaVWwJIGt3xX6EcvbEJ6UCO+DpWGNVaHy6AlynBau0vdyyWstZFsLpKX9451aa7KRMwZHJk1+hQkkUoHLJMAtbSxbPyRSwpky1GbhKqikehH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468796; c=relaxed/simple;
	bh=yuSs65kmHYr77xDwVpF4Dy3q5+xnqgRpHPWIHPWI4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx2K7yrPWMwNRcYWr8syEMkr4CWQUl8wWJ66w9wQnPP4v/NQZIJ06xX3fgimczxLmgU2NFax/AMMSV9RX0U8OcL6iFnZvKvEhZL9uVkggW0JRrPmcEdLiJQvY4nH+xFo3lY/t2dVMUOfuWT8CmzdMDuM1ZVsSJBCdja/0161I44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WN7bSlcS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WN7bSlcS"
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9A403FBDB
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784468790;
	bh=uze8fnz61OwWI97EkVILqYaHqEWDohgXqld8ghdnvzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=WN7bSlcSuCiomU1z/KveXFjFOzBLn96ihy/p/P5Os8tvcPYRCh4L7zSHmvTT7VGjw
	 DtFAgqe8N0cvVg067GIQk9AS/Mb1eJGrGGrm7puybIGd78BMoHj3SadSppjKtJuHN5
	 s6IIiltSBbX+te0TdKCbly3E/rXz8DbPZf3PesVde0CAEKIEkqR9g5cxE15A6G8dt+
	 l7IeoAt2LHl2fRxWowkswSY2PU3rPYXDoOEDAGdz/dyHsSHDjdWeE2lTZmW10e0T0T
	 TLAnDtLwdYwep4R3RUuXNtgXnQeNoGuIfjJAB5S/8gwHw7YnQCqcOCntPEsPuYisCR
	 E+7FoB9DhcITILuztedsc7yeHDkId1cmR2JOuoScqjwPOKEYVY2Hf5Ut062JyS7M3F
	 1i4m5v8pdlMeQW8lLWfcFxjIsAJ/0JWRgM1zJvA5j6OhCcIQwnHX0+ba/Yroz3BwKS
	 H8TtFJEd8zJ/1K4QP6e9cRHstOS2GGhIFqR1G1zyxTlZYnVae2YQpFLdcGGl3rtMvy
	 k/PDC3kr2raPBMt9/6XbmClgB/5JKm8444EBfD1Xnc3MOBYWAhpAzK6KHkMImMtxrw
	 l74woXUmKcGOz8Ha9Bvy7TSFK77wPjDH/i/N1+8i+5S/WMgty8V43x/Np2BUSnpCdx
	 6+GjwsBYqf/QInEjQnGYuiJY=
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4629f312a67so8268248f8f.2
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468790; x=1785073590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uze8fnz61OwWI97EkVILqYaHqEWDohgXqld8ghdnvzI=;
        b=itnHVcKakYiqIpCQzknwrY3rJhpWwNXZkVSRI3n/3BpxdyRSA1ANL26j7eQVWIV3aD
         QW7p6oJcv26udWwMLXPzBbnsSaAbkmIm2301t0CMBNgwZJWktqT89jfuZ6oV/ZxLJXQe
         5pGPM8liM/SIaLvl65xkWNOFTTMwB2SWgr77BmGQvNOWxsLDIJG68N+bGDv8HgnHDN46
         lvzfxyBQPJk1eHsEwTWf24qZcam2IwkJXgsCMwP3AwZcyppholaM+kYK3M7JGF+M7g3+
         aPXLz4FdfT+dCQcQZicKUbQ+KhxeP35CQqiF7GBpBXcItTqguZEj0ziT9RasemdfCcWO
         mUKg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2NL80Z9/HAyqOfxddlad6EsdTyLtZlvkkNXxd4thh2T842RZOE0PcqWFcb4PAQoI6T/xFX7oCVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ieoEAT12Qihil3Tu5l/XgK4YQvBCBzFyLgpMk4JmwnAAoHPV
	qS+EWba9DI1AaOk1G9HZyJEVFHbeFdHYPDoflVwiJIuLhQPlfzFVKL0SXSdvkPi4qoPlpX+JaRX
	R0Tlb2tuDZVO6SbTI4Sn9TSfiOtfB3msEV5X/rXIrcuPWY1d495dT1i04MrYT97gAEQ+ZRj3991
	RB
X-Gm-Gg: AfdE7cl44eLYbxxElb0yj7WlcZGSp9jvNMlRXldlKwn8kGkxBqFt9igV7GWd/PeeSCB
	l4q0vn1BZlzl5pszjdjUPW8J2+HqwBK5+tAkFM8RFkCA4cGiiWxDRyHlhJvVes32Qji2qNjJAcW
	YCvll7UW/Ai6Nu/hrTM0xRihTaCWxE9mKmil7i6p/9LqwMfWc8fsF4czMrU9bFbsrdVxLsIU+i0
	tNr7k2HHlSfZJvsXrp8amKNFtvKjYR0ugGPQhfLqVgsenRUNHrvHyDfZEDFeUcMmhtuBC+Kv3Yy
	0OmTXUY2416LTGX2u+9rf7tFHTQkoHx1FxsaEkqa/OOqP7WeqtYFHACjK7H7Zv3pO78AkVHpkxu
	PDyQ+Gb40MgDHbN1q61Agl22XvZoyW8axFU8cRqe+0qKq6lmmshRC7wSJTqKr9BebcoMWtrovA5
	jctoGfEHrH
X-Received: by 2002:a05:6000:4916:b0:478:2698:72f8 with SMTP id ffacd0b85a97d-47f62335823mr10580114f8f.49.1784468790271;
        Sun, 19 Jul 2026 06:46:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4916:b0:478:2698:72f8 with SMTP id ffacd0b85a97d-47f62335823mr10580088f8f.49.1784468789897;
        Sun, 19 Jul 2026 06:46:29 -0700 (PDT)
Received: from t-14 (lfbn-idf1-1-452-109.w86-242.abo.wanadoo.fr. [86.242.159.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed244asm19771318f8f.20.2026.07.19.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:46:29 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	david@sigma-star.at,
	upstream+dcp@sigma-star.at,
	zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: Re: [PATCH] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
Date: Sun, 19 Jul 2026 15:44:07 +0200
Message-ID: <20260719134409.3336365-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alv7LVoTQJOMyk2J@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 19, 2026, Jarkko Sakkinen wrote:
> As said, code changes themselves look reasonable but the commit message
> is painting a picture of impact that this bug really does not have.
>
> If possible strip down the paragraph and add fixes tags (if possible,
> I can dig it up too). With those requests send v2.

Agreed, thanks. You and Richard are right that this is not an
exploitable OOB due to the struct layout. 

For v2 I'll:
  - reframe the commit message as a correctness/hardening fix and drop
    the exploitation and "how this was found" paragraphs;
  - add the Fixes: tags myself (they both trace to the DCP trusted-keys
    introduction) so you don't have to dig them up;
  - keep the code changes as-is.

Will send v2 shortly.

Thanks,
Fabrice
