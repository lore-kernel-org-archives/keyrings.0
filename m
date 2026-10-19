Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451759;
	b=r3XvS67NmwmCthMpViVYj4gVfYfuNNM4z/8UuFPuNLEkHHqIdUuLDRnjHc3/NaDc5UYO
	 1z0Zsl5ZFuguERnhlkTSharwYsKI6YPll2YIW8+qt/21OVX5FoLkXnc/8oqLmtJEAytRO
	 54a47+BtxBg9EpGceim3AFTvkTlV4r+NmGlUSTMNryZiEw2lBUvoXICPV/E8370ToEmcz
	 cTxdaY+MjphkexSZBqMtp+OOnQH51SwmJjEPVyvJXbwEP8aQtNs3vpErS44tcE95OmF3Y
	 Q9oc/CHwa4StI5GEA8D5nnLajJi4h+sKWNwmhu2pPXq2vQXK3RWElgjIeTSvYmcox3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451759;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZFh4t2a+XC8DHJvTpV0MW4bJipbpqLj03+M6T9LwwnI=;
	b=MosacQhYQ4TWqBBprm4hgMeV63T/9LKRxZDvRo5rtGXtkCAGZZoDI0sj7+3BN7N6ffWn
	 yHGz10nwCOqSLnaTzQjz0grbl23yHk5LmFjvI22N6/3xb0xwIJgdkLOTFNSmy9kJXPx/y
	 NUOFeGkwWZ34A8MiV7S4YdqfSXzHjsvjsR8Gv3xdp3FR1gLb0A1HrEY0z5YDCNx2bt1uj
	 9x4+Q56FQ1clL9pvKaPs6EnH98qocRr4LWT5+zDxBuG0rHtkxPSH7VyA4GsPO5HTasUiC
	 yxUGxEa7vJvNNJi415ec+LmQ9m43govz7cBFTNfKaIOwCoQAZ5SbJqijydcXKtz3hGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPIOEqzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA340606A31A;
	Mon, 19 Oct 2026 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPIOEqzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB371F000C4;
	Mon, 19 Oct 2026 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451758;
	bh=ZFh4t2a+XC8DHJvTpV0MW4bJipbpqLj03+M6T9LwwnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bPIOEqzKnmKauAtxooCrPQvPo9UW0wwVRVFWyPm/EFIRdYWNuLal3MOkYwCxk+ckc
	 qsI6gRZEEft2sEl58tKgnJRrJSPMOLCq3dCSFvudrL4YQAKPDo0p4LHZG/Oel0uv9o
	 mqY5ty8k37BBkJMg+Vk8VmNMLze5a0tT78MMuBqFii2pT0URI+OmkDsbEizwdmxGTK
	 iZ/CrN8vPzXUyvy4G2ZRm4OXOGzy3Jv7W949rxatRhlMwLlpo9rJFieOjyCEMKZder
	 vkE3FgPykTxNNkIErS9wR93pSPftiMRneXy1NRffwHxX2OhvvRwABnrlWy3/SyDZG7
	 HRSJv16QpB3og==
Message-ID: <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
Date: Mon, 19 Oct 2026 16:15:57 -0700
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: manuelh@nvidia.com, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/2026 2:40 PM, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> Add a dedicated .ipe keyring for IPE policy signature verification,
> modeled after the .dm-verity and .bpf keyring implementations.
> 
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
> 
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.
> 

You might need to explain why the existing keyrings, i.e. builtin/secondary/platform cannot be used in your scenario. Like the firmware is not trusted?

> A concrete usage scenario could be Kata Containers, which enables
> running Kubernetes pods in ephemeral, headless utility VMs, possibly
> without systemd. The rootfs disk is static and known beforehand, but
> containerd's image layers might be acquired and transported into the
> VM using the erofs snapshotter and dynamic block device attachment
> using dm-verity.
> 
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++
>  security/ipe/Makefile                           |  1 +
>  security/ipe/ipe.c                              |  2 +
>  security/ipe/keyring.c                          | 79 +++++++++++++++++++++++++
>  security/ipe/keyring.h                          | 16 +++++
>  security/ipe/policy.c                           | 10 ++++
>  6 files changed, 117 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e75344f4e0cd..fd508dd779ed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2733,6 +2733,15 @@ Kernel parameters
>  			Determine whether IPE starts in permissive (0) or
>  			enforce (1) mode. The default is enforce.
>  
> +	ipe.keyring_unsealed=
> +			[IPE]
> +			Format: <bool>
> +			When set to 1, leave the IPE policy keyring
> +			unsealed after initialization so userspace can provision
> +			keys. Once the keyring is nonempty and restricted, it is
> +			searched during policy-signature verification. The default
> +			is 0, which creates the keyring restricted and empty.
> +

I would prefer a Kconfig CONFIG_SECURITY_IPE_KEYRING default to N instead, like the fsverity keyring. In the kconfig you can also describe in which cases should this option be turned on. 

