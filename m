Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EB3AA1A1;
	Fri, 28 Aug 2026 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939560; cv=none; b=k+Ps3ksxi3j7qwH+KpSFTR5JIH6lieaMlgslAujBa+8KXh8XGGETOBocWpnhWqD61bqb8TjoTlJLzBotONBCRCuW9OvxZDVSaFdKIWcrcWM/nIveV6kMUE565oEw2rmfJmZwfrz88wen6AOjn+SlOcpBJRNfMjZ1jh8b0d2uUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939560; c=relaxed/simple;
	bh=bfn9tHefomhXtxx7D0eALkUi+dsmsahpwfEntZ+jw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbTm1pxdmIm1ciYLKSpiNejtdRTs1aFVe03FcCb+yKxr+4oTWasYarABFu1ufJowrZ3sDyY8n90baGAPi8v6y9QZBe5J8lVZJpdhKRAPBATqLREwMe2mwSuSR1Aup5y9FKB9ZJ+f3bzVZau1aHOcAuis7Hxz5RWL4AD8S58mu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=efUtFtfq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="efUtFtfq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9D8xfTIZZggTu5EMcF44win9WTF9DfCXPcwmOK21gZI=; b=efUtFtfq2f+OhZ26HkkEUArlUH
	Nqqy6z5KhDQDUKC4uwsVw/td3rEpvORSAEOTmW6S6GfrQ2QHRgwX1iwRo46FjKyQHFnUJM1g6sBN7
	sT6cSeqFn6Ihjyx+YLhxPs/kgPGGhpDYji9ShqqvS1MikZ2RHsdBYkt6ydZRo305IwrstMKcHcMDx
	PsYYJmbQMMMEytw6EscTvghdbWoGywEYH1UpSoPQivKN5hjU+ZsWYUpwQTYOUpQ3a1o3TIFq+h3mp
	g5NNeTqPkuhOvaw0adK9/sFXGUiiCPrRXCOtZYlU1DPPy7mjAb1dtuH+VNtFlXngBaoHOOrkQgNZw
	odSDsb4A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00km-0000bk-2q;
	Fri, 28 Aug 2026 19:52:36 +0200
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
Subject: [PATCH bpf-next v4 10/11] selftests/bpf: Add tests for bpf keyring in signed loader
Date: Fri, 28 Aug 2026 19:52:26 +0200
Message-ID: <20260828175227.1537793-11-daniel@iogearbox.net>
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

bpf_keyring_provisioned walks the keyring through its whole lifecycle in
one boot for ease of testing. It enrolls a freshly generated key into the
bpf keyring, confirms a load is still refused with -ENOKEY while the keyring
carries no restriction, then restricts it, and only then does the same
signed BPF program load with the bpf keyring. A caller-supplied keyring is
asserted to be refused both before and after the restriction, since what
refuses it is bpf.keyring_unsealed=1 rather than the state of the keyring.

Unsealing is a boot-time decision which also refuses the caller-supplied
keyrings that most subtests here sign against, so each subtest is tagged
with the boot it needs and the ones which cannot run report as skipped
instead of being dropped.

Regular run:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #425/12  signed_loader/signature_zero_size:OK
  #425/13  signed_loader/signature_bad_keyring:OK
  #425/14  signed_loader/bpf_keyring_sealed:OK
  [...]
  #425/30  signed_loader/signed_map_by_fd_rejected:OK
  #425/31  signed_loader/signed_sparse_fd_array_rejected:OK
  #425/32  signed_loader/bpf_keyring_provisioned:SKIP
  #425     signed_loader:OK (SKIP: 1/32)
  Summary: 1/31 PASSED, 1 SKIPPED, 0/0 FAILED

