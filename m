Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752218;
	b=AhMpaf5cnUpc1xXuWo3OxsyOsPLHc/prSmlHzc6E72dvYTkRbAoIQ/OsW/5n2t+FMYvf
	 Oi3fcKmFJuT62IqFeVWbgZoWUCju+0lwLbWe0gAGPhe8xnt0NXM9OVldp4Fut9MxFvwE9
	 Y7woCoVeTObLRiao8rfMKLueMkcb7A5vF0WRfIodE7zsG1JvopcDGh0tz4xXWvIZU4E7U
	 9IZl/rcapckzdELfGjrdDwavRleyUwBFXsjp+vseL1vADabKw/CYPfCmPBVHwfpwoQ4gr
	 slFnoShqSBe9n1ax/a5SNVhLcmhgJiGR93CChPYijn+7tmFbdIXG6IKWRxq0JCu2xjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xDOGDJnKdbk9zvnxTD/OktB5rQV36xGxR0ci2chyUhQ=;
	b=1nW/AnWYnoDdMpQdRqIPaleMNmDSiGWO5oqOR957Osm8LGwC9GwP+0hr6Xql1637I0Fb
	 FixXk1EcK27wGfBHfbucm6wQ7Y/JqKbaJtEm8l1UDg7WrO1mTLu1d16V/lotuhvF9ABDk
	 vzJZVd/GVKQ+BphZShg4QbF8HXewlpxdS2t3eJEG3I5uwVMoaMzVBy0iGyUTgw4GqkoEk
	 jT/OSQtJ7Ml+ivMIa8P0V7ngoy7jpIwA04dnfVZrqsoSsVfkDLpRFhXs/BaW+4WIaLSrR
	 1oepHix0glALbU6N6tPZWLZspAhF5ckMT+943cnweX/UhDl2dio5v/uKlXJ/ghWfKsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et0f9bLr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BD6AD606A31B;
	Wed,  4 Nov 2026 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et0f9bLr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1C63D1F000C1;
	Wed,  4 Nov 2026 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793752217;
	bh=xDOGDJnKdbk9zvnxTD/OktB5rQV36xGxR0ci2chyUhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=et0f9bLrm5IkPuVzusZcF1wHDuyMd5GkAeXuTcmg/IU4wI6y6HbVXOdTsjTXvIpuB
	 WKMlwA2rJkAjiTJaKZG40LNia7v96jYmTGRpb2nN/1LVRkh9A+VUIzSTj4PQ8C3HSB
	 h0TVlXyyiD86HwKFD4eKfkhuYFOUr5lDMHKBOevn+mkTKsBdAHdSFrJARJTYewH6tm
	 /eCll6gFnbVbTv8QFkrp6eI8ewMJlwySYxgJx2TW0R3+CiJ6wibQNYqkndEXWdncc0
	 hHj2prtg3sFvJg7OC115kcYV1WN3NxVaSsmeFsHshlG1S2/9orL2m14UARngjW0CIl
	 MS7tqvaVgHvFg==
Date: Wed, 4 Nov 2026 02:30:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
Message-ID: <aup8lXNaqGbPAuWY@kernel.org>
References: <aun4kXCJDtYomzpu@kernel.org>
 <aunNj35KmcAC4ByH@kernel.org>
 <20261103030226.2685251-1-jarkko@kernel.org>
 <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
 <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>
 <683284.1793719946@dhowells-thinkpadp1gen8.rmtgb.csb>
 <auoSwRMIXLajVeWs@kernel.org>
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
In-Reply-To: <auoSwRMIXLajVeWs@kernel.org>

On Tue, Nov 03, 2026 at 06:58:45PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 03, 2026 at 03:32:26PM +0000, David Howells wrote:
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > > > Actually, it can be done if the rxrpc and rxrpc_s key types are moved out
> > > > into their own module upon which rxrpc.ko depends.
> > > 
> > > Hmm... I'll experiment with this, thanks. This was useful.
> > 
> > It's not entirely trivial.  I've attached a patch that makes a start on it,
> > but it needs access to bits of the security class implementations (rxkad and
> > rxgk).  Those bits only parse the key (and in the case of rxgk access the krb5
> > code), so in theory it should be possible to extract them out.
> > 
> > One thing that needs to be considered, though, is the security class selected
> > should really be up to the application, not merely switched on by the
> > security_id.  This is one of the reasons I would like to add an add_key2()
> > syscall that adds an additional parameter string argument.
> 
> Thanks I'll investigate this.

Well, this really unknotted:

    dns_resolver: Move the key type into a separate module

    Once keys bind their type, having the DNS key type in the same modules as
    the resolver will introduce a circular dependency preventing module_exit()
    from ever running.

    Introduce dns_resolver_key.ko containing key_type_dns_resolver. On a module
    exit, drop the credentials and call key_gc_flush() in order the drain the
    remaining RCU callbacks.

    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

And yes, I was over-complicating this, just like I told earlier :-)

This means I should be able to submit v3, which continues to build
around the same ideas.

Br, Jarkko
