Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727F40F730;
	Wed, 26 Aug 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762542; cv=none; b=jZkxQ7Sh11xYDHZzrI99uF2hv9PDXTis9RQT+Y+/+22R9OJVpSVCECocHHDg3Vg0cbBj0jcfg43aoqfx6BgIjstUJSdzmqVSXGwQ9OvOE27tiabT26pdjdfIMEaaysUm6ZMXPJ2I0tXQeaC9VDn5mD6M+t7YdfLcm1na4TZYeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762542; c=relaxed/simple;
	bh=Iy8zbc/qIQHfHGQ+JDCmtEiLTrjDO/ZmfSxAL434n0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhEdTaEvTuWD9d5MPskq44lwpm5EbhjidJGfv/OtDdc6Z43RMXDQHoQG7kJ5Emi0h3IkEs+KqLr/8oG/se9JnorGht6MCd1XR2kM9XSEd2EA1oV1XQxpqX7Vy+plMnpQPVuNTXet/yBzLcDkah+iUFNzxbrCWOWSp0uIvI332+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rVTtr9iO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rVTtr9iO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ko15IlmBdWr3aMxlB61J4WQli1+xedKEGIK/X2L3BbE=; b=rVTtr9iOGyf5/NARnIgu6RCLAm
	AixAbjwu3H7y0alTqzok4D4kN12EV1UXHFO8rt544AwxezWHrMnKG0RcQJMPw/Vrp7zXcFVDN2iGy
	9XyuNOwtLtMulxf9i1kGuKXW7XeFn3cCXdmJJm8SQVa/zeHuoIk9SjIoOdwEYJNF0mho1PqNSO4wk
	jq9ExIrQdAeU+bItR5JQFYb3PBDof7AH5b5Ji1a0OoN5oGaRAoz6BW6wiDnXTLgj5EW4e0d3YfCk2
	IN3LTwThc9W3JbbyNs8bpexU5UighYO1ubGrymd7jXcUWvbRN+vd00dX6kSJZakAs3FbfCVjZ0ii3
	3Lf/YwYw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wzGh3-000ILM-33;
	Wed, 26 Aug 2026 18:41:42 +0200
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
Subject: [PATCH bpf-next v3 05/11] selftests/bpf: Add a test for the sealed bpf keyring
Date: Wed, 26 Aug 2026 18:41:30 +0200
Message-ID: <20260826164136.1400997-6-daniel@iogearbox.net>
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

bpf_keyring_sealed checks that a load naming the bpf keyring fails while
the keyring has not been provisioned. It uses a junk signature as the
size check and the keyring lookup both happen before any crypto, so the
error under test is reached without a real signature and the ordering is
what gets verified:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #425/9   signed_loader/signed_module_kfunc_rejected:OK
  #425/10  signed_loader/signature_failure_logs:OK
  #425/11  signed_loader/signature_too_large:OK
  #425/12  signed_loader/signature_zero_size:OK
  #425/13  signed_loader/signature_bad_keyring:OK
  #425/14  signed_loader/bpf_keyring_sealed:OK
  #425/15  signed_loader/metadata_ctx_max_entries_ignored:OK
  #425/16  signed_loader/metadata_ctx_initial_value_ignored:OK
  #425/17  signed_loader/signature_authenticates_insns:OK
  #425/18  signed_loader/signature_authenticates_metadata:OK
  #425/19  signed_loader/hash_requires_frozen:OK
  [...]
  #425     signed_loader:OK
  Summary: 1/30 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 0c5294738d6c..e30166c00be6 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -32,8 +32,13 @@ enum {
 	BPF_SIG_KEYRING_SECONDARY,
 	BPF_SIG_KEYRING_PLATFORM,
 	BPF_SIG_KEYRING_USER,
+	BPF_SIG_KEYRING_BPF,
 };
 
+#ifndef KEY_SPEC_BPF_KEYRING
+#define KEY_SPEC_BPF_KEYRING	-9
+#endif
+
 static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 		       const void *sig, __u32 sig_sz, __s32 keyring_id,
 		       __u32 fd_array_cnt)
@@ -627,6 +632,83 @@ static void signature_bad_keyring(void)
 	gen_loader_fixture_fini(&f);
 }
 
+static bool keyring_unsealed_boot(void)
+{
+	char val = 0;
+	int fd;
+
+	fd = open("/sys/module/bpf/parameters/keyring_unsealed", O_RDONLY);
+	if (fd < 0)
+		return false;
+	if (read(fd, &val, 1) != 1)
+		val = 0;
+	close(fd);
+	return val == 'Y' || val == '1';
+}
+
+static int bpf_keyring_lookup(int *nr_keys)
+{
+	char line[512], type[32], desc[64];
+	int serial = -ENOENT;
+	FILE *f;
+
+	f = fopen("/proc/keys", "r");
+	if (!f)
+		return -errno;
+
+	while (fgets(line, sizeof(line), f)) {
+		unsigned int hex;
+		char *sum;
+
+		if (sscanf(line, "%x %*s %*s %*s %*s %*s %*s %31s %63s",
+			   &hex, type, desc) != 3)
+			continue;
+		if (strcmp(type, "keyring") || strcmp(desc, ".bpf:"))
+			continue;
+
+		serial = (int)hex;
+		if (nr_keys) {
+			sum = strstr(line, ".bpf: ");
+			*nr_keys = !sum || !strncmp(sum + 6, "empty", 5) ?
+				   0 : atoi(sum + 6);
+		}
+		break;
+	}
+	fclose(f);
+	return serial;
+}
+
+static void bpf_keyring_sealed(void)
+{
+	static const __u8 junk[64] = {};
+	struct gen_loader_fixture f;
+	int serial, key, fd;
+
+	if (keyring_unsealed_boot()) {
+		printf("%s:SKIP:the bpf keyring was unsealed at boot\n", __func__);
+		test__skip();
+		return;
+	}
+	serial = bpf_keyring_lookup(NULL);
+	if (serial >= 0) {
+		key = syscall(__NR_add_key, "user", "sealprobe", "x", 1,
+			      KEY_SPEC_BPF_KEYRING);
+		if (key >= 0)
+			syscall(__NR_keyctl, KEYCTL_UNLINK, key,
+				KEY_SPEC_BPF_KEYRING);
+		ASSERT_EQ(key < 0 ? -errno : 0, -EPERM,
+			  "nothing links into a sealed keyring");
+	}
+	if (gen_loader_fixture_init(&f) == 0) {
+		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
+				 sizeof(junk), KEY_SPEC_BPF_KEYRING, 0);
+		ASSERT_EQ(fd, -ENOKEY, "sealed bpf keyring rejected");
+		if (fd >= 0)
+			close(fd);
+	}
+	gen_loader_fixture_fini(&f);
+}
+
 /*
  * A signed loader must ignore ctx-supplied map dimensions: the host cannot
  * resize a signed program's maps via the loader ctx. Drive a one-map program
@@ -1806,6 +1888,8 @@ void test_signed_loader(void)
 		signature_zero_size();
 	if (test__start_subtest("signature_bad_keyring"))
 		signature_bad_keyring();
+	if (test__start_subtest("bpf_keyring_sealed"))
+		bpf_keyring_sealed();
 	if (test__start_subtest("metadata_ctx_max_entries_ignored"))
 		metadata_ctx_max_entries_ignored();
 	if (test__start_subtest("metadata_ctx_initial_value_ignored"))
-- 
2.43.0

