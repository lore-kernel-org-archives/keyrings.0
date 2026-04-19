Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56C2628D;
	Sun, 19 Apr 2026 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600565; cv=none; b=NqskNnfgY/x/lnznk+odsnUg+9FV9K8zRW8wXkTK6aO9O+P/B3osfPhSONjOYeBdgzeiILEW/vEXotnbQfmRogL2dmyo6dKrQXfF/+xyI12qJLTJRIzdsTftxZfTENONI3f/bf+EmEDS5h2sWX1Oslrd+ylCwB50WtsjsPxU9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600565; c=relaxed/simple;
	bh=Kk9+2wR9sxun2MeisQa9a1zgASIJW5erzE9E0xEcG+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boWhx0JWOxQJsBFD6n7qJtrMbVDk7C6UY42kLsDabz++o5Shy3fPu5ypBv9SrVUf0gMtjAOvSmMYgvPsllrAS57EkEweOSDqp/KgrClugLQw9TIjTuUO/Vfm49WgxgUcglDq8adMqO5duVMyhNHjbKp9EZQbhrdn9kI5X86M24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZD6jKXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZD6jKXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26944C2BCAF;
	Sun, 19 Apr 2026 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600564;
	bh=Kk9+2wR9sxun2MeisQa9a1zgASIJW5erzE9E0xEcG+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZD6jKXsjv+ANnef+r7CeL1o8zs3gJSinOd3ymRSRdcAWDS2yO/WNOI3waZY9fRnJ
	 3TdbLlx7T9KKNIo8s2mIhEqr6CFq7lMvflmogK4rIJ/evpLb2Izo5Zm37ny7XZ0QKK
	 q08tC9HnQ7LUT6N5eimTkrZokWtMRC5QcNhgxfs0vdYyAhswCbGpz5vx1f4eQ9tD05
	 GUessHTn7dXX3ceA2TTqgI1fBPkIxTGOyotdHjg51Ik6kQER1jASyvi1lJFmd+yAOr
	 fxqXsQUUoPgJkNrz1O9ndovrNYpK/sHf0yBhmrrEo+r90lb73jP/nNC+2KB2RUw8zL
	 NAzu5HBPjNUvA==
Date: Sun, 19 Apr 2026 15:09:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <aeTF8FSjo1_4zrO8@kernel.org>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
 <adYZoWK_CTv2-RA_@kernel.org>
 <adZIP8w0IttbIZa2@linux.dev>
 <ad7UjdtT1vLwlu0_@kernel.org>
 <ad9dCoEsiwwgRK2L@linux.dev>
 <ad9_wQfq7fYEU7mS@kernel.org>
 <aeC2SNPslfdMV-Rh@linux.dev>
 <aeTFXg7-vpeyEr7V@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeTFXg7-vpeyEr7V@kernel.org>

On Sun, Apr 19, 2026 at 03:06:59PM +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 16, 2026 at 12:13:28PM +0200, Thorsten Blum wrote:
> > On Wed, Apr 15, 2026 at 03:08:33PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Apr 15, 2026 at 11:40:26AM +0200, Thorsten Blum wrote:
> > > > On Wed, Apr 15, 2026 at 02:58:05AM +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Apr 08, 2026 at 02:21:19PM +0200, Thorsten Blum wrote:
> > > > > > On Wed, Apr 08, 2026 at 12:02:25PM +0300, Jarkko Sakkinen wrote:
> > > > > > > On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> > > > > > > > Add the __counted_by() compiler attribute to the flexible array member
> > > > > > > > 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > > > > > > CONFIG_FORTIFY_SOURCE.
> > > > > > > > 
> > > > > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > > > > > ---
> > > > > > > >  include/keys/user-type.h | 3 ++-
> > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > > > > > > > index 386c31432789..2305991f4fcd 100644
> > > > > > > > --- a/include/keys/user-type.h
> > > > > > > > +++ b/include/keys/user-type.h
> > > > > > > > @@ -27,7 +27,8 @@
> > > > > > > >  struct user_key_payload {
> > > > > > > >  	struct rcu_head	rcu;		/* RCU destructor */
> > > > > > > >  	unsigned short	datalen;	/* length of this data */
> > > > > > > > -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> > > > > > > > +	char		data[]		/* actual data */
> > > > > > > > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> > > > > > > >  };
> > > > > > > >  
> > > > > > > >  extern struct key_type key_type_user;
> > > > > > > 
> > > > > > > You don't provide any evidence of any improvement.
> > > > > > 
> > > > > > It's a proactive hardening change to help avoid future mistakes.
> > > > > > 
> > > > > > The __counted_by() annotation makes the bounds visible to the compiler
> > > > > > and at runtime so that future ->data accesses can be checked against
> > > > > > ->datalen.
> > > > > > 
> > > > > > The current code is correct regarding ->data accesses and doesn't
> > > > > > require any changes.
> > > > > 
> > > > > OK I'll buy that but send +1 version:
> > > > > 
> > > > > ~/work/kernel.org/jarkko/linux-tpmdd next
> > > > > ❯ git am -3 20260406_thorsten_blum_keys_dns_drop_unused_upayload_data_nul_terminator.mbx
> > > > > Applying: keys, dns: drop unused upayload->data NUL terminator
> > > > > error: sha1 information is lacking or useless (net/dns_resolver/dns_key.c).
> > > > > error: could not build fake ancestor
> > > > > Patch failed at 0001 keys, dns: drop unused upayload->data NUL terminator
> > > > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > > > When you have resolved this problem, run "git am --continue".
> > > > > If you prefer to skip this patch, run "git am --skip" instead.
> > > > > To restore the original branch and stop patching, run "git am --abort".
> > > > 
> > > > AFAICT, linux-tpmdd/next is missing this change:
> > > > 
> > > > https://lore.kernel.org/all/20260226214930.785423-3-thorsten.blum@linux.dev/
> > > 
> > > By pratical means, that is lacking any proper commit message.
> > 
> > My point was that it has been in linux-next since February, but it's
> > missing in linux-tpmdd/next, which is why patch 1/2 doesn't apply.
> > 
> > I'll send a new version with 'char data[] __aligned(8) ...' on a single
> > line in patch 2/2 after the merge window - please let me know if there's
> > anything else that should be changed.
> 
> Whoever mirrors that in there has the ball on that patch. I can revisit
> this once it is either:
> 
> 1. In the mainline
> 2. Dropped and resent for review.

Or actually it should not be applied to mainline with my ack but anyway.
Sounds weird.


BR, Jarkko
