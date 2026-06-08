Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95970808;
	Mon,  8 Jun 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890543; cv=none; b=OEFbRBfud2tA3VAnflGC6KDRoFtDJBCNA1cpQe7mgMndO/YOam0/JNRJ4NsPomGfYIWDWqym2Yq7XAklsKCwYCDrn+AYWR9vZwEL8Gz8Iz3X/FoXAZoT7hOWm29DALep6XVtTDUPnA6ok/h898IW/YaW8qt44OnfDgKI6QTKmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890543; c=relaxed/simple;
	bh=NHvv1C9nD5fi6ecrpB8JZZnGPsOr7l7jPJQ+ny+Ejao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjZyA2+vaH1mMDtWtrAz4v667odiAxoiXkVgPDUmrEpIJyiEu189mWL75/T2mdZBbBPPLX0WDMZdsu90LYnIzg7QKGzpjiI1DN/AGBAAMhB2oJoed3Cu7SWLMI8s1DL5UeeQ+Niu2bm140Wda+7v9npzkGV84QcOGHEJqDdq1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISjI26et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISjI26et"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B14DD1F00893;
	Mon,  8 Jun 2026 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890542;
	bh=7pUp3OJR2R30yLjkoMrfjrkuj3wqfZLCawbD/bNLgc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ISjI26etW4rh3io/3Jd36iTWmwREu5TTaV1JCKIZmUEVWaP3rvnTgHu7FdYo2sUdM
	 logZiiTinVZyN1JiFwcX0c3AqjDbIBcW951cDZ3cBgwRC2MeWAeIbNSq233hV+I+5T
	 WvkNZ+PSYoWb2pnySGcSBSYSpOyybh7M2x4Vpgnth91sdcqDUE3SA7WSZ7RtZ/0L93
	 oPVMX26gmUVeRDxQhTAul9PB/fQdK3uVxO3W5GZ9bM79BftaMDNovgXy0lHgXwwGf1
	 9d4rcrZNHv4rDf8VsyvMnULQBsMRGosmgb8yDcthwFF/Pk5JUZwHqLU2ZMSRwGmvjC
	 DYW2t4PCfRDyg==
Date: Mon, 8 Jun 2026 06:48:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, ebiggers@google.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com
Subject: Re: [PATCH] KEYS: Use acquire when reading state in keyring search
Message-ID: <aiY7qqDGdfketqqP@kernel.org>
References: <20260529033406.20673-1-hanguidong02@gmail.com>
 <aho3CYdv8lQd2s85@kernel.org>
 <CALbr=LYaca4+=hTsZJORQfrtzyUAGo8c+4ZEgkzgkFWQDWNJBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALbr=LYaca4+=hTsZJORQfrtzyUAGo8c+4ZEgkzgkFWQDWNJBA@mail.gmail.com>

On Tue, Jun 02, 2026 at 05:42:26PM +0800, Gui-Dong Han wrote:
> On Sat, May 30, 2026 at 9:02 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Fri, May 29, 2026 at 11:34:06AM +0800, Gui-Dong Han wrote:
> > > The negative-key race fix added release/acquire ordering for key use.
> > >
> > > Publish payload before state; read state before payload.
> > >
> > > keyring_search_iterator() still uses READ_ONCE() before match callbacks.
> > > An asymmetric match callback calls asymmetric_key_ids(), which reads
> > > key->payload.data[asym_key_ids].
> > >
> > > Use key_read_state() there to complete that ordering.
> >
> > OK, so... I'm having a bit trouble understanding the exact concurrency
> > scenario you're trying to describe despite I think I get the fix itself
> > i.e. it is not pairing with mark_key_instantiated?
> 
> Yes, it is intended to pair with mark_key_instantiated().

OK, right. I'll apply this.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
