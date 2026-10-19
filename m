Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452509;
	b=QBGsQJjE8qYJVMoqi+sWOI2W5CueVvxmph3TRYPkveeDAESZBOTvcD8uYUyKW6VAEkbi
	 7HhX7qQV55cYrp6HEZXxxJTs1S1iRplPCY2HvD/VuJwOh+atUY0Hrx5Z1YAtUIfq7ETYd
	 uDjM3lSw/aUqJmuGc/5pDCepspBES2H5w3FxumIWdvZfuaOr1Vw9YBK7GQWBQbdIDeyqq
	 zcIg8V+0SVf/xPFfg1lb5rX7sYp+pGx0U9MKJZKLY8zGbDnlXzAbN0qPfSRuhgNAQnaHr
	 wyTpPt4C46sN1DpYorC7TGFsq3n0N8c21ffnS8kFmzBL1YoWDliN/KadwM3Bq+mfTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452509;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ML8QuNr/SitRoSc3ITEYHmuyYUgVewzWtNVAZkiyDrE=;
	b=QO85JXRPoKytZ8BS2rAdcDs1znthD6o9aP+sgVSp1JHbUtcIhTV2CFdIHxVXL9xXSjnj
	 hRB2ftEhKs4cyehBc6pk4mPfnI36uAML+5VyTR15W7/o0glvYaGVUc6SdA/d47pLMbyc9
	 J03FbYjl+vcUL2pPPcyba2MGjCmaSAE0fK/kjPz0OL6VcCN3QrAAKCO/HVYenRHi37fYH
	 +DLejaMr9f25Dn3/Cd3OVDKVikU3O3u/s/sS2/YvQO6PRA7HtlhMg5PggfBtM6SqXAtOK
	 dv9pXTk3IWgfJqQNqfCt0UdG13u2mTr1Zi4UibFnGHOiB/eL3GXzQtw6IS2bL6aEQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tqn4kl1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB50606A31E;
	Mon, 19 Oct 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tqn4kl1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F71F000C5;
	Mon, 19 Oct 2026 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452508;
	bh=ML8QuNr/SitRoSc3ITEYHmuyYUgVewzWtNVAZkiyDrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tqn4kl1PBPlF2kJixJd/7mcxxNuVLf+rAAEUu4w/kptLkmEe42mooG5/d2QlJiedF
	 AraewhApdjMu8UNc+h2EcoVwZrBaPMASILorZSqAGTMMzlvw/JxFkwF98K8ICs36A6
	 HD+/6JXVP6rp3sPLcTU+hTTg+0dIFjf0czrL097yKqHljEnxEErWHRyEImtiz/s1a2
	 M71ODIREV7LtTdztLHznrO0xvkVBPxz5u0fAX/7kqRUUf0zUvsu43y8w6vz57gQN4f
	 jKT+jrq9unme/Y815KwMAgGcVGx4br4fDV3TnOpDTGpI+npQAoqybcpfUmH9SvMUFO
	 6T+1Z2ybUEa1w==
Message-ID: <1c39ea06-4b5c-49c0-a508-06955c549556@kernel.org>
Date: Mon, 19 Oct 2026 16:28:28 -0700
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
Subject: Re: [PATCH RFC 4/4] selftests/ipe: test the IPE policy keyring
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
 <20261019-b4-ipe-keyring-rfc-v1-4-156f0b93e843@nvidia.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-4-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/2026 2:40 PM, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> Add an IPE kselftest that validates policy keyring operations for
> both ipe.keyring_unsealed values 0 and 1.
> 
> For the default ipe.keyring_unsealed=0, verify that a) the special key
> ID resolves, b) certificate enrollment is rejected, and c) the keyring
> is not used for policy verification.
> For ipe.keyring_unsealed=1, verify that we can a) provision multiple
> certificates, b) restrict the keyring, then reject unenrolled and
> corrupted signatures, c) authenticate policy loads and updates with
> different enrolled certificates.
> 
> Since IPE is built in, keyring restriction is irreversible, which is
> why we can only exercise the initially sealed and unsealed scenarios
> via separate boots. To get full coverage, CI thus needs to spin up
> separate environments with respective parameter values.
> 
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>
> ---

IPE doesn't use kselftest. Our tests live in the IPE CI [1], which already has keyring tests for policy signatures [2] and an initrd unit that provisions and seals the .fs-verity keyring [3]. Please add the .ipe cases there instead.
[1] https://github.com/Integrity-Policy-Enforcement/ci
[2] https://github.com/Integrity-Policy-Enforcement/ci/blob/main/suite/cases/policy_signature.py
[3] https://github.com/Integrity-Policy-Enforcement/ci/blob/main/image/initrd/anchor-fsverity.service

Fan

