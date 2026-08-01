Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663A254AFF;
	Sat,  1 Aug 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601902; cv=none; b=M2xdqCknP/F7OW0zM9flKDEZ6oCl8uQo0ol0uNfWPG+96VcV24aOsQko50ccbSpc0M0fPf5N6UcnBtFSJRVECSGCCfsWvmLVd37BuLR3Op8qw8r0tBvuKcpd9J8h3bMT8tNFXz3fAhTJBPdTKq9tAVPksUCqaNT/KSnc5lSgbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601902; c=relaxed/simple;
	bh=EfI+4CNn1IzNdVFSyFoDKS+KPU7V09xdwBkC6lGm4nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScBCEUtGRDL3WIp0rXr6qzQHUBN48C9BftvU6JMMSK0gwcKUSBy7nj9ylAD3SxgbtDvtaWhZgejkvAmNFTPdRJCkOetHLYD2ynLn8Tr58vcU2qK9rPgU7lvpe9N9GOlitX/FW38gDbi3OOU1PVYQ/O/NjynQHKRRJi1qyMQWPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=RmkXFT2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AM+GAMAm; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="RmkXFT2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AM+GAMAm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 2F5F113001C3;
	Sat,  1 Aug 2026 12:31:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 01 Aug 2026 12:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785601898;
	 x=1785609098; bh=+GWeLMj6JRkBwIB5dZ2ML5Xr2ewkb9W4drJzAxuBpRM=; b=
	RmkXFT2XRwFzTnZ4RUuvPxrVeMfPjFOnKrwCQsS1XptZmkGjnm0XK8zPm95SZptR
	vblyF6P+DynXIEReP4UCqbvO3IMnP26E8gPFZVvIKxFxpj/WP+jbSL0xKwAplAJE
	gEnbKFuaiMyMaFH5mrB8PQ+DMYdaPHXJ97/jG9UBaGIj3TQ7X1dTNdx1rF4YdDSc
	iMHjeqzRagEJLUxPukNwHDgpBumKK9kM6tgK5VD2UiZaQwlECGu1yKPHEkzUz/AK
	WkXrhcCp+jhjHp8Ngn+QB0Pt9guioRZlwl/hktcFcX6LZeI/fYbv/NpTjqirwpZn
	VVHNMIE0xu4DhjWBh1KyIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785601898; x=
	1785609098; bh=+GWeLMj6JRkBwIB5dZ2ML5Xr2ewkb9W4drJzAxuBpRM=; b=A
	M+GAMAm3QbbKNrAARFlEsFWy2tEQk0jncgzM/KHX319JOGnX3qe1BISPYpFfR9vm
	+Mw8Yrb5xv6kiMCyD9tEu8u1sJgT/x9+BwsfZ0I/5bT+yZXvmV7fD1LMhb+LmGvV
	8/4QEFQ2T1n45F2uJKEEeqD7FBWoiHWHR9Qu4WAZlxzzH52Npi94GZFVuq5dqBgs
	r16p0vkhDOqgX6wB8Ijy/G0nlIeqX5WG3Wlr3z9CEWwxsTI044OAmxg+Lr6NWXvK
	KUOKRdx6W+pcgXx5fMrK/FmdWe5guJFfuqbQPAsBnUKOzvrVxPucnnUVUjqaYPn1
	Je6eQuIup7l1UHNYKtBbA==
X-ME-Sender: <xms:aB9uauKFiZJTjA93RGjFnHFdEvt-HMy0HsgX3-hOAJlqrp1C3ZizVQ>
    <xme:aB9uaqFUWSmz2qOoolnQJtK4wKgpBNA245buXNm6-MRNEo9R6Ua67PC9nQciMCnBx
    wnk7tfBCvCeNvKWhGXcU30p2SuE3RCAmug5Hgz0g3Zhrot4cMOPIg>
