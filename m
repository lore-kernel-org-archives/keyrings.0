Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B23B14D0
	for <keyrings@vger.kernel.org>; Thu, 30 Jul 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446162; cv=none; b=BUeemH802NZgb0HHsAh5cJh54PSvSKfFjZWwPmVDzOk4DadMbR+rPJQ5y1j4iQZwY60xit1m8Z5mwlREp73pxCFTlNx1NBXJ8b2nLT3UxdwYwBO+RlI+dFTt9ChSUuOqOONDHcrMGglDcHgZWQRjg7v6H3/Zt5lwG70Mo+LwPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446162; c=relaxed/simple;
	bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVcq90vPAoWfKHj0lmC+zpQRiNs8y85LjptCIyUhpNXJMIepocCKKysMCf9Cxoz6gppxdCdekYyri2qpO7Th4cgD+apycq4nnaldz0WBiGJAwiugXqQ71QfuVu7o17I0dl+AiOniTbwR6j73Tlt3gSPItIihC5bVpDR4C4ws/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdANWppI; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdANWppI"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb973e6749so290066a12.1
        for <keyrings@vger.kernel.org>; Thu, 30 Jul 2026 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785446156; x=1786050956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=gdANWppIZaHHVrO4NaZ0vAnYOeETJRqHszRJALyTxCLTqgXFXrtYSNK//frvSJEA1M
         3XJJ9haOTo6G6TFEVFdIkZaz52Q8g5dIQV2bVosoXWU/WWUFW/93r52sljYl22mpBKl/
         2MLJqA4PXP/ZhvSSifBMiJxZWjtupSytErT1RK1s73DP0GXqpIkcM5CzcKqA+eoYZkU1
         8HpTUNx7+9bcYo5oBcQR8sogLak4n13pvrOpuY+MEVc05W3e9bhnbfFlWDdj5mvoouCI
         HnAYRTRyxcZIqKGWZbU3wEQlEpc7dIhx8SWOIQw7iUrd9xDOnXw6dWZtVg/1OHfI5+BD
         2i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785446156; x=1786050956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG0+e1KN1nsoMOFFn5MjuvZvyoDnerqjnUnTWeX68Mg=;
        b=hKOCy9kfHYL5vToL78SSaqgyIgIe5OyJV9I3STy8djgIk/c0kHvO2Ktk8zXntqxQE/
         ObfxijfLcVB9Da2dC/+bv+JcWOXiXoks9pfmCKsT4/4TjVTQ2frqJhSgxhwOTR4GlZbG
         PDLtzwckT7jkKTh8YB6kW4FsVd3MzJ49nf5BhQqUdayIwhcOJf1gTfDv0IKjcPD8Yx0F
         0ww3JeE3VspZKhwuqYUfhrD7qk9ff7J+H4IYCJNBcfbHXIuzmFFqU8uB0Yq6y14+DsT4
         lYit/SpaF7QunoELTqlEQEgGfurMbVNuaBCbqZsTZABXfpgVhs/JcCETgYaKYBVYJFfy
         5LAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeyhTPs/sQp1DHSx8ZiNWBkGq8D+qGC8Xy6K5AYqWILE17pUP+NlQfxYEjio/PyDkCbBis5oMPYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoeDbGLJ6hyPBCU9P3OkvzAOH5iOYe+L4XktKNqFhwHCYkMO6
	8YqimhfdrYkSDsInDhmVlwqstyYVrbqj8bQL2NE3fFjPIKK42Co6/DaxMX24fGs=
X-Gm-Gg: AR+sD11+IVO0T4D/9VCEONWEUV3HDUry8YMhN5ToRxvvHr2C/pB6QmHALz4komClnXl
	uorHytbpf/wYtRe84wxQpL41bRLGhyz3t3ms6O6IUiZq4bssTqdoa/rK3oJmT5VFa9St8La2wqB
	L8Eqo8D0fqRnx5Q6wXTWJVCVCEaAhaA0gBLvvzpZ5Yz+CYMc2eeNfsBwq4mbX3NPKcUnHIR45sL
	rPf4/kdl+qqHS4Pe06N8e9feMKPusKHBCbgZ0FhpCPyIY3ywV+6MhbwcceloRiiPm5wgG7Q4UCl
	V/CgXhlvWeBvX0u54seJ3t34EKdR/aZNomJTBUe38t2dSsTVQVt2mjLhMEp+/GMALk9gkOLhn8A
	aRIuDZA8AYPQWh+KGGwmSqfMi9TEA4LDeSTj1Nl8/ii18RqoGu8Vega44RJikNVaORbthi1CjTk
	/+a8OICOSrEwB+K4rfodmp8zL2mcaP47bkalppHQqlE90h+W/IIEZUm4Zd//KspYTQTFU3vLDmB
	JQvQBkA84UMSnyZdNFzIxbezsOare3H3fAy7Q==
X-Received: by 2002:a17:90b:380b:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f9c0abaecmr3050277a91.40.1785446155807;
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.221.78.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7263cfd9sm36251186c88.4.2026.07.30.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:15:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mingo@redhat.com,
	paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	tglx@kernel.org,
	westeri@kernel.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Thu, 30 Jul 2026 17:15:42 -0400
Message-ID: <20260730211542.1422-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113209.GF20844@black.igk.intel.com>
References: <20260730113209.GF20844@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Agree. It should be preparatory patch for the series.

I think ur ideas should be implimeneted AFTER the patch, because this
patch adds a kind-of important feature to T2 macs, and well ur ideas
are for code quality, and well it takes time for patches to upstream
