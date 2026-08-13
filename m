Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17E376BC1
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645593; cv=none; b=bGbVnY8uWCt1qC6GICds/+3eMd3pL3YFeLtfHvz/SRjHZ0fP3k/hwziG8hG2xjwR3C0nreQ5qL/E4depPIq6/hTKX8aHYVxgzFQwIN6PWHnZP+SyWQh8fT6bTijPDV1W5DUScK7wmJR+d9bhR8RQhMmXcEImXQQ13X/RJqRmYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645593; c=relaxed/simple;
	bh=qNr87o6e0Bb7wX22ASvFdidNIJuY9lsUYCsNJOlzTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rzy4TMNt4MWSkneG6oTwKRdOL/jlkytAPDzGKy8fUrjnKAKjcIuIaI9cOsXqPC9pEMdZsQm6VbfBZAjzavIxrtEUfup/0M9hofXhznHI2HjAPH8aqZjHLlu6j+jfBX3u7TKP++CKRjhJTruW48ekHHC+04CsT2nfkXB8BaxsX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ddd1oDHf; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ddd1oDHf"
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B232B3FBFD
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786645587;
	bh=qCW1V67Ahu0HN7EbgMsfgf+m2evOSojVUf49w/6VGa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ddd1oDHfGwcOo5EHu8r1kSY5fl1nBvaT6vZL+fSNJo1Pw6cz5qMXrxQZJpkWl+wDu
	 /WqwjNFipMGVghfYQ381WkojYeY9pOBWTGybUZqxahDnjmLTHRjTcMXh1DIRbgkzDu
	 FWzlV4JX3ZLzFdrfn7WEIN7jBsDg9T8DoZ5NVfMmzi7tUUf/KNLe9FIN1+daxumwe5
	 Dsj957jMuO0CHsL7FqQNZ9WcFmG7tTDjVNvmVjk9JPg0wcO8vsB5LwH9ho/1JESI9H
	 +B2gnzx0bKkvG+INlBwA+8r/RCSDVGw3fMwJ/5G3uD3U07axp7BSK4GS8elm5oekf8
	 lPcJ9ci+QB/DfsUVzxQsY3hvqd5581kZhy5EGPA+Mi6KgNO2JgimpMVR7MQKkBTfIw
	 M/4Cxs8errL7OB2zisObeXDJ8UYR++oCnEeQahB/rEmqfTT7XXEECYNmbrEfDZf5Ul
	 S6ASArJkNk7DBvvPhy3iTgCiRawlEptyx8avPRKH6QJIB9rpZGtuDVzaFuHm+9uKEj
	 8Vx8EKV5DI6LGFtWNbQNP+FK4l7B8h3cuf3n0DG8jCxdGTXMUDdSYzwPaQaRXceK4H
	 p+i6KvDA+tYLS/uL9pHLacfbD7L29IGXvh2ItERiMg4yHikZHzkFryEjW6qK9j2rs+
	 c6SoeMujcZlURBwapQx3UFCc=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472c330e555so53194f8f.1
        for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 11:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645587; x=1787250387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCW1V67Ahu0HN7EbgMsfgf+m2evOSojVUf49w/6VGa0=;
        b=UEf828KnwwpJqfd8aghasckpo2N3DorSJMiYcAD4GrDorCTs0314LyCdywSJawlTsM
         6gEfnFQ2MGMyCbi8wS3nF7xMQN1mEuOjMwBplKEgSCBVDZZARGEFcL9RsEUL/EnnuRJ1
         ybw4dr2BmPqqrA9AZSvwVVIG9mKOqam+xM3BUb3HdsWTe6Q5UD7gX4HwZFptpvls24Sa
         cFDSXFfDrNj96HkEa6ayOvepb6VgrRXPV2Bd71dhsqdLWxMq17yMr6fCafk5EGSmfHWp
         W/wtnOtz/NDKURqEUUdWHDzlBk1UiMeGcpMFlidHIDnvhKCBrGbY4K/sJxNqf+8IJb78
         L19g==
X-Forwarded-Encrypted: i=1; AHgh+RqELnDkK3TvKaJMB7pUXLpx3GFcfTW1G7T63GHCdHCObj032l8wcH8EAWH3nNbkkATNKpGMleVkQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyppvJvL7G2Q2OVxeyuJkX0KKhdVg/7/Qkd6zrBsyzMRr6Nm3+C
	qtO38vBG2wdp31wdV8OAO0zbTFVCyrsXjXpUOZsTk5dUs41Dex5BprNxvDP/JnIvUoeu7+bjqPJ
	yJLykUmPlU3mEpXtcI6AkuQdFBpmVkqLJrTaL7Nbamgdago1mX36FmMDs5992GyDr5yx23cInCb
	pd
