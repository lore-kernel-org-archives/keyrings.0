Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622108;
	b=rgwNuhiud/GFSkhmED2cp9hQN2pgENT9qWfCWiXzI0n+t81cEFgUiZAMOOB6SC+MI3vU
	 uN+FlrY79+1F0Tlyyt6GTh+q7gVgrDW8VzKqzcUIQs4GNY8dnr7+yyvm9sezItn8uz/9L
	 NbGCQyMhxeGbJUPSY/vdtB6QFlyRlZSMWWhiCK2bUYdrCuR15R1O61FOp0OHIYeyqqC0X
	 KSL14+60Xj/qDmN3oo+whVBbOayBnue2H2m20Pja2u0etbERsWBJ/sknjY1Zc/BwsIrMB
	 ru9++tzrD5LvlRrc/rSf7E2b41WZKoU+mTehEjLxfqhV2BVFyBc4/hUpY1+DPj8cDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GHovLVucfyKq5UqgyfiXId8rVl0+79MEBkzUXLNAN7I=;
	b=ajhua/5XvvWWdgpSZixbDaHcNgsCaDrQIpbbbwuBRnEh3K6Dkst8ltIRSji+i1lXKwMM
	 qA1TfQLfbS9WPHw+F50hpMl+hGoE96c4Hja+NmDvR3iWp8acqYUrYv3eSlAiNq6sK75DN
	 boVg+krTVDbSFr4zVPwE5FnTnkHwhNbTOTEDF0OlIR5KFjkbXI+wx7vnt8FBEchlW8ZPQ
	 YF1brujdPR8xvS7V8/Q+GEN6fIZJFUYsxFHo9aeGMk+TlAD9sPdUIys1/uTt51rsgTN3y
	 Jox04DP1yZUEdKAgmuhcFoJdG0Bx09Vome0GhFg/Ewe2v6sE1MMm4YI+tBUQi3tyGqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4R2LTHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 222FF60A5BD0;
	Mon,  2 Nov 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4R2LTHk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 058621F00A16;
	Mon,  2 Nov 2026 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622107;
	bh=GHovLVucfyKq5UqgyfiXId8rVl0+79MEBkzUXLNAN7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4R2LTHkPbsCTOWRAU9jt7D/+oHDv3ggE25SgObERnWJzJifuU5G4jVybbx+hrScw
	 ypa568/IcWGmR545l0LEUUKt4crFx0UQPHPZ1FeLgE/wODPyoO8lkQ76Y+IIrXvJHt
	 S2DFE5uJOFgqNZE31+1wzQQYhpHCB3q9AAq2lc28b0METdC4vusvQtTkiAM7i0TVHB
	 jrgppPq9iPTOLHa0htEwq7h/xsmRAjrS6NXCUOIOpl2w/tONEPYXD/H4ojqe98L/Ou
	 teOewByHsNweghD7lrp2PvgOin4j3QYZ4YNBMgcKse7zkNARrIUwJt6YSnOcH2VZsH
	 o2FIQAsBttx9Q==
Date: Mon, 2 Nov 2026 14:21:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] KEYS: Remove key_type_dead
Message-ID: <auiAVx5DrjNSMSpS@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-4-jarkko@kernel.org>
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
In-Reply-To: <20261102121518.1197453-4-jarkko@kernel.org>

On Mon, Nov 02, 2026 at 02:15:14PM +0200, Jarkko Sakkinen wrote:
> unregister_key_type() no longer needs to retype live keys as keys and
> restrictions pin the module while they reference it.
> 
> Remove key_type_dead and associated code from the keyring GC.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

This was not too hard as I had just paid tons of time implementing
and benchmarking the chunk processing code, and I think these
features supplement quite nicely each other.

Br, Jarkko
