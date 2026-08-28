Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479463A1A3B;
	Fri, 28 Aug 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939560; cv=none; b=ftfrKbNuzaBPc0YukgyA+v8yekAFBNxvuOp7UjxLQ73itRlICDzHHxxLGjqNG0LxxFlBnXRkDQpBS5Momj+Na42TPdCDcSNJZJT2+U0XsdwJWG9TVglC2nvnvevDfF7qWcnG9AzU47niNG/IM0DwSUnyIB3DVmPreWxFP5WeY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939560; c=relaxed/simple;
	bh=U7wzSR7439nn+Fi5SgeW3apgfv/5vDqIb06YQ+i+mng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acmNEC/Tmt8N/ZyFHryN+/yfhlkiKgJoThZKTKAeAlcyLZ8ms2axxki1zLuLvBP8MCNcLTcJGK4bTuGO0CKxagDUzGe5lJTxlIb5wpuyYTcvWFHNJbY8x2qveA+dTE/lRZJHAMO89xTPjDEtEom/2sJbTjm0MbPCGAEQr61fe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=EE3DlN/6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EE3DlN/6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ENGVFJH4VABL9esrNnw7jL9XwYlrZ1Q6mqu2AQ+tlyU=; b=EE3DlN/6LywcvaqjKBCJ6RzFLE
	cMA3SwQkACBsQz6lDSjz1Q27ion51U05dRmCDBCwc6f+2aiQ4hL/O29woIJjdxDwLugswrQASwFjh
	D+gwjUjiPUUgOv23yoXdQDfdSPFcstpM9DGzl+LP/Dl1Qin5ea6gOK2oTHrsYsaWdSwFvlRLxOZGb
	bqQ/3RqtcpSa1HniVvU0URZFrdJ8QwEuMGnj9Vk8ZCCU2Mk1RHMYSRcP4zT0FJh4rBYPzaXlnLirs
	mU4QG2E3NYdJN+X45W0LeM6Nxz8SXqtRb4yaf4aVyuL9rzB9tvZdpy8RJnpyWbCUGn4aZFySayX1a
	8Bb4xh0w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00ki-0000am-0T;
	Fri, 28 Aug 2026 19:52:32 +0200
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
Subject: [PATCH bpf-next v4 04/11] bpftool: Support ML-DSA program signing
Date: Fri, 28 Aug 2026 19:52:20 +0200
Message-ID: <20260828175227.1537793-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828175227.1537793-1-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28106/Fri Aug 28 08:27:08 2026)

Add bpftool support for ML-DSA program signing and drop the flag for
ML-DSA keys on affected OpenSSL versions, the same way as commit
0ad9a71933e7 ("modsign: Enable ML-DSA module signing").

Also, an ML-DSA-87 signature is 4627 bytes on its own, so the blob does
not fit into the 4 KiB of MAX_SIG_SIZE anymore and signing would fail
otherwise. Bump to 16 KiB. MAX_SIG_SIZE only sizes the buffer for
what bpftool itself emits (unrelated to BPF_PROG_MAX_SIGNATURE_SIZE).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/main.h |  2 +-
 tools/bpf/bpftool/sign.c | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

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
index 88726a6db6d0..adbfd4ae5c02 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -130,6 +130,12 @@ __u32 register_session_key(const char *key_der_path)
 
 int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 {
+	unsigned int signer_flags = CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
+#ifdef CMS_NO_SIGNING_TIME
+				    CMS_NO_SIGNING_TIME |
+#endif
+				    CMS_USE_KEYID | CMS_NOATTR;
+	const EVP_MD *cms_digest = EVP_sha256();
 	BIO *bd_in = NULL, *bd_out = NULL;
 	EVP_PKEY *private_key = NULL;
 	CMS_ContentInfo *cms = NULL;
@@ -167,6 +173,20 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x40000000L
+	if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
+	    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
+		/*
+		 * See workaround in 0ad9a71933e7 ("modsign: Enable ML-DSA
+		 * module signing"). Kernel only accepts sha512, see also
+		 * 8bbdeb7a25b4 ("pkcs7, x509: Add ML-DSA support").
+		 */
+		signer_flags &= ~CMS_NOATTR;
+		cms_digest = EVP_sha512();
+	}
+#endif
+
 	cms = CMS_sign(NULL, NULL, NULL, NULL,
 		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED |
 			       CMS_STREAM);
@@ -175,9 +195,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
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

