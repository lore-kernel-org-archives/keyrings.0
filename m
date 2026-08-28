Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC313BC687;
	Fri, 28 Aug 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943207; cv=none; b=J0t9cI+GmbZAjEDCySuHdeF+EiWTGxLNnlfN6khro6AvP7aRUuLDaNW4g/8VTgzcY98JwWFw8LdzF0hkRJY1reyJtitwRQLeY8VXiVR+/0f7x1+0SA1Cr+OfBMHAvN/xFbe8OjkXArTAii+6MH0QxsOJOjVIHOo/lg6mgghoeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943207; c=relaxed/simple;
	bh=v685qp/qLlsFbb3TpUalCVY1HGrkqGeOa+KuVcNHny0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WkE8DzeS+99p2N6ElLDg+90AZx26OIfRjrFoxkkoyHIo2uqiLjNFt5wK/ZqhmXo79NbbE2sfnbcQkpG9rZXI8sFBK9qCpd52BZhKa5jiqImxf0mVtIV24StzEHepwbmoCa2YBbo4oKpLlo6tn9F1fTvvRAb3K8fcxSw4VomR7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IphqBf7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IphqBf7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF121F00A3D;
	Fri, 28 Aug 2026 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943203;
	bh=rjG/xRl5gkiwMQ72LCL1Wnz4Vsa2zyPJp4A0SQ44dZY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IphqBf7BEEpVhnuK74neQx8zlCG64XY/EgGZ4ob+UcZbia9xI3//IuEY0u12QMVRx
	 RPWLoB6De1kDEGGhdDGOXP8C2BTflivrI9+uzEORTGnIkDUL8gghFSfjcM7Xg8YFd6
	 bOdew66E4v9ZzR16Nf8gkeMttJtDcBLRQ7lluF+nOD5McqiiPLPrzwK6GDBf5s1k7Z
	 MM8xok6Cr3IAL0OE4hKCQKZ8PFDmV+E4yzfDUNd9Y8VAzSLemL4N52rT3A6PbDvtH6
	 Hf6ihTwCO8YhPPEJunwoxWXxp/UyASQtc5pWhQRHAZKeK+f3oQRxlmm3tYZ1HgxAfe
	 JugvQeez6hexg==
Content-Type: multipart/mixed; boundary="===============6265881278863570823=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0b7f404558aa401ea95ccaa30bd5423374f49f287999b8f7e87379e7c4759fc@mail.kernel.org>
In-Reply-To: <20260828175227.1537793-9-daniel@iogearbox.net>
References: <20260828175227.1537793-9-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 18:53:22 +0000 (UTC)

--===============6265881278863570823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
> index 202e6e6418fe2..ba5921e4b12d2 100755
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
> +	# No -<digest> here: ML-DSA hashes the message itself, so openssl
> +	# ignores an explicit digest for it.
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
> +

This isn't a bug, but genkey_mldsa() and setup_mldsa() look like
near-verbatim copies of genkey() and setup_rsa(), with only the openssl req
flags differing for genkey_mldsa() (-sha256 dropped, -newkey ML-DSA-87
added) and the probe call for setup_mldsa(). Would passing the extra openssl
req flags and the keygen function name as parameters to the existing helpers
work here instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33197746599
--===============6265881278863570823==--
