Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F23C73F7
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456697; cv=pass; b=F1DQQ1/XZZl79rggp4JcpqREw3mKyPSyy4eBAMNVqyxPaQk3J2Hy4ZP+4yobcztEcvmM8hT6RRG+eyWQ1bRI4eQ7bUSnlCbHlNOAJJ6+SFW7YE4agQ3184Y5SbsGG1jHt1uhutL4hrKkc8AKEVX74pkEiRh1WbhIvmwuAP592XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456697; c=relaxed/simple;
	bh=waEYwU6s0rfg95pT6ZKFiPUyBmp+lu1t0GLS/lCY70Y=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ctx5Lhkff9FWr9plsBXhzoC8chtoEZCW2t47JmrPHp7wFB2mWEx+NIiIiWNKgrMz7vTKZnmMxgHVwWCQaQBTkiDR2vSYPQnmAePFD7Pa8JvAmIalWJ5mznlJTpq/SpuhddJvA7vQY4JCaR+mEUDdTddMnZ09TM++kDwcHvho7RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnMCatrT; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMCatrT"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-825487fb37bso2372736a34.3
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 03:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791456694; cv=none;
        d=google.com; s=arc-20260327;
        b=rU4Se5g5MaH/etV0J9uzXEvgJV+jn2CuCgkpuX4o3ufAWseBCznCDFHPqpAtGiD91f
         wvIu6V8Zdw2Gpmc0nW3nua8qy0n7AvI5eF7YDVOL34A5xbH91CrSxtOXRDY8YtGapH0c
         mgF0hb3JmuqooMeqHKHEvm5TRDqP+68ERtOmqtwM96BHuK84XjjtUCP0iETozMGwBYOh
         48DY8VYIjMtfpWF/lbQ/Lz5ntHz+FiwTk/0QYFHtnDIZm84sr9kvAQyQSJ50lSupyeqC
         ex9OGmwqKRezFLdeWCRfQ//ZNDFaCpKLrNi0fphAr3USJVt9QJ2aUsgJfa8SrD/c8SZJ
         sl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=waEYwU6s0rfg95pT6ZKFiPUyBmp+lu1t0GLS/lCY70Y=;
        fh=e2hw30cY2Evhogwwrx7+SnmKC5+G3MBeg+70CGHeGmk=;
        b=qiwGTxycakYMFSt+PX2/sGqva0ZUU4kNAXpB+cdqG/ZYYZoGqQVIhAJTzkoRUcrZHQ
         q3hvFiYecjCBUTTAmdTTnAcAaKrWhICMUZpY1Hy48fCoGQmP2A75QjSRDvrrkBC3ULOg
         WYKchh1VWAzxPN67r15yjKtcWXnHxQ7AVw9CrHTByx8Q+aTPIGUKruJ/TE2HQwPZ4MGv
         S8z4tsxr8+hMu+O21x+uHibJ11EkJESw4Dummem6rVxCBoWSbCHvuvG+iNC1zfmPM5Jz
         HeC5Us6gillYjIGHSXy2aL0mFcfa2Zy/1QIb2cWaduGjHOWbjjQmQIc+zgO9lBJM5pyl
         5YKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456694; x=1792061494; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=waEYwU6s0rfg95pT6ZKFiPUyBmp+lu1t0GLS/lCY70Y=;
        b=DnMCatrT1ZUzgpt5QrJWZhv7izUfRIwbLrYGVwLxyLjb9BR2nBTugN/WSOgjwI+xNt
         6yRfOjqrF1X+97lrTyYf7pkaDF+uE/uE/3CjsmlqWvwhT5RN7S2DnJ6KMPbNGvLvXSWM
         hK14IVU+tCGLwRrurWgX9jOHfKPT4A+oXlez9dQYJlm4QX8/EI96ZLtySBcXV1hAMPIe
         lXtio2pLhYvKPZ7UELgHCFZpMWiGC54bVsPwwxRVNZUjCfEkYfuM3B0clkSY81gzSUKF
         bMYkYp8uKDXFFhuf3I/frI5Svh4ds7K6EReWpWG5cH3JEC2K6Pn5xzjaLDOipZhuFwJz
         wK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456694; x=1792061494;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=waEYwU6s0rfg95pT6ZKFiPUyBmp+lu1t0GLS/lCY70Y=;
        b=MnFcDOIjd3GjUb7lZIS3MToo30c06JRvKsazgeFO+wIxH9ftCo5iBmtQI0S0tOUBor
         zz/P6XSi64Z7D13mU32Khes57azcQ/CGeTzRDNEVL/Ro+9MH93U+LaFGOc1nbtxaLIDN
         EBhRz721jCUj6og9HtQNq66rCDqK/xb/siR8mc5m5uXRX4hVxrgcsQYNFrsihpbuYvCt
         aQ5brhytnS0dM7w2MuhuV3LDasVSHnoGxq2CT5imxHa0iSs2NyKgRLYRB/OOVzy7zeCW
         BGa6Fw5qlY7Xeh20xgjYXHtZ+QwJY3oENQs8/tjpgu+2SvSKSgbAs0uExLa9z6SGamQA
         nD6A==
