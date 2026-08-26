Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339246D571;
	Wed, 26 Aug 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766875; cv=none; b=XJJlDlGR0A0X68GdHX70UQ5UHIf4oFX+0+R+iwULZfgOb8Xfj4hubp3NcHgdJ9N3J4pDrK5IbQ+CzjOgnFefPlBUslsQMTFi7l2dY8YCFIwTpAJ/+Xwpjq2qUkkC8nPMZwZyDVVSgiuuM1SC/CvqhnfuZTi6Sc6bGzEQ+uGy+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766875; c=relaxed/simple;
	bh=P4O5SRNzjSiXePcWM3ca66wBn85vW/P2FgJRQarTF+M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GJeKmrf+3kc/gmucMyWH8TF4GVFPoPif8daHe2YeF81sg+nlUVO4zr7yw1Xk4VieTN1TBq/I+FPWUIMNWS9QJToyGVKXQEfocAyyWkynlxP/sIur3lOXdA+JjnOxIrBKV+lg5zRfc3uprkV2R4FZlb/MwkaUl38UX38s2fxN0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2uRh9EA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2uRh9EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A681F000E9;
	Wed, 26 Aug 2026 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766859;
	bh=Z4XeeX0XKTJ8cLJ9UNKgUtNPinjPajoTou1H6qgbZqg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F2uRh9EA8suJ13ldza0mFYzU4cpVi3CTljLyrJctg2940pISF5IIMUIwCJJAse/8W
	 H6cxqady13xomz9i5Z7Kd7JBMuVd9Jx1JbzRgqYB/8HSr0cuuCR0g5OADslwNxgN6S
	 ZV9u9xMkbsHsqTs6EaFGMizDjvjLmlYMkYs+uCBVypVV4errvFuZGG1I3/Av+s380A
	 KAkSr1xZRBr6hrgY/cX0ymP9Renz1nPWFoz6qpQaNh/Gn+NtU8F4foF8I/vhnApbr3
	 kXQW0PI2/x3yRlftU+t5aVXiK9hZtnFKUhL9kGk6SeGZti45UZOzdBUVFTZvEYtGbp
	 G+ZQSGSNbfGwA==
Content-Type: multipart/mixed; boundary="===============5496916835098493789=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8bf0343717916d5d484a21b822436fe559cc246abdeb37768a142ed782c6f707@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-11-daniel@iogearbox.net>
References: <20260826164136.1400997-11-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 10/11] selftests/bpf: Add tests for bpf keyring in signed loader
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:54:19 +0000 (UTC)

--===============5496916835098493789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 039b5d044545d..eb78525d33595 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> @@ -1975,6 +2170,11 @@ static void signed_module_kfunc_rejected(void)
>
>  void test_signed_loader(void)
>  {
> +	if (keyring_unsealed_boot()) {
> +		if (test__start_subtest("bpf_keyring_provisioned"))
> +			bpf_keyring_provisioned();
> +		return;
> +	}
>  	if (test__start_subtest("loadtime_no_map"))
>  		loadtime_no_map();
>  	if (test__start_subtest("loadtime_with_map"))

Does the unconditional return here skip subtests that would still work on
an unsealed boot?

The commit message explains that an unsealed boot refuses the session
keyring, so signature-dependent subtests would fail. However, 11 of the
31 subtests never populate attr.signature or attr.keyring_id at all:
metadata_match, metadata_ctx_max_entries_ignored,
metadata_ctx_initial_value_ignored, hash_requires_frozen,
no_update_after_freeze, freeze_writable_mmap, no_writable_mmap_frozen,
map_hash_matches_libbpf, map_hash_multi_element, map_hash_bad_size, and
map_hash_unsupported_type. These subtests test map hashing, freezing,
and metadata features without signatures.

They would pass unchanged on an unsealed boot but are silently dropped by
the return. A side effect is that a targeted run like
'test_progs -t signed_loader/map_hash_bad_size' on an unsealed guest
reports the test as passing while having executed nothing, because
returning before any test__start_subtest() leaves error_cnt at 0 and
registers no subtest.

Would it make sense to let bpf_keyring_provisioned() run first, then fall
through to the unsigned subtests? That would keep the same protection
without the coverage and reporting loss.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============5496916835098493789==--
