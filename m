Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259600;
	b=w60amQwAFG6ddiby2sn9v72bAJWY8jMSdZGTQ0vGa4RJleBWdPIk/KTwGmSzNMQyAI3L
	 Pf0dRDP71/eoGCefqzJ58AjuxGGGk5TomOmP2ebv7YCuITlI6Ev5Q3POxcpVDkAEJLSWR
	 mbCvt8/xWFvUDaSTb8IjXUWEZhl4YTD0lXXgOF6bD0J3GhWrJVz+xL85WWxBSqUvt66dA
	 6kBMU67yYFZXohOsLfHS6kSIr0Eb+WhDvt5trw6C3JWCf8mCqS4yZTEdhc1T/A2xVl2Oi
	 UWwtOPceQNlR5FuZa7gIU2tjYtp2IY268oBuSR3BAWVoQ0Y7cDDqGmo3rRPuUUx8bOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lQqydnWRoSGt2ahvObnzZZPU4tywkZQM18aaUe/DYek=;
	b=bq0RrHfRWE71J/KYn4B53tnIKgyBTo3c3I7DZLpJgvE1WHxhOFJtoFSn9Ta9zPs0K/i6
	 NeAOlOOYw4SZwpoyMT3QuyYkWSPSClqL3BoFQKJV/TXl+3ojANepR+iCKprem4Lj8oHRD
	 ZbHE+TMGmAYQA4mqry7diWuk2Sf2QRxaHHvA6B7b2ct3xsC3nsd+ds38WzifVw9BoGx27
	 utqpfnHyIbDG6A+JtGhgwrw09mqz++iLXSXYvilbbAmOeiGbUBnNuG6GBX3k2UH/TqOng
	 ySmIksuWfhrPBrJbZjmKN5kpPtwzN8iu0HVQ/RETe5weFJSDPsC5ElJ0oZvnZ4UNnHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG7PlDNf;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E960A2608
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 21:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04E960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG7PlDNf
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so2405736c88.0
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259599; x=1794864399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQqydnWRoSGt2ahvObnzZZPU4tywkZQM18aaUe/DYek=;
        b=pG7PlDNf/Zvt2sa85ke4K57XJQ/yyBxVpe7Ofv2AlSKbc7PZO/kiL6FNWJrv5QdJrg
         lSxE//mvtyYJ/kzQrTLNF9y5mu1hcGKcTGV8FMz9OcFEYtCbWV2OtZxyDWmYZqP0yJ/T
         E194IQPoqnsBjWODZrydOB7wjr/Kkp18QiRoea3ZqZkHD8GpHJra4nhyf/xcaKL8gxNA
         LOnjdqU6JekscEoIvToG4L5dZBnRNPHZFriq6OjNDVz1QbjOZXWvPtNnFewv6oPdLUwC
         trOTFmMe2+g274LAYUyq+0/LmDULXStFFWwS2LpC6xlzKZAvqrTvn1nlup1LPVjNSIXm
         r58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259599; x=1794864399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQqydnWRoSGt2ahvObnzZZPU4tywkZQM18aaUe/DYek=;
        b=nh+t2PqFP7WpnURA5wH4mgIjjuUbebae00Bq/Cs/UR9H65j4SxtAgZeUAHPdgIKZiO
         vJ5A3MRyE7jBZAoVH0CGTbtjWdpp1a9DhkP6/+XZhO+lBhPouTwytIE53SVLJ3TOdzVO
         z4KtuESlUABnZBUUJol2Q6MqPFjXzicMh64CZwd4/0Se//myW1SXZ+ypM/sO5YhVSpVc
         rjcVkc/m9Fj//Pgs89v9e78tdps8l9Av62HXIeAsaIIPRLmB61AFotexnGuivdL1i/lV
         8/R290kr+kBdrf5ie0ZxzOHJRgPVwmhDYNqIBg+7wn3p5HcnjeA95E/wJzkx4mQZ7Xc1
         ZaBw==
