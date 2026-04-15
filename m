Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B6231714F;
	Wed, 15 Apr 2026 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254918; cv=none; b=V7AKm0Sxe1jLpq6F/DkXzd2tmgg2ctkt6s29y5Tq6vEIkJayKV7KytWm6tsmzOgIgO18tnhCrS92cVRqySgDGfcuOM9MarcpjQLop4UYz9RSWPMCRqrBhrXOPw+eFYhUV+0LZnFOfbhcRZvYfY+x5xYrWMFpapE7lVQkmyVgxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254918; c=relaxed/simple;
	bh=uykFcHYs5XbFbRSMsJKgZxNwKQCnwgz6lqEF9ZKrZ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOidQNKV1yyvpVEdqX0dyXgth2nSj5cN1li4Mn1aPiw5s7AyLLgqmRuICWeNLZ3OP3oEDwt8mJOgH062TkbEhZmD+jihPqWx6OQE+Jj7FajvVB9RxQt+GpooDuotC8a4Kk9LK0EAmguXG8ZPZZHHV0iPDBnJ3pL3DQlzG+OaUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUv526Qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUv526Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7D9C19424;
	Wed, 15 Apr 2026 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776254917;
	bh=uykFcHYs5XbFbRSMsJKgZxNwKQCnwgz6lqEF9ZKrZ7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUv526QiHFL9Xp9EvuhOxHOtAnjQzg6fk5HyKW0bR/QRzckXI2cr1Nn6ZN1squea1
	 ak6hfr4s2AK+pXAaFpvmNUV96EHPDYUrC1wn+iDCzZQWeWdv0xPKuC+H1SkCtPsyIq
	 4Hyx1aViSG7ypNoYR45odIPoqmlA8lfyGyVchptrn9Iu0InlTjxxKOO07dvdb5yZUT
	 yEqfrWSfRGQ1ENaxHRgsJGDUC9fVr34ZERv4NOUF+Wa6oRsUWpD4ANjZcSHGgeQ4al
	 cWsAHZyktQARomACoNMLB7Vcc206FvVDYMAE9WkwrnxjxMOeZ4dG3zsuzhoLKnXjS2
	 tXZqt+7ZKWaeA==
Date: Wed, 15 Apr 2026 15:08:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <ad9_wQfq7fYEU7mS@kernel.org>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
 <adYZoWK_CTv2-RA_@kernel.org>
 <adZIP8w0IttbIZa2@linux.dev>
 <ad7UjdtT1vLwlu0_@kernel.org>
 <ad9dCoEsiwwgRK2L@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9dCoEsiwwgRK2L@linux.dev>

On Wed, Apr 15, 2026 at 11:40:26AM +0200, Thorsten Blum wrote:
> On Wed, Apr 15, 2026 at 02:58:05AM +0300, Jarkko Sakkinen wrote:
> > On Wed, Apr 08, 2026 at 02:21:19PM +0200, Thorsten Blum wrote:
> > > On Wed, Apr 08, 2026 at 12:02:25PM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> > > > > Add the __counted_by() compiler attribute to the flexible array member
> > > > > 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > > > CONFIG_FORTIFY_SOURCE.
> > > > > 
> > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > > ---
> > > > >  include/keys/user-type.h | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > > > > index 386c31432789..2305991f4fcd 100644
> > > > > --- a/include/keys/user-type.h
> > > > > +++ b/include/keys/user-type.h
> > > > > @@ -27,7 +27,8 @@
> > > > >  struct user_key_payload {
> > > > >  	struct rcu_head	rcu;		/* RCU destructor */
> > > > >  	unsigned short	datalen;	/* length of this data */
> > > > > -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> > > > > +	char		data[]		/* actual data */
> > > > > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> > > > >  };
> > > > >  
> > > > >  extern struct key_type key_type_user;
> > > > 
> > > > You don't provide any evidence of any improvement.
> > > 
> > > It's a proactive hardening change to help avoid future mistakes.
> > > 
> > > The __counted_by() annotation makes the bounds visible to the compiler
> > > and at runtime so that future ->data accesses can be checked against
> > > ->datalen.
> > > 
> > > The current code is correct regarding ->data accesses and doesn't
> > > require any changes.
> > 
> > OK I'll buy that but send +1 version:
> > 
> > ~/work/kernel.org/jarkko/linux-tpmdd next
> > ❯ git am -3 20260406_thorsten_blum_keys_dns_drop_unused_upayload_data_nul_terminator.mbx
> > Applying: keys, dns: drop unused upayload->data NUL terminator
> > error: sha1 information is lacking or useless (net/dns_resolver/dns_key.c).
> > error: could not build fake ancestor
> > Patch failed at 0001 keys, dns: drop unused upayload->data NUL terminator
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> 
> AFAICT, linux-tpmdd/next is missing this change:
> 
> https://lore.kernel.org/all/20260226214930.785423-3-thorsten.blum@linux.dev/

By pratical means, that is lacking any proper commit message.

BR, Jarkko
