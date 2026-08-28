Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1D364058;
	Fri, 28 Aug 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939560; cv=none; b=evxvk7aN9nNRmOhHAVhLUO9UWswvpqFRKjUaIi0UkZov+Ul5ugkY/WExSA5uEgcZGIBeI04Rm1hYX0ZmyY20WVwIKg8riUDBxtu/gkAtXDTYj/pr7gr8p9NROkNvhKMOetSItwW364jXdklpbJzZin2dLWnxWP7g7RS/g7oJdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939560; c=relaxed/simple;
	bh=YUbtmxxVi5hpygjO9pR4mkDDr8aqzKsjD7zMr+JQ3Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU9q3X3qys+YPnicxpjr55WagYsebYkUo79pPopwLwF+rwY7gs0ricv8KJIpkL3//d8CvnLqnj82UxKFSi9NlkNLpSOCzVvexqefAiLYUlmBVRMv6K3OVuRyf+E7B4rtubhqPxYMF/i6cIvMQqQ2POwiNa/k4WutubyFlndeIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bE+GahOE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bE+GahOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8rUNM+AQjDvqUS3gKMtjoQvtJDvAZf/maiPNoOxlnn8=; b=bE+GahOEk4MliI4TD+CYH5Uyf2
	GggsnUCP4Pksatiq6pgReMVeBtceDZv40+SjmBDSUqnSrJsOIN+jdf/bkR8DQqOivOifgQef3zTFt
	p5bEL6+CNgno2x+RcwZ6lbUwuUOrg8iznAniNIQ67Rl6IMK+sp1FPyWcpl56G6VmCG4G2mVb8UMGL
	LMR2Emm08gkdKqjW4sop1eIkH5uxXTfw1QXv28N4/FrMvG0DxwF8PxCpVeoCY7lvE/+JVlKOw2e/z
	4y6Bgiu7zbAXZCdt7YkJNbdWAB00NfxA6gRwkQUMcMHG26ETSjyaaJFm9ZWgo+vnVAIqLfquv9awS
	BPCz8Ffw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00kl-0000bO-17;
	Fri, 28 Aug 2026 19:52:35 +0200
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
Subject: [PATCH bpf-next v4 08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
Date: Fri, 28 Aug 2026 19:52:24 +0200
Message-ID: <20260828175227.1537793-9-daniel@iogearbox.net>
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

The BPF signing is algorithm agnostic, but so far the BPF CI only
has tested a single one. BPF hands verify_pkcs7_signature() a keyring
and byte ranges, and everything below it already understands ML-DSA,
so add a test for ML-DSA signed program to validate it works as well.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #425/10  signed_loader/signature_failure_logs:OK
  #425/11  signed_loader/signature_too_large:OK
  #425/12  signed_loader/signature_zero_size:OK
  #425/13  signed_loader/signature_bad_keyring:OK
  #425/14  signed_loader/bpf_keyring_sealed:OK
  #425/15  signed_loader/mldsa_signed_load:OK
  #425/16  signed_loader/metadata_ctx_max_entries_ignored:OK
  #425/17  signed_loader/metadata_ctx_initial_value_ignored:OK
  #425/18  signed_loader/signature_authenticates_insns:OK
  #425/19  signed_loader/signature_authenticates_metadata:OK
  #425/20  signed_loader/hash_requires_frozen:OK
  [...]
  #425     signed_loader:OK
  Summary: 1/31 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/signed_loader.c  | 125 +++++++++++++++++-
 .../testing/selftests/bpf/verify_sig_setup.sh |  57 +++++++-
 3 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index ea7044f30adc..2f79688dcf7c 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -12,7 +12,9 @@ CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MLDSA=y
 CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_USER_API_SKCIPHER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index fbf14c7dd560..87f155de0e65 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -39,6 +39,12 @@ enum {
 #define KEY_SPEC_BPF_KEYRING	-9
 #endif
 
+/* verify_sig_setup.sh exits with this when openssl cannot do ML-DSA. */
+#define SETUP_SKIP		(-77)
+
+/* FIPS-204 ML-DSA-87 signature size, see include/crypto/mldsa.h. */
+#define MLDSA87_SIGNATURE_SIZE	4627
+
 static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 		       const void *sig, __u32 sig_sz, __s32 keyring_id,
 		       __u32 fd_array_cnt)
@@ -161,12 +167,30 @@ static int run_setup(const char *cmd, const char *dir)
 	}
 	if (waitpid(pid, &status, 0) < 0)
 		return -errno;