X-Forwarded-Encrypted: i=1; AL+hErHf9adOOtSGctiNlO0hCcZ6PcP/aDvwhV0iYWiDwLQkBm1K89dTyVTLh7CdqT8mf0k6SsxVzpfpTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9GrSD9ab4ER+zoys9EaxPqJlnlKf+rbdCElcqjIH8FJrQdHPik
	vYe8SfFR06C+SltAMpRE/kBMXdWh1QQoiivRmBr476rHvwExm7i9eUwN
X-Gm-Gg: AYBFou25egg40j8IpejpNvf59/m3beWY+hVKO8jFEqFQY66Okq9LL5TmRR/hu0tnYJr
	a8mD3jZ44H4melN9Zu7RCpMTrunDMLy7SwDTQWJvVuD4JV16oWv0M72o90BdRhiSl425fZUr8WU
	qq0txGiR/AODTEkzkMXzZoK4sXhrth9Q2m9qLRbweuOdPVKpWQ23boLz7F0LW05/hLPTvsMxol3
	ytrCdrRINCHWVOpQ2FNRPFPj/Dt/7JRhYcJ9Y1H63Li7v6Ea3Uop2ajzGiJ1dJKH6ZrNtl/Dw6C
	f0ey/o3hZONYOFdGYHHYoQpxaQ77dyxQ7vnhluMDSrIYW0eWQ+o0DUqSo0Ibv1Len1eqSUxUJy2
	UffokOdOOsQ1pOmDfr/HiCjO/A1I6c8zkGjBr3qSE5BSey3tMy2FC9ve6MYC0mvKtMXdPevMxs0
	nwRXM0ogYDnJrxoo+0ASFSYWyTA147x77UC73BNbUGEF7/E4ai3qNOK1vhWtFIeRbmL8v5e8hkC
	e+MZ6Piu8DK19jFDTSXWxg2e5/23y4/WmgtdtnAMiCk7IP0wnnqOBwiVbJi/x8LFp56DoKJ/Rgn
	flv0WjoyYHtya6hHB++VaxLnqBh/9vuZHF1cxzWe1D7/k9UjAw==
X-Received: by 2002:a05:7022:4388:b0:151:2e62:fe4b with SMTP id a92af1059eb24-1b3b5ff2595mr1169686c88.23.1794259598485;
        Mon, 09 Nov 2026 13:26:38 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm1882794c88.3.2026.11.09.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:37 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform: cznic: avoid slab-out-of-bounds write on short Turris key reads
Date: Tue, 10 Nov 2026 06:26:31 +0900
Message-ID: <20261109212632.2437881-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
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

For 0 < buflen <= PAGE_SIZE, keyctl_read_key() allocates a temporary
kernel buffer of size buflen via kvmalloc() and passes it to the key
type's .read() callback. Only after the callback returns does it check
whether the returned required length exceeds buflen.

turris_signing_key_read() clamps buflen when it exceeds
subtype->public_key_size, but ignores the clamped value and
unconditionally passes subtype->public_key_size (33 or 67 bytes) to
memcpy(). As a result, calling KEYCTL_READ with a smaller non-zero
buffer (e.g., buflen=1) writes past the end of the temporary buffer,
triggering a kernel heap slab-out-of-bounds write.

Per the key_type .read() contract, only copy the public key when the
supplied buffer is large enough to hold it, and always return the
required size.

Fixes: 0b28b7080ef5 ("platform: cznic: Add keyctl helpers for Turris platform")
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 drivers/platform/cznic/turris-signing-key.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/cznic/turris-signing-key.c b/drivers/platform/cznic/turris-signing-key.c
index 3827178565e2..af414e236de2 100644
--- a/drivers/platform/cznic/turris-signing-key.c
+++ b/drivers/platform/cznic/turris-signing-key.c
@@ -46,12 +46,8 @@ static long turris_signing_key_read(const struct key *key, char *buffer, size_t
 	if (!subtype)
 		return -EIO;
 
-	if (buffer) {
-		if (buflen > subtype->public_key_size)
-			buflen = subtype->public_key_size;
-
+	if (buffer && buflen >= subtype->public_key_size)
 		memcpy(buffer, subtype->get_public_key(key), subtype->public_key_size);
-	}
 
 	return subtype->public_key_size;
 }
-- 
2.43.0
