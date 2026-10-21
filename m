Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590856;
	b=tIRVry9uLcQhMXXb/Vj8UE/kZgpqkaIt8eVebFfbM2rU7vhlpG9b/xV52FkWJ6BR4WCO
	 WHwoPj0d4Hu93OR/M8nxrG30dGdyuvd/O8qi/bt6Z2zKKqPcVR8JMICDBU3xnqJV4BCMo
	 biWKvTmIGZAEAb3GXi90zJ0BVN8pIfTdPnicJDaPsWdrYcT0jrZi1gaZ2JRf7i1mlSzWm
	 C6INYLwFzxgqD17hBB7R8ews0TI+Ywuv6/qV5UQ7iUwCba0nxbLaPtSEFfd47hKsEfNU7
	 sml+pPYpi0ZcQUoOw9OhTwX2MqPJx3mQvoDuwivTqO3s+qcllF3c5+jnVqkcwMnOtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590856;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FDNNWaOPtMA9qs4CREujGnfrcXs+rMZ9c2Bi8CYQVb0=;
	b=b8FHg1SsXMRC/++MYW4jUCYS6N0kLoy+hhfhiWiYaHJH5HfeseihL/cDMW958XhfMcfj
	 qYu1UOrdzETKro0nQz3sHZdIT3ZQFd8TvHY4K/nBS8P/nUvtJxbb3YorEgM3Vbip+Hw/4
	 58pTKZf6La81OSY++WKrktYiVUhCzyGBuki5pEULEgGzMDCIsK1hXEsN64jrhdUqzklXu
	 uPB5iV+zToByN5/iIzksofP9cbHuqdhlx2V9PICTXiEiDJHvodMipZm10u7Dra5uUjER8
	 idcCOfJdaADKfUv87p33Spy4ArNb+EKfFGeOqMpdBvRDqd3eGjMe4n6NjSodRy1x/4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGoJ44vj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93A606A31E;
	Wed, 21 Oct 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGoJ44vj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99DD1F000C5;
	Wed, 21 Oct 2026 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792590855;
	bh=FDNNWaOPtMA9qs4CREujGnfrcXs+rMZ9c2Bi8CYQVb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YGoJ44vjhGHr+aR0tbIV9YuvFaXJilSwaP7iIwHF22YUtS+pJjG4dUZH3SIAKsgPy
	 1rIMCeUkr+U+bFVVn1ybFnMl3TJiJ1yF7LtcyJ5ZLKsL6dwgMIe7szO7AeQ/agA5lG
	 KUZDM0Ll+g3L9bgTCJioNUVgFqnyrUJlzmlBPMGUPyaFtHGAW8VHLEVeLgJVQZzHHi
	 gbaZO80Lhe8V7RqkHKbZWxo5GGIIwj+FHLK70aAMSzS+4Djfe2wbTDdMqQ/3iQ0ak7
	 6WcYvKYviL3G2ApmUj4IBSzqIXep7Jud10PEgLW5KVFv1MvW+40z0XsX9tRQvQxcx0
	 FSzDobcDbR8Iw==
Date: Wed, 21 Oct 2026 15:54:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Fan Wu <wufan@kernel.org>
Cc: manuelh@nvidia.com, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Message-ID: <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>

