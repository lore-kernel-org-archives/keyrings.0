Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D637AA63
	for <keyrings@vger.kernel.org>; Fri, 22 May 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452444; cv=none; b=rEPYLmansKfrk1RL4KDkR/ki4HqAw37IPwvj00GpJTRqigANlWRjlK1DUKI3QpDTmyaTfrH0GSvDvPs60Mz7Lldl6d73vHAOr069zabhkj7qtrX/uJjMZygbr7vfPvkj9QT1mevclcRcnEO7aNT9FfBkc4ZG+jdvhx58QVnfCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452444; c=relaxed/simple;
	bh=bhfJYktqcLA186BQdpKCnz/FDnquz083vYJ7/H9ksvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUZdGHY4cq5tkt4KZfE4ZV2NDdxcsdFT3i/gczt/ileR+hlpQmmyk1LXHpLpFCuH2XY86mfaPdGxBpo+lYPHX9xxe7NtXoFUOYxCoVHuuuJUzTp4zmVaSOycSMObdu1BYNcIfvgIvGLlvYh+aqZbk+p7maFZT+yRL+H21EkF8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmY0gZbX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmY0gZbX"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b7105dfb35so93631116d6.3
        for <keyrings@vger.kernel.org>; Fri, 22 May 2026 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779452442; x=1780057242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMmEkAgbAbL0bknXE6VKXd/SNfsxV03AylxbVaw6hzs=;
        b=nmY0gZbXwgS54EoPEXgYVuBKpYHH6io3n5ehwg78xbZhHaK38dOB+Telxxx45Jp61X
         GGZcKzR414JW1sZAQg8+hXmbyeXSFSwHy4XMXwH/mgHvOYuNWc1enuyP/voeR4nRiLOu
         uGbNfZA7uLya1U3P55tAVoACav6qc9YSgtX655yA1BAx882fBQ7XSrvjveGChsPOIrO/
         d29pPkwrNOUhDdRp8iGHn7CXgRyZnNDi/Ob+K2YrMYjmIWL9+zhdQAUxmk5CJaU2G3DI
         FlValHSurbv0C71Z7jtpwRK+c1/3wlRfiBQ8JZULCT+nvX6OTidV6RzWtdNRI7mCRYzG
         +ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779452442; x=1780057242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMmEkAgbAbL0bknXE6VKXd/SNfsxV03AylxbVaw6hzs=;
        b=KU0mztaHbNkSHvpd0jt2R9WZir2PKG/UWSkkZC7LJIoHFIzYvsXFnupL4rqaUWb38m
         cjKtT9emqnSBL56AOFTgZnL38MZGj/Q8MeHH+0Ijc9KkeP5+q+KxDdteIswq31zdSm7/
         P5O7T7Z59FqSLaHgodsJEQLmQLh2vtKGe4rlS9k0Q0y/A46dgPTai6NpiTIdrKfx5zNE
         lU2lWrJq4i/Rw1J6I8MAd5OUV2nnDf75lTlb2YDCWyadloK+hIy6E0WmocCo4yBvlTls
         nRsd8CthqmzS7RB1N47Y3hT1Z0ayvbz9fGKgi3IwMxYLTj/F9ILb8EP2V6rSkmRCI47h
         p3Dw==
X-Forwarded-Encrypted: i=1; AFNElJ/gSz2nG5iBvDr2AtqJ85SQE6X2hmNLtJ1FMOC44jf6NCIEblHzHDS/IuR5T1uNcgthVSe5GFXe7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfPkpupQeRQxItH9B2jSK75wmG/gcbqa12mYgHDtOasVdehT0
	EduaQvYbGlpmNr87O89D0z7RCrsEIS/RGEu6v8Afa825J4j2Cl84gVT/
X-Gm-Gg: Acq92OEaDMpb6ekdEQZjOC+ItjvVMrwtGHJB4rT56SOhNk5ttVJtqcq0zHleu9zbm+a
	vCwLhiZXixj3VOMcX8UZqP4fVUX+I75I4BSMnF7Av2ptn8ZcwV0dIxAH32Uk3XHyLOL10EZIJXp
	7QaCKQMDemW7IkB5dzPFEknCP8/UCadZnzHCMhpXSidSrr9wAmt6i+Nt3IiT+59XUdio7hbIYzD
	+XdzilxtegmDDv6KoSrKRrXQzIQ1Don+ajV1Fk05p2Ma4HzD2EGZKb79VwpgKAXCC32fsiLmeM6
	O0UZw+Vv1JnIXnIYiKJKnCYrec7aWVg8Ul9qn35yMEApIdzTyvKi0Qhonyp3RtMv4tc7gH+nxvL
	nHolSl5E1Bl3rPs9YiA/6T55PxgkYkE6nUh0SRDcrZt3jXTT7Wu6uRjTjAaFLmOMzR/ZdT6EmQp
	lUfG/zMBKtAmdrP8lyJh3JSWinoqfvP9mTNrp9NxeGtULDPb/WGafi9aW9S2yx7lIbET2eufLm7
	ruy3zFIE5MtNEdjt2m9
X-Received: by 2002:ad4:5d4c:0:b0:8a4:8b2c:428f with SMTP id 6a1803df08f44-8cc7b53d77amr58734616d6.2.1779452441618;
        Fri, 22 May 2026 05:20:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcec8esm16656626d6.7.2026.05.22.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:20:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: asymmetric_keys: validate PE section bounds before hashing
Date: Fri, 22 May 2026 08:20:25 -0400
Message-ID: <20260522122025.250646-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

pefile_digest_pe_contents() hashes each PE section using PointerToRawData
and SizeOfRawData from the section table. These fields are parsed from the
input image, but the per-section hashing path does not check that the
resulting range lies inside the supplied PE buffer before passing it to
crypto_shash_update().

A malformed image passed to kexec_file_load() can therefore make signature
verification read past the end of the PE buffer. Return -ELIBBAD for
out-of-range section data and guard hashed_bytes against unsigned wrap
before it is used by the trailing-data calculation.

Link: https://lore.kernel.org/keyrings/20260430173632.277436-3-bestswngs@gmail.com/
Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKCS#7 data")
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 1f3b227ba7f22..1405b76322cbd 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -292,6 +292,15 @@ static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
 		i = canon[loop];
 		if (ctx->secs[i].raw_data_size == 0)
 			continue;
+		if (ctx->secs[i].data_addr > pelen ||
+		    ctx->secs[i].raw_data_size > pelen - ctx->secs[i].data_addr) {
+			kfree(canon);
+			return -ELIBBAD;
+		}
+		if (ctx->secs[i].raw_data_size > UINT_MAX - hashed_bytes) {
+			kfree(canon);
+			return -ELIBBAD;
+		}
 		ret = crypto_shash_update(desc,
 					  pebuf + ctx->secs[i].data_addr,
 					  ctx->secs[i].raw_data_size);
-- 
2.53.0

