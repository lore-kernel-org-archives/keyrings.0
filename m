Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102A396579;
	Fri, 28 Aug 2026 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939560; cv=none; b=FXcmQ97yPvF1nYM1scxCAm2vRaQdSQo92XSr4FUmlN1JM5VkBicu7+wnlplz5+/3jNzhtSSYfEdOsqSO2kvriUkiRh8VCw9wg68ufNhTFlIXn3doQBYW4xVojNUFZDRBVTIV3nSVpMyi1IYb3Z+/eX7KY8a0duTZW0Q7mNar8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939560; c=relaxed/simple;
	bh=cewWWgy4OIBYEr3yDYJVivyuOKpYTRW78jLqkK80dlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZnIcv1e3XGwgOkzyxynV2G2636C3vPYK8MgyGHs7tm2HOAvwjYr+0snH1UoMGJFqTuBwQ8ITXIGV4HUXNRq1VsTQPzE+JZaFGGBsoBWx4W0GJaLXQOH2QlEnBqg9brtHREkcFn74ONduwq5KBV2f8s7qw9F5vl8h1Cmew2Lv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=o4bnTNhA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="o4bnTNhA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RAe8hqWelnoxKfoB5SbEE0Oz6pidu65yqSW66X4AbVI=; b=o4bnTNhAvaJ3TvYOWdNLuhC8Kr
	PK27JaAHlgnXKYaNJ7atyAeOrt9lhAOiK0LwE0t2Mqry1zIT4+SgLZKZpMFVKAgVw/P4fC4XqQqQi
	VxU4XK6Y0ZgWz51FNomGldMElkrpNYLtxn9/WUz7W86KXFqsrZjAQuQLb9disCFdkmy6A2chzUAur
	HmsaotidVP4dS7YKfzwprQGVYFTKN2pMbwhj9b9xT74J05ZJOYymzQ70jBLxpej+RinuwwkJhjuqU
	DSbz/yGPKjGBb9buRuWW+spQm5iELsnvCGYpf40O6uDBkgwECbVTDxaKqoW0inkFY4cLySA85htJF
	mV3iWZjw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00kh-0000aY-0v;
	Fri, 28 Aug 2026 19:52:31 +0200
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
Subject: [PATCH bpf-next v4 03/11] bpf: Raise the bound on a program's signature size
Date: Fri, 28 Aug 2026 19:52:19 +0200
Message-ID: <20260828175227.1537793-4-daniel@iogearbox.net>
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

signature_size is bounded by KMALLOC_MAX_CACHE_SIZE, which is 8 KiB on a
4 KiB page system. Back then we chose it somewhat arbitrarily and was
picked when a BPF program signature was RSA or ECDSA. ML-DSA (FIPS-204)
verification is wired through the X.509 and PKCS#7 parsers, and BPF
reaches them too via verify_pkcs7_signature() without having to know the
concrete algorithm. The bound becomes a bit too small, thus add an
explicit BPF_PROG_MAX_SIGNATURE_SIZE of 64 KiB and use that instead
to cover all options.

KMALLOC_MAX_CACHE_SIZE is PAGE_SIZE-derived, so what was accepted so
far depended on the page size which is not optimal as it should be the
same behavior on every configuration. On 64 KiB page kernels this lowers
the ceiling from 128 KiB to 64 KiB. Nothing that could have been verified
is affected as the largest signature the kernel implements is ML-DSA-87
at 4627 bytes.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c                             | 15 ++++++++++-----
 .../selftests/bpf/prog_tests/signed_loader.c      |  5 +++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d50adf3800d..d50a135466bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20973,6 +20973,14 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * Upper bound on the PKCS#7 signature blob passed with a program. Comfortably
+ * above the largest signature the kernel can verify, and far below anything
+ * that would make rejecting a load expensive. Deliberately a fixed number so
+ * that what the syscall accepts does not depend on PAGE_SIZE.
+ */
+#define BPF_PROG_MAX_SIGNATURE_SIZE	(64 * 1024)
+
 static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
 {
 	switch (keyring_id) {
@@ -21012,13 +21020,10 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	u64 data_sz;
 	int err = 0;
 
-	/*
-	 * Don't attempt to use kmalloc_large or vmalloc for signatures.
-	 * Practical signature for BPF program should be below this limit.
-	 */
 	if (!attr->signature_size ||
-	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
+	    attr->signature_size > BPF_PROG_MAX_SIGNATURE_SIZE)
 		return -EINVAL;
+
 	if (system_keyring_id_check(attr->keyring_id) == 0) {
 		key = bpf_lookup_system_key(attr->keyring_id);
 	} else if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 77381d345435..0c5294738d6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -571,8 +571,9 @@ static void signature_too_large(void)
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * signature_size beyond the kernel's bound (KMALLOC_MAX_CACHE_SIZE)
-		 * is rejected before the buffer is read.
+		 * signature_size beyond the kernel's bound
+		 * (BPF_PROG_MAX_SIGNATURE_SIZE) is rejected before the buffer
+		 * is read.
 		 */
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
 				 64 << 20, KEY_SPEC_SESSION_KEYRING, 0);
-- 
2.43.0

