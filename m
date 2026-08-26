Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFB466B17;
	Wed, 26 Aug 2026 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766116; cv=none; b=AcxcME7+hbK+Y26VvoTkUxuDd/MDZLvcsHYID6LIHmZD/xR4VaOMlKWy+87svxxSAS3SRkCz//bV8uNXLhNef5OmJn+DAhJgTCDO6tcmv1t7TP+JSX3vi/YWBcMc93uajawuh6wnIVwYANF/ZTm0TNs2psqh73d4e38OKW+2ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766116; c=relaxed/simple;
	bh=yZ3HevPY6qxZrpzcS0h/Jgq/yDXblzQL5Pix1HvuYRg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XsFfiPRw1NWNFXh02W/XeBSX9Ryg0I7ykLTQxFVz63VVK353hULurKM7MSxdK3jEvpw0kqG7BprsIusL2CV8lD2Y7Cr/8RPT80imG1nk9yB4IshpyyGdNlO8WI58VlKgYb0anCyNGR+0uBoOIzi0W8Ub1zXSQTRnZDeI8I1hidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhvqL4Ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhvqL4Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2301F00A3A;
	Wed, 26 Aug 2026 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766097;
	bh=y5bGHWgsqfCpD3oqct6docn0mEzGiKUOzAm81aBRytY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UhvqL4AxKOCqFm1IeHDH6VZ3CfAxJyyZH5WA5ObWizE9MxRlnIFDhT7uLxQcGULM9
	 HDdpek2h9ZB9Ot6yQI+Yz6LoO1NaWyOwjagdo91vexohf8Oreuitcl3cd10M4SOjy6
	 f/U7KuzFMqS9EXrmNJVHOs9dqFR8oSu/L4Drmd5neNg316i779fI+hr8FKWssFlhzN
	 lEcIMWC2TUGgw/g5H2OGq7bhxypn714OQkd/tnQmtEGmuuKJwOnpXRX/L1Qwh52DbK
	 9kpusWruiIhtZ6JWdGuZHdbnQAD26nD2OlzyeSaEPCiTXUQq/ob1lsl3Y2vP9P6fng
	 DK8t/HpqwhvCA==
Content-Type: multipart/mixed; boundary="===============2045058904401121369=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc867c621433391199df821596ce0f67a22289e4eece889b8eac1aa5f5f4c20f@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-6-daniel@iogearbox.net>
References: <20260826164136.1400997-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 05/11] selftests/bpf: Add a test for the sealed bpf keyring
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:41:37 +0000 (UTC)

--===============2045058904401121369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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

This isn't a bug, but is BPF_SIG_KEYRING_BPF referenced anywhere yet, or
is it here to keep the mirror of enum bpf_sig_keyring complete for a
follow-up?

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

This isn't a bug, but since the bool param is always rendered as Y/N by
param_get_bool(), would a plain `val == 'Y'` read more directly here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============2045058904401121369==--
