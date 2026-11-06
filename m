Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995475;
	b=wDy1tvVH7KdXm6YC2MGXuOWyIa3JABCeTG19DBah4raJ5m5GrA1Y4us8A6UY6z9BQL68
	 lQOdFVMjz1wmV5FaCgOXH7vZ+HKv0IEJmMicr8WpfGCk/TwbLk/KNIHqPeJEtmxpXEIcw
	 woaTRTT9kqDTpofpQyj4YXCSei7K3xOC776kthE17k7PISO5a3OcQTUg5OCQmDedocGzE
	 BHdmbcyEht5KTyGdQz4ewdogeR+I/BH96eTdlTWw93gAZaQVIYLwPg3Wmym5+E1WAf5r/
	 26y0C5DeMVjCQsIyMZI6pEDRO2e3cCY+4u3PEZj8OJ2nk+tjCFcc7Jb8CHvArSs+svA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
	b=FeMl/nS9GqQURHXinuJyrCUMwQc4SpNGkZ0iMVggYILfAaJwveFk6eDJVWn5tObc4BeI
	 Rpx7aASIvphHJD7RLac9u3kpmVmGvS4mCqDF7SjKyUny9Vm9yqVt2xeYfEcBD12J0vi+p
	 Hau6ZB/kjOdTF0K1/9t4tvFGa9Mvc4LFi4l4Q47o5citzzPDVI0PnFxDg0HnccFiHxB9D
	 md839lbfAk8tEuUUZ8mfvgHmMFQqHmwT1QVLqmtKAKa4BwWHChyJyKCW9dV0n+t4ChYgG
	 hXQLbJa9MWHmx3nWdlYN29RNQb/rKYms7jNwafdaBhTzlm8xKsauuZIBD12fZro4RaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EaSKAHq;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF3606A32D
	for <keyrings@vger.kernel.org>; Fri,  6 Nov 2026 20:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAF3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EaSKAHq
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so8170275e9.0
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995473; x=1794600273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
        b=0EaSKAHqfT6MH8ZkinKIWE9zvrSc79drozCAYUhfgwN1m4IXV5z8n7RslTiGPtjbks
         8vK9vNKjmpB2vCiu82GrSYnB7PriyUI9woE+kdH/u1SeQ6RDamBgmFLd3Q3y6RWgAYpL
         gmxNBdiPLUIC9Iq9auW8I24skXfVqMt1s8SVEl5yAEoY0A/eN2BAwW7kWLtmS4SMKYau
         6RTbon4zvOqZi9yMA+4XmSKUmzQReJL1OAEaiOteb/X1HYQoOIwIMqUPcm1S8w/mM2SU
         tMZhlgkHK0CHkJKjkLF+F+7KNVaEUCCaTOShURJCGPeygCU6Z11sKRGrVyg+Xz7e3+Ob
         yz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995473; x=1794600273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdzzuDHKyfn9MEDqIa+4Jje9jOJuwPCdKzFPnU5vUZU=;
        b=AFrjEUxgUfAdA7YjE9+3kpTG79mEpaCnPG23FoD3lY/TKTrG2JJJjFmHxEF7t+MfGZ
         Tx5Bxku9batFT7SWnGVP4jtzL2HPBQDWhR0rE+hdzmnE0IxYP1bjeyUzmNcqzt05eE0K
         rnh752dpeo5cVhw69zKnP1SoNTybvn5lfyiZ3BwZEaCGuNL6eSB82r16nEQ2Bz+aQXA0
         MVW8dqzmuWAKG5jSTf50TU6gyeux0/mu4i0QhEZC9uTRzWvsSfgK/qbao2hirDK+BVi/
         u1PP32fpz+uK/Op17mPhwFlQSIP4Dqb9sZKC6xdj2IqMfldc0l2ReelZAi7h6AgRBVsS
         yMpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDKkA33z5ZzclnvpoVAs/3rXQpM7tdlVaEzYrHw13Wy520SXCIx6zKFoSIsVWByN6cyvZmXUfMiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9b9MmxeYuzFT7GUhGjdRa8BLBrAL9M+YHrwFAaXlWHaNub3IA0
	/JZex/SFDSJzYC8ZYt9J15efDrFFCHhk/n/ie2ibuoc/utlXD1YND4IG
