Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111E4D09EC
	for <keyrings@vger.kernel.org>; Thu, 15 Oct 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062531; cv=none; b=YYwQi2V5Iu/bSNHH3q+F3CW96t/rveiaHlt0dbGEhMJPoDUqEcUhBEeeMCPXRlDBg/jRIwiyYWlgrE003jmpDMW775Y7+BPRhrFa5c88fATuXkRUGSgaedUy+k+B4P/uzpevJzhxIV6KYf52xnFWajfnW9ubnOQvHntHA1CkBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062531; c=relaxed/simple;
	bh=XJoINwSigmUSFf2dqnHMxDsKhNmQqPxs6uqpqIC4U0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lONEwj5c5sDhpMkRMqwK5eNvjkk9VCzOOhfXHsGPmAP/JHOTdpCsQZlQWw0bPLBsNx5Lj2AOg1II0SannsMyqbwXPDsWm9uT7p7bNiybTqn+8uSFuek4tQq109aiBoZs51mBmAAFBFbhMuq90WIdQcjiUhv4lEMdzhuBZKOxFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqLN95jQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqLN95jQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49ff680331aso21478565e9.3
        for <keyrings@vger.kernel.org>; Thu, 15 Oct 2026 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062528; x=1792667328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JPj12lyap6keUb37p7J+0g+WrRr2s4sx+gWyL/wnu4=;
        b=AqLN95jQ2XnT1cnMrhbgB31/aOeLpWWnkN5wz47YsEHwiCSjtYuLHth/cOHOFn4QeX
         lapuJImuXnrm5GPGgHBq4FM6+yEszMmAgl9ugJb0pO21FnnwTcsp2CsnJOy92KGPUQFl
         WZxBjn6BiGVztt+RZBn/9YxHvABezUB4VcOkoKDVxzqIDonaEzJ170n1xsu84xftiO/r
         KcReyDQDnhFcHiHd3SvUcjluF3MaTW4jHYiNOc0PKvstzBAlquj0JVJXO8Dv6tZWp1PJ
         JIXOFVF0ZBv13SCRl7sDeUQSk/Hua/QyZgO8R7Urangz0ngDx0E1cnMUK4lr5myQkUHx
         W8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062528; x=1792667328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JPj12lyap6keUb37p7J+0g+WrRr2s4sx+gWyL/wnu4=;
        b=jy7Rne101/g90MorISwFk6/ROXwLyUV/WoWXQhlRcmBJlhcCM26scW+0ksZfhoi/EP
         DjQZx8AUuDaZ/kiMx8Ys04kcp9SjxV2NM0btd5jnS6XbbZRDCM+SJrp31rjmv9F/hacJ
         Y96uQx/Zt2W9cUlg0PbgfDRIp7kRAVVFAUqeW4RH8aEoBWI4JIvvsImzxpRh8a2ANnlv
         pGwltqAMEppRunTk27QgQY0vZk2bRJHYYHoFIR4bvJ1jY2RJ0Jq4Urum+9HzPqYhTFNo
         5/PwyjPS8oxjSFh3xztYHqGdBl3dU/sKwYIF3OyOkb8C1HwIuOn+9XN54Fofg+n+9O9v
         j+Cg==
X-Gm-Message-State: AFq9FYJdFfodgd1MrE1aHj8AiPrm9Kuaat3n7QqT+HuqJsxwvs4w/YUZ
	rtQMLO84F1hbb3En3/SageucgwAu/pWey9Xsd1gyo+vwvhebRrkcHZib
X-Gm-Gg: AYBFou1SnkGd3aQvPe3uiOfBClPMhm96TI8w49h2j8bD+83T0IKJgnjcEcl/lUJUcN+
	uv1usC9QDjeICvge9A0Xw28X5BtKqGh12weNAwSlAZzMzZ5HrEybYCwaVSgp7K2lZrYJ+J70h06
	60PcYq+/YEBm8WSfTAUY79Ys3YKSI+1Julu8T083A9Ez4w/4eMcgpQ+R/wG9yzu7a/llJG3MMr/
	z3SmBwi4KHlRRz+bPxz9m22Egi1S9CpIKWENhdWEn+Q2BOCvlt5CvSHj1NiqyiwaCcf4gkcp7Ar
	pQ/ITz7yVgi/VCf3q71jvivA1TDjcdA1n8zUKZXEEteSVE1/BJvJ/ewZnLjKtCloKJKGFmwXHJL
	wBA6nos0WFPQPVDhP/5lSWd8CWYkYNe9diM23ysAhSxxrKiNuseBrPEcGPhJ4Zvlh7rAyWHIx5R
	/ulbThgpmwzIaBbNdby6qTBKLZcC+8PLTlgh8nXVQI3tt/LIP9oz3stfU0FhOmYefNGZI/ai9c
X-Received: by 2002:a05:600c:699b:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a18e4af334mr397244145e9.33.1792062528000;
        Thu, 15 Oct 2026 04:08:48 -0700 (PDT)
Received: from fedora ([2a02:4540:a7:16c0:b518:4b00:679:375])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd99e87csm62639105e9.13.2026.10.15.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:08:47 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH] crypto: pkcs7: Return no-digest for data-taking algorithms
Date: Thu, 15 Oct 2026 14:38:26 +0330
Message-ID: <20261015110826.126621-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
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

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21..7939b08b603 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -147,14 +147,15 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 	if (sinfo == NULL || sinfo->next != NULL)
 		return -EBADMSG;
 
+	if (sinfo->sig->algo_takes_data) {
+		pr_notice_once("%s: No digest for data-taking algorithm\n",
+			       __func__);
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

