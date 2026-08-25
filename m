Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8184582D2;
	Tue, 25 Aug 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667941; cv=none; b=RTarLJ6xUMsGzTp/zi4tHUBdVDnEk6GsKCAFXFcb4aM9Kv2g4kWOZO80s/05rj+ueQIAjAw5I2Nda1yRhivjrWRIY7DN0f/mryfZLM4/hAVJaFI2D0V/Yta3ycFRyrBy4vXqDkXXr+2SIhBlM8mftmf7oCtuB3dIOWYfau+NE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667941; c=relaxed/simple;
	bh=Axhzo/QLrt2Fm3aPV+s5QahHgLMN2UdW6KP/hI6hc90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCFApvrEMojVLqAYNjE8wuISaqD8nYIj5IsNl1cmqMBnEEVCUn3bw0UiK8oM6pXZ/WRIEzyo0vs/xsh+bwPHH/ELNhfh1WY1r1bVkhyA3ZmkIUwVoN6k1MkH1eWsXTce1QvGy4cPkHQse3a9hEnGvfJ2r6nQ2uJXeSG+MYmMTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rChJuSxG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rChJuSxG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lU1t2Z4kg3fekr99Z98PLBBehF5XNX7Adtbqw4WlaxU=; b=rChJuSxGbH+7FtrrDU5XXI/tGU
	l/lrzM794F0gWrEeIlT99DM9TV4DcNfRyYBdplDyhqhVhuQ6HaYeW5ZJ4TkDNv0qiZl6BrxcxjK10
	Aer6/XPSbhZUa0suXbP2miQIp5w8qb55MF54dgCI/hdSSXI/C4NsQIApZc0ImfKA0oQGGiqr1wYlT
	fiQ7Q+b6QxP99OzqYAcuNzwVwFKUZp/6lruWj7Vi59+08rxoQ5IQALvLq6CWP0RlZ86zLhMOQamh5
	UN5dCVGHjEnbkH/wU4DPLQndyOxLbTn4VkUU5Wlj+5VTzXfS3layWhQqcwbGIy3Fr05FCahkF4FBw
	SQ7nVc7g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5p-000N9I-0E;
	Tue, 25 Aug 2026 16:25:37 +0200
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
Subject: [PATCH bpf-next v2 07/11] selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
Date: Tue, 25 Aug 2026 16:25:26 +0200
Message-ID: <20260825142530.1329706-8-daniel@iogearbox.net>
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
index 5fb931d6b4c4..08d1cfe06e15 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -460,7 +460,7 @@ static void signed_btf_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -910,7 +910,7 @@ static void signature_authenticates_insns(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1010,7 +1010,7 @@ static void signature_authenticates_metadata(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1346,7 +1346,7 @@ static void lsm_signature_verdict(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		dir = NULL;
 		goto out;
@@ -1529,7 +1529,7 @@ static void loadtime_verify(struct bpf_object *obj, int expect_maps)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1627,7 +1627,7 @@ static void signed_no_fd_array(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		return;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		return;
 	}
@@ -1698,7 +1698,7 @@ static void signed_map_by_fd_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1760,7 +1760,7 @@ static void signed_sparse_fd_array_rejected(void)
 	dir = mkdtemp(dir_tmpl);
 	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
 		goto out_map;
-	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+	if (!ASSERT_OK(run_setup("setup-rsa", dir), "verify_sig_setup")) {
 		rmdir(dir);
 		goto out_map;
 	}
@@ -1814,7 +1814,7 @@ static void signed_module_kfunc_rejected(void)
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

