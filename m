Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446859;
	b=Xp2VQZyvMhXY5QaNLEjeQLcxA+mbTDTgQrnghyoJwLZghjUwrv1FwSNrNo8uxN0qx3uR
	 4yRHu9yS9bjPIX7hYS8Md8CtdTy7QjPFiTQQRVf+Pa+Y5ZstJSH7jOMC58jUXFuwp1/X3
	 p11p65OMjWJrzedRs8DvWXsNAbaeD5iJY1wj9w3ZuV5Gc4Qk8VKkcwWS0kcmETwSVieIb
	 IeQcTi63E4KoCvxBzEOt7QBi5kddn2/Yapgnq6IOLGFWtJASej9s0D0UD/qH8S0Oa5HWS
	 Gt7KHx2jmiRDaJdiK/Z5kbcuQfS+HLQUD7Zr0tG9+H5q8uQIMxx/Dg5bOJ9p+v7qo2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446859;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9VOqMYgyNn/QmRwvpRSK7qR74louWoMyKZEaojotFbw=;
	b=jL7OuW+tkYopJGzRsTZ8y9B61026eaMpxAq92ZieffChQFHbZTfJ03UnECmRUAj8Ht+Q
	 mMiUCagLemuneU84RcqpqK4QUJljTpmmLHROy26+WK3lfEhmtz7RCG4zOvY/SpeUp2uxX
	 ECPmJ6nkuRUcTGzbaKonBG32HQigbwRqmwFdBrc5u8NHVbrkxMPFgzCcLa+B1g+RmT6NR
	 /brfO89DmA3B8WUmnIQ5vbq8WMXj12Ww4Y5RkSM+xiJ+qJ26Ka8NonUiuC2EXay+ni9aE
	 lPZqBeYKBCljvOohZaiIz8Ysn8oqTa3nVjcN58iTGW3FCsAV/VmOEfnNXbhsJxJtPsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK7+r4OA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B1F5A606A31A;
	Mon, 19 Oct 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK7+r4OA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B651D1F000C5;
	Mon, 19 Oct 2026 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446858;
	bh=9VOqMYgyNn/QmRwvpRSK7qR74louWoMyKZEaojotFbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QK7+r4OA84djCe8sbywz/SfHhL34jL0OcRwYgTQ9E6z/LUAWCITJbcpn7I+qYoF93
	 ehZleY2Lao9msS4gqzDv6GX+OypO2owkTeLCbzTZV6FEk3hKAzpY8wIDCrvyP0ubEO
	 a41SJvZKoaOA/4ZICR3sHCNqYKZuFj5cNedlzgmQFyqTix+VGObZsUdrpnoPqRBXvv
	 WTvh8L/NNWUt9SJgfsvaQQO6d/EEhlW/xYNIC/Se7Qj80qg86hPgZ+BBUCsKF7czRJ
	 yMiqR5LLyNiHlY2Qm+e6eVsqrxrxEO2u9A0Y8GcogfK3wPbygmGukp9U7RxWpqbVLF
	 /WNWFs+CkTmUA==
Date: Tue, 20 Oct 2026 00:54:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Halaney <andrew@amutable.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] IPE: add a dedicated policy keyring
Message-ID: <ataRhrucvhM8qZAs@kernel.org>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>

On Mon, Oct 19, 2026 at 09:40:24PM +0000, Manuel Huber via B4 Relay wrote:
> Add a dedicated ".ipe" keyring for IPE policy-signature verification,
> modeled after the dm-verity keyring, allowing userspace to provision
> IPE-specific policy-signing certificates. Systems that do not provision
> the keyring retain their existing behavior.
> 
> This RFC is based on commit 48f936e302a9 ("ipe: update the project and
> test suite links") from ipe/next so review can begin before the
> prerequisite keyring work reaches that branch. The series will be rebased
> onto a refreshed ipe/next once that work is available there [1].
> 
> The keyring readiness check currently follows the dm-verity and BPF
> implementations. A parallel keys RFC introduces keyring_is_empty() for
> this purpose [2]. A later revision will use the helper if it is available
> in the submission base.
> 
> Testing:
> - Built an x86_64 kernel with GCC 15.2.0 and Clang/LLD 21.1.8.
> - Passed all 33 IPE parser KUnit assertions.
> - Passed all 4 sealed-default keyring selftests under QEMU TCG.
> - Passed all 16 provisioning-mode keyring selftests under QEMU TCG with
>   ipe.keyring_unsealed=1.
> 
> [1] https://lore.kernel.org/r/20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com
> [2] https://lore.kernel.org/r/20261016215326.4110064-5-jarkko@kernel.org
> 
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> ---
> Manuel Huber (4):
>       ipe: add the .ipe policy keyring
>       keys: add KEY_SPEC_IPE_KEYRING
>       Documentation: ipe: document the IPE keyring
>       selftests/ipe: test the IPE policy keyring
> 
>  Documentation/admin-guide/LSM/ipe.rst           |  41 ++-
>  Documentation/admin-guide/kernel-parameters.txt |   9 +
>  Documentation/security/ipe.rst                  |  16 +-
>  Documentation/security/keys/core.rst            |   9 +
>  MAINTAINERS                                     |   1 +
>  include/linux/key.h                             |   2 +
>  include/uapi/linux/keyctl.h                     |   1 +
>  security/ipe/Makefile                           |   1 +
>  security/ipe/ipe.c                              |   2 +
>  security/ipe/keyring.c                          |  80 ++++++
>  security/ipe/keyring.h                          |  16 ++
>  security/ipe/policy.c                           |  10 +
>  security/keys/process_keys.c                    |  23 ++
>  tools/testing/selftests/Makefile                |   1 +
>  tools/testing/selftests/ipe/Makefile            |   5 +
>  tools/testing/selftests/ipe/config              |   7 +
>  tools/testing/selftests/ipe/test-ipe-keyring.sh | 357 ++++++++++++++++++++++++
>  17 files changed, 575 insertions(+), 6 deletions(-)
> ---
> base-commit: 48f936e302a9c48cfc032eb5944c3a6246bc9043
> change-id: 20261019-b4-ipe-keyring-rfc-b93b9ae129a2
> 
> Best regards,
> -- 
> Manuel Huber <manuelh@nvidia.com>
> 
> 

We are in the phase of release cycle that it would be hard to find any
time to review this properly so might take a while, or I'll review a
follow-up iteration if other feedback arrives.

Br, Jarkko
