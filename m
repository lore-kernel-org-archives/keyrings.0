Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771634756CA;
	Tue, 25 Aug 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667945; cv=none; b=H7a56grG+D5dem1SMqe7Gs1AsHAlRwOWvmT2Tc44s1i6Lxkr/o51pRADtIF3vrpe0ae+3Onh/kHCqJ7+sVBqgzoUCD1wb7WzDS3wvZ13mOed4JwfZOi8+kUISZFP6BfDw6pv+Kg25oDbk/n/WOJjmdLbR3g0fN09P3/9lk7+BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667945; c=relaxed/simple;
	bh=lBvJz911ZG8kKeQlMDGnxH3ADPyeCFxZu+sQs4TXCWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snlAO7so2zcP7LYVAmTFR2Kkk5PMHlrtAkAd91uxXoZS+Bo6ktkj2OrFgu1STiUlZxt6zSjpcDvA1fCWT2aKNDzbJ/j+rO+QjjEOJXLaiA+8fah6SEF73CSgsa1/8cNP33TP39MZbkcPb/bQp1LK79nHE/+xEGfoXyhODNsY8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gQfKAbxh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gQfKAbxh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iy8UMuhFk1s0RufDp25OB9AQzzv5EGE0wZRqF2rE6Sk=; b=gQfKAbxhW035oTFlUnGObCEHZJ
	qlAYNh1hcS2frN0778X6czZ4GP0a8tJSC9A62y7EvAz91/gwtnPaNvyaFTTHKEYUqITas9sXA2muF
	BkCZxqFo+Wonjoot9IU95ardinrIc80sxLG/IBWrrTLnZ7B+l/FwbhpZLjQzCDVTL/BQML0oIFPnV
	bZnL+ALrHUGZGsugh8krg7SZXlUA9og7rUeuImTLRnhUeqLGAmLiIwgLt+hDzoKYEvrk5UIrXMuhn
	rS/V4FyEO7gMmvOP/xqjcglvEPSWF/phGM1W4lvIgjfGYLVwTXDnK/MoQrdBT22w/G4veqMsx0Hqd
	a+wqesrw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5m-000N8e-2R;
	Tue, 25 Aug 2026 16:25:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH bpf-next v2 04/11] bpftool: Support ML-DSA program signing
Date: Tue, 25 Aug 2026 16:25:23 +0200
Message-ID: <20260825142530.1329706-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825142530.1329706-1-daniel@iogearbox.net>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

Add bpftool support for ML-DSA program signing and drop the flag for
ML-DSA keys on affected OpenSSL versions, the same way as commit
0ad9a71933e7 ("modsign: Enable ML-DSA module signing").

Two small differences to the latter: sign-file.c for modules takes its
digest from the command line whereas bpftool has no such knob, so the
digest is pinned to SHA-512 for ML-DSA keys. ML-DSA ignores the CMS
digest and hashes the message itself, but with signedAttrs back in
place they are what gets signed and only SHA-512 is permitted there.

Also, an ML-DSA-87 signature is 4627 bytes on its own, so the blob does
not fit into the 4 KiB of MAX_SIG_SIZE anymore and signing would fail
otherwise. Bump to 16 KiB. MAX_SIG_SIZE only sizes the buffer for
what bpftool itself emits (unrelated to BPF_PROG_MAX_SIGNATURE_SIZE).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/main.h |  2 +-
 tools/bpf/bpftool/sign.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 78b6e0ebb85d..9315a1db1f7c 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -57,7 +57,7 @@ static inline void *u64_to_ptr(__u64 ptr)
 	})
 
 #define ERR_MAX_LEN	1024
-#define MAX_SIG_SIZE	4096
+#define MAX_SIG_SIZE	16384
 
 #define BPF_TAG_FMT	"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index 88726a6db6d0..1b5502f48add 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -130,6 +130,9 @@ __u32 register_session_key(const char *key_der_path)
 
 int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 {
+	unsigned int signer_flags = CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
+				    CMS_USE_KEYID | CMS_NOATTR;
+	const EVP_MD *cms_digest = EVP_sha256();
 	BIO *bd_in = NULL, *bd_out = NULL;
 	EVP_PKEY *private_key = NULL;
 	CMS_ContentInfo *cms = NULL;
@@ -167,6 +170,21 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x40000000L
+	if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
+		/*
+		 * ML-DSA + CMS_NOATTR is not supported before openssl-4.0, so
+		 * fall back to signedAttrs. ML-DSA does its own hashing and
+		 * ignores the CMS digest, except when signedAttrs are used,
+		 * where only SHA-512 is permitted.
+		 */
+		signer_flags &= ~CMS_NOATTR;
+		cms_digest = EVP_sha512();
+	}
+#endif
+
 	cms = CMS_sign(NULL, NULL, NULL, NULL,
 		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED |
 			       CMS_STREAM);
@@ -175,9 +193,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
-	if (!CMS_add1_signer(cms, x509, private_key, EVP_sha256(),
-			     CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
-			     CMS_USE_KEYID | CMS_NOATTR)) {
+	if (!CMS_add1_signer(cms, x509, private_key, cms_digest, signer_flags)) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-- 
2.43.0

