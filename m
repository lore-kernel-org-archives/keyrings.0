Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAD345ED5;
	Mon,  3 Aug 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761668; cv=none; b=gqXe2q7oeShHbokCFFFWS+dSiQBdj8CQPc5E8CY20ABPXS1odnauvS09rNTMAFmcITrBqyFJdOr/SfGQmUWMIAItT+cfGxwfUHM1uD2SEYYwrPfc23P0l54rZ/tx3ecPo4kzcsMRLR1Leo/2vOPMRfoX8qMfUYb36i41+NzSQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761668; c=relaxed/simple;
	bh=vEBjojxZT4Ct4FWOkPtSl/UsjJV83U0kyCzMKx6h/5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NywHhasirPFB+C6uPyy4XkZbesJTBheYYBHLAAkpAbSFZzvNNdIiQl9xQexRWpbYtwR3b77j+ZM20bUuuBCCnDSyixd3JTX1PJ9wF8bJ1drsI4JQA4VbXd6X4B6xzFRwRKeb8UMJLbJcVyUq51kmOAiNuIum+iMUXs3NmOvqLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=E/37XMMJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFiXArHD; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="E/37XMMJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFiXArHD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 970111380046;
	Mon,  3 Aug 2026 08:54:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 08:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785761665;
	 x=1785768865; bh=XdhUY7gIfBKTt39kTsvjcNMlzRZeyYxSvOWiFph/C9I=; b=
	E/37XMMJ0v1Ud1lWVMQvTpyJCZCOLPVTbuoLeAvRkedhouyV/mlnvFSGw+oaQldM
	p73GHXwhaKd2DTK07mdTe7wKjvUiFTZ3RLkcX8Pa+qAp+4GDEkJlIhu0CLBT/1Dq
	Rwg4J/vBB/l6N/VOPRo21re9jKhsgafZirxl6MAj4z2QD9EJAGNn+Ju3cc9DIVMV
	VHpDEt/LvGTFFVgplQVHIMMziB3f8IWMSXMzOwSm4QzFPbdYI3edHpAMGUXdsnLN
	yS1Ct3IGugF74exAfxiZQexS3uM1zwnS8MbKrFmsbGIwi5DvWn0zdQvkaCHIEnK4
	7hJqcH1CBvuoaTEESExJFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785761665; x=
	1785768865; bh=XdhUY7gIfBKTt39kTsvjcNMlzRZeyYxSvOWiFph/C9I=; b=X
	FiXArHDlNIaYE+MSFFil6OM4ih9Q9ukB8Xg+PtmQChn/juMjJc5C/2TiiQa5rDdQ
	oji9SOifXAUFhQxCaF9TZXe4d3tJdWpFkRJkXwJUoFA3Q3h9CaaPWuAcoBKMGvNC
	T9XijdaPf5V8CmiRq3ZnS/+60fkcDV9s12//xkQJenxHiczv+ufSAF/ohVvvdK9s
	GHRfIJIuS87uOuHA7XRSOEVD0Gzqi9hjRJ6EC1I9JeX0UEgEAloWzvCEbTlnrQSl
	BnB/vKYF9z0sNpWDGDutmpSRD5Msj6V9xxH7ub3hX6IBXd3AXCvNvkO2QAvMkYTQ
	dJ0Oy4up4nrGsFmtx2aFw==
X-ME-Sender: <xms:gY9wap_gyPrNfTOfCdMuF-RTBVYkBSjVwOcJQ2LNvslRQxZCVvhLTQ>
    <xme:gY9wagfKNF4RQqJ_KVzOwahfzhJ9V1E8SMnCPJza0jrXdz4KYLY5_WmUjuk_5nDYn
    WNlfBrCYKBNem6pA0jfsdYEO8YIo_PxNOTHP28LMpWsdQIxkYBF6Q>
X-ME-Received: <xmr:gY9waj7qzG0aTPTP4hskOb8STRqmTH5_15kri37eDl3xAtfKXZb3lLjT_IQ8lvqKdf6xgwCsYfl5xLOUBrcrNvQ>
X-ME-Proxy-Cause: dmFkZTEAFwn4saL/ueJBGnQZvkKPJZOrxi7Z/2dkwRHayWmHWj9cIIsrRAVO1lPv5iGa2I
    07a4H2y3pW3KAvHQ432PvCbsVS0IkeXykOQfC9H46EgUO9jcKnIJ7dW4YjzU0Ps4sC4bQo
    8pzctXin8n+CtzWh+qnXDD5LsdpMGDmzQE7xHuriMeVbPyLI0BTGwLVBkZvM3487FUS5mH
    ojh/ZlhUAfcD6c7XxMQYSJdd/MJVosZjcqbPVVxLFGJsoN316J5bx9B/ynbhOnU5BJ6bMt
    UpXH6loyunRrrLxq3Qtdo7N7A6Zfs+5ztQR9/k+CaHMErQU69rWzwbtket9B+FHmEPJmf+
    m1QBe/Pypl+OospWrYYumCNptZu9SKzBkqfs6a8tBtpO5ASa0CndqsfBSx9nQ5Bis/RX1D
    KaqdqRod2s8ZM7BFrfCiSfeFbwkKjAZefFu2qSO2YBnUztZxlRWQ711MNeQ+I2zTxNaayR
    bUPmyHUCEXgi2r1cavn+NNVJCy8obrmR4csBg51STLoI/cHLdDvy4DYyCzKxo1CLi7dVxF
    oRTnbIHkJIHJDIYxZ19P3h9HrpUIAKmVZFO3YLDrTl+Ohck5MTLywiOvDh3dz53JqxWxko
    6lKg2tvXK/oMHO/Va5BgR/bc03JkpZhDno+J5C7c5sYZnPqOybQFQpL8cgXA
