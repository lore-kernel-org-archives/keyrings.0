Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=pdaQ6mVt2Ee9A/e6x66E9zWDud6+zOyrEsvKpu6FlRz2OPSS2YSmyBjfUsrg+eyIUXSe
	 4NaNwXGfV9vep/zQaV+vPz2LzAOCTuUJfCroTLkQyxDbuqb3/aM8ntHrTSn1OngUzxmDQ
	 N9EkCjwtS9+RPXWN8OQZhlmb0xVWFE8e0s2s0k8vCgemiI/sKQYB9R8qgX2RZ0e847CCE
	 rOl1k5CKh1PUTWPSz8X5/fN2+ZCAjJmQ3yvF/TSxwBY5RiqL7ICCUnGmgtHY6UoDEjjRj
	 tuopwEYvVzVTV2sg+9hsQoYR7E+cqcdaaDW/piPG62+mx78BLAiZFZ+8TVH025vWzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=oGmhluTROFYuBBu2dGiwnQCLLfstOgXIwScIhjleFa05B1XVZGjBSxKpGGmfHkaIqhLp
	 qcn7qokI3M5eshGhZsJpNI/DcXSTdFXWWxptUMnUkTE/v1lsMkcvJTaNE/io2By0mzB0y
	 3LUP+iZpuv3Uh3MQgY+58DIawF/TVv7pvUJL6r5N7ZjvdV35EPB/V6lTw2ERz1WHUrtoc
	 pIBsN4qO0AT9RTSyFGGldhf6ZFMg9+kgsP2p2M78qW+mvFSsALk6eDBUsd9nUImg2hY/7
	 6M2MsVJhEZTRuCAnc2JPPwzXTuasSZBQaqFL1+1I9Pgj/RzAuJ2qg61d5P/YcTEs0rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16723608337E
	for <keyrings@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16723608337E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b244fb7fffso1559745c88.1
        for <keyrings@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=VFIw8Vt/GDI1O2y3JoN2lgc6mxn0VNJ0iGqR+h8gruRXY6Jdl+b6692J7X/2SMmWGT
         oEug8IR1Z5vTVsd2GOr7cEODj3h8gd29S5yN2EYsBrxNG3fwfmQqgMRNeCKqdKexvnri
         CXOnvB6g8GySiuhSExULZaDElOCKdTenIF/CYc9FXkmZtUViierc2BPkwp/lE+h+n4pR
         ya07tKUB8MW1hxMT/RP5axO+wQ0vkBiViGgS5hXmI18TS1Tb1xeZwU4urOSwa+vLt9H4
         FZnbemRC3JcNZr0UZah72HTkwGciACQnATYE5z6mgwJkv1ibQc+GDRAbZkF8IhCR8U7y
         8s8w==
X-Forwarded-Encrypted: i=1; AKwUvBxMZHjbw7nZVn7lAO+rw/nODStd5prRdFy7eaWLsejexR718uZSGDlGoWhLwAbLuZTxcpQibP/RPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9tWMY0Vm2WWQQ3NE+DtR6U4aBT/tWIDlJE8n+Im99GVQWzBH6d
	uXZNtgip1usPLgb1zsX0Tr+R+VMLrumgfF6xalRK3haZQ1qiX5bzgt4=
X-Gm-Gg: AYBFou2f7ebQE74Z2iFSb9LQExiWvi5D0Ld1pulpHec+WB6hvCWvIyDlVy8Siyofb6Y
	epL+cG+AUcnrhFNKS5ZQog2TW6BCNvIVs2xF+0H+bDAABiDyTAahXjt5lNrWm57MqaL8btJ8YHl
	uy/l3afMjYmkbsM08GEFdnoXsaYQw1QO1aoslAIEmJT4rffWF2hZrJy/I0OE0f6GucymclcrFZE
	jCIi74cE9gE8WJapjtKz2LPBtaZwXqwhWU9h+WJaNzg03wFPCKdIWHam43IpEegh11FuaMD2t49
	Gu4m88GetvToWrtbJxbOByGc9nEMApDsOB8X/SnYB7F8C0aKNA+AeLBEvcdu1JiCQkR20UNs40g
	1IsUAbA9e+GlUm9cKrhhtqyNSOBiOeu1ntnQcazGn0DqSpp1ks9YdLreRCqJ2lAzRk6IWbHgjMi
	etQAGXfZBKeAdXicLnkrXDFogrDytKPu6GWw/5dMyWabBuTGS2Qrcc+6Q2mL3OpMDxEdpZsZjzP
	WrGh7CuRwXc8IKUeXERX9Ab8XMw4ukv0ryH6UZeV51OiXapvNyeZa33sGv6E9eYT0PPgK2oWd1F
	ky8f61tJGCn4LjnZpYqsb7DNBhMFc8fk3UTlfmdgA1xfyoVyKof+BBEJ3BxVvkK2Iw==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
