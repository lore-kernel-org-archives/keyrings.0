Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C148331ED3
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640246; cv=none; b=CvS2FvRcqvWslou8eLYZBhyvUtbNcHWqjhiMz8XDSbyxXtKfnGhIW1CLta6zMueVhDvnnvKaELXKKCxvNB//TmVd89ReGvtnuOfg31wfgjJmCV+1QhUG1cmxeTa/RW3SUpBmuU/jYSIH+zsPgI0hVIDBnTll2ezeCor+Ie0rbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640246; c=relaxed/simple;
	bh=9RpAvBQAy/SAGsjLUsavkvhR2IXORLH2z64F8pxIE2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1wcv3tbVfUNHv2R2dZxOLVUiAqgf2yv4DEdSk9D8UF1AbjwFw7fgPNR9+1JEzBilANqZbbto08O07p7SsD6lnu6qCDx0vbdUmgIPU/ANr+z+JMHMfhXCz/N0PcpRDUFHBE/MAf56XnMW/G0PGAwbbUuJwnrLwkSKsoDfs2uH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jdk0cchK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jdk0cchK"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE48E3F4C9
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786640235;
	bh=v4gKNmrcl/ldyDb/KPnMDoGw2a6pO4iklkGUcioG2dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=jdk0cchKFh0+3KTIUUoaEU594EzICF17vl9sq4C1ObaND1GDlbhwwjM/RiIyMuQ0d
	 Lg4y+WS2fJrOsVQqmoqXmZdLYdwSfDTmBnauQgCnbt8WqPojH3N8HHg/InawgsDwlw
	 1cXUYYa4nvqiXa7eOz9wLfRMr3xXFoHkpqhybF8jpAaUznVDA+tDzLMuMLGRBNYzhI
	 kXXfA9lsNP5AFB/Kjltt8DNHkM1NGAPNbjHSEFlTiqVWNDdt/qQraJDX2DW6Q1D5AM
	 uAyPkfxMFkrV/NPH7+aOt1T/RbxOPhMriD2vypLzmHyTGGrSCmX7oRMYOXsUMHIYup
	 hNBJBbEHMbr4lKBIVNwy4cPbSgquGI1r8BGy/HK3jNCjnDJbcBRkkrmFNgfogfl+CR
	 tOewMDo5ENVyuw/iM8vop44syZzl+aJkE1Bf+lyU78+ZXJAtEGyZMSzxqg29WiST/6
	 nbV1DcwasQdiH8wcFOGZENhETKQgQdejZTe7K1FiTfza1W/TxxCxSeQQEEVy6dOAI5
	 Tz0KaTi/79r+vz0fFoAQ5AVa7OI16ORUjr6+TudbTIDlyS76kjLEupEHNNq7koo577
	 4jFUZ87o8GaoKzHjIiNir7DNHD+UloRfc9aYvHt6ZJSX/mtFcMMGjX5+ZHvUhOunGe
	 rrnWlYOhfJcryRpuAbV7/tg0=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so782505e9.3
        for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640235; x=1787245035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4gKNmrcl/ldyDb/KPnMDoGw2a6pO4iklkGUcioG2dw=;
        b=Hw7f/FApFjujhnt8nbQBvm5bhWWfgagMsM4f9ZlZ/m6qtp8XWqWLr4QkrpwhX8M79e
         vpulfuGy4zUwwJKdZegqnr998eWCLwA2LbXOA+8KpElL6/pvahbNfllgf+p3s/bvQu80
         mXOMIwdlCprRYFIifu0Zjd+UN0ri4HV8fjOgnmSppCaUsCJ6+cYM0kF43hlB+qQPJgKk
         Qj9X7qfOkGvB4hoTZJRktOPqNv5X89Yr/wWdCScKEGeNEvjVEVs+Nu8cAZgELAOaC53B
         kZNmB3iQPujYBn20WvwBieLGpxDwcW/jiq6OSNd0LaT27nUuNOf6zjjg0p7O02BHmase
         UTxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJqXD14QI0F7EfCFZ53fxHFQ9OGD2QezR4Rq+PrGVtRfG8lhr77BZBaw3WKEk36m/02vgNm1vvCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFKnF0Gpi36HJIhf2xWtdfWM2x6rkMVbYK+/iz/GSkYWhe2Sp
	bBSmfzVemNiKYtI+sUgj5y5gGu3X2VspDEpdJDPhoT0g80AGqGdXmzdho3Cd/k3viluq3Ptr0gB
	P7HnhcmJDVFvgLiaAHEiQzU8MfGKohsQfcZq1hrtLwCUog2e0w3gnPXD1YPWK6MvXEYbYUdGRFS
	jn