X-Gm-Gg: AYBFou1xEKPevuHtSkt4iEnXZONLga7k4nVuTmlZ4IaytgO4ckCvJK2C6yocHxmySjU
	kj7kpIEt7ZC4bq/GiFddKhLIpXvSmeNtRWIFRO1bDTIbZY7D7Vpm6MsdeQlz1hvY0FuF8DITTtz
	GQZydlGjFSK/q2rj/u9rxVjInmxCe5/OXsJ0ygAS15cJpch11TgoV0Pn+089QoBIGxCrO+CJ1uA
	8tJT8pQy+41dZJBPhq2Dz/ANGek4KCM8Ej5FBKjwF+t/8glhE+Ue4EsS0P8sdoBwAouSrU7nZgO
	brjY1Ur+6aLQpHMQ11D2/ud03tdhKo3DH7EdksBGK9WIe4KiQ20LlqyuMoJRuLexD1V4XarbULr
	yYEPZGq7oLs4QLVzCpCDuRFVULfPUwonMVIOnfz4/nSPWPt8fwlpQwXKEjjToJCtmtrSL0pLQXu
	U/TCel4USdQWIo1FPByDlqO2Bqwoc5QotKAPIw2coasszbT8yKn4upIBXCgu3Vg6ORDA0YYDv6D
	/QDFolndI4sHUghN58uCEgYR9ji/tkVsoNqVwVpk1uzzWDqH+GOfmLJLd2AUVJoZDw7Z+yW7FBO
	5P/Ea1/pIQfs1gfC+Fqnb/81/jy63uChEQqOhA==
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4b6db1c5f48mr71249715e9.4.1793995472786;
        Fri, 06 Nov 2026 12:04:32 -0800 (PST)
Received: from fedora.domain.name ([217.218.152.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbdb9cdsm16959195e9.1.2026.11.06.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:04:32 -0800 (PST)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: ampr.mhd@gmail.com
Cc: dhowells@redhat.com,
	lukas@wunner.de,
	ignat@cloudflare.com,
	herbert@gondor.apana.org.au,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] pkcs7: Return -EOPNOTSUPP for data-taking algorithms in pkcs7_get_digest()
Date: Fri,  6 Nov 2026 23:33:56 +0330
Message-ID: <20261106200423.37769-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
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

pkcs7_get_digest() is documented to return a digest for IMA to use
when verifying a modsig.  For signature algorithms where the public
key algorithm consumes the raw data rather than a precomputed hash
(algo_takes_data, currently ML-DSA), pkcs7_digest() does not produce
an intermediate digest.

When such a signature has no authenticated attributes, sig->m points
at the raw data and m_free is false, so the existing check rejects it.
But when the signature does have authenticated attributes, sig->m is
an allocated buffer containing a modified copy of the AuthAttrs and
m_free is true.  The existing check therefore returns that buffer to
the caller as if it were a digest.

Test for algo_takes_data directly and report that no digest is
available, before attempting to call pkcs7_digest().  This covers
both ML-DSA cases consistently and removes the now-dead m_free check.

The only in-tree caller, ima_collect_modsig(), does not check the
return value of pkcs7_get_digest(); for a data-taking algorithm it
will now leave the digest fields unset and fall through with no
digest, which is the correct outcome for an algorithm that does not
produce an intermediate digest.  Callers that do care can detect the
new -EOPNOTSUPP return.

Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digestion it wants itself")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
v2:
 - Add algorithm name to the pr_notice_once() message (Ignat)
 - Add Fixes: and Cc: stable tags (Ignat)

 crypto/asymmetric_keys/pkcs7_verify.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21b..c2e0eda502e2 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -147,14 +147,15 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 	if (sinfo == NULL || sinfo->next != NULL)
 		return -EBADMSG;
 
+	if (sinfo->sig->algo_takes_data) {
+		pr_notice_once("%s: No digest for data-taking algorithm (%s)\n",
+			       __func__, sinfo->sig->pkey_algo);
+		return -EOPNOTSUPP;
+	}
+
 	ret = pkcs7_digest(pkcs7, sinfo);
 	if (ret)
 		return ret;
-	if (!sinfo->sig->m_free) {
-		pr_notice_once("%s: No digest available\n", __func__);
-		return -EINVAL; /* TODO: MLDSA doesn't necessarily calculate an
-				 * intermediate digest. */
-	}
 
 	*buf = sinfo->sig->m;
 	*len = sinfo->sig->m_size;
-- 
2.55.0

