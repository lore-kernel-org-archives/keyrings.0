Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579064;
	b=SnyaqVzr5YZzLuWFjZMpUNChDLCQB1rz1SezO8ZnBzX5TPTY0MfZLEys0zU2C5Q7Ag7i
	 TAl7sPhetsx5GabHbWjCmNOkDN3ePvxc3CnEgnBGhtX6Jvg4TSlW1h9Og+EGXBVSYoXe1
	 D3GNRf9UhMdL1OfgyEoKvpkh4SdQXkCHY4oCpiw9iqJApouU0Sg1ZId/fQHK9OvAAoGun
	 lZtkzcayMSIAFKaa0xznV8Ve/Cd7MoeEoSdKLr2fdBdVsuFPqEBoGf00Xs9THRXRuOWvT
	 IJhDNvTttFDbUsZ/sVXfAGQ4OoBj6lPbliepe2KdtnILBikLC9PhkX176F/M8fXgDEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rXolkretRqhTPMPkIn+usIC0YShu0DXio/AcMkve2K4=;
	b=lhlWoX/gAh75ezPJXK8EfDxN5lVfOu4L5Ich9EiIwNEhy4AntAuZzqqWsh6neEO1CrGA
	 5CJ59HDjVweNK6U1HhBJonUyNyf7drsUxzGdAF8tGEXCn4WGP5g/TjVs5/dGTLf8FgHNc
	 JPuq3BYrXKmZYy/HvjIZGNFf0vrVjfaSRz/yT9nshitlbVUKAdfzfdX5IxniP+ccWISDB
	 NTNDOeERCgt4oVyzBPegJdqjQ+IxKy8Nc2jhstJGnn3JVfIvGxsqAJaUlX+16AaJmgZ0r
	 L4l4zH2W4jy6U5By0498FWPiTcqHzhVkNsfCXWJDizsvd+v2ELbva1dJ6pIXK46XEFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEV8Y46Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 12A7B606A884;
	Fri, 13 Nov 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEV8Y46Z
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1E36A1F000C6;
	Fri, 13 Nov 2026 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579063;
	bh=rXolkretRqhTPMPkIn+usIC0YShu0DXio/AcMkve2K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VEV8Y46Zw41xyyyGReDOwMrThrNzdGvifjdmDPn8l3wmJsQvJAqGwmcYxAqq6Mzrv
	 EjnkXBbA416tpdBke/iNP8ikviAYisDjSz+bZ5kPsN9HSSgPVsR+rAgYIKRUjDpshj
	 jx97fIwG3foMd1g4Pj+HVVQPU4uVimpUOqIkKRcI9tpJfZJAfzvGA82e66W8dtwSB8
	 m7YVe8urpymq2bZ9YaC8wIs2Vzad1OtEBPwszIij5GurW8aHsm1Zxwh86tTUAtjteO
	 BZOZVOMntUwoLObKvx3TLLaI6RphMaBDQmmv68eGRXe2KW1ay14EBDS/HUhSsbl/s6
	 5cm7how4ffCzg==
Date: Fri, 13 Nov 2026 16:11:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	dhowells@redhat.com, Florian Bauckholt <florian.bauckholt@cispa.de>
Subject: Re: [PATCH] KEYS: Fix signature input size for KEYCTL_PKEY_VERIFY
Message-ID: <avcadBCRBGUXDapR@kernel.org>
References: <20261113140311.1375048-1-stefanb@linux.ibm.com>
 <avcaQGqHKnNFNFSG@kernel.org>
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
In-Reply-To: <avcaQGqHKnNFNFSG@kernel.org>

On Fri, Nov 13, 2026 at 04:10:12PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 13, 2026 at 09:03:11AM -0500, Stefan Berger wrote:
> > Revert the changes made for signature verification in cb481e59ea6c back
> > to the old behavior where effectively the params->in2_len was set to the
> > length of the user provided buffer uparams.in2_len (out_len is an alias
> > for in2_len due to the union). We cannot use the max_sig_size in the
> > case of signature verification since this is neither the true size of the
> > input buffer nor would it pass tests of size indicators found in the ASN.1
> > in the buffer comparing against the input buffer size.
> > 
> > Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Florian Bauckholt <florian.bauckholt@cispa.de>
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  security/keys/keyctl_pkey.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> > index 15b6bf6399b5..794fa3d01911 100644
> > --- a/security/keys/keyctl_pkey.c
> > +++ b/security/keys/keyctl_pkey.c
> > @@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
> >  		    uparams.in2_len > info.max_sig_size)
> >  			return -EINVAL;
> >  
> > -		params->out_len = info.max_sig_size;
> > +		params->in2_len = uparams.in2_len;
> >  		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> > -- 
> > 2.56.0
> > 
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Did we have reported-by and closes tags for this?

Br, Jarkko
