Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3F37DEBE;
	Tue, 11 Aug 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460764; cv=none; b=julxQB9rLMIbXuO97ttakte22gVWR6QV7JAPpyMNYuWaNRwcPzDvgbKN0bzP1QAmNMvTe73emMU9/NlIVPNsiagBftUfkJ16Ls3taw4MUQ6Q+34opTk2JcgQxT31FOBxEjNd1TrrJQm4IMXReGIpQ7u9gWsSrLYG1HN56Z5Jta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460764; c=relaxed/simple;
	bh=h3p/frgakgpVtqwQ+vREzkwvtkpyulm5iMEkKC5De5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1s6rmwI5wT3/uyMS8S/jHjwH3MM12EJitwhsfK54s34JNXwjgdpfuYqdB8KVQIsKqLFX8BTR9svxCZeNTrtAGarzTePSJkQdFj4ptCDOfedDoMepkBNkozMGCoOV11BExE37pJsuzCzWAhYBWKbmca0L1s/s7QYA8i9bFUh7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=DUWOYSVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlpZQapP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="DUWOYSVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlpZQapP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B24857A0181;
	Tue, 11 Aug 2026 11:06:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 11:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786460761;
	 x=1786547161; bh=+R7JMANSoPU0Lo7IzhksLdgglky5VdSN1BAdqtQvJK0=; b=
	DUWOYSVsIpLVmKjF/IUlILPEMxDBvO4sFISJOuzQouSq7xBMC3EiHDoCsXZeGn/w
	euv5pKnuG2TpICvHrI6NQRv3gcJ+Q22zvvhmOZhwa0+FjvQDvHfo3G3ohHOOby1K
	VkqvZ26a3FC/AhHvg2icA/n61RglIhgkUmH/zEoT90/zc1v2ySLBzYx2k8I3S2VH
	bEVmP2LIr1LTq4wugyZHXcKeCL+2qnuvQMdvVCOmx42/+cgPNt1boalq6lPlc2iV
	eC2J+VGuUJzk8CdXEN+dOp+2kZFgx60YEHXLKdIsbGnooQPAHJEfe8NOrrfzCiPH
	3hCcmpUnfzpgrzqVo7XozA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786460761; x=
	1786547161; bh=+R7JMANSoPU0Lo7IzhksLdgglky5VdSN1BAdqtQvJK0=; b=j
	lpZQapPqhsyo0fVD++SnG85AILHWB5Wd8YIPSfiqcJfVeFxqq7XQcRhiXz7fv/3s
	Ugqsydv6dIWLt54KeHQ1cAp5F867ooOZcK292nMX50drIQgCRqN8g9l340a3xDRa
	UlKpPROVSWfZWHPWtFzUPlX9JnE7bMicUEG04ipR6EWChf2pbMQVFVclBqZL9n5p
	eyGNe/E3xabtplwUebsD0mxeeLkj2gS42vduVd3JLG6sqr6EH8x5/saufriwrnZM
	zCxLxSS1WjbSFXLPXWO+gyb6WyajYCLn5Q5vpSoL30zoepi5vz26LhfFU/AYS64T
	3MSNNF/jq/RNBWkL8eaKw==
X-ME-Sender: <xms:WTp7ahuVXkaO_fLso6p8gNYsCct6uUXbXX_JdV6NujKqUIHCWNdMlw>
    <xme:WTp7agc2IqgE61_WDHIPY4ZGxjBXWDJYc4SXs-fvyfOJJGkzj2-R4-rhK4lmBBDjL
    HKMpzAIslESfSf25FCILDWmIDHc3Q8xXCEGqWy0S3iAg_OOOjUxjQ>
