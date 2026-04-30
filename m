Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AE2848BA
	for <keyrings@vger.kernel.org>; Thu, 30 Apr 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570664; cv=none; b=b2zYcEsyPKzCwkaRtbxUufxkto8/IjfcodkZUtQNjig6dMp/pLa+MmQigbBnxWT6dxBgpwLn9XXVp63ZrQTrIruYnE8OvnElhjeI8y8AFx7D3wpyXMPywmm7yNQGfRP6pMur9mIrs7xHEihtGUz0REGQhfDDPkXIxUwe867EjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570664; c=relaxed/simple;
	bh=g+RA+/B9ogh5Lr5VFnWAfVAqAy9aljo+8QIRWQwcF9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKWbhbhDdsPjAGrXXVw3uAudnKDGjwce2p3N7o/Zs+ILK4Q40mh5jPnjlzHaEMB4ivav271Or7gzDWh8nKDwJQ1hWdx52YBfKm2Px5s7b2FKyKJ/YvkpaAHBuOYib4AD65jzhb0nydXQ3t90dZMRVcYU1YuADSgfCs/w80oCZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaPCe/gM; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaPCe/gM"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12ddbe104ccso1303469c88.0
        for <keyrings@vger.kernel.org>; Thu, 30 Apr 2026 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777570663; x=1778175463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWw6wa3QL95dIfuoX0OrurEDxczvWFjJooGa8i+ckkQ=;
        b=aaPCe/gMAyeM2vWCwWN4RPacWpHlSwl9FCJMFRNMLx8u6VRnLPBjIkmdsIONHDdz3Z
         cQLC3Z2mcsb/0sYA6Ao5SaMIpP533PHBF43uO/d7xZjeGMKk7DbGxufv6sQgDS5+KfpI
         2zzyz4709e4NBJxJocBFaF2pvy4dIRce1TpT5VpQg3cy6lyhO+ZdPPnglflKxHfY+WM1
         H1W0d7/xp66QUg9nBrsAdwg9FXOg84cjh7Ryw4L/3dhrUBR0ffTpaATFoPWD/clzQZHV
         yFaH2cKOHnfpNzdWXOzjBin73ZiqWklnSpsJXTPkzIIGtzxjZtcWcDdsf8c0pYzW5r+7
         cOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777570663; x=1778175463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWw6wa3QL95dIfuoX0OrurEDxczvWFjJooGa8i+ckkQ=;
        b=Q2TEptuP2s9vpAhiSFWHXBrcNQB0iUFN68ng7jICw8uNp967aZoUB/O4z/8kxzJubF
         Qku9gI3xuE1U1vxA7adPViNXr8BtFSSgOZXP3OqgMFll78NAptEKv7FxrNH6EuXjXIss
         U9Cq0UdgXUUDmM5NswKAFeXMNOulbDTfBpl3xriEEdDSqaT6tKNmosgzIQdIEgRAujCn
         ++H/s1gB/a1l2xkbzvWQJdaZIV8HMZ0pXXTI1eU9pCZ8PE+wLY9beRM/WAos2B3ZrqjI
         BO9Wag7Cegzp2uRG2OJFW3uFe/GuD3lxv7yxOqAgqXa6W+Oo4BH+OZbfH2NRyUaFjn5J
         rhfw==
X-Forwarded-Encrypted: i=1; AFNElJ8xLKJzgId16JsIiFhP4zgwiZG9jB+4TtIJWJrPFRKYegm4Gd/U8s4I4tmCvLW1GCBRrAWzAC7bRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK00zJ0DgwNCDrpOM30XOnX+mVZOFxzgMpbyD+QGh+SHjZf9OR
	5iut+hvvjrL2h8HXjSF5ndnNB6IUJ/D2I/Le0NqXDd062N86UrqiyGyQ
X-Gm-Gg: AeBDievXBTgNMwDhkvBn97fGhJeDwGs9lOO54X45gzpRylDdiLVrb7V4TNJVI/u6b0o
	wY90ByC+o6yNumZ/3H67e/BF6bzVIfaq1i3TCQqJBhfBVut89NdKE2ZnKw7oNSDuR1eFY4gqMMI
	a/n8IokqmFzPiSqliHJeFwDOL8U3qukjwoArlcfhcmd2G8ZYq6PGFqA1MEwDzaE4paNLuQ0QufE
	QTp9VonSn+xVAroj69n6/Lm5gBye2N6Zs2M8Vrz+u7QClVs5pebpPWYRm1Non09/GTDMwpNGBIx
	i2H8pGEYYbDMAhFQwhAx8TkESPdWTqQiyignLW1ivq0nA4hjsMO0x3JI7zqKIABdGwMmGSn2cYf
	Hrija67NKlC7cbkH2RYXpvr8QIPj8b2zx09EMt07WAHfpFiXy/nUBORzIubukInB54Bjr0iPWyN
	dUNIviGpEtnP9B4OWp0JK9wUNWreyNbg8zj77/+gU0QjcVit+8dL5LqKrCm6IjWB7pA6dvW8SQv
	RahQz5L7IW4x3ZnabRi
X-Received: by 2002:a05:7022:43:b0:12d:de3f:d853 with SMTP id a92af1059eb24-12dead675c2mr1724005c88.44.1777570662331;
        Thu, 30 Apr 2026 10:37:42 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71ccesm1044942eec.10.2026.04.30.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:37:41 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Kees Cook <kees@kernel.org>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] crypto: fix OOB read in pefile_digest_pe_contents
Date: Thu, 30 Apr 2026 10:36:34 -0700
Message-ID: <20260430173632.277436-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pefile_digest_pe_contents() computes the trailing-data hash length as
pelen - (hashed_bytes + certs_size). A crafted PE can make the addition
exceed pelen, causing the unsigned subtraction to underflow to ~4 GiB.
This is passed to crypto_shash_update() which reads out of bounds and
panics on unmapped vmalloc guard pages.

 BUG: unable to handle page fault for address: ffffc900038d8000
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 RIP: 0010:sha256_blocks_generic (lib/crypto/sha256.c:152)
 Call Trace:
  <TASK>
  __sha256_update (lib/crypto/sha256.c:208)
  crypto_sha256_update (crypto/sha256.c:142)
  verify_pefile_signature (crypto/asymmetric_keys/verify_pefile.c:436)
  kexec_kernel_verify_pe_sig (kernel/kexec_file.c:151)
  __do_sys_kexec_file_load (kernel/kexec_file.c:406)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Validate that the addition does not overflow and the result does not
exceed pelen before the subtraction. Return -ELIBBAD on failure.

Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKCS#7 data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 1f3b227ba7f2..cec99db14129 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -305,6 +305,8 @@ static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
 
 	if (pelen > hashed_bytes) {
 		tmp = hashed_bytes + ctx->certs_size;
+		if (tmp <= hashed_bytes || pelen < tmp)
+			return -ELIBBAD;
 		ret = crypto_shash_update(desc,
 					  pebuf + hashed_bytes,
 					  pelen - tmp);
-- 
2.43.0

