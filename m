Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8673839B2;
	Fri, 28 Aug 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943209; cv=none; b=n0QyolcegfWVlWKCndxAZ+4SUdc3Ftba95i4O3OYQcbRYALiiEXIOX1RysK9JZ13LxR7KuvWuoFUFRPVO6Uuj67zI6PWgGgnY3EntLQpxkHLfzmFTo14n8op0G4jpKFo8moDMnQQeKNIL1gHsP9aDjv0RtvFSVZ39DnRm9WB7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943209; c=relaxed/simple;
	bh=vpqzz476L9C3sK32zALzV29pKqzNZrb+BNpwKNUx0kw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HTsrdixDU66su0OvV04A0FvS3yWLgF4Qy/Q+2qd8UGai1xagTSaq3EwnlYjGaNwAeVW/9A4kDJM/49v6ldC9+1XEiJcC8V75iujogm0TYMMvljqGRyMLPKKf1h3WaFFWWLEVDEWe0LOIbtI2gDTM3j44MUbLfcV5q+EIssqIK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ8h3/Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ8h3/Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE851F00A3E;
	Fri, 28 Aug 2026 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943206;
	bh=qfZClw44eIu/YN2tAQrnVcPFWAeae9PVQmPC97IWQKU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gZ8h3/WzGmH7TVT5jnJcN4RFj33UfGZ1jtVi3wgk6yqOO1uSyf+7g8QLpZhFKVUvi
	 AbSiQLL7TvsyDG3qeorSWLMfImLreLaRIFi81FjqIjReE/p0ZOmQLdavw+xi3PsFTb
	 L92QgHGH9A0X0EU1TTwU3V2emcu3blYRVvjDxcjmVjHfPbrny/tAYQ51Olzu8griGD
	 sBhiQDoIn6uADOeRVH0LHJ2EjTz+wFCouCBwkXtuyAamMa7vXxiXn5IWw7rC5u5/6v
	 a/KcqgAoHUWqSifF4F9jjy3w/JsljvE8ZfCCgoircxOFg7NjItnNPZpPzNLWgjbtw0
	 mNrUXy7k8LlYg==
Content-Type: multipart/mixed; boundary="===============5738127382509661305=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <98d86e76665751ec4d309893f165938d6c369b636226a3a8fcff80ef9b193f39@mail.kernel.org>
In-Reply-To: <20260828175227.1537793-11-daniel@iogearbox.net>
References: <20260828175227.1537793-11-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 10/11] selftests/bpf: Add tests for bpf keyring in signed loader
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 18:53:26 +0000 (UTC)

--===============5738127382509661305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 87f155de0e656..a0f93756e717b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> +enum subtest_boot {
> +	BOOT_ANY,
> +	BOOT_SEALED,
> +	BOOT_UNSEALED,
> +};
> +
> +static const struct {
> +	const char *name;
> +	void (*fn)(void);
> +	enum subtest_boot boot;
> +} subtests[] = {
> +	{ "loadtime_no_map", loadtime_no_map, BOOT_SEALED },
> +	{ "loadtime_with_map", loadtime_with_map, BOOT_SEALED },
> +	{ "metadata_match", metadata_match, BOOT_ANY },

[ ... ]

> +	{ "signed_sparse_fd_array_rejected", signed_sparse_fd_array_rejected, BOOT_SEALED },
> +	{ "bpf_keyring_provisioned", bpf_keyring_provisioned, BOOT_UNSEALED },
> +};
> +
>  void test_signed_loader(void)
>  {
> +	bool unsealed = keyring_unsealed_boot();
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(subtests); i++) {
> +		if (!test__start_subtest(subtests[i].name))
> +			continue;
> +		if (subtests[i].boot == BOOT_SEALED && unsealed) {
> +			printf("%s:SKIP:needs a boot without bpf.keyring_unsealed=1\n",
> +			       subtests[i].name);
> +			test__skip();
> +			continue;
> +		}
> +		if (subtests[i].boot == BOOT_UNSEALED && !unsealed) {
> +			printf("%s:SKIP:needs bpf.keyring_unsealed=1\n",
> +			       subtests[i].name);
> +			test__skip();
> +			continue;
> +		}
> +		subtests[i].fn();
> +	}
>  }

The commit message documents running './test_progs -t signed_loader' with
KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1", making the unsealed boot a
supported configuration. Does this need to account for other signed light
skeleton tests in the same binary?

tools/testing/selftests/bpf/Makefile lists three signed light skeletons:

  LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c

Each hard-asserts successful load with a caller-supplied keyring:

prog_tests/atomics.c:
  skel->keyring_id = KEY_SPEC_SESSION_KEYRING;
  err = atomics_lskel__load(skel);
  if (!ASSERT_OK(err, "atomics skeleton load"))

prog_tests/fentry_test.c, prog_tests/fexit_test.c, and
prog_tests/fentry_fexit.c have the same pattern. When the kernel is booted
with bpf.keyring_unsealed=1, bpf_prog_verify_signature() refuses
caller-supplied keyrings (-EPERM), so those tests fail rather than skip.

A full './test_progs' (without '-t signed_loader') under the unsealed boot
would report failures for atomics, fentry_test, fexit_test, and
fentry_fexit. Is the unsealed boot meant only for '-t signed_loader', or
should those other signed-lskel tests check keyring_unsealed_boot() and
skip when appropriate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33197746599
--===============5738127382509661305==--
