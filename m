Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC43B7749
	for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731510; cv=none; b=dBpObqpfGGSbBBk9iWRD324TmDdORcOeFOu+5K9CvYy1Ywg4cPozfxmMZSvvCIfINTaKs4wfON+9TVSotWsWtjkUNI2Ey/FD6ggUKbDLtQOxF/JcUZzAk2MCr4IPGW7e9FangBreYPXHBjSeLy7wEcWH0s8HX/NBSPrhFEWOD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731510; c=relaxed/simple;
	bh=adQmRDDMdEGHtE5WpnEdo09OXdFUdHwAT/L+LntBHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVm9hm2D2ZxPlusgGRIPa5Q079o1qink/dPf0WdPkrHFrAu9Y+HNnOvZfkwEB55T8G0faErpnlFALM0k/Df9JjSTMlHH6n6HyFz+oMVOBZWgMLv+w7GiPr78akQzAVzuqDt61h0WL9b9WylwvYHUzDOTbwCw9F9sCe5fpEiHRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl4tMIFT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl4tMIFT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caed617615so7768185ad.3
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731508; x=1788336308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=fl4tMIFTFn8KT1OAjfI+5im6kY2ISfRFvcWma/srmjWcsYWUgeSxRMO3tbpwySB02T
         rYfkSUM53AorEpSwTipYRVQLP9v1DM+w/Ku5xdLaRYAkVTlbaqlBsuC0jMS1XPlgPSa9
         kaXPvC6JMCi56YITMduWAzDQxq9Ccpi21w7REhhGZ7d0Cbxohnopu+1/vQRu80rEAElL
         sh/CZOGC+tHku8h5O0LiK+n7mta1bJFSZuQY+SuVxVx+zgujZjnbIAepT3bGRVoNihi9
         TyNABhzxi7F+AoBT+nGQDIUVbFj+N4hqrYZSARHVq7FU/y/ScAiFtOsPoSDURc3RP8/5
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731508; x=1788336308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=O26sSdjaC9f+hFp6F06NJXWPWa1DKJqWwjtpyf2A8bPEg8ReN6B9+jximzP3TcFL/Y
         1PL83UYHiOLUqkwXmOSWOVFV6DpWRcoofi1scM1skyMdAipWgq9Y1JBsFGZz1ljcwiMx
         h31OnW7hSIU8m/6x1iMwaoeIUCW5cAkccgPJ6RQ5ywlzOyrLHaoUrRKQZa8NJw7p3aNd
         vn1yYojl4f5s7eoGrY6XySBFO5Y6wdTH5i6csqVnt+MM52E+vRmaW8JICPMY/DRi69AB
         Zo9gqFHm7aBNfYOI6n0f9PrJQMzliaFzAQdA0GESeGJpB6O7q8loAvm0OfG7SrGfzuo0
         P+6Q==
X-Forwarded-Encrypted: i=1; AHgh+RprVU7zjPo4nUxvTkWv49Xz+BZbQnPAwOr93lhj/IVknjN9iANoFQeqj1Ee5CW4RjRuMtmGSsaM6w==@vger.kernel.org
X-Gm-Message-State: AFuF++ny8CJgKKboc8jxt5fCyH5oNZ9LCY+INVDZpK4WSIuRS/S+pUj3
	0VlJYDQ39TvgpLUhnmEts7GIGMK5PEErKQblNWdtsVp1GhBrWtJTKXGu
X-Gm-Gg: AR+sD11tN4irNZALk6Nlb7gdGZl/tkNX2J944YQPb0q+KEdpJoSlMQjCl5Mrbfb/1dW
	WhkzDK3XGjuHxsOFNCFkpl81vJLrUprkZJke2JgFiIj2+37aRaZjn6kTAn7n6nU0R+5p9aGkAii
	D51Ts0w62bzhkbAo6jws7H5DB66pLuIcvhGmB+6nRjbbDLncVrFpTRNJKjDljokUGYgTMPXo93N
	CpuoGAT6hbJoakGfLinr++VfpzRrx+Y5UO/Kxe3SOe5mby3h3APxWZ1hJ22GgXs99c9ApNB98pW
	JkSapnLFw/O8E/y0rReQUKkZ6b6fEx/VP1dLc/6DdMrg1EUlNYIbAAWLqNr9eVp9IgJAKSna9LE
	UwijxL58ZjMD9beGA10mX1UxrLwcAHHfj2Xbe/TDCqJKONo+zSyzXyAqwkdSD9IGIrQHfok7FyS
	GHLxt7dLBd168jNASx7M/8vX9fQAV7V/qUXA9BYQRsT8i3QoxgVeT14mYr+2wk84mqwwNyAJMy9
	RkxpGlHhmh/p0i2TxCYzpVGzCcedz4jCZVHiS0Mo26k69y6QhNpnROmyrM=
X-Received: by 2002:a17:903:1b08:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d707b7f5bemr88598635ad.9.1787731508372;
        Wed, 26 Aug 2026 01:05:08 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm9566068eec.5.2026.08.26.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:05:07 -0700 (PDT)
From: Sanket Sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: gregkh@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	Sanket Sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH v2 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Wed, 26 Aug 2026 08:04:04 +0000
Message-ID: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_seal() computes storedsize from TPM response fields and passes
it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
validation. A forged TPM response can set storedsize to 4086,
overflowing the 512-byte blob by 3574 bytes into adjacent slab
objects.

Add a check that storedsize does not exceed MAX_BLOB_SIZE before
the memcpy, returning -EINVAL on oversized responses.

Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 8f57c6111..d47cb7108 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	/* copy the returned blob to caller */
 	if (!ret) {
+		if (storedsize > MAX_BLOB_SIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
 		*bloblen = storedsize;
 	}
-- 
2.53.0