-	return (WIFEXITED(status) &&
-		WEXITSTATUS(status) == 0) ? 0 : -EINVAL;
+	if (!WIFEXITED(status))
+		return -EINVAL;
+	return -WEXITSTATUS(status);
 }
 
-static int sign_buf(const char *dir, const void *buf, __u32 len,
-		    void *sig, __u32 *sig_sz)
+static void genkey_dir_fini(const char *dir)
+{
+	static const char * const files[] = {
+		"signing_key.der", "signing_key.pem", "x509.genkey",
+	};
+	char path[PATH_MAX];
+	size_t i;
+
+	if (!dir)
+		return;
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		snprintf(path, sizeof(path), "%s/%s", dir, files[i]);
+		unlink(path);
+	}
+	rmdir(dir);
+}
+
+static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
+			   void *sig, __u32 *sig_sz, const char *digest)
 {
 	char data_tmpl[PATH_MAX], key[PATH_MAX];
 	char sigpath[PATH_MAX + sizeof(".p7s")];
@@ -195,7 +219,7 @@ static int sign_buf(const char *dir, const void *buf, __u32 len,
 	}
 	if (pid == 0) {
 		snprintf(key, sizeof(key), "%s/signing_key.pem", dir);
-		execlp("./sign-file", "./sign-file", "-d", "sha256",
+		execlp("./sign-file", "./sign-file", "-d", digest,
 		       key, key, data_tmpl, NULL);
 		exit(1);
 	}
@@ -233,6 +257,12 @@ static int sign_buf(const char *dir, const void *buf, __u32 len,
 	return ret;
 }
 
+static int sign_buf(const char *dir, const void *buf, __u32 len,
+		    void *sig, __u32 *sig_sz)
+{
+	return sign_buf_digest(dir, buf, len, sig, sig_sz, "sha256");
+}
+
 struct gen_loader_fixture {
 	struct test_signed_loader *skel;
 	struct gen_loader_opts gopts;
@@ -1607,6 +1637,89 @@ static void loadtime_with_map(void)
 	test_signed_loader_map__destroy(skel);
 }
 
+/*
+ * End-to-end signed load with a post-quantum key. ML-DSA (FIPS-204) is wired
+ * through the X.509 and PKCS#7 parsers, and BPF reaches them via
+ * verify_pkcs7_signature() without knowing the algorithm, so an ML-DSA key in
+ * the keyring should verify an ML-DSA signed program with no BPF-side work.
+ */
+static void mldsa_signed_load(void)
+{
+	char dir_tmpl[] = "/tmp/bpfmldsaXXXXXX";
+	int map_fd = -1, prog_fd = -1, err;
+	__u8 *sig = NULL, *buf = NULL;
+	struct gen_loader_fixture f;
+	bool have_fixture = false;
+	__u32 sig_sz = 16384;
+	char *dir;
+
+	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
+		KEY_SPEC_SESSION_KEYRING);
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		return;
+
+	err = run_setup("setup-mldsa", dir);
+	if (err == SETUP_SKIP) {
+		printf("%s:SKIP:no working ML-DSA signing, set SELFTESTS_VERBOSE=1\n",
+		       __func__);
+		test__skip();
+		genkey_dir_fini(dir);
+		return;
+	}
+	if (!ASSERT_OK(err, "verify_sig_setup setup-mldsa")) {
+		genkey_dir_fini(dir);
+		return;
+	}
+
+	sig = malloc(sig_sz);
+	if (!ASSERT_OK_PTR(sig, "sig buf"))
+		goto out;
+	have_fixture = true;
+	if (gen_loader_fixture_init(&f) != 0)
+		goto out;
+
+	buf = malloc((size_t)f.gopts.insns_sz + f.data_sz);
+	if (!ASSERT_OK_PTR(buf, "signbuf"))
+		goto out;
+	memcpy(buf, f.gopts.insns, f.gopts.insns_sz);
+	memcpy(buf + f.gopts.insns_sz, f.blob, f.data_sz);
+
+	/*
+	 * ML-DSA hashes the message itself, but openssl before 4.0 cannot
+	 * produce a CMS message without signedAttrs for it, and with those in
+	 * play only SHA-512 is permitted for the messageDigest attribute.
+	 */
+	if (!ASSERT_OK(sign_buf_digest(dir, buf, f.gopts.insns_sz + f.data_sz,
+				       sig, &sig_sz, "sha512"),
+		       "sign insns||metadata with ML-DSA"))
+		goto out;
+
+	/*
+	 * Guard against the setup silently handing back some other key type:
+	 * an RSA or ECDSA signature is a few hundred bytes, where an ML-DSA-87
+	 * one cannot be smaller than the raw signature it carries.
+	 */
+	ASSERT_GT(sig_sz, MLDSA87_SIGNATURE_SIZE, "ML-DSA-87 signature size");
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, KEY_SPEC_SESSION_KEYRING, 1);
+	ASSERT_OK_FD(prog_fd, "ML-DSA signed loader load");
+out:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (map_fd >= 0)
+		close(map_fd);
+	if (have_fixture)
+		gen_loader_fixture_fini(&f);
+	free(buf);
+	free(sig);
+	run_setup("cleanup", dir);
+}
+
 /*
  * A signed program need not bind any map. A plain BPF_PROG_TYPE_SYSCALL
  * program with no fd_array is signed over its instructions alone: the kernel
@@ -1890,6 +2003,8 @@ void test_signed_loader(void)
 		signature_bad_keyring();
 	if (test__start_subtest("bpf_keyring_sealed"))
 		bpf_keyring_sealed();
+	if (test__start_subtest("mldsa_signed_load"))
+		mldsa_signed_load();
 	if (test__start_subtest("metadata_ctx_max_entries_ignored"))
 		metadata_ctx_max_entries_ignored();
 	if (test__start_subtest("metadata_ctx_initial_value_ignored"))
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index 202e6e6418fe..ba5921e4b12d 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -28,7 +28,7 @@ authorityKeyIdentifier=keyid
 
 usage()
 {
-	echo "Usage: $0 <setup-rsa|cleanup <existing_tmp_dir>"
+	echo "Usage: $0 <setup-rsa|setup-mldsa|cleanup <existing_tmp_dir>"
 	exit 1
 }
 
@@ -57,6 +57,57 @@ setup_rsa()
 	keyctl link $key_id $keyring_id
 }
 
+mldsa_supported()
+{
+	local tmp_dir="$1"
+
+	genkey_mldsa "${tmp_dir}" || return 1
+	: > ${tmp_dir}/probe
+	# Same digest as the caller signs with, see sign_buf_digest().
+	./sign-file -d sha512 ${tmp_dir}/signing_key.pem \
+		${tmp_dir}/signing_key.pem ${tmp_dir}/probe || return 1
+	rm -f ${tmp_dir}/probe ${tmp_dir}/probe.p7s
+}
+
+genkey_mldsa()
+{
+	local tmp_dir="$1"
+
+	echo "${x509_genkey_content}" > ${tmp_dir}/x509.genkey
+
+	# No -<digest> here: ML-DSA hashes the message itself, so openssl
+	# ignores an explicit digest for it.
+	openssl req -new -nodes -utf8 -days 36500 \
+			-batch -x509 -newkey ML-DSA-87 \
+			-config ${tmp_dir}/x509.genkey \
+			-outform PEM -out ${tmp_dir}/signing_key.pem \
+			-keyout ${tmp_dir}/signing_key.pem 2>&1
+
+	openssl x509 -in ${tmp_dir}/signing_key.pem -out \
+		${tmp_dir}/signing_key.der -outform der
+}
+
+mldsa_skip()
+{
+	local tmp_dir="$1"
+
+	rm -f ${tmp_dir}/x509.genkey ${tmp_dir}/signing_key.pem \
+		${tmp_dir}/signing_key.der ${tmp_dir}/probe \
+		${tmp_dir}/probe.p7s
+	exit 77
+}
+
+setup_mldsa()
+{
+	local tmp_dir="$1"
+
+	mldsa_supported "${tmp_dir}" || mldsa_skip "${tmp_dir}"
+	key_id=$(cat ${tmp_dir}/signing_key.der |
+		 keyctl padd asymmetric ebpf_testing_key @s)
+	keyring_id=$(keyctl newring ebpf_testing_keyring @s)
+	keyctl link $key_id $keyring_id
+}
+
 cleanup() {
 	local tmp_dir="$1"
 
@@ -91,7 +142,7 @@ catch()
 	local exit_code="$1"
 	local log_file="$2"
 
-	if [[ "${exit_code}" -ne 0 ]]; then
+	if [[ "${exit_code}" -ne 0 && "${exit_code}" -ne 77 ]]; then
 		cat "${log_file}" >&3
 	fi
 
@@ -110,6 +161,8 @@ main()
 
 	if [[ "${action}" == "setup-rsa" ]]; then
 		setup_rsa "${tmp_dir}"
+	elif [[ "${action}" == "setup-mldsa" ]]; then
+		setup_mldsa "${tmp_dir}"
 	elif [[ "${action}" == "genkey" ]]; then
 		genkey "${tmp_dir}"
 	elif [[ "${action}" == "cleanup" ]]; then
-- 
2.43.0

