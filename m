Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823309;
	b=raajG4ruTAmusBQaLsKKliEsPTEpsgNjKct3MZ5JYjLe4Si4OJGBks7MM9IHTM9rDSNK
	 949G++JM0taXuiuNnHQbjpjmGTr6ywFhZo43xGV3+AhaeQApiA4XqOyvGoEvvdt7WYRjl
	 PlwL34jSx/u98puvLtn3KUwEgGmLn7m0t9OTnfOeVmr5jXDHE4DUSKKmEtWoPlduvuTj3
	 xmKuszWsnMQUxgqC/DGhD6LqGAfFDldVDEtLpEw5y4NDhYKuCd6a0HQl5oGzuKzcQZZY7
	 oymMzNpUO1ohEnu4rXI7aJQISermx5Msr4zRoC2LOsVKZM9RxFFkSHNIfoGjxxCtOiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823309;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=;
	b=BoikOALVxeA2RRWsbsVu9CSM5bmF+oQLvjFK8MnmA1w1jypAccEzCH0x4+IqAoboYVs+
	 jRJN0OPjDbExwONxHsoOGMGh9bNoQZ5rRAjroAYBsmpaq/NDa+CmGFNaVlZD8C3UBZGvO
	 Hw0tlmzuMhG2KM4OsdkoSfjDFFvrkqrOgOT7Zgu5Cdet24Zk5EOgmxPy6k1t5GpBJjUMz
	 Kvt7ah6tTfre/hMa3LsS4tZgtTUOh7x5Snn03CtzsG3e1zWEdt3TrqW58CiQC9uhTXGqI
	 OlbrAYIYtUoRu6O7kVtRwoRwooC1kbTFEZiJOVpg1yuscUkIuy1oEh/HF64Wd1yBtXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gocBBGef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE260A5BE6
	for <keyrings@vger.kernel.org>; Wed,  4 Nov 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gocBBGef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27ED1F000C1
	for <keyrings@vger.kernel.org>; Wed,  4 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823308;
	bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gocBBGefUS86VeDGr2GnpTXWHIBcyehEC2BzWYaGTs+R5yXx9Am/8Bh5+zeBlQHk8
	 PmhLKfvq8zVEbvNUsXvs7sMBwkgWDqScd2gBkB7tdvNcnSQ1CpRA81wa96QKKdGiP+
	 NKezweyP7HIPECGSFAQQ99swLRmH3aHllYpNahkuGi0/kw9zYNCwq4ciTGyB1Wwczm
	 N2BxU7G15rVtzlE+3zhsr0aieZPwhUfbwbnno+A7oNNVdrJ5ZQQ/bD8E1KRhsYD9tl
	 CerEHtHV04E2LVDCt47D3yJET0J2yudAl+Kjy5RxwskxCEEO8qQzUVpokNNIjQshiE
	 59nbqAC5vAy1g==
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so2280825c88.1
        for <keyrings@vger.kernel.org>; Wed, 04 Nov 2026 12:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzgkLq6iJ/abnWQ8QM8gtoURmEV11legc2L3uxJLaKTHmg3Ddh3kOM8ZS2YSXLAtPRnFw8w0Uj6Og==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZvzKlJEWWtTfsNiH3XwjQ7m1rou4WYXdL0tyGuH3/85E/Ufx8
	E2EfQ3tQ/oizG7Y3x9d2HCliQDwYKwaFR+bFgHi/blCO4s+O8NTY6Wa+b+37SF1eo8l/LxexvLQ
	G8gQOviYRgTXnP48A4J0kZZVxmsyikas=
X-Received: by 2002:a05:7022:5f0b:b0:1ab:de8b:5f0f with SMTP id
 a92af1059eb24-1ac5cb18717mr23723691c88.40.1793823308323; Wed, 04 Nov 2026
 12:15:08 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com> <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 4 Nov 2026 12:14:57 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
X-Gm-Features: AclHuK825M3Tp0Q3mYcH1rJyDUZVk5uCyEMH07CZFl9zj20qOO90PZscL7Din2Q
Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:31=E2=80=AFPM Manuel Huber via B4 Relay
<devnull+manuelh.nvidia.com@kernel.org> wrote:
>
> From: Manuel Huber <manuelh@nvidia.com>
>
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
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
> A concrete usage scenario could be Kata Containers, which enables
> running Kubernetes pods in ephemeral, headless utility VMs, possibly
> without systemd. The rootfs disk is static and known beforehand, but
> containerd's image layers might be acquired and transported into the
> VM using the erofs snapshotter and dynamic block device attachment
> using dm-verity. While in that usage scenario, signing a per-guest
> policy with a pre-provisioned policy-signing certificate in the
> builtin, secondary, or platform keyrings would be technically possible,
> it would require including its corresponding private key in the guest
> build artifacts. Making it possible to use an ephemeral,
> userspace-provided key avoids shipping a static policy-signing private
> key with the guest rootfs.
>

Reading through this scenario again, I have a question about the design.

I suspect the reason you need a signing key inside the guest rootfs is
that you are running the snapshotter inside the VM. Have you
considered generating the snapshots on the VM host, signing the policy
there, and passing it into the guest?

The workflow would be:

1. The host generates an ephemeral signing key pair for the VM and
injects the public certificate into the guest's platform keyring via
firmware.
2. The host prepares the image snapshots, computes their dm-verity
root hashes, and signs the resulting IPE policy which allows execution
by dm-verity root hash with the ephemeral private key.
3. The host attaches the snapshot block devices and passes the signed
policy into the guest, where the guest simply loads and activates it
against .platform.

That way no private key ever needs to live in the guest, and it
confines the TCB to the VM host. Would this approach work for your
setup?

Fan