Unsealed run:

  # KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" \
    LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  #425/1   signed_loader/loadtime_no_map:SKIP
  #425/2   signed_loader/loadtime_with_map:SKIP
  #425/3   signed_loader/metadata_match:OK
  [...]
  #425/30  signed_loader/signed_map_by_fd_rejected:SKIP
  #425/31  signed_loader/signed_sparse_fd_array_rejected:SKIP
  #425/32  signed_loader/bpf_keyring_provisioned:OK
  #425     signed_loader:OK (SKIP: 17/32)
  Summary: 1/15 PASSED, 17 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 376 +++++++++++++-----
 1 file changed, 287 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 87f155de0e65..a0f93756e717 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -45,9 +45,9 @@ enum {
 /* FIPS-204 ML-DSA-87 signature size, see include/crypto/mldsa.h. */
 #define MLDSA87_SIGNATURE_SIZE	4627
 
-static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
-		       const void *sig, __u32 sig_sz, __s32 keyring_id,
-		       __u32 fd_array_cnt)
+static int load_loader_log(const void *insns, __u32 insns_sz, int map_fd,
+			   const void *sig, __u32 sig_sz, __s32 keyring_id,
+			   __u32 fd_array_cnt, char *log_buf, __u32 log_sz)
 {
 	union bpf_attr attr;
 	int fd;
@@ -59,18 +59,31 @@ static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 	attr.license = ptr_to_u64("Dual BSD/GPL");
 	attr.prog_flags = BPF_F_SLEEPABLE;
 	attr.fd_array = ptr_to_u64(&map_fd);
+	attr.fd_array_cnt = fd_array_cnt;
 	if (sig) {
 		attr.signature = ptr_to_u64(sig);
 		attr.signature_size = sig_sz;
 		attr.keyring_id = keyring_id;
 	}
-	attr.fd_array_cnt = fd_array_cnt;
+	if (log_buf) {
+		attr.log_level = 1;
+		attr.log_buf = ptr_to_u64(log_buf);
+		attr.log_size = log_sz;
+	}
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
 		     offsetofend(union bpf_attr, keyring_id));
 	return fd < 0 ? -errno : fd;
 }
 
+static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
+		       const void *sig, __u32 sig_sz, __s32 keyring_id,
+		       __u32 fd_array_cnt)
+{
+	return load_loader_log(insns, insns_sz, map_fd, sig, sig_sz, keyring_id,
+			       fd_array_cnt, NULL, 0);
+}
+
 static int run_gen_loader(const void *insns, __u32 insns_sz,
 			  const void *data, __u32 data_sz,
 			  const void *excl, __u32 excl_sz,
@@ -205,6 +218,7 @@ static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
 	fd = mkstemp(data_tmpl);
 	if (fd < 0)
 		return -errno;
+	snprintf(sigpath, sizeof(sigpath), "%s.p7s", data_tmpl);
 	if (write(fd, buf, len) != (ssize_t)len) {
 		close(fd);
 		ret = -EIO;
@@ -229,30 +243,28 @@ static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
 		goto out;
 	}
 
-	snprintf(sigpath, sizeof(sigpath), "%s.p7s", data_tmpl);
 	if (stat(sigpath, &st) < 0) {
 		ret = -errno;
 		goto out;
 	}
 	if (st.st_size > (off_t)*sig_sz) {
 		ret = -E2BIG;
-		goto out_sig;
+		goto out;
 	}
 	fd = open(sigpath, O_RDONLY);
 	if (fd < 0) {
 		ret = -errno;
-		goto out_sig;
+		goto out;
 	}
 	if (read(fd, sig, st.st_size) != st.st_size) {
 		close(fd);
 		ret = -EIO;
-		goto out_sig;
+		goto out;
 	}
 	close(fd);
 	*sig_sz = st.st_size;
-out_sig:
-	unlink(sigpath);
 out:
+	unlink(sigpath);
 	unlink(data_tmpl);
 	return ret;
 }
@@ -564,7 +576,6 @@ static void signature_failure_logs(void)
 	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
 	char log_buf[1024] = {};
 	struct gen_loader_fixture f;
-	union bpf_attr attr;
 	int fd;
 
 	if (gen_loader_fixture_init(&f) == 0) {
@@ -573,22 +584,9 @@ static void signature_failure_logs(void)
 		 * failure is reported through the verifier log. A present-but-
 		 * invalid signature is rejected and the log says why.
 		 */
-		memset(&attr, 0, sizeof(attr));
-		attr.prog_type = BPF_PROG_TYPE_SYSCALL;
-		attr.insns = ptr_to_u64(f.gopts.insns);
-		attr.insn_cnt = f.gopts.insns_sz / sizeof(struct bpf_insn);
-		attr.license = ptr_to_u64("Dual BSD/GPL");
-		attr.prog_flags = BPF_F_SLEEPABLE;
-		attr.signature = ptr_to_u64(junk);
-		attr.signature_size = sizeof(junk);
-		attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
-		attr.log_level = 1;
-		attr.log_buf = ptr_to_u64(log_buf);
-		attr.log_size = sizeof(log_buf);
-		memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
-
-		fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
-			     offsetofend(union bpf_attr, keyring_id));
+		fd = load_loader_log(f.gopts.insns, f.gopts.insns_sz, -1, junk,
+				     sizeof(junk), KEY_SPEC_SESSION_KEYRING, 0,
+				     log_buf, sizeof(log_buf));
 		ASSERT_LT(fd, 0, "invalid signature rejected at load");
 		if (fd >= 0)
 			close(fd);