>  	ipe.success_audit=
>  			[IPE]
>  			Format: <bool>
> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> index 2ffabfa63fe9..109e736696a5 100644
> --- a/security/ipe/Makefile
> +++ b/security/ipe/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_SECURITY_IPE) += \
>  	hooks.o \
>  	fs.o \
>  	ipe.o \
> +	keyring.o \

with Kconfig this can be obj-$(CONFIG_IPE_KEYRING) += keyring.o

>  	policy.o \
>  	policy_fs.o \
>  	policy_parser.o \
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 495bb765de1b..f5232f850dc2 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -7,6 +7,7 @@
>  #include "ipe.h"
>  #include "eval.h"
>  #include "hooks.h"
> +#include "keyring.h"
>  
>  extern const char *const ipe_boot_policy;
>  bool ipe_enabled;
> @@ -97,4 +98,5 @@ DEFINE_LSM(ipe) = {
>  	.init = ipe_init,
>  	.blobs = &ipe_blobs,
>  	.initcall_fs = ipe_init_securityfs,
> +	.initcall_late = ipe_keyring_init,
>  };
> diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
> new file mode 100644
> index 000000000000..ea8d164b62a6
> --- /dev/null
> +++ b/security/ipe/keyring.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/key.h>
> +#include <linux/moduleparam.h>
> +
> +#include "ipe.h"
> +#include "keyring.h"
> +
> +static struct key *ipe_keyring __ro_after_init;

You can remove static here then the other ipe code can directly use the variable instead of a function call. 

> +
> +static bool ipe_keyring_unsealed __ro_after_init;
> +
> +/* Set the right module name for built-in parameters. */
> +#ifdef KBUILD_MODNAME
> +#undef KBUILD_MODNAME
> +#define KBUILD_MODNAME "ipe"
> +#endif
> +
> +module_param_named(keyring_unsealed, ipe_keyring_unsealed, bool, 0444);
> +MODULE_PARM_DESC(keyring_unsealed, "Leave the IPE keyring unsealed");
> +

...

> +
> +/**
> + * ipe_keyring_init() - Allocate and configure the IPE keyring.
> + *
> + * Return: Always %0. A failure leaves IPE without its dedicated keyring.
> + */
> +int __init ipe_keyring_init(void)
> +{
> +	struct key *keyring;
> +	int rc;
> +
> +	keyring = keyring_alloc(".ipe", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				current_cred(),
> +				KEY_POS_SEARCH |
> +				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
> +				KEY_USR_SEARCH | KEY_USR_SETATTR,
> +				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
> +	if (IS_ERR(keyring)) {
> +		pr_err("failed to allocate keyring: %ld\n", PTR_ERR(keyring));
> +		return 0;

You might need to panic here like the fsverity kerying.

> +	}
> +
> +	if (!ipe_keyring_unsealed) {
> +		rc = keyring_restrict(make_key_ref(keyring, true), NULL, NULL);
> +		if (rc) {
> +			pr_err("failed to restrict keyring: %d\n", rc);
> +			key_revoke(keyring);
> +			key_put(keyring);
> +			return 0;
> +		}
> +	}

This looks kind of awkward, like if unseal is not set, it can create an empty keyring then immediately seal it. I would switch to the fsverity's approach to let userspace seal it.

> +
> +	ipe_keyring = keyring;
> +
> +	return 0;
> +}
> diff --git a/security/ipe/keyring.h b/security/ipe/keyring.h
> new file mode 100644
> index 000000000000..3d450a465511
> --- /dev/null
> +++ b/security/ipe/keyring.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#ifndef _IPE_KEYRING_H
> +#define _IPE_KEYRING_H
> +
> +#include <linux/init.h>
> +
> +struct key;
> +
> +int __init ipe_keyring_init(void);
> +struct key *ipe_keyring_lookup(void);
> +
> +#endif /* _IPE_KEYRING_H */
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index e542329726bc..abc1ff9ac230 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -9,6 +9,7 @@
>  #include "ipe.h"
>  #include "eval.h"
>  #include "fs.h"
> +#include "keyring.h"
>  #include "policy.h"
>  #include "policy_parser.h"
>  #include "audit.h"
> @@ -160,6 +161,7 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>  				  const char *pkcs7, size_t pkcs7len)
>  {
>  	struct ipe_policy *new = NULL;
> +	struct key *keyring;
>  	int rc = 0;
>  
>  	new = kzalloc_obj(*new);
> @@ -189,6 +191,14 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>  						    VERIFYING_UNSPECIFIED_SIGNATURE,
>  						    set_pkcs7_data, new);
>  #endif
> +		if (rc == -ENOKEY || rc == -EKEYREJECTED) {
> +			keyring = ipe_keyring_lookup();
> +			if (keyring)
> +				rc = verify_pkcs7_signature(NULL, 0, new->pkcs7,
> +							    pkcs7len, keyring,
> +							    VERIFYING_UNSPECIFIED_SIGNATURE,
> +							    set_pkcs7_data, new);
> +		}

With Kconfig this part can be just like the above cases. 

Fan

>  		if (rc)
>  			goto err;
>  	} else {
> 

