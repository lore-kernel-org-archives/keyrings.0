Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF558361944;
	Wed, 26 Aug 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766125; cv=none; b=e9CuUHVaeEkfYfAmq6OD8LUS3Ht81OZp9OkhVzU8zzIoUh1eKMvI3t756uSU45Z6qH3voqicJk2GcKdGR/pCGl8wx/cK+NEeKOQgDj9GCF5DapnfZpftvcCw6sqpuH2AHQGIYIhgChYQD/eOHeurIL92xEur9EVrHgNOODzA5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766125; c=relaxed/simple;
	bh=RqvrSC/u8ffeILHjUMlApnV2ziiY+90xGKbb/yzGqb4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VgJ+ZnIXn7gewstSXU+UMoOK+Px4uZI67YiUhj46YIww0pizCQoO5UCtC92c9/DN0Iz1KJmy0K/P0nN7PHN0CMf3A5P+fO8UIU+LtTg7b/NZmvNeSx8XgrSgZXVH9SeeHCjDQ4nMO8jOY/tBBGp5om0UYfj3cQoNy7B709uWA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMMsRZKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMMsRZKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C61F00A3E;
	Wed, 26 Aug 2026 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766101;
	bh=bEwAyNEyDfKcKpFKCFgjYv1VOJYJhwT0F0AbrT2n5Nc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WMMsRZKHLTpR1D01rTsQdbUwnMhzK+nGelJbXzrfYjfxuHN87WymEfllDa4BLCjdo
	 OZuMHgryBUu7QTPg4SA0RsyY3QF3K4D4g1RKPxsJvaKeluMbBZkyyZiKha386PYPzF
	 g+dUsf2cwuQpa+/RU9lfRa/CZAPFlL8O+nTe34UZKVoNZ9C0h6ZHx1oEDW47Vb1k3v
	 4/rCDveMcyezgyNyf8ho4QCpzwK1+iO4sEo6UlPxKqVmmK0nSIrCja36knScoF3Zgx
	 MnfRHh2lQuBYm4Nx2sPr9e4Fh5zbm8u0r7338bSILmwjKxIr2iJ1zvzmU9Zn5WPdWO
	 NwSzg/JRV5RxQ==
Content-Type: multipart/mixed; boundary="===============5992077780879722460=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e783182c9c90c540f79299ee1a346fdfa600c3686e8500d32dc1c166a54d5f79@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-9-daniel@iogearbox.net>
References: <20260826164136.1400997-9-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:41:40 +0000 (UTC)

--===============5992077780879722460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index ea7044f30adc3..2ec15117abb50 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -51,6 +51,8 @@ CONFIG_IPV6_SEG6_LWTUNNEL=y
>  CONFIG_IPV6_SIT=y
>  CONFIG_IPV6_TUNNEL=y
>  CONFIG_KEYS=y
> +CONFIG_CRYPTO_MLDSA=y
> +CONFIG_CRYPTO_SHA512=y
>  CONFIG_LIRC=y
>  CONFIG_LIVEPATCH=y
>  CONFIG_LWTUNNEL=y

This isn't a bug, but would these two fit more naturally in the
CONFIG_CRYPTO_* block at the top of the file, next to CONFIG_CRYPTO_SHA256,
rather than after CONFIG_KEYS? The file is otherwise maintained in
alphabetical order, and CONFIG_CRYPTO_SHA512 reads oddly 40 lines away from
its CONFIG_CRYPTO_SHA256 sibling.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
> index 202e6e6418fe2..2737c1a2bcfd6 100755
> --- a/tools/testing/selftests/bpf/verify_sig_setup.sh
> +++ b/tools/testing/selftests/bpf/verify_sig_setup.sh

[ ... ]

> @@ -57,6 +57,57 @@ setup_rsa()
>  	keyctl link $key_id $keyring_id
>  }
>
> +mldsa_supported()
> +{
> +	local tmp_dir="$1"
> +
> +	genkey_mldsa "${tmp_dir}" || return 1
> +	: > ${tmp_dir}/probe
> +	# Same digest as the caller signs with, see sign_buf_digest().
> +	./sign-file -d sha512 ${tmp_dir}/signing_key.pem \
> +		${tmp_dir}/signing_key.pem ${tmp_dir}/probe || return 1
> +	rm -f ${tmp_dir}/probe ${tmp_dir}/probe.p7s
> +}
> +
> +genkey_mldsa()
> +{
> +	local tmp_dir="$1"
> +
> +	echo "${x509_genkey_content}" > ${tmp_dir}/x509.genkey
> +
> +	# No -<digest> here: ML-DSA hashes the message itself, and openssl
> +	# rejects an explicit digest for it.
> +	openssl req -new -nodes -utf8 -days 36500 \
> +			-batch -x509 -newkey ML-DSA-87 \
> +			-config ${tmp_dir}/x509.genkey \
> +			-outform PEM -out ${tmp_dir}/signing_key.pem \
> +			-keyout ${tmp_dir}/signing_key.pem 2>&1
> +
> +	openssl x509 -in ${tmp_dir}/signing_key.pem -out \
> +		${tmp_dir}/signing_key.der -outform der
> +}
> +
> +mldsa_skip()
> +{
> +	local tmp_dir="$1"
> +
> +	rm -f ${tmp_dir}/x509.genkey ${tmp_dir}/signing_key.pem \
> +		${tmp_dir}/signing_key.der ${tmp_dir}/probe \
> +		${tmp_dir}/probe.p7s
> +	exit 77
> +}

A subsystem pattern flags this as potentially concerning: mldsa_supported()
collapses every possible failure into a single 'unsupported' verdict. The
calling code in signed_loader.c then reports:

    printf("%s:SKIP:openssl has no ML-DSA support (needs 3.5+)\n", __func__);

But `return 1` in mldsa_supported() is reached for any of: openssl missing or
too old; `openssl req -newkey ML-DSA-87` failing for an unrelated reason;
`openssl x509` failing; `./sign-file` not built or linked against an openssl
that cannot CMS-sign ML-DSA; a write failure creating ${tmp_dir}/probe.

Every one of those reports as 'openssl has no ML-DSA support', and with the
CHANGE-8 modification to catch() at line 145, the openssl/sign-file
diagnostics are deleted for exit 77 cases. In a default
(SELFTESTS_VERBOSE=0) run there is nothing left to distinguish 'ML-DSA
genuinely absent' from 'ML-DSA present but the signing path is broken.'

Would narrowing the probe help here? For example, only treating a
genkey_mldsa failure as unsupported, and treating a ./sign-file failure with
a working key as a real error would keep the broken case visible.

> +
> +setup_mldsa()
> +{
> +	local tmp_dir="$1"
> +
> +	mldsa_supported "${tmp_dir}" || mldsa_skip "${tmp_dir}"
> +	key_id=$(cat ${tmp_dir}/signing_key.der |
> +		 keyctl padd asymmetric ebpf_testing_key @s)
> +	keyring_id=$(keyctl newring ebpf_testing_keyring @s)
> +	keyctl link $key_id $keyring_id
> +}

[ ... ]

> @@ -91,7 +142,7 @@ catch()
>  	local exit_code="$1"
>  	local log_file="$2"
>
> -	if [[ "${exit_code}" -ne 0 ]]; then
> +	if [[ "${exit_code}" -ne 0 && "${exit_code}" -ne 77 ]]; then
>  		cat "${log_file}" >&3
>  	fi

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============5992077780879722460==--
