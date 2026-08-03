Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877536402D
	for <keyrings@vger.kernel.org>; Mon,  3 Aug 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758546; cv=none; b=XUzTjF2jUZ+tXzZs1QI77lGG5G8F2ZgwARBoq4gTRNEIC1con4+FH8xUlB+F0oxuSt45dlHcaAKa38aEEEVYmpJA0qIFhZ9embWl+m5ES02BKt/7iqLaioPXm2oeH1rMSrcg3vo8p8fdHYC+z35yEgp1LbYgI2ls8y61COBMyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758546; c=relaxed/simple;
	bh=uPSvFy7P+QFSiwZBSzTMTlUAthCnrZKn7ag0MqcBlBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t06D8mLJm+DJ8u605CeMODi+XzOX/IJV/g+lByVDbvoCukDhzOWMZclKU4fwWynQ1W0+S9UGqc13jsf6GNNCQFjdk/99xLFBWUlhUTQ48JZINhssp/oRVEX+mRd2unBFBWKvmWaqYyzJPVPKgWXzRt/i5AH1/OrQA7ru5u3RZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnouUtAw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnouUtAw"
Message-ID: <d5513f7a-6a69-44ad-ab3a-095cba0d1cb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785758532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52EZk8YPwTy+jG8rvfx/kfwJ0amdCbdlhZF4BPxa9n0=;
	b=EnouUtAwmdUyiYMkNZYeTEKz+AWGqvGLFPzrRg2VSPbHDC6HVF7FROS4eLHrg3gT8tooRk
	rig62DQPA5EaSsWXf6iA3G0v/XDaJ6BmV1oe49+5hzRGn2f3z2n2yirXt1Il6HlfYyxdck
	yb7BufJLbG3lqJtL+aY1dN0OwdZGnlw=
Date: Mon, 3 Aug 2026 20:00:32 +0800
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: David Howells <dhowells@redhat.com>
Cc: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
 Baoquan He <baoquan.he@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
 <20260731154608.153258-1-linux@jaseg.de> <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
 <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
 <2490025.1785751199@warthog.procyon.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <2490025.1785751199@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 5:59 PM, David Howells wrote:
> Dave Young <ruirui.yang@linux.dev> wrote:
> 
>> Cleaning up secret data can be done with makedumpfile + eppic scripts (see
>> the manual of makedumpfile), or it is even possible to do so in kdump kernel
>> with Tao Liu's improvments for makedumpfile previously (I don't know the
>> status, probably dropped for the time being, but it is possible, cced him).
> 
> Does this represent a leak of the secrets?  Also do governmental
> standardisation bodies have opinions on what constitutes a leak?

It depends, for the crash case I'm not against to clear sensitive data, the
concern is to avoid extra complexity of logic pre-kdump.   Which
government?  Sorry I can not answer here.  

> 
> David
> 
