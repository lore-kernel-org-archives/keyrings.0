Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700750;
	b=5aO4L/f4cg/zHzS9bOL1RrrXYL3ldN+fBiBGLRpOHUpeN8gFRKcGbfSXCsb0kykr4D6t
	 aAR/+BK4gAm4c7exc3TGXVKjiqRWbbY+qko/WdWtCXtzo6jHopqmLRGzATjJOGKjVlW3B
	 HqNqS4SlDPxf2fEe/f8u/aaEhzGyLbIQ0SJUAcigHLn9BdXoQHgq8B5duFqRlL+hPSrl8
	 scDDd2M9mpFquf1+8FPRR+OroPAxe/lo5o9zGkFEn5CAzmiSxh8ApgbihmINZ+mf7TviX
	 xlK8nf1JOVN/6Xc4aGvh/5Gp7X02jp3PIuCOSZWVzWAJ64/Ci92/Nf8Ig9B2Hz5ww4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700750;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ux1UTnRjOyGqJzOYM5Hv6XVTNeyYxnuotg3pXhf5HHs=;
	b=waRzbVwjosYBWAXuarYS9W5BBZG/4wCrCKRqRLIPM/HJnYNMnz0HWqaBX/zw9G/pTULt
	 bajrovIiZGOPQgXjEjYVtR4DDk+QzED5EtKnpuXMKmLab+ZrWesdkAN+dj1aKDyuomthr
	 juSCikXk+6LPMyqsjJuplVkLHny52QnGD6tfuvTWsJ1tb4pCqn2wLPUDh5AAhBp6Nk/Mj
	 htI4pngNpcv+V2kdr5N/gVCI3e4wjuwvexLaBn7iizjXjfHJaCFgkPME0PYDduHBmMb6y
	 IiMBBQfYmLtu8YPcc7XHx93fS7qhWu+lYaWExfibbXTYmq32Uw2o2GCD22Aq6PjECBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLMS0l8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6249606A325
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLMS0l8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68F11F031E6
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700749;
	bh=ux1UTnRjOyGqJzOYM5Hv6XVTNeyYxnuotg3pXhf5HHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RLMS0l8SrlVSlB+xSKm6w6FYJ1BVIP2OUvpbyz9MikbM20bH8i83IdqYLHnzS4qj9
	 vo6B8FxfAsRueY9WSJTqmuWYCQSQkIN60PxS1EOjtlPkF8g30tel+vLlAPnohHXmRv
	 /Vbi1+UaOcDgUZ0i0fi6x/na8nusRwiADaFX9FXU32HXstuRnUFimv6wlTGqn34WfD
	 QMfTzkYILeeei8YsWI50/UKTnIXVBnU/aSI39gffsIi6/ScqbVu8/ubBXYIWQU9gCd
	 GSwDnvTkIbRy4NYjw2TbXlJoApzGgMFRPZgGDgCAPArwrn6dScfyWS8TCD77ysDeE5
	 19uIGvmDPyrRA==
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-156cbe59622so166625c88.0
        for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 13:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzefk26VQnuUv16lQOcDYA4uNmveHCTURF1RIrpkwd9sq6h/tPNs0c1+YTQSHFKWBsDEEg9tLGgvw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJlYlhMr28CROf8ArV0kPaSZkn0nk2qUwcPgBghorWf2+oyM2pY
	yPi//iRRKaVrX7qB/5vIErrsnO5Fx5pF3kSrO0hvE/gMKZzJt4Hlx8XGhclZghQ8lVvZvk0kwSq
	e/kw0U7x4nKIqQYHwTY7sWqf6VPkTYWQ=
X-Received: by 2002:a05:7022:1707:b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-1959a382fb4mr475195c88.38.1792700748990; Thu, 22 Oct 2026
 13:25:48 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 22 Oct 2026 13:25:36 -0700
X-Gmail-Original-Message-ID: <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
X-Gm-Features: AclHuK-w0c1onI8im_hxrE8Vj8Tb7-7Hy-SNC8hLk4Qv6iomWwee3Oh6ZTdAJrg
Message-ID: <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Manuel Huber <manuelh@nvidia.com>
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:02=E2=80=AFAM Manuel Huber <manuelh@nvidia.com> =
wrote:
>
> On Mon, Oct 19, 2026 at 04:15:57PM -0700, Fan Wu wrote:
> > You might need to explain why the existing keyrings, i.e.
> > builtin/secondary/platform cannot be used in your scenario. Like the
> > firmware is not trusted?
>
> As touched upon in [1], the scenario uses an ephemeral VM whose
> IEP policy would be assembled after boot. There is a mix of explicitly
> trusted dm-verity root hashes and possibly signed dm-verity layers
> which can vary per VM, so the final IPE policy would not necessarily
> be known ahead of time.
>
> This specific scenario is Kata Containers on Kubernetes. Each
> Kubernetes pod runs in a headless Kata VM with a static dm-verity
> protected rootfs, while its container image layers are delivered
> dynamically as dm-verity protected block devices. The kata-agent acts
> as trusted bootstrap userspace and would author the IPE policy for that
> particular guest before starting its workload containers.
>
> The firmware is trusted in this scenario. A public policy-signing
> certificate could be compiled into the builtin keyring or provisioned
> through the platform or secondary keyrings. Because the policy would be
> authored inside the guest, however, the corresponding private key would
> also have to be shipped as a static artifact in the guest rootfs and
> shared by every guest using that build.
>
> Instead, the kata-agent would generate an ephemeral, per-guest
> policy-signing key pair, provision its public certificate, sign the
> policy, destroy the private key, and restrict the keyring before
> allowing untrusted code to execute.
>
> A dedicated .ipe keyring thus provides a purpose-specific runtime
> provisioning path for this scenario. Once the certificate has been
> added, the keyring can be restricted against further enrollment.
>
> I envision other scenarios with similar characteristics may benefit from
> a dedicated .ipe keyring as well.
>
> I could elaborate more on this, e.g., on the how users' deployed
> container images translate to dm-verity protected image layers etc.
> (the erofs snapshotter is used and there is no filesystem sharing
> between host and guest, image layer transport is realized via block
> device attachment), but I am trying to keep this response brief. Some
> more breadcrumbs on the combination of containerd, IPE, Kata can be
> found in [2] and [3].
>
> [1] https://lore.kernel.org/r/SJ1PR12MB61246B0BF58BC2B6F0A79D30DE9F2@SJ1P=
R12MB6124.namprd12.prod.outlook.com
> [2] https://github.com/containerd/containerd/issues/12081
> [3] https://github.com/kata-containers/kata-containers/issues/10943

Thanks for the explanation. This clarifies a lot. Please include this
context in the commit message and doc for v2.

Also, one thing I missed earlier: before the policy verification call,
please also check:

ipe_keyring->restrict_link->check =3D=3D restrict_link_reject

so we make sure the restriction function is the right one.

Fan