X-Gm-Gg: AR+sD10vQJFHQWEHMOy6mojeITnfRhgOwIeRDw0klyEraVfDHxdP/AlyUQXW62p7/Lp
	qeDdz8djAVg4uS77v7gDDY8WA+px2KP499mWOnLWzj9eNoK5AiEXlfN0uafaYGKytnRMQxc105x
	V49/s+Oep5hcamgHaHaAdnPp2LvBsLPPeaU05ooMigswek8f7M4qG2QCqJbJUAuifAiFNp8BTZ+
	paP2JFoPEQu+xSnqps6E+QpfgilzknOMWW+IY2u9uyeMT8uKr67AQbCLhtxFmmfPKpGiA1uZXQq
	j98Tg9ephwGAWP1Kh4dQ/A7lVa0OGA72iZuS6XQmpRzOulCmrkpIuwomWVnP4abot80ckFkCUBQ
	HFORha1zE0UxEUI2nCaP5ZLVwkDpj7AEi25+xPLrY9bcZSwIpjWty4yYokXTHIp02D4tQtZO5Et
	ME/sLX/goMD7dyrUR2HZwRTOL8
X-Received: by 2002:a05:600c:1d19:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-499821548efmr108289125e9.2.1786640235337;
        Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1d19:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-499821548efmr108288525e9.2.1786640235000;
        Thu, 13 Aug 2026 09:57:15 -0700 (PDT)
Received: from t-14 (2a01cb00088323008940b17acf2a49f2.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:8940:b17a:cf2a:49f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm574151f8f.34.2026.08.13.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 09:57:14 -0700 (PDT)
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
Subject: [PATCH] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
Date: Thu, 13 Aug 2026 18:56:45 +0200
Message-ID: <20260813165654.36098-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pefile_parse_binary() reads the size field of the certificate table's
data-directory entry, which sits at fixed index 4 of the PE optional
header's data directory:

	ctx->certs_size = ddir->certs.size;

but nothing ensures index 4 is present. n_data_dirents (the untrusted
NumberOfRvaAndSizes) is only upper-bounded against header_size and may be
0, and header_size need only satisfy cursor < header_size < datalen. A
crafted PE with n_data_dirents = 0 and a tiny header_size therefore causes
the ddir->certs.size read to land past the end of the image (CWE-125). The
chkaddr() that bounds the certificate blob runs only after this read.

verify_pefile_signature() is reached from kexec_file_load() (the
lockdown/secure-boot enforced PE-image signature path), and the image is
parsed before its signature is checked. The trigger needs CAP_SYS_BOOT and
the access is out-of-bounds read only (no write).

Require the certificate table's data-directory entry (index 4) to be
present; the existing upper-bound check then keeps ddir->certs within
[cursor, header_size).

Fixes: 26d1164be37f ("pefile: Parse a PE binary to find a key and a signature contained therein")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that
builds a crafted PE (valid MZ/PE/PE32 magics, data_dirs = 0, header_size just
past the optional header) and calls verify_pefile_signature() with a NULL
keyring -- the parse runs before any signature check. On an unpatched kernel:

    BUG: KASAN: slab-out-of-bounds in verify_pefile_signature+0x1d6/0x950
    Read of size 4 ... in pefile_parse_binary() (inlined)

With this patch the crafted image is rejected (-ELIBBAD) before the read and
the case passes with no KASAN report. The test is not included here; happy to
submit it separately.

 crypto/asymmetric_keys/verify_pefile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db..e7f8bdb 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -87,6 +87,10 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
 		return -ELIBBAD;
 
+	/* The certificate table entry is at fixed index 4 of the data directory. */
+	if (ctx->n_data_dirents <= 4)
+		return -ELIBBAD;
+
 	ddir = pebuf + cursor;
 	cursor += sizeof(*dde) * ctx->n_data_dirents;
 
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.53.0

