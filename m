Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55139B4A9
	for <keyrings@vger.kernel.org>; Thu, 16 Apr 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334425; cv=none; b=TQh4heo0lS12iOWB8qAjzMVEKQ+DUDulfEXMCe6PcvaFWHyXbCmHwIX743A0MrUMaY2FydGr9oNLyMP/rqM5HSJUE8f00gJNuVzbFB0U7RbKf9KjF08tcTEJU1t8ItoPZADPK+3S2E4BCw20AK8fgf0sdmHqwuFaeydLZLEpePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334425; c=relaxed/simple;
	bh=ArcIWCZmBPTDwwsC/vDqAb5wp9IUKWfD7vKLk5BsjGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVR0rgzL+fOk75UmkJLb5zaPIVMgktQ1ewogCxvnASDSYcWi9m/ubk8cg+7UaBgpZzNotYTsW4fqCq96/hlKlkBzFvgiOnCa4quvc1aHaVoYRbuNHVpX44O9pN66oRS3PsVl/sXvXsd5GoeQD+07KXsfPshnBSH3okmcw8Rkf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QuOGEMes; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QuOGEMes"
Date: Thu, 16 Apr 2026 12:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776334411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEP3FwppOq3TV1mgmtnkSnFGLCh9cN1Mu28D/6VMLvQ=;
	b=QuOGEMeskI5EHg8WF/aN2FDxxyoBCBMMDRWLZC0h8nwkBkwFFFIfd8azWo96C/GLU6PQzQ
	qb+W2G2Sdow+98lNEaUKyWepNCtZtxmREM1iiQ/vDr2jqBbOy/wi2MuBTf+DXHn7ERUwbY
	fMGFg4r1+TSUfgcWsO7S72b5S+okw1o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <aeC2SNPslfdMV-Rh@linux.dev>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
 <adYZoWK_CTv2-RA_@kernel.org>
 <adZIP8w0IttbIZa2@linux.dev>
 <ad7UjdtT1vLwlu0_@kernel.org>
 <ad9dCoEsiwwgRK2L@linux.dev>
 <ad9_wQfq7fYEU7mS@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9_wQfq7fYEU7mS@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 15, 2026 at 03:08:33PM +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 15, 2026 at 11:40:26AM +0200, Thorsten Blum wrote:
> > On Wed, Apr 15, 2026 at 02:58:05AM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Apr 08, 2026 at 02:21:19PM +0200, Thorsten Blum wrote:
> > > > On Wed, Apr 08, 2026 at 12:02:25PM +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> > > > > > Add the __counted_by() compiler attribute to the flexible array member
> > > > > > 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > > > > CONFIG_FORTIFY_SOURCE.
> > > > > > 
> > > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > > > ---
> > > > > >  include/keys/user-type.h | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > > > > > index 386c31432789..2305991f4fcd 100644
> > > > > > --- a/include/keys/user-type.h
> > > > > > +++ b/include/keys/user-type.h
> > > > > > @@ -27,7 +27,8 @@
> > > > > >  struct user_key_payload {
> > > > > >  	struct rcu_head	rcu;		/* RCU destructor */
> > > > > >  	unsigned short	datalen;	/* length of this data */
> > > > > > -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> > > > > > +	char		data[]		/* actual data */
> > > > > > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> > > > > >  };
> > > > > >  
> > > > > >  extern struct key_type key_type_user;
> > > > > 
> > > > > You don't provide any evidence of any improvement.
> > > > 
> > > > It's a proactive hardening change to help avoid future mistakes.
> > > > 
> > > > The __counted_by() annotation makes the bounds visible to the compiler
> > > > and at runtime so that future ->data accesses can be checked against
> > > > ->datalen.
> > > > 
> > > > The current code is correct regarding ->data accesses and doesn't
> > > > require any changes.
> > > 
> > > OK I'll buy that but send +1 version:
> > > 
> > > ~/work/kernel.org/jarkko/linux-tpmdd next
> > > ❯ git am -3 20260406_thorsten_blum_keys_dns_drop_unused_upayload_data_nul_terminator.mbx
> > > Applying: keys, dns: drop unused upayload->data NUL terminator
> > > error: sha1 information is lacking or useless (net/dns_resolver/dns_key.c).
> > > error: could not build fake ancestor
> > > Patch failed at 0001 keys, dns: drop unused upayload->data NUL terminator
> > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort".
> > 
> > AFAICT, linux-tpmdd/next is missing this change:
> > 
> > https://lore.kernel.org/all/20260226214930.785423-3-thorsten.blum@linux.dev/
> 
> By pratical means, that is lacking any proper commit message.

My point was that it has been in linux-next since February, but it's
missing in linux-tpmdd/next, which is why patch 1/2 doesn't apply.

I'll send a new version with 'char data[] __aligned(8) ...' on a single
line in patch 2/2 after the merge window - please let me know if there's
anything else that should be changed.

Thanks,
Thorsten
