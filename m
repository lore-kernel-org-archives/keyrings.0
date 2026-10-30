Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340651;
	b=x3g/8eniuZgBOVPQ8b+1MaxRdo+chML3cSi9in0wq5YVNvZl9BdOeDNUHG+jFHnxYsSk
	 DmW8NvyePEZjMQ0c/w2+rLpi0h8zH6lECA7xGwoAwrAkqPOesS+OjEZa5Vg5O0Sa8ctFG
	 1f5q58EJ9ZSRysMm2NIT8fhmrgPDU60MwE6W2is5fQY460QylEaeKax6pHfsFWAZUCjUL
	 LiWpfX/tB96QaofsGnNZMzPfiA5OiaItiGaTsavtkRPUdQePM7UEaFZTOfu0i+DghhXk4
	 8vM8fVYyS++XmWCWf0tF5aw2SPIG5hlVVOlJc481M6Y91+4dausoks1M0esqgRKZgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340651;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eMxOXDCp+lLHimw0Ajvi6bdsS4XBDctUyG1YUtNMsak=;
	b=V+5aqGjKcVb32kPeutPfxRovm6QE8qclh3GKDM+iGq0cBrf97/vGBzw8l2sOTMBA7nAX
	 1WyTDwgNceke3G3owHXdcDjtVbQ3nctcxMeWj7Gb/W8jAhXk42Oes724o/YHgPwYnb4Qj
	 zzllCk1LmbO7jjx+UvRIjdGDcovgeVwAWb2lySbm+Vhn6WBfD7wFqNAuo0kVqOVqeSZxS
	 DTH/Rp6FZCLOUYhy7PRxX6ygM6saiucH7rGyYfJTpdr109G80WSAD6m9aqMZQYsjLS9sT
	 8kR5aERSW+/ovjzRiyJy/vLPOBqGi38X+gdbLlGuuatyoa0bpvcKRhvt30j6ACmkFCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=pimCZgrm;
	arc=none smtp.remote-ip=202.108.3.163
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFBA606A31A
	for <keyrings@vger.kernel.org>; Fri, 30 Oct 2026 06:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CFBA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=pimCZgrm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793340649;
	bh=eMxOXDCp+lLHimw0Ajvi6bdsS4XBDctUyG1YUtNMsak=;
	h=From:Subject:Date:Message-ID;
	b=pimCZgrmnSAq4X4zHwmGbeg0TQBKyAWzrzBm7c0Wv+V0PmESo90ZFNbhfGyoFNcx8
	 WETgK3dMuQkNHI1uP6lczctlmL57g75/z479y0FvksdVbGKb+22jJqrZahJGDczlFC
	 Ox1zm1ObaSdE0cw7AlZcSFcBklRqJZAqkcy8iG00=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.254.0.223])
	by sina.com (10.54.253.34) with ESMTP
	id 6AE434DC000034D4; Fri, 30 Oct 2026 14:10:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8079216291752
X-SMAIL-UIID: 10D141D9B4E846BC8D24E5D11E86C7F7-20261030-141040-1
From: Hillf Danton <hdanton@sina.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Date: Fri, 30 Oct 2026 14:10:06 +0800
Message-ID: <20261030061030.233-1-hdanton@sina.com>
In-Reply-To: <auPjLi6xocFw7r-k@kernel.org>
References: 
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 02:22:06 +0200 Jarkko Sakkinen wrote:
> On Fri, Oct 30, 2026 at 02:17:31AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> > > On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > > > key_garbage_collector() has a design that is not resistant enough for
> > > > workqueue lockups. The duration scales up relative to the number of items
> > > > in the serial tree, which causes a reoccuring theme of being guilty of
> > > > causing workqueue lockups.
> > > >
> > > Given cond_resched() the gc work is not a cpu hog, and given concurrency
> > > workqueue can get individual cpu highly overloaded in short time, so what
> > > you delivered is a half backed croissant, HBC, as you failed to make it
> > > clear why lockup occurs when the number of gc items rockets up.
> > 
> > Please, read:
> > 
> > 1. Documentation/process/code-of-conduct-interpretation.rst
> > 2. Documentation/process/code-of-conduct.rst
> 
> And: I'd suggest to do some self-reflection and not use LKML for
> trolling. There's 4chan, Reddit and other more appriate forums for
> doing that.
> 
Can you answer the simple question, why is your patch correct for curing
the root cause of the workqueue lockup? Because it has nothing to do with
trolling.
