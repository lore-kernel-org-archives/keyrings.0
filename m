Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51017375F65;
	Wed, 26 Aug 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765392; cv=none; b=b8yl5K1E+u4Z019ake+hcVrjrSZMNmx3m0FwOWQoHigjLId5K7jHQrAO5kAxQ+hlpw4q+wloaw+fxQloVay7LQX6TwPny/rjpiBk1O9kbAEvH9GVOSnk1OKSyuI6+mLd5bzNwu1pVr1kb5uMs4RRYiMrO1iif40b+NCGsWE9jhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765392; c=relaxed/simple;
	bh=IHpSubs3I7mj2LkS2HowxSYFU9IhoGvNIjFMZxWlhvc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bmjEBKPZnXJgqzQ3zmWLlKqZge3jWLIaM7w7lY9DRPsCZn+JhkqlMAfLW7OWp4UvqpJbs9X6YY0juRYjyybyVyDm0/dOKfBzFkefUC9V9JFhgZe53hCc4SDZZbilEPStijVtCQ5Aly32kl9nrZ3Aqg6ugaqS45hjnjLelQpPuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8WVup98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8WVup98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F621F000E9;
	Wed, 26 Aug 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787765376;
	bh=x1NLkkMCEcxfiyNKhz6qBXX+0ZUXE57V6HJcVrklnMA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K8WVup98/Awo8koXqVLpqIP41gR11NIfq01P8fhS+Cm52u7yReQj30ClDhccCKBLk
	 yXwRE/35/spPziMSn9RpvjexLArUThTtY4SWeL7KqQ02Rsl1MbMzPBeu9BB6wtJ/AZ
	 gF+nem9MRdiV3ShYTxdG3xKpUKmY3mbwW6t9f1l5ofkASu7Jd+yZgpnQP+f1bwp2VW
	 ncHxoRNysHDRh72uM2CIZYqPLCewoZ+iIBE8qwznDoyd8aalg+t3UmW+TIoDM4wiEN
	 E32BxE+vUZa7FlH8OOxYZX8qgZIpExwJmd0JJUDawlRSoBFg+Y1WzmoIASZBGcPc4m
	 56+YMNOS5qOTg==
Content-Type: multipart/mixed; boundary="===============6413054825729676466=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4aafb74ee385a13ec7e1b97285fab2f402a76d506e84a4a40c5ccc61477a4129@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-8-daniel@iogearbox.net>
References: <20260826164136.1400997-8-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 07/11] selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:29:35 +0000 (UTC)

--===============6413054825729676466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
> index 09179fb551f09..202e6e6418fe2 100755
> --- a/tools/testing/selftests/bpf/verify_sig_setup.sh
> +++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
> @@ -28,7 +28,7 @@ authorityKeyIdentifier=keyid
>
>  usage()
>  {
> -	echo "Usage: $0 <setup|cleanup <existing_tmp_dir>"
> +	echo "Usage: $0 <setup-rsa|cleanup <existing_tmp_dir>"
>  	exit 1
>  }

This isn't a bug, but while updating this usage line for the rename, would
it be worth listing the other actions main() accepts (genkey,
fsverity-create-sign, fsverity-enable) and closing the '<' bracket, so the
help text matches the dispatch?

> @@ -47,7 +47,7 @@ genkey()
>  		${tmp_dir}/signing_key.der -outform der
>  }
>
> -setup()
> +setup_rsa()
>  {
>  	local tmp_dir="$1"
>
> @@ -108,8 +108,8 @@ main()
>
>  	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
>
> -	if [[ "${action}" == "setup" ]]; then
> -		setup "${tmp_dir}"
> +	if [[ "${action}" == "setup-rsa" ]]; then
> +		setup_rsa "${tmp_dir}"
>  	elif [[ "${action}" == "genkey" ]]; then
>  		genkey "${tmp_dir}"
>  	elif [[ "${action}" == "cleanup" ]]; then


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============6413054825729676466==--
