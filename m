Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9342931E2
	for <keyrings@vger.kernel.org>; Sat,  1 Aug 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593027; cv=none; b=kIKeUyiKIMEfwsq0eDJxEWGjtS7EU7bQJ+ccOk5ndU6yfUELuwXHxYzsJAFvjCpcUGNJ99Fkj6s9Oe4GtZPkL3ttCV5ucczCkafbP7/rVE8jnQEgcC3dq/xnuCI63XxkNY058+hY6Xi3Y3NeSok2HVqLBEgx+vTAIXI8TZtghdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593027; c=relaxed/simple;
	bh=+5PaZLENBtMC1rFzEw8siFOhgZfccxYn2PK1TRm0+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juIaN2yNPgvZI1pOg0y/IbLPtxmVtdsSvTUwyDtC9Vtkyq9O7tBZ/v9T2hppGwI16b2jaYVxLERbLPyBgx2D1oF0ZeXJjU6xq39m4QwycnL4Oyp1dy7Uk9uCrvR/vaHcJktVtm5fyQ4jR6EXkNsee/jrI/gwjYUzl+mg2dplzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEDQsNuM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEDQsNuM"
Date: Sat, 1 Aug 2026 22:03:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785593013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqzEYyvsxUaoTo7q5N2srwBhq/x6rJ9uYS3yb+pyTCM=;
	b=cEDQsNuMU8m/3kJa8BRPGCCaVqA8r7jf5GBr9BqwksvWQ/PAlqBsrBozlWfigSsa3nLSoD
	V5tD/fjnuc0ccF7kNC9WdzxKuuDZ3jOm2kTSbc1ZkPmRPmyg36zpt6RYRwuJiEw4c7aKdY
	A2CajIn/zJtbM1ar9ehSkRM6ioD3jLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
Message-ID: <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
References: <20260731154608.153258-1-linux@jaseg.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731154608.153258-1-linux@jaseg.de>
X-Migadu-Flow: FLOW_OUT

On 07/31/26 at 05:46pm, Jan Sebastian Götte wrote:
> I'm using linux on an embedded target in a Hardware Security Module-like
> application. One requirement is that I want the system to be able to
> quickly erase its memory when it detects physical tampering. I'm
> approaching that by using kdump to load into a small payload that
> instead of dumping RAM, erases RAM from start to end. However, writing
> all of RAM, especially on an embedded target, is rather slow. For this
> reason, I propose the mechanism in this patch series:
> 
> Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
> subsystems handling secret data do a quick, targeted wipe of these
> secrets before kdump. This behavior might also be interesting in cases
> where you run a normal kdump kernel but you still want to keep things
> like fde crypto keys out of these dumps.

Please check below patchset, you both seem to have the similar
requirement. Please go there to discuss.

[RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor upcalls

Note that we usually dont' want to run a lot of work after panic and
before jumping into kdump kernel.

> 
> CONFIG_CRASH_ZEROIZE is a best effort, defense in depth solution. There
> are circumstances, such as when a panic is triggered after memory
> corruption, or when a panic interrupts some operation that mutates data
> structures under locks, when the kernel cannot safely wipe some memory
> areas. The handlers proposed in this series will just print a warning
> and skip the affected areas in this case.
> 
> This series introduces two handlers as a starting point: One for kernel
> keyrings, and one for secretmem. Future places where such handlers could
> be added would be for example drivers for crypto accelerators. 
> 
> The patch series applies on top of linux-next but should work on 7.0.0,
> too. I've tested the patches on a Arduino uno Q (Qualcomm QRB2210)
> embedded target.
> 
> Jan Sebastian Götte (4):
>   of/kexec: fix typo in comment (usable-memory-range)
>   kexec: add CRASH_ZEROIZE to wipe secrets before kdump
>   mm/secretmem: zeroize secret pages before kdump
>   security/keys: zeroize key payloads before kdump
> 
>  drivers/of/kexec.c                        |  2 +-
>  include/linux/crash_core.h                |  5 +++
>  include/linux/key-type.h                  |  9 ++++
>  kernel/Kconfig.kexec                      |  8 ++++
>  kernel/crash_core.c                       | 18 ++++++++
>  mm/secretmem.c                            | 50 +++++++++++++++++++++++
>  security/keys/big_key.c                   | 15 +++++++
>  security/keys/encrypted-keys/encrypted.c  | 12 ++++++
>  security/keys/key.c                       | 44 ++++++++++++++++++++
>  security/keys/trusted-keys/trusted_core.c | 14 +++++++
>  security/keys/user_defined.c              | 11 +++++
>  11 files changed, 187 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0
> 
