Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373454;
	b=t2vkXGBPuac5SvVNV+B4nSCNbvHkMsEif7DIfIhsmSK3JBA9QUncx16EBezCvRG76g4c
	 EHlHboiOApQEl5VshWAF9S1qGbzfbloc5uZG+pWF7w0cA9AMlOsyQC2LG5/VA7vLxFZXq
	 BWQfJbLgiux9JLstQ42O5OLcyOIpz2mSx4I3QvpYQDwDbJM4AOI8MA3Rdq3eY/jJq+VpV
	 CJVIyGCeIsBQYZPHMEoloGw+LvPemO1X8KqQsMTNqNan55okgyErlJsJwP2peeXLh1gpc
	 htkHZff1Ilr6piPUc8gOIdqifO1Onus3f8QOeMFi6DF7sKEca49i2HSGhbHU6p9JTsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/jp6ivy6vmyDZtH0OefXra17iOUkW2kShpGzOfJVuWQ=;
	b=lslnmNrX8qM8lUOOSibSm01WLRqUhmGXQRU+vGN274vdrqawepXtRUoixFWYfw4ms2JW
	 YISRKfeCY2ckDRRPhg60a97rL/96Gg/Zn2v9X2BugGE/palLFl/PPU3+F0yxlQVSedF+e
	 jd2pHIe0mcrn1D/EEjMClEVXRPNdmED6XD9EYUqAG75+RLc2hXVFYDveecWB7hx4iVSie
	 FsxAHvtZDEPtUebAvrnDqX1wFlom14n9P00nkJmZq9lkufNLsZXDC9XHlNTRNMRtlvyH8
	 Wl56qdJPm6yr3BQFcCAuRGTse4vubIFGuLHsw7KwetduTJYyiLHTuQF/Ru6h5FEG5nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l5mT5ov/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8B15B606A31A;
	Fri, 30 Oct 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5mT5ov/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7E9321F000C1;
	Fri, 30 Oct 2026 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373454;
	bh=/jp6ivy6vmyDZtH0OefXra17iOUkW2kShpGzOfJVuWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l5mT5ov/LuihabC2MGkwBiKUC6X1tie03nkzY2/qVhkS7aBEyvulkfMw0q2lmYP6n
	 wupKYQ74chyObMTDOdoLqtxqxRYKGmFoDhVIv/a4JSyDuDTMQb3hscPgY6Cy2xgcSz
	 TxK/lYGUSTO6y0Rr+m2XfhQrMDKAUSaolJ6/GtpUgOMb4e29Q81YFBZ3oF6Hfz8wdC
	 9wDLpLsfBu/l972XC83PZLGkL6Ga4sfQepd1IXRBE92HEXjA9hvzk8W4ZOKbvjp0f2
	 eWvdsSyAFQvIwRcaeeY9LjT0dRUyF0wq9t2bnGF4KEaBkqk0APJBTv2E5QQ4aPAhgb
	 HsA30ixGqj5VQ==
Date: Fri, 30 Oct 2026 17:17:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auS1ClHZaIVxOCNc@kernel.org>
References: <auPjLi6xocFw7r-k@kernel.org>
 <20261030061030.233-1-hdanton@sina.com>
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
In-Reply-To: <20261030061030.233-1-hdanton@sina.com>

On Fri, Oct 30, 2026 at 02:10:06PM +0800, Hillf Danton wrote:
> On Fri, 30 Oct 2026 02:22:06 +0200 Jarkko Sakkinen wrote:
> > On Fri, Oct 30, 2026 at 02:17:31AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> > > > On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > > > > key_garbage_collector() has a design that is not resistant enough for
> > > > > workqueue lockups. The duration scales up relative to the number of items
> > > > > in the serial tree, which causes a reoccuring theme of being guilty of
> > > > > causing workqueue lockups.
> > > > >
> > > > Given cond_resched() the gc work is not a cpu hog, and given concurrency
> > > > workqueue can get individual cpu highly overloaded in short time, so what
> > > > you delivered is a half backed croissant, HBC, as you failed to make it
> > > > clear why lockup occurs when the number of gc items rockets up.
> > > 
> > > Please, read:
> > > 
> > > 1. Documentation/process/code-of-conduct-interpretation.rst
> > > 2. Documentation/process/code-of-conduct.rst
> > 
> > And: I'd suggest to do some self-reflection and not use LKML for
> > trolling. There's 4chan, Reddit and other more appriate forums for
> > doing that.
> > 
> Can you answer the simple question, why is your patch correct for curing
> the root cause of the workqueue lockup? Because it has nothing to do with
> trolling.

No.

Br, Jarkko