@@ -708,6 +706,23 @@ static int bpf_keyring_lookup(int *nr_keys)
 	return serial;
 }
 
+static long keyctl_ret(int cmd, unsigned long arg2, unsigned long arg3)
+{
+	long ret = syscall(__NR_keyctl, cmd, arg2, arg3);
+
+	return ret < 0 ? -errno : ret;
+}
+
+/*
+ * What the bpf keyring still needs once it got provisioned: KEY_POS_SEARCH
+ * for the in-kernel search during verification, and the user view/read bits
+ * so it stays visible in /proc/keys, rest is dropped so the enrolled is
+ * therefore final.
+ */
+#define BPF_KEYRING_PERM_LOCKED		0x08030000
+/* What bpf_keyring_init() grants at boot. */
+#define BPF_KEYRING_PERM_INITIAL	0x082f0000
+
 static void bpf_keyring_sealed(void)
 {
 	static const __u8 junk[64] = {};
@@ -721,6 +736,9 @@ static void bpf_keyring_sealed(void)
 	}
 	serial = bpf_keyring_lookup(NULL);
 	if (serial >= 0) {
+		ASSERT_EQ(keyctl_ret(KEYCTL_GET_KEYRING_ID,
+				     KEY_SPEC_BPF_KEYRING, 0), serial,
+			  "KEY_SPEC_BPF_KEYRING resolves to the bpf keyring");
 		key = syscall(__NR_add_key, "user", "sealprobe", "x", 1,
 			      KEY_SPEC_BPF_KEYRING);
 		if (key >= 0)
@@ -739,6 +757,183 @@ static void bpf_keyring_sealed(void)
 	gen_loader_fixture_fini(&f);
 }
 
