Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378985;
	b=4vCYvHu8M/NOg9BusPWlAdyFqdCXxn30Cjdx6zAvS79X57KqK1CqCc0mdHobhTxIsVM8
	 ioT5Bg1JjXJ8qlgx2rbKZ/WvgV+BPja5HCJHupWVVHZAwmy44K/sMWIs9LcqoWhON8cUZ
	 j5ni0Arxody3x7GFITYu96zfxH/wEz5YPzZRT70AF95SlK3JZQziFkmUJqg91u7mi4Xb+
	 PTmhbAiseZap48k6UJaAENyZqRJ/3HmE279od32OVG6AHXygID8fFWqCAfp6JuqXgAbGZ
	 BKZ6d/yM51P+P09dXYaWVAywhHOHmPjuw/AQbX2YGey7zBL1YHe3U1UN/I4BxE2kJ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C1nnIuDkJo88uq0902CAY8XSm4PVZ67NbB/TQHtf+fY=;
	b=vlkf9HSxajzrcVKl+Mf87vv3syuFgjhrs+PhXvNtoELUtKsvfFgnWCg5JtxH9rwwebDX
	 K6OokBzUtEwqUx+w62J59bU1ZH87D/Vw3nEPFeLIG6o9//zOFa4i8Z4dbenSDPhvrGAaG
	 tB010MliFYIzYfVUK0vRnSaBbVp4s/dL/qY8oyY75xRV4z3Ro1bBY3wdjGiSi3KW69kvr
	 RvNol45L3VM3RwxnCdS6ru6ADjDl+XsBWLOWh07LLvfPXeFS2fiHOoaex+qjH+qsaew9C
	 C02aBpnNqoML2yRf/MPqxFe4h6u89BKCMThA3LM9oI/H915APN7b9YucwXd5f8+O9Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lf4Av+u9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9DC4E606A31A;
	Fri, 30 Oct 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lf4Av+u9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B032E1F000C1;
	Fri, 30 Oct 2026 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793378985;
	bh=C1nnIuDkJo88uq0902CAY8XSm4PVZ67NbB/TQHtf+fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lf4Av+u9KwgRLURTaREHHEy4oSVE81g6du+3bsAbEkFPM4j41TUYhEYNovvWCoSjs
	 4hmUbaHxMI77QjW8M11vtL1S1VoOdaHJHgdVTFHGtaRUFN3+1/81Kp6gFrWpa1G/ql
	 x4aqYsgTolJEzQP2seThSrGmVE9+m9Z2Gk3tf5qdOKX3P0iViqdZIavX7acjGdGFE1
	 SjzyzGcV/axv3Je6keIq1DPCi9jwJjfB20WefmA1Mr7IRAmnzpbRJ4dvrHRbsYtmuE
	 2YQXi79Ebz0BOH1xkWnOQ1rhBaadq75REyPdnySdfi8ikbkD1qInHKPs4j6x4g+rWn
	 4wRo3lvi7w46Q==
Date: Fri, 30 Oct 2026 18:49:38 +0200
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
Subject: Re: [PATCH v6] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auTKovajh5MQlbre@kernel.org>
References: <20261030160924.2919363-1-jarkko@kernel.org>
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
In-Reply-To: <20261030160924.2919363-1-jarkko@kernel.org>

On Fri, Oct 30, 2026 at 06:09:23PM +0200, Jarkko Sakkinen wrote:
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
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> 
> keygcbench results without the patch:
> 
> unused:   min=798.785 avg=4181.989 max=7565.193 var=11446068.927
> expired:  min=0.003 avg=2404.971 max=4111.065 var=3061018.501
> combined: min=0.003 avg=3115.778 max=7565.193 var=7172908.943
> 
> keygcbench results with the patch:
> 
> unused:   min=0.005 avg=0.125 max=79.590 var=1.088
> expired:  min=0.002 avg=0.196 max=236.207 var=8.121
> combined: min=0.002 avg=0.154 max=236.207 var=3.912
> 
> These results translate to:
> 
> - 93% drop in the combined variance.
> - 2.2% increase in the total task time.
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

Interesting :-) It has been idential other than block size change
for v4, v5 and v6 and updating benchmark result but this is the
first version with Sashiko feedback.

Looking into it...

Br, Jarkko