On Mon, Oct 19, 2026 at 04:15:57PM -0700, Fan Wu wrote:
> 
> 
> On 10/19/2026 2:40 PM, Manuel Huber via B4 Relay wrote:
> > From: Manuel Huber <manuelh@nvidia.com>
> > 
> > Add a dedicated .ipe keyring for IPE policy signature verification,
> > modeled after the .dm-verity and .bpf keyring implementations.
> > 
> > With this, userspace can provision its own keys into the keyring,
> > then restrict it and activate it for IPE policy signature verification.
> > 
> > This enables scenarios in which a trusted userspace component generates
> > an IPE policy, and creates an ephemeral policy-signing key pair,
> > provisions its public certificate, and restricts the IPE keyring during
> > the early lifetime of a system. The trusted component can then sign the
> > IPE policy, destroy the private key, and load and activate the policy.
> > During that phase, the system is considered in a trusted state whereas
> > the system transitions into a possibly untrusted state afterwards,
> > running arbitrary user-provided applications. In such a scenario, the
> > trusted userspace component could reside on a dm-verity protected
> > rootfs disk, and applications would reside on additional dm-verity
> > protected disks. The latter disks would be dynamically attached and
> > their dm-verity root hashes and/or signatures not known a priori to
> > launching the system.
> > 
> 
> You might need to explain why the existing keyrings, i.e. builtin/secondary/platform cannot be used in your scenario. Like the firmware is not trusted?
> 
> > A concrete usage scenario could be Kata Containers, which enables
> > running Kubernetes pods in ephemeral, headless utility VMs, possibly
> > without systemd. The rootfs disk is static and known beforehand, but
> > containerd's image layers might be acquired and transported into the
> > VM using the erofs snapshotter and dynamic block device attachment
> > using dm-verity.
> > 
> > Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++
> >  security/ipe/Makefile                           |  1 +
> >  security/ipe/ipe.c                              |  2 +
> >  security/ipe/keyring.c                          | 79 +++++++++++++++++++++++++
> >  security/ipe/keyring.h                          | 16 +++++
> >  security/ipe/policy.c                           | 10 ++++
> >  6 files changed, 117 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e75344f4e0cd..fd508dd779ed 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2733,6 +2733,15 @@ Kernel parameters
> >  			Determine whether IPE starts in permissive (0) or
> >  			enforce (1) mode. The default is enforce.
> >  
> > +	ipe.keyring_unsealed=
> > +			[IPE]
> > +			Format: <bool>
> > +			When set to 1, leave the IPE policy keyring
> > +			unsealed after initialization so userspace can provision
> > +			keys. Once the keyring is nonempty and restricted, it is
> > +			searched during policy-signature verification. The default
> > +			is 0, which creates the keyring restricted and empty.
> > +
> 
> I would prefer a Kconfig CONFIG_SECURITY_IPE_KEYRING default to N instead, like the fsverity keyring. In the kconfig you can also describe in which cases should this option be turned on. 
> 
> >  	ipe.success_audit=
> >  			[IPE]
> >  			Format: <bool>
> > diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> > index 2ffabfa63fe9..109e736696a5 100644
> > --- a/security/ipe/Makefile
> > +++ b/security/ipe/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_SECURITY_IPE) += \
> >  	hooks.o \
> >  	fs.o \
> >  	ipe.o \
> > +	keyring.o \
> 
> with Kconfig this can be obj-$(CONFIG_IPE_KEYRING) += keyring.o
> 
> >  	policy.o \
> >  	policy_fs.o \
> >  	policy_parser.o \
> > diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> > index 495bb765de1b..f5232f850dc2 100644
> > --- a/security/ipe/ipe.c
> > +++ b/security/ipe/ipe.c
> > @@ -7,6 +7,7 @@
> >  #include "ipe.h"
> >  #include "eval.h"
> >  #include "hooks.h"
> > +#include "keyring.h"
> >  
> >  extern const char *const ipe_boot_policy;
> >  bool ipe_enabled;
> > @@ -97,4 +98,5 @@ DEFINE_LSM(ipe) = {
> >  	.init = ipe_init,
> >  	.blobs = &ipe_blobs,
> >  	.initcall_fs = ipe_init_securityfs,
> > +	.initcall_late = ipe_keyring_init,
> >  };
> > diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
> > new file mode 100644
> > index 000000000000..ea8d164b62a6
> > --- /dev/null
> > +++ b/security/ipe/keyring.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> > + */
> > +
> > +#include <linux/cred.h>
> > +#include <linux/err.h>
> > +#include <linux/key.h>
> > +#include <linux/moduleparam.h>
> > +
> > +#include "ipe.h"
> > +#include "keyring.h"
> > +
> > +static struct key *ipe_keyring __ro_after_init;
> 
> You can remove static here then the other ipe code can directly use the variable instead of a function call. 
> 
> > +
> > +static bool ipe_keyring_unsealed __ro_after_init;
> > +
> > +/* Set the right module name for built-in parameters. */
> > +#ifdef KBUILD_MODNAME
> > +#undef KBUILD_MODNAME
> > +#define KBUILD_MODNAME "ipe"
> > +#endif
> > +
> > +module_param_named(keyring_unsealed, ipe_keyring_unsealed, bool, 0444);
> > +MODULE_PARM_DESC(keyring_unsealed, "Leave the IPE keyring unsealed");
> > +
> 
> ...
> 
> > +
> > +/**
> > + * ipe_keyring_init() - Allocate and configure the IPE keyring.
> > + *
> > + * Return: Always %0. A failure leaves IPE without its dedicated keyring.
> > + */
> > +int __init ipe_keyring_init(void)
> > +{
> > +	struct key *keyring;
> > +	int rc;
> > +
> > +	keyring = keyring_alloc(".ipe", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> > +				current_cred(),
> > +				KEY_POS_SEARCH |
> > +				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
> > +				KEY_USR_SEARCH | KEY_USR_SETATTR,
> > +				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
> > +	if (IS_ERR(keyring)) {
> > +		pr_err("failed to allocate keyring: %ld\n", PTR_ERR(keyring));
> > +		return 0;
> 
> You might need to panic here like the fsverity kerying.
> 
> > +	}
> > +
> > +	if (!ipe_keyring_unsealed) {
> > +		rc = keyring_restrict(make_key_ref(keyring, true), NULL, NULL);
> > +		if (rc) {
> > +			pr_err("failed to restrict keyring: %d\n", rc);
> > +			key_revoke(keyring);
> > +			key_put(keyring);
> > +			return 0;
> > +		}
> > +	}
> 
> This looks kind of awkward, like if unseal is not set, it can create an empty keyring then immediately seal it. I would switch to the fsverity's approach to let userspace seal it.

Please don't start breaking an established pattern that works well.
We're now using this with both bpf and dm-verity with
systemd-keyring-setup. The point is that the keyring is intentionally
inactive unless it is sealed and restricted. That is part of the
security model. fsverity is used as soon as any key is enrolled which
doesn't give userspace a throwaway the key moment.
