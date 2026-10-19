Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446779;
	b=RXH3X2E0S70lvBAgkHSnqv9dHZ/kyRKKMyHGxmJ3hnKVOecxYMRc3oHPif/4lBiN9TUC
	 uINpx+KBVR5OPrpFqDVq8vccqg5hhMec5rS37vy9NjWmcZBKpUa9QktsSp+4Wpe5b4h2G
	 o7DFi3xkAs+OrsZP0m5co5BLdovRT2W0h0NbKxuRkjVKsO+nu+YKe8+9yDBMDhOavU7UV
	 XM6F8KT5m8qNswd079V7K2GwuCJ1Jpf2ekct46N4SqEmpWAcdWcNuQIt1VN/IVW0BDuSD
	 tXthAyjqunA5bgCwCms01FaDokC+ylCCfz6wpQDcj5Ez53bIVxhQMUbqEiiApZjnfIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446779;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XkNTB9RlJjKmfq1LDFqnedvYhQMkhuIDdxti3vAmpE8=;
	b=hX70tEgpQhXrH9k/0j8dbReRYVYcjWNEKWwDnJ9FYlQ5J4mAX2y7izMD/s1ioS7haciY
	 I/NkgphT0L7knE/31Q2pfsTrDR0k4o2N7xyKuutdnTB+JU6qfgfXrsAG4AdmPPwbuhFlV
	 jlelptmakgjm+acvv8vCEjSGxjSBGtXchyz2n7HhbpdS+KURV4ESZf77nDGskCryoVMvU
	 v0SPWbVoVdADw4OXYLVX98W+BDYyb3op3EIe7NCq4AofvEtStTNGWkyMcuChWo1r54a90
	 eSqa74U+RWnmW0m3x+oHIg6DwZqqe9yLeaIbmk/KA5uh9MMJjBMcLvI4ZlnYGeE4Pkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jh+c3uWk;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3C606A319;
	Mon, 19 Oct 2026 21:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C3C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jh+c3uWk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XkNTB9RlJjKmfq1LDFqnedvYhQMkhuIDdxti3vAmpE8=; b=Jh+c3uWk+UlrqGbfwYcC/1raav
	sz/oGgLiFCUE3x2hjr4aPv8iTL9EJ2a58vEgdXhtOtDUAuDcpXNnYgK0M9fU8ijISSqH+yZX+l1Px
	h+5KhtI632/LbLWByyR1KmTmc2KEg0Lys97BtF7rmDEwr6rHz4D1GPj/BK7y2Ixplf0gCs8nN0YRo
	Qz0pdacCHDt1ly3+m91dtaHeAKFRhYaZKQtJJFSETdjyjC08wTj3XanRLl0N97IpwQJVRf9KQg9Wc
	akt+LwU4IVAwo5qznzjQX+lC8JlCske5LKgBpw2lRdjIIXxXCVwXZ2E0I0OyJ+Kpfq8QbgTZy7SW3
	vIP4N/Mw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIvHj-00000008QwF-2h4B;
	Mon, 19 Oct 2026 21:52:47 +0000
Message-ID: <1a0c87ba-be48-4425-b7d1-48f7496c67d3@infradead.org>
Date: Mon, 19 Oct 2026 14:52:46 -0700
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
To: manuelh@nvidia.com, Fan Wu <wufan@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/26 2:40 PM, Manuel Huber via B4 Relay wrote:
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
>  	ipe.success_audit=
>  			[IPE]
>  			Format: <bool>

Please also add an entry in kernel-parameters.txt (near the beginning,
in alphabetical order) for what "IPE" means.

-- 
~Randy

