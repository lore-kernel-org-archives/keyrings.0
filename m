Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D6377541;
	Fri, 28 Aug 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943204; cv=none; b=OWDQy9T6h7WxfRxtn3ObV1v5pHLfTeyLQjeXksaOoQJJjVykkVvdj8l0hrwOrvPuuN4p5X1Qf0SvmByBPi2yBOu/iyuxOYxHD83wVj5mkQVFFcZYuMZmQE62X74OHbitZWZ+C/Qp1/aAlZDb2Q+nlPj1vGdvpwHgNovCC3c3SBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943204; c=relaxed/simple;
	bh=UdHt1/tCz+Ep/3ThqXVMLxXPPV10uo9ugmHzBIL3O4Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IRiInOu7GC8L4FA3P51b7+uFj1UYFqWWHZ2XHJ7DaUf/GN3dl0Zk2ka1F0JxhoIkaJMqC5cRRmUvtiR8JFVFPoFKbvKM+aJCG/NdRNeJPPlf4LNOoYEDgSMCekEzdkO/viB5PcirZKiB9lTCEpEFtIGUPmYjSjphkrAPqTq2YYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtLYp5R/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtLYp5R/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272F81F000E9;
	Fri, 28 Aug 2026 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943201;
	bh=z1AllJjJLg9apdJGmW6WtfsO+KvlsTsmFAHoegX7+mk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YtLYp5R/kC0IZ3tXJCHRmneOdhFiJosXWjRESTEiKZPt7/BbqMlEEalRCdeuwTrCX
	 4toAfUnYM/OOOZAWh2uOzEZRMpGee6cMojsSRFybPKgYRmOGLgKGFsSH/MhnUzVjpG
	 ySrLZNGbsTDwsfwY/FMpph2G05hgnVZAVDSFIVWz9cYbC3w8F3NSXYMqbP+xbMVt6y
	 Nyey+J33HiDmcRJUnZ+Bhoyd/LgGF79pRljWdEtRXnLqBv3N55F3cxXG6e3ikBkYP8
	 EWSdNLaXy6WeQrVXOrRMVCvct+iTAPahhkqcXz2BG6il9xF2bTit+mVlFvCJuR268i
	 rNlLE+vsazOrg==
Content-Type: multipart/mixed; boundary="===============4603960760390044224=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4aa6c4f3d60d4e2e072b0ed0c26497a8a704aee66ef98c81da60731f61e0f294@mail.kernel.org>
In-Reply-To: <20260828175227.1537793-6-daniel@iogearbox.net>
References: <20260828175227.1537793-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 05/11] selftests/bpf: Add a test for the sealed bpf keyring
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 18:53:21 +0000 (UTC)

--===============4603960760390044224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf_keyring_sealed checks that a load naming the bpf keyring fails while
> the keyring has not been provisioned. It uses a junk signature as the
> size check and the keyring lookup both happen before any crypto, so the
> error under test is reached without a real signature and the ordering is
> what gets verified:
>
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
>   [...]
>   #425/9   signed_loader/signed_module_kfunc_rejected:OK
>   #425/10  signed_loader/signature_failure_logs:OK
>   #425/11  signed_loader/signature_too_large:OK
>   #425/12  signed_loader/signature_zero_size:OK
>   #425/13  signed_loader/signature_bad_keyring:OK
>   #425/14  signed_loader/bpf_keyring_sealed:OK
>   #425/15  signed_loader/metadata_ctx_max_entries_ignored:OK
>   #425/16  signed_loader/metadata_ctx_initial_value_ignored:OK
>   #425/17  signed_loader/signature_authenticates_insns:OK
>   #425/18  signed_loader/signature_authenticates_metadata:OK
>   #425/19  signed_loader/hash_requires_frozen:OK
>   [...]
>   #425     signed_loader:OK
>   Summary: 1/30 PASSED, 0 SKIPPED, 0/0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This isn't a bug, but would it be worth a sentence on the add_key/-EPERM
probe and on why the subtest skips when bpf.keyring_unsealed=1? The
description covers the junk-signature/-ENOKEY check well, but the subtest
also verifies that add_key("user", "sealprobe", ..., KEY_SPEC_BPF_KEYRING)
returns -EPERM on a sealed keyring, and it skips via keyring_unsealed_boot()
by reading /sys/module/bpf/parameters/keyring_unsealed. A reviewer reading
only the changelog might miss these other behaviors.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 0c5294738d6ce..e30166c00be6a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> @@ -32,8 +32,13 @@ enum {
>  	BPF_SIG_KEYRING_SECONDARY,
>  	BPF_SIG_KEYRING_PLATFORM,
>  	BPF_SIG_KEYRING_USER,
> +	BPF_SIG_KEYRING_BPF,
>  };
>
> +#ifndef KEY_SPEC_BPF_KEYRING
> +#define KEY_SPEC_BPF_KEYRING	-9
> +#endif
> +
>  static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
>  		       const void *sig, __u32 sig_sz, __s32 keyring_id,
>  		       __u32 fd_array_cnt)

