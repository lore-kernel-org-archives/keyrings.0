Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DD456DED;
	Wed, 26 Aug 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766110; cv=none; b=atFZiNlobX/fzgTertjyCkriCiwd64UQ/CIY9ZeD5UC717x15HetSOX8JZOvK+IL/ms0zj4gmef7fgLZeLeu4qpxLK7d3tpHe5YMUr+S3y7sFZjSFE1ve44NOTNAJFjqTCAhRppi8GWPB0NYcuvcT4M9wheO8ye0JWZ2bIH32Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766110; c=relaxed/simple;
	bh=hb+cgHkVfWIsDUYKxkWPErBR93QSUr+eSJqu1klq9mE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qqHCMvLkCmwr2aW4R7s3Gr0gCqylsGA8GF4NJFQWnGMSGpPMK8Ca2Wqd1ZaMTw3tsoqId7F9dsdFpLnQ6ghVpbZMJNnmHOpD/wYiYPd7fxULh04AoljJXqL+RpjnMPjAhZp5DANaHMcHkgxcBORW6ZdwzBx9I3zX9ucHO1RDI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSsJ/rxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSsJ/rxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D8B1F000E9;
	Wed, 26 Aug 2026 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766095;
	bh=ynOx0Ao/KlvvtKGTYPqe3o1DfAOy41NZ62rwoeJExFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KSsJ/rxxyXN9cev4Tvwi52wA0DaVILfyh6cBCoHisFw5BeSGqbX3f27L+18xP5R4O
	 sJCzgIWncv/bTENrwmmpb7fOKbDmes8hO5TtxezU3Hrl92GDnVVC9TrdWKYESzZRF8
	 41emj/g6fNUKf13lStqfIYJFs8C/8pWeYyZDgf8dxZKjYmtQDnlapmAG1FCmZBywoP
	 MZqX2U8IsQ8QLL9SrwWaMAQMKbt0vMKwrWYBavC5HRmjfWE/YqGPCpGJP1HI6NXKeq
	 knMHe6Ll648OA78+1CUtI46ahjcyaI2gkuc2/AlaLg8PcqrbMZe2MpRcnF/wLWuXkl
	 r2u06AFLKGMzw==
Content-Type: multipart/mixed; boundary="===============6882066040335087117=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <81ed03379aa4633d31ca8f2bb50f6eb372b25be21044075baf334bf8394ccd80@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-3-daniel@iogearbox.net>
References: <20260826164136.1400997-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Refuse caller-supplied keyrings when the bpf one is active
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:41:35 +0000 (UTC)

--===============6882066040335087117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2beb61092bb31..e70fb15757d40 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

[ ... ]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 039674b2f8752..3a7eb2185c354 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> index 08549b3220c13..bffc356839ac5 100644
> --- a/kernel/bpf/keys.c
> +++ b/kernel/bpf/keys.c
> @@ -18,6 +18,11 @@ static bool bpf_keyring_unsealed __ro_after_init;
>  module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
>  MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
>
> +bool bpf_keyring_enforced(void)
> +{
> +	return bpf_keyring_unsealed;
> +}

This isn't a bug, but would a short comment here noting that
bpf.keyring_unsealed doubles as the enforcement opt-in help, given
"unsealed" and "enforced" read as opposites?

The accessor name and the flag it returns read in opposite directions:
unsealed describes the keyring being left open for provisioning, while
enforced describes caller-supplied keyrings being locked out. The
rationale lives in the changelog and later in signing.rst, but keys.c
itself carries no comment about this coupling.

>
>  struct bpf_key *bpf_lookup_keyring(void)
>  {

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b45d201c25357..0950572779948 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21019,21 +21019,28 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>  	if (!attr->signature_size ||
>  	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>  		return -EINVAL;
> -	if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
> -		key = bpf_lookup_keyring();
> -		if (!key) {
> -			verbose(env, "the bpf keyring is empty or has not been restricted\n");
> -			return -ENOKEY;
> -		}
> -	} else if (system_keyring_id_check(attr->keyring_id) == 0) {
> +	if (!system_keyring_id_check(attr->keyring_id)) {
>  		key = bpf_lookup_system_key(attr->keyring_id);
>  	} else {
> -		key = bpf_lookup_user_key(attr->keyring_id, 0);
> +		if (attr->keyring_id != KEY_SPEC_BPF_KEYRING) {
> +			if (bpf_keyring_enforced()) {
> +				verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
> +				return -EPERM;
> +			}
> +			key = bpf_lookup_user_key(attr->keyring_id, 0);
> +		} else {
> +			key = bpf_lookup_keyring();
> +		}
>  	}
>  	if (!key) {
> -		verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
> -			attr->keyring_id);
> -		return -EINVAL;
> +		if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
> +			verbose(env, "the bpf keyring is empty or has not been restricted\n");
> +			return -ENOKEY;
> +		} else {
> +			verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
> +				attr->keyring_id);
> +			return -EINVAL;
> +		}
>  	}

This isn't a bug, but would a flat else-if chain here keep the
KEY_SPEC_BPF_KEYRING test in one place and avoid the extra nesting
level, or is the grouping of the non-system cases deliberate?

The keyring selection goes from the flat else-if chain the preceding
commit in this series introduced to a nested else { if ... else ... }
form, and attr->keyring_id == KEY_SPEC_BPF_KEYRING is now tested
twice - once negated for branch selection, once positively in the
shared if (!key) error path. The if (!key) block also uses else after a
return. A flat chain would express the same thing with one test of each
condition and one less nesting level:

	if (!system_keyring_id_check(attr->keyring_id)) {
		key = bpf_lookup_system_key(attr->keyring_id);
	} else if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
		key = bpf_lookup_keyring();
	} else if (bpf_keyring_enforced()) {
		verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
		return -EPERM;
	} else {
		key = bpf_lookup_user_key(attr->keyring_id, 0);
	}

Flat else-if chains at this indent level are the dominant idiom in
verifier.c (72 occurrences).

>
>  	sig = kvmemdup_bpfptr(usig, attr->signature_size);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============6882066040335087117==--