+static int try_load(const struct gen_loader_fixture *f, const void *sig,
+		    __u32 sig_sz, __s32 keyring_id, char *log_buf, __u32 log_sz)
+{
+	int map_fd, prog_fd;
+
+	map_fd = setup_meta_map(f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map"))
+		return map_fd;
+	prog_fd = load_loader_log(f->gopts.insns, f->gopts.insns_sz, map_fd,
+				  sig, sig_sz, keyring_id, 1, log_buf, log_sz);
+	close(map_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	return prog_fd;
+}
+
+/*
+ * This needs bpf.keyring_unsealed=1 on the guest kernel command line, which
+ * vmtest.sh can pass via KERNEL_CMDLINE_EXTRA. There is no way to unseal the
+ * keyring from here, so without it the test skips. It also only works once
+ * per boot, as restricting a keyring cannot be undone.
+ */
+static void bpf_keyring_provisioned(void)
+{
+	char dir_tmpl[] = "/tmp/bpfkeyringXXXXXX";
+	char bad_tmpl[] = "/tmp/bpfkeyringbadXXXXXX";
+	__u8 *sig = NULL, *bad = NULL, *buf = NULL;
+	int serial, err;
+	int nr_keys = 0, der_fd = -1;
+	struct gen_loader_fixture f;
+	__u32 sig_sz = 8192, bad_sz;
+	bool have_fixture = false;
+	char *dir, *bad_dir = NULL;
+	char log_buf[1024] = {};
+	char path[PATH_MAX];
+	__u8 der[4096];
+	ssize_t der_sz;
+
+	serial = bpf_keyring_lookup(&nr_keys);
+	if (serial < 0) {
+		printf("%s:SKIP:no bpf keyring (needs CONFIG_KEYS)\n", __func__);
+		test__skip();
+		return;
+	}
+	if (nr_keys != 0) {
+		printf("%s:SKIP:the bpf keyring has already been provisioned\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		return;
+	if (!ASSERT_OK(run_setup("genkey", dir), "verify_sig_setup genkey"))
+		goto rmdir;
+
+	snprintf(path, sizeof(path), "%s/signing_key.der", dir);
+	der_fd = open(path, O_RDONLY);
+	if (!ASSERT_OK_FD(der_fd, "open signing_key.der"))
+		goto rmdir;
+	der_sz = read(der_fd, der, sizeof(der));
+	close(der_fd);
+	if (!ASSERT_GT(der_sz, 0, "read signing_key.der"))
+		goto rmdir;
+
+	ASSERT_EQ(keyctl_ret(KEYCTL_GET_KEYRING_ID, KEY_SPEC_BPF_KEYRING, 0),
+		  serial, "KEY_SPEC_BPF_KEYRING resolves to the bpf keyring");
+
+	err = syscall(__NR_add_key, "asymmetric", "", der, (size_t)der_sz,
+		      KEY_SPEC_BPF_KEYRING);
+	if (err < 0 && errno == EPERM) {
+		printf("%s:SKIP:the bpf keyring is sealed, need bpf.keyring_unsealed=1\n",
+		       __func__);
+		test__skip();
+		goto rmdir;
+	}
+	if (!ASSERT_GE(err, 0, "add the signing key to the bpf keyring"))
+		goto rmdir;
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
+	if (!ASSERT_OK(sign_buf(dir, buf, f.gopts.insns_sz + f.data_sz, sig,
+				&sig_sz), "sign insns||metadata"))
+		goto out;
+
+	ASSERT_EQ(try_load(&f, sig, sig_sz, KEY_SPEC_BPF_KEYRING, NULL, 0),
+		  -ENOKEY, "unrestricted keyring still not consulted");
+
+	ASSERT_EQ(try_load(&f, sig, sig_sz, KEY_SPEC_SESSION_KEYRING, NULL, 0),
+		  -EPERM, "caller-supplied keyring refused before provisioning");
+
+	if (!ASSERT_OK(syscall(__NR_keyctl, KEYCTL_RESTRICT_KEYRING,
+			       KEY_SPEC_BPF_KEYRING, NULL, NULL),
+		       "restrict bpf keyring"))
+		goto out;
+
+	if (!ASSERT_OK_FD(try_load(&f, sig, sig_sz, KEY_SPEC_BPF_KEYRING,
+				   NULL, 0),
+			  "load signed by a key in the .bpf keyring"))
+		goto out;
+
+	bad_dir = mkdtemp(bad_tmpl);
+	if (!ASSERT_OK_PTR(bad_dir, "mkdtemp unenrolled"))
+		goto out;
+	if (!ASSERT_OK(run_setup("genkey", bad_dir), "verify_sig_setup genkey unenrolled"))
+		goto out;
+	bad_sz = 8192;
+	bad = malloc(bad_sz);
+	if (!ASSERT_OK_PTR(bad, "bad sig buf"))
+		goto out;
+	if (!ASSERT_OK(sign_buf(bad_dir, buf, f.gopts.insns_sz + f.data_sz, bad,
+				&bad_sz), "sign with an unenrolled key"))
+		goto out;
+
+	ASSERT_EQ(try_load(&f, bad, bad_sz, KEY_SPEC_BPF_KEYRING, log_buf,
+			   sizeof(log_buf)), -ENOKEY,
+		  "key outside the bpf keyring refused");
+	ASSERT_HAS_SUBSTR(log_buf, "signature verification failed",
+			  "the bpf keyring was consulted");
+
+	f.blob[0] ^= 0xff;
+	err = try_load(&f, sig, sig_sz, KEY_SPEC_BPF_KEYRING, NULL, 0);
+	f.blob[0] ^= 0xff;
+	ASSERT_EQ(err, -EKEYREJECTED, "tampered metadata refused");
+
+	ASSERT_EQ(try_load(&f, sig, sig_sz, KEY_SPEC_SESSION_KEYRING, NULL, 0),
+		  -EPERM, "caller-supplied keyring refused once .bpf is in use");
+
+	err = keyctl_ret(KEYCTL_UNLINK, KEY_SPEC_SESSION_KEYRING, serial);
+	ASSERT_EQ(err, -ENOENT, "keyring writable while the user bits are there");
+
+	err = keyctl_ret(KEYCTL_SETPERM, serial, BPF_KEYRING_PERM_LOCKED);
+	if (!ASSERT_OK(err, "drop the user bits on the bpf keyring"))
+		goto out;
+
+	ASSERT_OK_FD(try_load(&f, sig, sig_sz, KEY_SPEC_BPF_KEYRING, NULL, 0),
+		     "load still verified against the locked keyring");
+	ASSERT_EQ(keyctl_ret(KEYCTL_GET_KEYRING_ID, KEY_SPEC_BPF_KEYRING, 0),
+		  -EACCES, "the special id grants no rights of its own");
+
+	err = keyctl_ret(KEYCTL_UNLINK, KEY_SPEC_SESSION_KEYRING, serial);
+	ASSERT_EQ(err, -EACCES, "unlink refused");
+	err = keyctl_ret(KEYCTL_CLEAR, serial, 0);
+	ASSERT_EQ(err, -EACCES, "clear refused");
+	err = keyctl_ret(KEYCTL_REVOKE, serial, 0);
+	ASSERT_EQ(err, -EACCES, "revoke refused");
+	err = keyctl_ret(KEYCTL_INVALIDATE, serial, 0);
+	ASSERT_EQ(err, -EACCES, "invalidate refused");
+	err = keyctl_ret(KEYCTL_SET_TIMEOUT, serial, 1);
+	ASSERT_EQ(err, -EACCES, "timeout refused");
+	err = keyctl_ret(KEYCTL_SETPERM, serial, BPF_KEYRING_PERM_INITIAL);
+	ASSERT_EQ(err, -EACCES, "the bits cannot be granted back");
+
+	ASSERT_EQ(bpf_keyring_lookup(&nr_keys), serial, "keyring still there");
+	ASSERT_EQ(nr_keys, 1, "the enrolled key survived");
+out:
+	if (have_fixture)
+		gen_loader_fixture_fini(&f);
+	genkey_dir_fini(bad_dir);
+	free(buf);
+	free(bad);
+	free(sig);
+rmdir:
+	genkey_dir_fini(dir);
+}
+
 /*
  * A signed loader must ignore ctx-supplied map dimensions: the host cannot
  * resize a signed program's maps via the loader ctx. Drive a one-map program
@@ -1973,68 +2168,71 @@ static void signed_module_kfunc_rejected(void)
 	run_setup("cleanup", dir);
 }
 
+enum subtest_boot {
+	BOOT_ANY,
+	BOOT_SEALED,
+	BOOT_UNSEALED,
+};
+
+static const struct {
+	const char *name;
+	void (*fn)(void);
+	enum subtest_boot boot;
+} subtests[] = {
+	{ "loadtime_no_map", loadtime_no_map, BOOT_SEALED },
+	{ "loadtime_with_map", loadtime_with_map, BOOT_SEALED },
+	{ "metadata_match", metadata_match, BOOT_ANY },
+	{ "signature_enforced", signature_enforced, BOOT_SEALED },
+	{ "signed_nonexcl_fd_array_rejected", signed_nonexcl_fd_array_rejected, BOOT_SEALED },
+	{ "signed_unfrozen_fd_array_rejected", signed_unfrozen_fd_array_rejected, BOOT_SEALED },
+	{ "signed_nonarray_fd_array_rejected", signed_nonarray_fd_array_rejected, BOOT_SEALED },
+	{ "signed_btf_fd_array_rejected", signed_btf_fd_array_rejected, BOOT_ANY },
+	{ "signed_module_kfunc_rejected", signed_module_kfunc_rejected, BOOT_SEALED },
+	{ "signature_failure_logs", signature_failure_logs, BOOT_SEALED },
+	{ "signature_too_large", signature_too_large, BOOT_ANY },
+	{ "signature_zero_size", signature_zero_size, BOOT_ANY },
+	{ "signature_bad_keyring", signature_bad_keyring, BOOT_SEALED },
+	{ "bpf_keyring_sealed", bpf_keyring_sealed, BOOT_ANY },
+	{ "mldsa_signed_load", mldsa_signed_load, BOOT_SEALED },
+	{ "metadata_ctx_max_entries_ignored", metadata_ctx_max_entries_ignored, BOOT_ANY },
+	{ "metadata_ctx_initial_value_ignored", metadata_ctx_initial_value_ignored, BOOT_ANY },
+	{ "signature_authenticates_insns", signature_authenticates_insns, BOOT_SEALED },
+	{ "signature_authenticates_metadata", signature_authenticates_metadata, BOOT_SEALED },
+	{ "hash_requires_frozen", hash_requires_frozen, BOOT_ANY },
+	{ "no_update_after_freeze", no_update_after_freeze, BOOT_ANY },
+	{ "freeze_writable_mmap", freeze_writable_mmap, BOOT_ANY },
+	{ "no_writable_mmap_frozen", no_writable_mmap_frozen, BOOT_ANY },
+	{ "map_hash_matches_libbpf", map_hash_matches_libbpf, BOOT_ANY },
+	{ "map_hash_multi_element", map_hash_multi_element, BOOT_ANY },
+	{ "map_hash_bad_size", map_hash_bad_size, BOOT_ANY },
+	{ "map_hash_unsupported_type", map_hash_unsupported_type, BOOT_ANY },
+	{ "lsm_signature_verdict", lsm_signature_verdict, BOOT_SEALED },
+	{ "signed_no_fd_array", signed_no_fd_array, BOOT_SEALED },
+	{ "signed_map_by_fd_rejected", signed_map_by_fd_rejected, BOOT_SEALED },
+	{ "signed_sparse_fd_array_rejected", signed_sparse_fd_array_rejected, BOOT_SEALED },
+	{ "bpf_keyring_provisioned", bpf_keyring_provisioned, BOOT_UNSEALED },
+};
+
 void test_signed_loader(void)
 {
-	if (test__start_subtest("loadtime_no_map"))
-		loadtime_no_map();
-	if (test__start_subtest("loadtime_with_map"))
-		loadtime_with_map();
-	if (test__start_subtest("metadata_match"))
-		metadata_match();
-	if (test__start_subtest("signature_enforced"))
-		signature_enforced();
-	if (test__start_subtest("signed_nonexcl_fd_array_rejected"))
-		signed_nonexcl_fd_array_rejected();
-	if (test__start_subtest("signed_unfrozen_fd_array_rejected"))
-		signed_unfrozen_fd_array_rejected();
-	if (test__start_subtest("signed_nonarray_fd_array_rejected"))
-		signed_nonarray_fd_array_rejected();
-	if (test__start_subtest("signed_btf_fd_array_rejected"))
-		signed_btf_fd_array_rejected();
-	if (test__start_subtest("signed_module_kfunc_rejected"))
-		signed_module_kfunc_rejected();
-	if (test__start_subtest("signature_failure_logs"))
-		signature_failure_logs();
-	if (test__start_subtest("signature_too_large"))
-		signature_too_large();
-	if (test__start_subtest("signature_zero_size"))
-		signature_zero_size();
-	if (test__start_subtest("signature_bad_keyring"))
-		signature_bad_keyring();
-	if (test__start_subtest("bpf_keyring_sealed"))
-		bpf_keyring_sealed();
-	if (test__start_subtest("mldsa_signed_load"))
-		mldsa_signed_load();
-	if (test__start_subtest("metadata_ctx_max_entries_ignored"))
-		metadata_ctx_max_entries_ignored();
-	if (test__start_subtest("metadata_ctx_initial_value_ignored"))
-		metadata_ctx_initial_value_ignored();
-	if (test__start_subtest("signature_authenticates_insns"))
-		signature_authenticates_insns();
-	if (test__start_subtest("signature_authenticates_metadata"))
-		signature_authenticates_metadata();
-	if (test__start_subtest("hash_requires_frozen"))
-		hash_requires_frozen();
-	if (test__start_subtest("no_update_after_freeze"))
-		no_update_after_freeze();
-	if (test__start_subtest("freeze_writable_mmap"))
-		freeze_writable_mmap();
-	if (test__start_subtest("no_writable_mmap_frozen"))
-		no_writable_mmap_frozen();
-	if (test__start_subtest("map_hash_matches_libbpf"))
-		map_hash_matches_libbpf();
-	if (test__start_subtest("map_hash_multi_element"))
-		map_hash_multi_element();
-	if (test__start_subtest("map_hash_bad_size"))
-		map_hash_bad_size();
-	if (test__start_subtest("map_hash_unsupported_type"))
-		map_hash_unsupported_type();
-	if (test__start_subtest("lsm_signature_verdict"))
-		lsm_signature_verdict();
-	if (test__start_subtest("signed_no_fd_array"))
-		signed_no_fd_array();
-	if (test__start_subtest("signed_map_by_fd_rejected"))
-		signed_map_by_fd_rejected();
-	if (test__start_subtest("signed_sparse_fd_array_rejected"))
-		signed_sparse_fd_array_rejected();
+	bool unsealed = keyring_unsealed_boot();
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(subtests); i++) {
+		if (!test__start_subtest(subtests[i].name))
+			continue;
+		if (subtests[i].boot == BOOT_SEALED && unsealed) {
+			printf("%s:SKIP:needs a boot without bpf.keyring_unsealed=1\n",
+			       subtests[i].name);
+			test__skip();
+			continue;
+		}
+		if (subtests[i].boot == BOOT_UNSEALED && !unsealed) {
+			printf("%s:SKIP:needs bpf.keyring_unsealed=1\n",
+			       subtests[i].name);
+			test__skip();
+			continue;
+		}
+		subtests[i].fn();
+	}
 }
-- 
2.43.0

