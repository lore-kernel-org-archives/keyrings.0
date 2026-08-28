Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE3822AA;
	Fri, 28 Aug 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939559; cv=none; b=m6wEQKnKqaw+vWxa3A8Zf+8GzIyVMnhimu1HsP33hM+5Qv/ILDDdAbe4qO15nmucPVKixCF3fqOnAATm31AySCgOUY1L3h8GTFoD+DdwLNZ3+A4epjWYR/ht2cK5UdUqXQz5Vni5rSrmxl+kkBlQvHPkIhb7T+OXLr6Deqs3cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939559; c=relaxed/simple;
	bh=3Wtkmbwy3OPlKz7qt4TUHZEF80EkYQ9fQJQnZJ+McVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spiAA7EN32wGfyWIQ6htdcdd8me6N2EYuoN+b4K3yX6hM7LqKJbKlsOziIMYF0bPbAnWIJyHgH5SSolPM5t8ivC2tvkOdG45CdguT7Oqo0OAi1MDx5t1axChlspASUu1Y2oWlAZzzUBRt3gjIAFUNsOTp2D7DNgC/2L0oht6lYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PoQe/bde; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PoQe/bde"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=E+dbyEhtIAF3ST+aEg7QNzybDSvTP3eVxWFQ0RycZ18=; b=PoQe/bdefDou1mvxlxWhkcbQx8
	YhtLvo7BU+W9ctFRkjX5I14cXfFFNscyEuuEG+5t+b75Q3riJ1h9w/9KPGg2mibMgd883H4wOfX6U
	x531+v7aHTD+TJKlJZXUDm0dKtfsL0yQdktME0AQ/WBe3/huKmOYqlV3gTExM93Xiu5pi7/ESbhQw
	9NqM05aXi+jGYDMuYZ2YAbSdJ9PgkCeE5fqprLbrKVqBin5TWcyJutAr4Vw1OIa9TVDA2ngukcK/U
	yR2VTsiK3Zom9oBUGcCmgZkIlan3VqC+bfPPKeeuhYXT01hNZPxkVpkT/BXhbpn5eeqKl6TH8S1zq
	8YMVWKUg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00kk-0000bG-1Q;
	Fri, 28 Aug 2026 19:52:34 +0200
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
Subject: [PATCH bpf-next v4 07/11] selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
Date: Fri, 28 Aug 2026 19:52:23 +0200
Message-ID: <20260828175227.1537793-8-daniel@iogearbox.net>
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

The script's "setup" action generates an RSA key, enrolls it and builds
a keyring around it. The name says nothing about the algorithm, which is
fine while there is only one, but we'll add "setup-mldsa" soon, therefore
rename the existing one into "setup-rsa". No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c   | 18 +++++++++---------
 .../bpf/prog_tests/verify_pkcs7_sig.c          |  4 ++--
 .../testing/selftests/bpf/verify_sig_setup.sh  |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index e30166c00be6..fbf14c7dd560 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -462,7 +462,7 @@ static void signed_btf_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -914,7 +914,7 @@ static void signature_authenticates_insns(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1014,7 +1014,7 @@ static void signature_authenticates_metadata(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1350,7 +1350,7 @@ static void lsm_signature_verdict(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		dir = NULL;
 		goto out;
@@ -1533,7 +1533,7 @@ static void loadtime_verify(struct bpf_object *obj, int expect_maps)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1631,7 +1631,7 @@ static void signed_no_fd_array(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1702,7 +1702,7 @@ static void signed_map_by_fd_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1764,7 +1764,7 @@ static void signed_sparse_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1818,7 +1818,7 @@ static void signed_module_kfunc_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index f327feb8e38c..12b146d205d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -257,7 +257,7 @@ static void test_verify_pkcs7_sig_from_map(void)
 	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
 		return;
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup-rsa");
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto close_prog;
 
@@ -458,7 +458,7 @@ static void test_pkcs7_sig_fsverity(void)
 	snprintf(data_path, PATH_MAX, "%s/data-file", tmp_dir);
 	snprintf(sig_path, PATH_MAX, "%s/sig-file", tmp_dir);
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup-rsa");
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index 09179fb551f0..202e6e6418fe 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -28,7 +28,7 @@ authorityKeyIdentifier=keyid
 
 usage()
 {
-	echo "Usage: $0 <setup|cleanup <existing_tmp_dir>"
+	echo "Usage: $0 <setup-rsa|cleanup <existing_tmp_dir>"
 	exit 1
 }
 
@@ -47,7 +47,7 @@ genkey()
 		${tmp_dir}/signing_key.der -outform der
 }
 
-setup()
+setup_rsa()
 {
 	local tmp_dir="$1"
 
@@ -108,8 +108,8 @@ main()
 
 	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
 
-	if [[ "${action}" == "setup" ]]; then
-		setup "${tmp_dir}"
+	if [[ "${action}" == "setup-rsa" ]]; then
+		setup_rsa "${tmp_dir}"
 	elif [[ "${action}" == "genkey" ]]; then
 		genkey "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
-- 
2.43.0

