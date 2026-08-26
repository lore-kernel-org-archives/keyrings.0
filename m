Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A520470EB6;
	Wed, 26 Aug 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762544; cv=none; b=kL6GpinEHjXOqPFglGXI5WQs/ka3t6CvDNH/01Jrp8aaKpxVhfE9kLhEV/zYSlHjx1kAhHoGkA5hXw6oIkc178gxYy07fMfH22G2lNRvZPxfOam5Kt32uwO3jUltGORZO8+VilbDMlgEvsCl7BWLKHZ6FxA0sK/vyBiOBzb1TYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762544; c=relaxed/simple;
	bh=ciri3z/tfv5riYBWFVmMOSbLUrn50AcovyqeWGLNCmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5WFDr3rBmM6mjjdjLt+PD/+zfiuY6TGKN1kBA8V1yTmR6hjkndc/sAohbs4Vnex0Bf/jdOn+JqxwF2Vpf9qQMdN1WzlAnkJQjhZx7zibmtb5XGmYnKijquXQ7YMB7Te/eMz3E5o2U+D71rny8b1AKmq2xJ2bS3wHIpfk3vaZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RLADXjat; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RLADXjat"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QtoMDSlp7wKmiG7m3inH4d792pJnoWeNYYU2nSA2KxE=; b=RLADXjatdhHXZ3vM7j0JEr7Qm1
	wqIv+yhXcVcx2OOcDuLBSf1AyuwIB7HPcdFvx0WSXOPrZzoPyewM8u1ny9EzDa5dePdj3sFAHX/f+
	7OFUvn1PmN6+ynqN72SLplaVonkwtT7jFbLRwGJ433hESI11Qmh1asEgfOBQQ0RR+127uJVYQ8Dxb
	e9BrkTqqr5mv7rdfa47L1diMOfgnruiKKl/ZPaI4n6GCK2sqc7f2X5ZO40Hy5QjClCtGQOH83Ju6e
	24GNvlMlspJX/4w1oPm8/ZjyRZw1qkeqWiF908n6xuPuoM4O+QpGE8qTbGKSOfW6wLONOUBLInzpN
	6ogrNa2A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wzGh6-000ILf-11;
	Wed, 26 Aug 2026 18:41:44 +0200
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
Subject: [PATCH bpf-next v3 08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
Date: Wed, 26 Aug 2026 18:41:33 +0200
Message-ID: <20260826164136.1400997-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164136.1400997-1-daniel@iogearbox.net>
References: <20260826164136.1400997-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28104/Wed Aug 26 08:24:01 2026)

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
index ea7044f30adc..2ec15117abb5 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -51,6 +51,8 @@ CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
+CONFIG_CRYPTO_MLDSA=y
+CONFIG_CRYPTO_SHA512=y
 CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index fbf14c7dd560..039b5d044545 100644
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
+		printf("%s:SKIP:openssl has no ML-DSA support (needs 3.5+)\n",
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
index 202e6e6418fe..2737c1a2bcfd 100755
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
+	# No -<digest> here: ML-DSA hashes the message itself, and openssl
+	# rejects an explicit digest for it.
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

