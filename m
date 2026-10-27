Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134275;
	b=WJn1pG8TfE9ADkM3wiJcgg9KtFVBnvWBN4P815d1+x44GACbvraPHE8+2OKMaL5x32nr
	 lKqHVeqheG8rgo0W8EJv55W/+tOd09vQP36Eov3L30Yl0sR7bQRn0QQgSTZu4VZJrlmQf
	 fFcuuZjKysLXN7xO65pTMAGJWpdrd/oYSXG1nJsncbMHCNzC3HblZulKI1z2e0lZxsWtx
	 WBxlndg4dc0bwQQQq187vxGmCZRX7k6w8X30sLic+rmyc6svW5KOsHZBZWUyqlT3LJYQB
	 /nBH19u44pOQns2xOGviVqfVoXj0u2n68HmBj9vg8PYkKfHmgxSRdfc1sWwXgy+pKMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134275;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CSLm47a7FT6NjfnxYmf/lBzZ+ptNygyn0ERsa1f7ok4=;
	b=KMbM7l2aroNWA9z8EOpUC5OpitsrEV1hM6s31KjeYanrgLdMBI7OJRQmbXTQJIB/BPSl
	 OXm7SRYvExvNgMnalENp/555SUVBhwrE7sV4r4kakG01hUXw8vmUd0oB9EfSvZc6RMQjw
	 nxuMeZWTcZWWc+06SajowJm5IuhNwvo27SPcRMiTGYPz6bxma0I6V9C7fRtMBuuqxooZF
	 /6ZeOk3bQ0HrjoX4F0cahZV3A7u0G/7w5TRcke2y22pgk96gFd2DUgB2afBKVts6ihqrk
	 wPCc34LJAHsht8T+Let7kLPMpfyggkAB74dcIB0/P7IHS+LsKWs/rro8V1mhzQUyTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IutB40zm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465F606A31A;
	Tue, 27 Oct 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IutB40zm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703AD1F01825;
	Tue, 27 Oct 2026 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134274;
	bh=CSLm47a7FT6NjfnxYmf/lBzZ+ptNygyn0ERsa1f7ok4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IutB40zmBKNxx4M3pZNrzksYDpGtSz4o9lVe5YiPqvjlw/+8B2o1ONubnP6N4ozC9
	 gnxLLJkWCtIaXcepa4/frGNd5mrtK4ttXP5mR6OZCMCGJa6FDRAdlNhNQE0RlNIc/H
	 mjFMr3Ejx5T7sMcQmnHyUEJNq2JdgQ/p76LSGXb5lFzYvKzC82OU6mUup76APkFQZz
	 yrMsNnK3WIbqfUk8bVvacmE+/UL1UDBQb7UNkadB0Dy+Z9PtBFJrc84N7KvrWzoTVy
	 Vfps1n/0cV2H05QJaZ1KQS6sCGwa/6Ed/mNCmYkbEX/pxKBKLXy97xJ3xDn8KiVAMo
	 H/F+lVMdKTzAg==
Message-ID: <271e8930-471e-4685-bed7-756748cb1baf@kernel.org>
Date: Tue, 27 Oct 2026 13:51:14 -0700
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
To: Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
 <DM4PR12MB6136C6E1BE1E6D675AFFF0EDDE602@DM4PR12MB6136.namprd12.prod.outlook.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <DM4PR12MB6136C6E1BE1E6D675AFFF0EDDE602@DM4PR12MB6136.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/2026 1:12 PM, Manuel Huber wrote:
> On Mon, Oct 19, 2026 at 04:15:57PM -0700, Fan Wu wrote:
>> I would prefer a Kconfig CONFIG_SECURITY_IPE_KEYRING default to N instead,
>> like the fsverity keyring. In the kconfig you can also describe in which
>> cases should this option be turned on.
> 
> Thanks to everyone for the discussion. Some of the points raised are
> actionable, but two review questions still seem to be open:
> 
> 1. Whether to use CONFIG_SECURITY_IPE_KEYRING or the 'per-boot
>    provisioning' pattern with a kernel command-line parameter
> 2. Whether IPE should accept any irreversible keyring restriction or
>    specifically mandate restrict_link_reject.
> 
> I want to remain completely neutral here because I am only a potential
> first-time contributor, and because the scenario I elaborated on can be
> realized with either resolution. Fan, would you prefer that I:
> 
> a. move forward with a non-RFC v2 incorporating your initial
>    suggestions;
> b. revise the suggestions given the subsequent discussion; or
> c. wait for more input before making a decision?
> 
> Apologies if this follow-up causes unnecessary churn and turnovers. If
> the thread remains quiet, I will proceed with (a).

I would prefer using a Kconfig option to enable the keyring itself. If
you want a kernel command-line parameter, please gate it behind a
separate Kconfig option and document the detailed scenario for how you
intend to use it.

The same applies to the keyring restriction check.

I also suggest adding a dedicated threat model discussion in your next
version. The proposed model drifts significantly from IPE's current
threat model, where the root of trust comes from the kernel image or
firmware, and please also address the kexec interaction that Luca
pointed out.

Fan