[ ... ]

> @@ -627,6 +632,83 @@ static void signature_bad_keyring(void)
>  	gen_loader_fixture_fini(&f);
>  }
>
> +static bool keyring_unsealed_boot(void)
> +{
> +	char val = 0;
> +	int fd;
> +
> +	fd = open("/sys/module/bpf/parameters/keyring_unsealed", O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +	if (read(fd, &val, 1) != 1)
> +		val = 0;
> +	close(fd);
> +	return val == 'Y' || val == '1';
> +}
> +
> +static int bpf_keyring_lookup(int *nr_keys)
> +{
> +	char line[512], type[32], desc[64];
> +	int serial = -ENOENT;
> +	FILE *f;
> +
> +	f = fopen("/proc/keys", "r");
> +	if (!f)
> +		return -errno;
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		unsigned int hex;
> +		char *sum;
> +
> +		if (sscanf(line, "%x %*s %*s %*s %*s %*s %*s %31s %63s",
> +			   &hex, type, desc) != 3)
> +			continue;
> +		if (strcmp(type, "keyring") || strcmp(desc, ".bpf:"))
> +			continue;
> +
> +		serial = (int)hex;
> +		if (nr_keys) {
> +			sum = strstr(line, ".bpf: ");
> +			*nr_keys = !sum || !strncmp(sum + 6, "empty", 5) ?
> +				   0 : atoi(sum + 6);
> +		}

This isn't a bug, but could the nr_keys out-parameter (and the .bpf:
leaf-count parsing) move to the patch that first passes a non-NULL pointer?
The only caller in this commit is bpf_keyring_sealed(), which passes NULL:
serial = bpf_keyring_lookup(NULL). So the whole if (nr_keys) arm, together
with the char *sum local and the strstr/strncmp/atoi parsing, has no
consumer here. The serial return value is likewise only consumed as an
existence gate (if (serial >= 0)), so the precision of the parse is unused
too.

> +		break;
> +	}
> +	fclose(f);
> +	return serial;
> +}
> +
> +static void bpf_keyring_sealed(void)
> +{
> +	static const __u8 junk[64] = {};
> +	struct gen_loader_fixture f;
> +	int serial, key, fd;
> +
> +	if (keyring_unsealed_boot()) {
> +		printf("%s:SKIP:the bpf keyring was unsealed at boot\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +	serial = bpf_keyring_lookup(NULL);
> +	if (serial >= 0) {
> +		key = syscall(__NR_add_key, "user", "sealprobe", "x", 1,
> +			      KEY_SPEC_BPF_KEYRING);
> +		if (key >= 0)
> +			syscall(__NR_keyctl, KEYCTL_UNLINK, key,
> +				KEY_SPEC_BPF_KEYRING);
> +		ASSERT_EQ(key < 0 ? -errno : 0, -EPERM,
> +			  "nothing links into a sealed keyring");
> +	}
> +	if (gen_loader_fixture_init(&f) == 0) {
> +		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
> +				 sizeof(junk), KEY_SPEC_BPF_KEYRING, 0);
> +		ASSERT_EQ(fd, -ENOKEY, "sealed bpf keyring rejected");
> +		if (fd >= 0)
> +			close(fd);
> +	}
> +	gen_loader_fixture_fini(&f);
> +}
> +

[ ... ]

> @@ -1806,6 +1888,8 @@ void test_signed_loader(void)
>  		signature_zero_size();
>  	if (test__start_subtest("signature_bad_keyring"))
>  		signature_bad_keyring();
> +	if (test__start_subtest("bpf_keyring_sealed"))
> +		bpf_keyring_sealed();
>  	if (test__start_subtest("metadata_ctx_max_entries_ignored"))
>  		metadata_ctx_max_entries_ignored();
>  	if (test__start_subtest("metadata_ctx_initial_value_ignored"))


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33197746599
--===============4603960760390044224==--
