Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B91EB1AA
	for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802445; cv=none; b=kEmAVMFoW3NqmqprOZ6lZQok9CowkOuiELN0QSAIDR3vgv7CNuSxUXILyhEqSdoWrKc6Xbx1fi9FkASOcKV3Rkb6aIv+WVUnl7FEJIVFoCNgwHj6Kg5YUzTIgUa6JAEN2BzbAp3dF2zE05cRfxDu4Km5LUwjFiTF2hJM3DGcuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802445; c=relaxed/simple;
	bh=4Wp+l0UIg5R0C0xs4vbLkewmvCtRKpnLLeBwc2c15gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXsyNdBuW8p93mcHdJ/fujuj9zswq++MDa8pRyN/li09uktxwQ0T1DHKvccanjewTBkV82lDLLkufK+cHJkVj7EeNFd7SHl5oUNKMfbrYJS5mwAqA2JyVZ67ae7zyVUFkj+KW+6m0CtXEVsCJoSgMD92MMT//XgDmMM3Gq931Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=FL2avUEs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="FL2avUEs"
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D773D3F332
	for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786802435;
	bh=86RGpNX2OsGBlms7o5V2IbYeBS1f1PX4b53IjP+9t+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FL2avUEsrTQ/SDLW1lpoI0ogMVFDl4OpObelcIcR/aO5h6/GE3qpLGVwQliIlXy0o
	 A2PrEtEVeyDca76SoMgwKeA7ESwpYVpAY1vsYaCtFLplYc6dLjXg+ABixMdvAlIdfY
	 Qf3SWLxzfi0FYtyGvYTT6l4ntXw9DyPluLiMUUaNefYGVTosvVSHvE1tceXx8tNnH7
	 SFQJqKGL4qw7ejzCYkA/IjX7I0pZdsl9oDD8IgDH+iI34I+1QyQ8F7+88R4FB6LWO8
	 2WnJLE14bu3DST5S+tKpkrVmxCQNl6Bh8MvVOyQ11QLpiqKDoOfBZJMRcsUPHfXBr3
	 YQZzExH74wksvrOKtUlDLMhcUXw5y/8tF9j/7w2Jc4/K8pPmPvLfraYe2IZplddqfE
	 H2oJpCx+qya4jjboWbKJy8HX3WUt0MhH73OL2en0OU/e3OI+C5i5+UuNTLryUpbcL8
	 K8TYzCJk/LbN/RN4IkCFhobBVKdN1WwWUrJG6nkf/qN21yYi+UhZo959w/CUgYuc+0
	 eLQHEES3Q+2t35AV43sEe1vEkxmSDUrxADmFxSi/zWs3OXD0aQY0cJQNQD2Z91FHCd
	 tR8LDVrFtXVsMysHQrNkJyyxVwJ6WimEadXfDLVYC2BQPlDCAMmqfYwrTeVOXyYdvW
	 IH1fqKrXuZEzB6gDi+7AJ/Nw=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so1305838f8f.0
        for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802435; x=1787407235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=86RGpNX2OsGBlms7o5V2IbYeBS1f1PX4b53IjP+9t+M=;
        b=c7/h81UVd9QxamFhGvM4K+rUSDBp5AF6s6BLGYk0M0Yi2BHaYAmH6r3nCFCq9Xcw2C
         HP6z8bQbgvJ3DbxfF5fI8r7lqDBUSfB8BDnmwvPX8gDKGBlWc/dzGvCZoVwdwsGHL9Yw
         kqfO1Wwy1XzgEU9oGsq8/Ke0hTxqYp0GzYFJKGXJRZQ6AwsZzgAOCfcNUQ22dMmi6TLY
         CWoGOD1/6f03JIFysgw1B0RZ/bRJk7iSl7+B86YHj+1iRVY/2em6ZHumgb8rn1FDRfgQ
         r8NoY4bHmBDqFDuxelGSF+oxG/sQujV7VR6S6n30bz6yQr6WnQZiwnDxVnS1smnOBxGr
         mqoA==