X-Gm-Gg: AR+sD13xHF0cFgeCB+jxS1nBhE7O6Teif08llOo0PezMe3QXGRvrTnm0rk8flecmyU4
	6NgPlAnF6/ki9PVqEcr1+IYM8eS0ugzJoeucu2jh71JFL6Lc57ZalnxBL2TB2OGgzcvpKDYyVd7
	9L+zndX770uZBTlLaduyIaGCeZGsNtwR2F0ZzA9CHLIeJVz3qud+VHMseSjcE8Jb4Li7qvqFl33
	297JqKrSM+GBMOfj6A5JvitE/nH20wo8d2RA4pd+noJTjfHHb9L6DAxcD222QJ9/HFJgsF1gJdA
	n2Xo2j4QInCakUHHDndtgIEHqKSIfkJitgr4L5xLNhRh/Ywr9cYCH8ynwQNz3wC+1AiDMc9VhBJ
	Xc7JqZcvYVUEtyJgmijFFL2gRJuxBSY8cwh0W12iGthH19hNIFhnDJMsAYihSiMz9EjYm1PbjBv
	tv5CoGMD9dLJRlpQixU9nj+yJ7
X-Received: by 2002:a05:6000:460c:b0:47f:e886:6dff with SMTP id ffacd0b85a97d-481606f67e3mr361531f8f.4.1786645587203;
        Thu, 13 Aug 2026 11:26:27 -0700 (PDT)
X-Received: by 2002:a05:6000:460c:b0:47f:e886:6dff with SMTP id ffacd0b85a97d-481606f67e3mr361461f8f.4.1786645586742;
        Thu, 13 Aug 2026 11:26:26 -0700 (PDT)
Received: from t-14 (2a01cb00088323008940b17acf2a49f2.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:8940:b17a:cf2a:49f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f229681sm995577f8f.16.2026.08.13.11.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:26:26 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: asymmetric_keys - bound section data range in pefile_digest_pe_contents
Date: Thu, 13 Aug 2026 20:25:36 +0200
Message-ID: <20260813182546.138705-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pefile_digest_pe_contents() hashes each PE section with

	crypto_shash_update(desc, pebuf + ctx->secs[i].data_addr,
			    ctx->secs[i].raw_data_size);

where both data_addr and raw_data_size come straight from the untrusted PE
section table. pefile_parse_binary() bounds only the section table's
location, never the sections' data ranges, and nothing else on the path
checks them. A section with data_addr and/or raw_data_size pointing outside
the image therefore reads past the pelen-byte buffer (CWE-125); a large
raw_data_size makes it read far past the end and fault.

Commit f7dd32c5179d ("crypto: asymmetric_keys - fix OOB read in
pefile_digest_pe_contents") recently fixed a sibling underflow in this same
function (the hashed_bytes + certs_size trailer computation); the
per-section read below was left unchecked.

This loop runs only after verify_pkcs7_signature() succeeds, so it requires
a validly signed image -- but not an attacker signing key. The PKCS#7
signature covers the SpcIndirectDataContent (a self-contained digest in the
certificate table), not the live section bytes, so tampering data_addr in a
publicly available signed image leaves the signature valid at that step
while the out-of-bounds read fires when this function recomputes the
digest. It is thus reachable by a local CAP_SYS_BOOT user via
kexec_file_load() with a tampered signed image; the access is an
out-of-bounds read only, but a large raw_data_size faults, which is a
denial of service when panic_on_oops is set.

Reject a section whose data range does not lie within the image before
hashing it.

Fixes: af316fc442ef ("pefile: Digest the PE binary and compare to the PKCS#7 data")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Note: f7dd32c5179d, which fixed the sibling underflow in this function, was
assigned CVE-2026-64544; this closes the per-section read it did not cover.

Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64). Two things were shown:

  1. The defect + fix: a KUnit case calls pefile_digest_pe_contents() with a
     crafted context whose section has data_addr = pelen. Unpatched:
     slab-out-of-bounds read; patched: -ELIBBAD before the hash.

  2. The reachability, end-to-end against a real trusted keyring: a real EFI
     binary was signed with a test key embedded via CONFIG_SYSTEM_TRUSTED_KEYS,
     then its section data_addr was tampered (leaving the PKCS#7 byte-identical).
     Results from verify_pefile_signature(): the untampered image verifies (0),
     one signed by an untrusted key is rejected at verify_pkcs7_signature()
     (-ENOKEY), and the tampered-but-trusted image passes that step and takes
     the OOB read in pefile_digest_pe_contents(). So no signing key is required.

The KUnit case (item 1) is easy to package and I can submit it separately; the
end-to-end setup (item 2) needs an embedded trusted key and signed images, so
it is harder to ship standalone. Neither is included here.

 crypto/asymmetric_keys/verify_pefile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db..4e84fcf 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -292,6 +292,11 @@ static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
 		i = canon[loop];
 		if (ctx->secs[i].raw_data_size == 0)
 			continue;
+		if (ctx->secs[i].data_addr > pelen ||
+		    ctx->secs[i].raw_data_size > pelen - ctx->secs[i].data_addr) {
+			kfree(canon);
+			return -ELIBBAD;
+		}
 		ret = crypto_shash_update(desc,
 					  pebuf + ctx->secs[i].data_addr,
 					  ctx->secs[i].raw_data_size);
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.53.0

