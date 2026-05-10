Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2913777E
	for <keyrings@vger.kernel.org>; Sun, 10 May 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778445180; cv=none; b=tSx1/KVJJNUbOhCg3LEPW6M4ASrjacqvzFX3pSfSX5nS4bXn/4eEgkUKq4r3AkmFI2F0OrQeoKvqxJchLgUeU77uCHNyVmI7mU/L6JuCDddMe8KcrdbaIOppcMzFnHD6Q7kUSQfLtexLTqjVa/8lGTMyjOfQtw5205rSjzU5KXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778445180; c=relaxed/simple;
	bh=XQUzK84HynaCOxTdgEwhL6AEUJLt3+fqRpgNfkWmrsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN88JpXmhYNdu0Wm9TCgbMFgpe9Nkc4tHt/i27h2ktr/RPjn30VEr2/oVMPRem2Z3pWmB/58YCE7qI3Nf/KoZbMuIes9q49icdFRm5Mb/i3z/4EYSqgGvfGAQVMvyqQNQ2RvBef1nIkU3faIoXmzaOnOmt5p8ljG7vkS/X3r3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZMroBtJu; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZMroBtJu"
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id M3lLwkbRHnwj2MApXw4vFN; Sun, 10 May 2026 20:32:51 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id MApXwdbXLUxNwMApXwPpbN; Sun, 10 May 2026 20:32:51 +0000
X-Authority-Analysis: v=2.4 cv=WpMrMcfv c=1 sm=1 tr=0 ts=6a00eb73
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7T7KSl7uo7wA:10
 a=Xn-DZyyB-tC0dpwOAtYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qmpCMxkpzSQC5550b9jS4HBEZiBG5nYRYB4x+ATjtNo=; b=ZMroBtJuc7WxUDw7JWRiPhN1vI
	NzsnAd5e0Hvte3p8yFvq47Q2BNLQgF8smCmeOESClS0Ngfur9u6BJLk8ObNLDm2NX8XtxxWTfMJaE
	Iud/sgybAXIDXPAxNaYd3zXUf/NL9JcapSYNja98AeZJHWoMOPRl5D91oLy8FhKIjRbfJMkfzQKBY
	xYpD86RAimfgr6miCqHoKsVhqPo/FX+pZes37qubZdiaUI8Ua7S2yTRinL9fcXk4noQfIvy3B2J8h
	Ja6UomXTdI7FQLpQmVTY4a5ajnuDC87ypel0gUVziE+PMVVw8IBmTB/UgkX7mp4Fq+Czi4KAt5CEK
	qV5K+gZQ==;
Received: from [177.238.18.176] (port=42958 helo=[192.168.0.11])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wMApV-000000012VZ-3kne;
	Sun, 10 May 2026 15:32:49 -0500
Message-ID: <531e960a-c2b5-484d-8265-e07ac021f272@embeddedor.com>
Date: Sun, 10 May 2026 14:32:40 -0600
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Tim Bird <tim.bird@sony.com>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <20260427114422.313356-4-thorsten.blum@linux.dev>
 <af8ZUXn4uStU_vs5@kernel.org> <agBiPEJZhWHydwuz@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <agBiPEJZhWHydwuz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.176
X-Source-L: No
X-Exim-ID: 1wMApV-000000012VZ-3kne
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [177.238.18.176]:42958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNCkt0vlZFfTjseCCst9HX3pCPR95X3ZaChKHnR8Nuv52nXMOZENnfkhDYrfrLdtGeg/8E0bIXchXDrD9z7j5P81O7XgRUiAlmzGVbhkx+YeWtyMjsrI
 zkZwzl0TSgiLyx6mmhACYJLAOZipqQ6uLuUzX7HuemZpFOtnz9o//8MHArhVqqVuxcV7ZNAeUiIIAAUy16HWtyZktkQKwMH07mU=



On 5/10/26 04:47, Thorsten Blum wrote:
> On Sat, May 09, 2026 at 02:24:01PM +0300, Jarkko Sakkinen wrote:
>> On Mon, Apr 27, 2026 at 01:44:24PM +0200, Thorsten Blum wrote:
>>> Add the __counted_by() compiler attribute to the flexible array member
>>> 'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>
>> This is again a crippled commit message.
>>
>> I.e. this requires either knowing, remembering and/or cross-referencing
>> "bunch of" unrelated to keyring.
> 
> I kept the commit message short because it follows the same pattern as
> many other __counted_by() patches that have been accepted across several
> subsystems.

That's clearly not a good example of how to document changes, so I wouldn't
use it as a reference.

-Gustavo