X-ME-Received: <xmr:aB9uanPuOshfY6CtKMSGadEowsBukwEQX-vYlocgi_Cuevm95ob8-EiONsw-uPGosUE0_r9cndeMRUDj2Ba5V_0>
X-ME-Proxy-Cause: dmFkZTGysGsnMEekMD+PYaXQlblXcVTecPczGN+gVmqOxy4sIfPSEgEdEy9IGkXqGXAYan
    DgHFBKPnw/bMa6UCHHMC0exlwD99XK3fcXTSJ0QkvFhwAe2MTshN1slIIxFE3BXZADEpdL
    tUUbdbZ08888lAfzeLa8pD6z4j7mB1zFV/lVyxXX1BWN5uUA++eU/U1yOSrRvDozJBELil
    8rJAGQd3FpKYZxHzerbf/GRb7jk5KXrrlWQSt0HC55zxuWRowmB5ffELTLLDzjdJzr54fX
    bVWNOtgpIcH43ZWWHr4BoZH4xazltQq9pdjH9ZmzK0fC7Hj6xiEL60USKu+J8gJURge/pZ
    gNQpgM+Fy6NfM+eMiFCVI0shBHyPX3L7aWUnI3ddWuPO/7fY1U7bleIEI2rKSRTh3ddxqV
    y0PFC1MHUOu1nFyHSfUpyW+CPxPjQHUWXAPWjbm4posuz0kZ2WVdesFbz8wX7xOhdtoeQ4
    NIB/ZyX+wPhghTBupZRz2Fao6YdT5OVKu5w6QFEVPgjZUTS5H4Eqkn/A6SMTGffrhS9ge4
    OlLF8+/f+sQTWF9iebWeJwJoCqNe07ytko3fiWkDeSitzobrn/lY5IP6VGsTQmOR+EUlQ/
    UzXA2VVLIxEnMTc5gz5NwCEakiJBTEWt62brpYUVuKzUapbciJ7ee4sqm68A
X-ME-Proxy: <xmx:aB9uas_pMjHsEPoSSOLYfSz1vKmRwTmnO44j2Uj-tvYYFw4JuvSiWw>
    <xmx:aB9uas7ZWYyx1bGFlgWkMgfFvbwNqE7huNTq2hV0KbcluNmuVZat8A>
    <xmx:aB9uapXiIem4YDb63Xz4m0RJHUCh1r5m3J01ugYIx9C4daDSwLyfTA>
    <xmx:aB9uaqJ9TByhcsx4YSr4sAoMga6UtLV_5ds_HktryZHRG1gXKovEJQ>
    <xmx:ah9uapeWm7c0PJ_UJy7PEj8GZJ4vsUgV29GuwE-0KO-FsDt7a1mwCaDy>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 12:31:33 -0400 (EDT)
Message-ID: <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
Date: Sat, 1 Aug 2026 18:31:31 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: Baoquan He <baoquan.he@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260731154608.153258-1-linux@jaseg.de>
 <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
In-Reply-To: <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,

On 8/1/26 16:03, Baoquan He wrote:
> On 07/31/26 at 05:46pm, Jan Sebastian Götte wrote:
>> Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
>> subsystems handling secret data do a quick, targeted wipe of these
>> secrets before kdump. This behavior might also be interesting in cases
>> where you run a normal kdump kernel but you still want to keep things
>> like fde crypto keys out of these dumps.
> 
> Please check below patchset, you both seem to have the similar
> requirement. Please go there to discuss.
> 
> [RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor upcalls

Thank you for the pointer. That's indeed similar, but I think this 
patchset here makes sense as an independent patchset.

* The two notifier chains run at different points, and theirs runs 
inside panic independent of kdump. This one here has to be run after 
machine_crash_shutdown(), and so makes most sense inside 
__crash_kexec(). The wipe code in this patchset must be one of the last 
things to run before the kexec since the wiped data structures could 
easily lead to problems if something tried using them later.

* I think this patch series here is a bit cleaner. I don't think this 
needs a custom notifier implementation.

* Since there's lots of places that may need wiping after crash, I think 
it makes sense to have an explicit notifier list for that purpose, and 
to not mix these with other things like hypercalls. I think ordering is 
important here: The wiping should be the last thing before the kexec 
jump. Having it on a generic notifier chain risks that later, other 
callbacks get added that when interleaved could cause problems.

* Since a good fraction of users may not care about wiping secrets, I 
think it should be gated behind an explicit enable setting.

> Note that we usually dont' want to run a lot of work after panic and
> before jumping into kdump kernel.

I understand. For this reason, I think it's best to keep this 
default-off. As-is, the notifier list call is timed and on the (slow) 
ARM64 target I'm using, it takes about 3-5 ms to run. I took the "try 
lock, skip if locked" approach to keep the risk of this code crashing 
during panic minimal. In my application, the kdump payload is code that 
then does a full wipe, taking a couple hundred milliseconds.

Let me know what you think.
