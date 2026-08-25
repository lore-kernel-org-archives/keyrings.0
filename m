Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF242589C;
	Tue, 25 Aug 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667943; cv=none; b=iXPiSk9Ye568dTJgqs+41ZBfLhgvcTYHjSYnpDopx49wVEgMy471JjTach4BsbI/XVsDkDdpUbR3Nxa+g7GSZNLtmIpmEaAelIM65oN+giKQNmWWhl/kq6rgQgtNHip2nVj3WgrmaINm8KJwNogc+yfSGx1rWkcIcdBXwmH+40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667943; c=relaxed/simple;
	bh=iM0AMgwQI6SosKWLFM+2RYyHa4V6rRXsDD9nahDlKS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXpFizw7UfT+JoIKYv2ekopnPpKePw1vkP8K/EK0XcAFYQNeb3uDn31hdFapG5rWSaMeJWI/aznKr99/oWUM0X6f9Agz93fzdf2LPLCSMWyItdkF0Xg4k1AB8vXjoPa1u7tGFPdUTRhw7lRzAnDRQ65WN3cv1C+X58/V8JfvHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OLR4hegE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OLR4hegE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=G2oBr4fE6sRDJEgT0ct5aR6Q1RMT6WnprNNkfFpxZVg=; b=OLR4hegE7Lz/7jG93ZMjHEMcUI
	eQ8hs0Qu9vqSRn2btDzR7sDaDVjQRUMM6+zUtBGj31wn0CdJ8UN15K4e38wt7qU5ZpkHX5eyH2wQF
	zO3inRct3USLnBSyh0m1AXO72plco+B6r2ZglBk4TOgiCR3dYISXur49E29pykLud4fJspYqnzebk
	BX/O9ZmkGi7MFFfMeW5G9jWE55n5g1c/XKMLS1xbLfTA15xmLmwfHYKIOdgnYYFD3iDt/tXgP7hiE
	U5adYZ7wCZUczsto583R26196M4LQtcdrdnXxxl3bN6HVaKjVZdavX7cyJcbkVbaIJ3Up0qBOBYsB
	KOPGI0ZA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5l-000N8S-2s;
	Tue, 25 Aug 2026 16:25:33 +0200
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
Subject: [PATCH bpf-next v2 03/11] bpf: Raise the bound on a program's signature size
Date: Tue, 25 Aug 2026 16:25:22 +0200
Message-ID: <20260825142530.1329706-4-daniel@iogearbox.net>
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
index a93a8dc427d8..558e518ad310 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20972,6 +20972,14 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -21011,13 +21019,10 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
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
 	if (!system_keyring_id_check(attr->keyring_id)) {
 		key = bpf_lookup_system_key(attr->keyring_id);
 	} else {
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