X-Forwarded-Encrypted: i=1; AHgh+RrrqsKPK0wYDxG6Yi6u52uIx/vUBVpUUzEEi2m1qQWxbE615STrG0R2Wf7uln8fH+DubLlxdQFNiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwykcEovECPOswx7AgZyIBtSOYBKOg7mzm/lYytP8mgS0H87ae5
	rq/kzIKWgBQHx8kRSPv5U9h8l0h0pL4GrEQND/vPmd+BISAvQ0w47ToU8fcYNb6u3g+yaHQoLTE
	UVrJvAxpnryFLOkht5k0INRQn3dB80+hanHgjv3WGTQrpfxKpJaEDIcLhxUFzv0s6nAFbeigDTi
	CA
X-Gm-Gg: AR+sD13bWaASXYRYS6MMGnj8WJqUKSmt6/K6cG9Tr0RhyJPFpgOA3jJQp0sseYQd6DT
	g3sMG+xWxboVIzLRCEHuN07MrGQtYTVLR+JYm179Rdly8O0xwCZ7oMiafsM1koT88Xp+rwZ3nDW
	JFn7gMAzArF2NiksMcmR87crxE1wG2tA4xdYsTTTp+kYuhTvzpvF/ZQ/IiB/Xx2pfRpexAqiQjF
	+V13sqMRbR+anHHWyhh0svHyK5OcVc2be7czpgz1jUVffIU9OBOh3uSDw8T8vj/AmKgazB79IVv
	m+g/VZLF8OvoOICEa60CA7SfMJLB1yvJww7zZo1elrkRpwbKp/paIG/RX/8O+pH3kIHrjiC0vGC
	i6T7u1+tUWwFZ0bfsJjcTYmDKkx6vVTozyXpCUFexvyNYvg9+p5aPxIybhMClBMPMZmXYu25Da/
	zXEg+zX1NnMyeGzZA5bJWeNOqJm98ldt4=
X-Received: by 2002:a5d:5f4a:0:b0:481:51b5:7503 with SMTP id ffacd0b85a97d-48160708252mr21357134f8f.7.1786802435392;
        Sat, 15 Aug 2026 07:00:35 -0700 (PDT)
X-Received: by 2002:a5d:5f4a:0:b0:481:51b5:7503 with SMTP id ffacd0b85a97d-48160708252mr21357037f8f.7.1786802434963;
        Sat, 15 Aug 2026 07:00:34 -0700 (PDT)
Received: from t-14.home (2a01cb000883230031a3fd8213e7cff4.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:31a3:fd82:13e7:cff4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20051esm18433563f8f.7.2026.08.15.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:00:34 -0700 (PDT)
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
Subject: [PATCH v2 1/2] crypto: asymmetric_keys - fix OOB read in pefile_parse_binary
Date: Sat, 15 Aug 2026 16:00:19 +0200
Message-ID: <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
References: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com>
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
v2: express the "index 4" bound as
    offsetof(struct data_directory, certs) / sizeof(*dde) rather than a
    literal 4, per Ignat Korchagin's review [1] -- self-documenting and it
    tracks the struct layout. It is the same value (offsetof is 32,
    sizeof(*dde) is 8, so the bound is 4). A KUnit test is added as 2/2.

[1] https://lore.kernel.org/all/CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com/

Reproduced under KASAN (CONFIG_KASAN_GENERIC, x86-64) with the KUnit case in
2/2: a crafted PE with data_dirs = 0 takes a slab-out-of-bounds read in
pefile_parse_binary() on an unpatched kernel, and is rejected with -ELIBBAD
(no KASAN report) with this patch.

 crypto/asymmetric_keys/verify_pefile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cec99db14..1efd5c0d0 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -87,6 +87,11 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	if (ctx->n_data_dirents > (ctx->header_size - cursor) / sizeof(*dde))
 		return -ELIBBAD;
 
+	/* the certificate table entry must be present in the data directory */
+	if (ctx->n_data_dirents <=
+	    offsetof(struct data_directory, certs) / sizeof(*dde))
+		return -ELIBBAD;
+
 	ddir = pebuf + cursor;
 	cursor += sizeof(*dde) * ctx->n_data_dirents;
 

base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
-- 
2.53.0

