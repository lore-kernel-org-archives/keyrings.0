Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622711;
	b=4acynlij3ce/wT9ZPntJVjNyZmpSWvyopmPV2U1xyX1bTwsqZp0exQNRsMGoN/OheXPk
	 IO2TIedc1oHTsQE/MRv4aXNa2Ru4VsX5mAWwnjtjIyf/98nmE3zwE20s2PL+JCUMYGWS8
	 v3xxt9Utj7wGbBEpHkdsWTlBTg3vc29ZEObW+COh93picAPHMxO6zcGTOUxWFu+MuVrvZ
	 TpGSrGeffySb/t+yJ8bsBB0e346PMI5wCr5CRzTjzKIZBz7dSOESb3UTvmw8kf+xmaMu2
	 kRBYw/dNJtlCznXvK8ebcG2BebNO9Rep51smJz/0ZY/v3/9Lr+uMAh97tkft7OZBSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9GghWpkMovI/jUpWaO5s0xGZNyj59uibOGDMhMvEi20=;
	b=uqTKjb+fL7PrSqXJdRicELqkhzjXv39vrx8kuzdx8yQjE+A6oRaP1TYBR2IssJQMPLTT
	 BPU8wulsyis5c3qK9TDW7I/H0AnWIXJPWxdrbzFy1I/l+GB0oAIJ/qImCOh9HqCyTgngv
	 ysTTXk+KFLrbOtyvVrR9RJDDDrkTZ7H2yeorQcab2/6TFmDbnbZhmicjL1/3ALZ0v5lVl
	 k+nVHIjpL1qFg83WlqulKqFyGr2R9fjvnwsQr50Ps5a5W3kNKVuMUM+QN2Kt8Cq3Oi8De
	 80tKzlGL3bwVwAqv1CVQcxdcMRLQt+YorhTfMhOYQgVdc1MyiqQ72CEerFHHOc6T97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHuY35DX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 10C94606A324;
	Mon,  2 Nov 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHuY35DX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2072C1F00A16;
	Mon,  2 Nov 2026 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622710;
	bh=9GghWpkMovI/jUpWaO5s0xGZNyj59uibOGDMhMvEi20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JHuY35DXe3hV++eYna7evx8k0tSB1MRK/n2I657OaluwYLTlWx/QHKV7RUCx87fRu
	 Z0xoy4v945QoFwf6b59Q5ki5VFHjeMvYWddu8efYG+2gVwE1U3uY/XIt5T4jd+WQsV
	 RnZpuqwL825yd+Z72SfNBB34nxFELJ+ECrJA5tHyoI5DSJPMiV3891efHtAO2aWIfG
	 B6cFz24d8bbjeNgrp4ERXZY/Fq0l+wwaFKuqLykNYuLHQzdbeZYbFL7xdk8Yq9Cedw
	 D2qEEuaAeTS9ZPMpJ1cvO2aqBX+u03dIWvBfeBtI/ayufFB3s3068P4NPZZyM3oH1j
	 WwG75dCWPhSlQ==
Date: Mon, 2 Nov 2026 14:31:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auiCsz1xs3M9-ujg@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-5-jarkko@kernel.org>
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
In-Reply-To: <20261102121518.1197453-5-jarkko@kernel.org>

On Mon, Nov 02, 2026 at 02:15:15PM +0200, Jarkko Sakkinen wrote:
> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
> 
> Resolve the problem by processing in chunks:
> 
> 1. Declare a static variable key_gc_work, which owns the garbage collection
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
>    the RCU grace period.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> 
> keygcbench results without the patch:
> 
> unused:   min=413.359 avg=1817.240 max=3221.120 var=1970880.024
> expired:  min=0.002 avg=1360.124 max=2481.990 var=1055093.994
> combined: min=0.002 avg=1542.970 max=3221.120 var=1471557.422
> 
> keygcbench results with the patch:
> 
> unused:   min=0.005 avg=0.126 max=54.173 var=0.946
> expired:  min=0.002 avg=0.210 max=216.470 var=7.894
> combined: min=0.002 avg=0.158 max=216.470 var=3.627
> 
> These results translate to:
> 
> - >99.9% drop in the combined variance.
> - 3.0% increase in the total task time.
> 
> The value 64 for KEY_GC_CHUNK_SIZE was cherry-picked from the set {1, 2,
> ..., 1024} by running the benchmark for each chunk size three times.
> 
> At the far left variance is 97% lower but at the same time total time
> grows by 133%, when compared to the selected chunk size. The size was
> picked based on getting a reasonable variance with a minimal throughput
> decline.
> 
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
 
I left out syzkaller tags (and do so also in the foreseeable future) as
they seem to influence kind of feedback to appear that can only
interfere the topic.

Br, Jarkko