X-ME-Received: <xmr:WTp7avmzT8cHgBdGUokViJIN5F0Rf9OJZ0HGQyZhk33Ey3bhAtwtiR2Q6318GxU-ylG4wbC0H-52-eQ--6qqaTU>
X-ME-Proxy-Cause: dmFkZTFaFhDTW9a+ci9/L6pvJA9qM5lpDLTqExtHVIRCEVDj2T2FGJP5tMn7RDwcMrn7qk
    nmtfjcoqgLBPcIFpZn3Dt/xrL4D3cnW3PvgGo+7f0FWlFXXUEMwiL50koRLeu7RvcjqJ0N
    yo9W+3LtgZmY1nd/bnrZ9RCoW1aOMJS/T+Gs/KEmr40y7tZoy0Qv6NM8Zuv0sTcKfD7rPi
    Tr0nLbR98w0As1ewCc32EOlrGy01CCfK2wfwvYgs74GhRytlkG+aPsOso4uvvcKn4gT/Xl
    wIvuEF9sWzRmG5BmTVw8x+fJIDI+xi3WR9f/sIGAM6JyS7cQlL2Tck2SfguzjWcLfVmWQb
    ECKcPDpnZOwc8n6BTMokL9nkMFaCqpfwl2dPlinwXUmp80krxIn9VK34Dt4sEjmCOPVzZI
    /f2XWTsXyHT3ZOiI+5Yye2d6HT/9Nl2bBEQExnM8wmuziPZd+NSSBaHyIXxHuY6ryUWOop
    Sez65xfX9kpda0ez8yvQLjywGwcixMSBDTbWQyVDKGDIlY6Rxdu51dxq7j8qynea8it8k1
    tNKwCIsK8KyyLgqUNiqQddNPJumWI9JYRzjLoww0Hj5dVIxjR1+avD2vmt619qEHP0qzMI
    6FWY3wbYpI+TeJyJtq+7d0XcZSEsrzqdxpEDqRtJiyDLmMcRbyJ+5bZX4PrQ
X-ME-Proxy: <xmx:WTp7arBnnxJkbgy1HxUpCWZni3V4ul13WTUeBYV9tOCNIZGXbdcBdQ>
    <xmx:WTp7ahMIwuQPghocYLT9MgVbDQS_WZneiQXxeRq6tNBu1Fvpg9l13g>
    <xmx:WTp7aiMI2wdw5OU9e8Sg1ytfJ6spwnAe57F5thebQO2Gng88IAmcFA>
    <xmx:WTp7apksJPOZUjU-C3Ozy3iDVi1OcT1ORMZHxXwvkQUHetKX4UJ1wQ>
    <xmx:WTp7ahcaGsU5R_6NpuyLx3az9b4EJH2MvGNbLPQC7hiSjNsfZbXS15c->
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 11:05:59 -0400 (EDT)
Message-ID: <adcafa9f-2365-484b-b31e-19006833efaa@jaseg.de>
Date: Tue, 11 Aug 2026 17:05:58 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/secretmem: zeroize secret pages before kdump
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260731162739.158320-1-linux@jaseg.de>
 <20260731162739.158320-4-linux@jaseg.de>
 <70c578dc-769f-465f-a146-4a4695f747c1@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <contact@jaseg.de>
In-Reply-To: <70c578dc-769f-465f-a146-4a4695f747c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/26 16:53, David Hildenbrand (Arm) wrote:
> On 7/31/26 18:27, Jan Sebastian Götte wrote:
>> Register a CRASH_ZEROIZE notifier that wipes secretmem folios. As a
>> result, when CONFIG_CRASH_ZEROIZE is set, secretmem areas will be
>> cleared before the kdump kernel is kexec'ed.
> 
> Are you actually using secretmem in your use case? I heard some rumors that
> secretmem isn't used all that much in practice :)

I'm aware nobody is really using secretmem. I decided to build this on 
top of secretmem because it's an existing API that actually kind of fits 
the use case. While I could have added a new API just for this (marking 
userspace memory as wipe-on-crash), making it part of secretmem instead 
gives some additional defense-in-depth protection for both users who 
only need wiping, and for users who only want secretmem's additional 
protection against kernel memory read primitives so I think everyone 
wins here.
