Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337038424D;
	Tue, 14 Apr 2026 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211089; cv=none; b=s9Ha/BOxnujKYIe9KQFdhcuq/SM7JUI2IU1PbpzTPAclMbRrAzprO7BP+iocJNYZuqyv2xeM908TjtI7c4xpaSGrxK1sE2nEgBEAuCrOI7zZTIlu05Qk/Vu+pBA9kVn+U/rINLFvBWFHSMAOsdi1Pu4cqDqjXv2QJ2c7xgss2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211089; c=relaxed/simple;
	bh=Ncf1TM3KGCc69Qo8ck7pIPJKQUTkRyFmU/ifvTZXZUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCvZgHqi5yqYo0qlI3O61UdchG08Ph0CQv4ge+s4JgGqAuC4qceEvAJGkfZ0wO+pd9c+IW5A2njZnZHy5CnXnruaGoTXNmfXOEHvtQPJIB+LSb33qfNFnrGsWgJ2/AemQ6RwrNg/nIdgdpfdS4IkHMkbnVood3ICI3rizOBnQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teW2CwnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teW2CwnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD438C19425;
	Tue, 14 Apr 2026 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211089;
	bh=Ncf1TM3KGCc69Qo8ck7pIPJKQUTkRyFmU/ifvTZXZUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teW2CwnQRyZwGMj8dvwPkxhtKLKEq1Z+PeDJS19fuE8Nqb+GxwIw9JtwTblNDOzw2
	 c0rK26r9Qfaz8aW3xu2ozXEmVrRRtt1yxFOhP6Myi804ymw02tybDOoYVmNKGzKKu2
	 53H1pgXqGeNgXlgMUtQoWhfMZMF1fFWGT2gMsERtqCSEz8ycpGW6tTWFnbAK8bVTVo
	 /wUMllVPO+FOzp9Ql7BTEhi8d05lk3dMeuYXcMiYelYu1MWPc+Zycrgf1kl65UjuiP
	 qqwDgwJ2N10MRPIQgDUczTPDX1TmGjjbNkfHlJobJBN8lzRgRf3Uwvh4pbRTcrp02M
	 5h450u+gUohCA==
Date: Wed, 15 Apr 2026 02:58:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <ad7UjdtT1vLwlu0_@kernel.org>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
 <adYZoWK_CTv2-RA_@kernel.org>
 <adZIP8w0IttbIZa2@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adZIP8w0IttbIZa2@linux.dev>

On Wed, Apr 08, 2026 at 02:21:19PM +0200, Thorsten Blum wrote:
> On Wed, Apr 08, 2026 at 12:02:25PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> > > Add the __counted_by() compiler attribute to the flexible array member
> > > 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > > CONFIG_FORTIFY_SOURCE.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  include/keys/user-type.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > > index 386c31432789..2305991f4fcd 100644
> > > --- a/include/keys/user-type.h
> > > +++ b/include/keys/user-type.h
> > > @@ -27,7 +27,8 @@
> > >  struct user_key_payload {
> > >  	struct rcu_head	rcu;		/* RCU destructor */
> > >  	unsigned short	datalen;	/* length of this data */
> > > -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> > > +	char		data[]		/* actual data */
> > > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> > >  };
> > >  
> > >  extern struct key_type key_type_user;
> > 
> > You don't provide any evidence of any improvement.
> 
> It's a proactive hardening change to help avoid future mistakes.
> 
> The __counted_by() annotation makes the bounds visible to the compiler
> and at runtime so that future ->data accesses can be checked against
> ->datalen.
> 
> The current code is correct regarding ->data accesses and doesn't
> require any changes.

OK I'll buy that but send +1 version:

~/work/kernel.org/jarkko/linux-tpmdd next
❯ git am -3 20260406_thorsten_blum_keys_dns_drop_unused_upayload_data_nul_terminator.mbx
Applying: keys, dns: drop unused upayload->data NUL terminator
error: sha1 information is lacking or useless (net/dns_resolver/dns_key.c).
error: could not build fake ancestor
Patch failed at 0001 keys, dns: drop unused upayload->data NUL terminator
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

BR, Jarkko