X-Gm-Message-State: AFuF++kGEK8LnNMhk6FDm/bkQhOjTodIHBykVpKcS33UKEW1CrKOGG+D
	9oRaFcO+RZBIN5Fgop7tBRSSYaKnlZejrUwoN7EaQYwfsTFbz1cRsdYqrwtWaJQrYOtQxYpy2ZF
	UuhEXZeHQamioBxFMF+upTAz+Rep1+ksFioKq
X-Gm-Gg: AYBFou1N9bccPLho0/3mcekS3257QKZ5LRC2f9x1RZ4bngtwKDVcMKDc+pq5cKbtn6E
	ICHY0MZSNfAmXauTBjoeCw8VxIj/d6pvhOGZl/oFZtvirS2sye50/xSN8cV+4eZIVfTu4e53rKp
	64PKiCjW3YmiGwN6ZO2HdOfA9wVbpsFS4Hwklpk1DjAILM9mOGBMeE/688gDHxk3lwzx9mntRQO
	IhVm3X83ZEbB1pB+lZpIDyuCX4W1rFtYKb+iqhUcn4w0SQ5yHnseM+6m/a9STnFcrJEoatNyFxh
	ovCpA+OrAdjpRV7lQ19M195HtazU1+QqHY/qLX52u6D7k6UfTz4UZqBBJ8XWdm91Vwu0eI7IJWC
	WF3A3Hq4lOYT1823moAGGNn006aU2YedAUCqYzChZsoszoE9Z5W3BkWI9
X-Received: by 2002:a05:6808:14d6:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-4fc435fc5ddmr4908352b6e.9.1791456694045; Thu, 08 Oct 2026
 03:51:34 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 03:51:32 -0700
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 03:51:32 -0700
From: adrimg3196@gmail.com
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Oct 2026 03:51:32 -0700
X-Gm-Features: AclHuK_P5vf9ra4U09whLUCH-Dc59ntNx3hzUSPQNjtu0g-6sMr6RIovrXySKmA
Message-ID: <CACO1+RSZuymnONwwmmRj=2ji=hNP4MTyOZOPKvR-Rr1OXQtJ0A@mail.gmail.com>
Subject: [PATCH] KEYS: Fix key_reject_and_link() race with keyring restriction
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"

The restrict_link check in key_reject_and_link() is done before taking
the keyring semaphore, racing with a concurrent keyring_restrict()
that installs the restriction while holding the semaphore in write
mode.

This is the same pattern that commit dd3ea3fc ("KEYS: Fix add_key()
race with keyring restriction") just fixed in __key_create_or_update()
by moving the restrict_link snapshot to after the semaphore is taken.

Move the check under __key_link_lock() so a restriction installed
concurrently cannot be bypassed when linking a negative key.

Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
---
 security/keys/key.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)