X-ME-Proxy: <xmx:gY9wak8h2ozZAE1RgwbftpnqMwtXUE2Rv-DcOVWREgeIuuNJfYikoA>
    <xmx:gY9walweEINbJmt1TkVmHteWu5WzfoVC2d5d9xFoJXhN9a-Y2AxKHA>
    <xmx:gY9wajHyXxJkuacXTCzsOmu2QS8sOZOAGqX-K3mWeUnGz35kSZI7RQ>
    <xmx:gY9wagOkgOrCBKZm5jNSl-r3wKgvHMLaG7_BHtFBrpYb9La7slGhRw>
    <xmx:gY9wat4FvRzPw34-XxHfeBGXAEHWmgoSE9B7iRFhhjBRP6_-yF9sTjNK>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 08:54:22 -0400 (EDT)
Message-ID: <ba907c1c-02e4-41b3-a14c-5535dc1fd09c@jaseg.de>
Date: Mon, 3 Aug 2026 14:54:20 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: Dave Young <ruirui.yang@linux.dev>, Baoquan He <baoquan.he@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <20260731154608.153258-1-linux@jaseg.de>
 <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
 <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
 <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
 <e9523b5a-6623-49ea-9ba3-cddae1a9ce7e@jaseg.de>
 <ab46b71a-9f8d-48c4-89be-e15ce50aa8c6@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <contact@jaseg.de>
In-Reply-To: <ab46b71a-9f8d-48c4-89be-e15ce50aa8c6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/3/26 14:12, Dave Young wrote:
> On 8/2/26 6:20 PM, Jan Sebastian Götte wrote:
>> On 8/2/26 07:08, Dave Young wrote:
>>> On 8/2/26 12:31 AM, Jan Sebastian Götte wrote:
>>>> On 8/1/26 16:03, Baoquan He wrote:
>>>>> Note that we usually dont' want to run a lot of work after panic and
>>>>> before jumping into kdump kernel.
>>>>
>>>> I understand. For this reason, I think it's best to keep this default-off. As-is, the notifier list call is timed and on the (slow) ARM64 target I'm using, it takes about 3-5 ms to run. I took the "try lock, skip if locked" approach to keep the risk of this code crashing during panic minimal. In my application, the kdump payload is code that then does a full wipe, taking a couple hundred milliseconds.
>>>
>>> Not only about the time used, the panicked kernel is not reliable, any more extra logic can make it even not reliable, any pre-kdump extra logic is not a good idea unless it is a must to ensure kdump working.
>>>
>>> Cleaning up secret data can be done with makedumpfile + eppic scripts (see the manual of makedumpfile), or it is even possible to do so in kdump kernel with Tao Liu's improvments for makedumpfile previously  (I don't know the status, probably dropped for the time being, but it is possible, cced him).
>>
>> Thank you for the pointer!
>>
>> There's two scenarios worth considering. First, in the standard scenario where you enable this option, then drop into a standard kdump kernel, I don't think it makes a big difference *when* you do this cleanup since someone is going to have to dereference these pointers. IMHO a good reason to do it in the old kernel is that there, the code knows about the layout of all the data structures. To retroactively do this in the kdump kernel is much more complicated, since there you have to reconstruct the structure layouts from symbols or hardcoded struct layouts, and you have to keep this symbol/layout information perfectly in sync with the running kernel.
> 
> I know that this is the usual reason people want to do things in 1st
> kernel :)   Like the crash_kexec_post_notifiers which was introduced for
> people to use at their own risk.  Is it doable for your case to use
> crash_kexec_post_notifiers?

I think there's a few reasons why crash_kexec_post_notifiers isn't what 
we want here:

1. Enabling/disabling just the key wipe notifiers scattered around the 
kernel becomes a bit ugly when they're mixed into the same notifier list.
2. The key wipe should run after other notifiers because by definition 
it will corrupt data structures so future operations like any crypto 
operations will fail in interesting ways. Having two separate notifier 
chains is an easy way to separate them.
3. For my use case, the stability argument is exactly why I want to run 
only the wipe, but not crash_kexec_post_notifiers. There are many things 
in crash_kexec_post_notifiers. They take precious time, and they 
themselves can cause instability. For example, the remoteproc panic 
notifier can (intentionally) wait up to several hundred milliseconds, 
which is too long in my use case.

Thanks,
Jan Sebastian
