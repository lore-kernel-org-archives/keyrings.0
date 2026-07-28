Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9B41225;
	Tue, 28 Jul 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200940; cv=none; b=GKuyd92bkYBiXxkozwWeACfKA+g+i7YsudNg3TEV0WRfvqO4sBEf28uGPri3o+gnMTkAQQ+bNl0m1/U3Z0lLEOC8VDz+0/Ntzb7lDzR0P88kgpaj/aZ14RwCqnwfuvkiR1debLmW2lXtcAfPRj5m9EYdoTDuq+8HO/B6awIrkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200940; c=relaxed/simple;
	bh=wuLHI9PJ37cVbO4KlUcdZsj8x2wzeuv7ucgeTzkebg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXAgy+jqfQker81qDw9DVk4T72MPb2b5ky++ShWM1Rrpb67S0zqrPLzzifr/ofwaIU/kIrX3ST624lGI75TxsnSZqIq8hhN7meeD5rmCE/xGd1CxNQn/bBi45yplQhrOzkiERyZgdXIfZ+r3uai+M7vNU29BavIpqqpJbH1I4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imon9MPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imon9MPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EACD1F000E9;
	Tue, 28 Jul 2026 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200935;
	bh=9zUymOl4IeQd930ZlDC66cwTGV5/HbSV07CpDuG3iEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Imon9MPQVTHFqv4ym3v5EWB9FBff091VMZOyMfAhvrpTS6cTpG25lmv1zbIwlBM1l
	 43Ga0P4pYugj9SZBnel1WIp98u68lz65Bx+H2YbYS4bI8CLp37NExn9+2SxJFV9G8b
	 xIbsATe/LNbTJxTgg2Az9JI6XblkxKuJ3y0ust11F8jP4iXVtqI1kwsXBV2BPynIBi
	 UeqLbquW2I7k+mHE0CYawaIYkWX6QIVtl9wWq7vjObcft+FANwgBQ4qg9cvb+I4NkQ
	 +IXoa+ZIL+osPnxyTY1/PThWcAzxb/YmSw9HPBEBmKWC5I0BIx6/1TEpmss6SqGjRv
	 V0dv/btO3cjHQ==
Date: Mon, 27 Jul 2026 18:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Jeffrey Altman
 <jaltman@auristor.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v4 8/9] rxrpc: Fix CHALLENGE packet overqueuing and
 simplify RESPONSE generation
Message-ID: <20260727180854.6280c04b@kernel.org>
In-Reply-To: <20260723100309.530157-9-dhowells@redhat.com>
References: <20260723100309.530157-1-dhowells@redhat.com>
	<20260723100309.530157-9-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 11:03:04 +0100 David Howells wrote:
> Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
> the AF_RXRPC socket that generated one of the calls on that connection for
> the application (which might be in userspace) to service.  The application
> then picks up the CHALLENGE and requests a RESPONSE packet be generated,
> allowing the app to include app-specific data in it if appropriate.  There
> is, however, no actual limit on the capacity of the CHALLENGE queue, and
> this could be abused remotely - and also getting the OOB mechanism right
> has proven tricky.

net/rxrpc/sendmsg.c:383:37: warning: implicit conversion from 'int' to 'enum rxrpc_abort_reason' changes value from 128 to -128 [-Wconstant-conversion]
  383 |                 trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
      |                 ~~~~~~~~~~~~~~~~~                 ^~~~~~~~~~~~~~~~~~~~~~~

Sashiko has some comments too (Claude Sashiko didn't run since the code
didn't build cleanly).
-- 
pw-bot: cr
