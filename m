Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581236;
	b=DYI52pDxHprN0pLFDxKtlO2J5EYwtlW1v9R9+vSHwoVsblLBXZX988GUBJZrwKo6i2TK
	 v6VSjeBIPhrgmEgb31ONkskMgvYNFJO/lKB268v9W8TEt5ZRpBPp97npwHphkfuRbIJox
	 Sm5wHlGQAGe6XJ3qBVTBet6aUiFEArkvyMxoaYwf0QmetjMyhlPB8IEuYKSTdk2+1prw+
	 9Im+p3QC4SDsHQyoovF3iv6PpP/YRpUL3EkKsBEUqxxHikcrCYkbiaJjZ1RwwnSlSyxeM
	 QsZ2UqgRJlljUflQWWNFQM6oE4ZtY6gm9qdldLK5rk7zVKBWMnKiKHFcZZ/O20pAEVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ArsSqsLjh+Rg9eIzAD28wSJrk/9VBuSn5KkM3umAEgM=;
	b=rprwy3VOpFEnFRODp1kYmjUk2y5wT9QW92tDhRgrrr2gxy31m/XcGNGusv1EhAcaorCy
	 KpmzB4wznu6QHvJ9l6CW5nhKP5n9K1AIR4wKUVBBylJLEOPJSoXbke0XZpsGOEMdZZWaR
	 6FG3KYKaDNpYUr8ZVnXPW8CRRBViSuY/JmqAKdcLfFtwG7LgNodQZY4NjybubJpOW4i7h
	 d/c1UcTzoP/snoBTfocuk6xdLNrEG6MkUKHiSKayM+9ZNrc2jUgxWT/mz7WOL2v+BYlgX
	 G0mOBwm3CmgFrFPlyPP9u1BOT/JsrS3KRFyGOb3iRBPZfWhKDK0BuhU/xCUfGjXSOaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1jpB+6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6E756606A32E;
	Fri, 13 Nov 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1jpB+6r
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 80C701F000C4;
	Fri, 13 Nov 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581236;
	bh=ArsSqsLjh+Rg9eIzAD28wSJrk/9VBuSn5KkM3umAEgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1jpB+6rH3enPLTEU7YUk1uWR2+8NZKzvswPr6dVtgLOQm8gWlbhLI91/PacXPjdB
	 vZo9Uzx7s2lOc1MNt6GKuE4FhEAVE+h4lsecDUFu+ofSO1K8tSeFvP5hMpGSjiyx42
	 OhbVuaX48awKjhvyQw0x1bMvb3xoWcjIBH/QOsO7GBPmMDey5OVV1ZG7GtNMQ6dvMJ
	 K+NLKHJduMKR3E4siRua/sMvqHqjKf1SpYIaMC4+g4IZXBb1ehdUbfjFvdMuGLDwSw
	 rcvf93tLNvSntPh/MKRRlzgxcoGopRMcC/68qbgZKlbwaBOUTb9F1sAExW9OC/xp4Y
	 fJxlVe1wIvE3w==
Date: Fri, 13 Nov 2026 16:47:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	dhowells@redhat.com, Florian Bauckholt <florian.bauckholt@cispa.de>
Subject: Re: [PATCH] KEYS: Fix signature input size for KEYCTL_PKEY_VERIFY
Message-ID: <avci8LBkAbfOUWIH@kernel.org>
References: <20261113140311.1375048-1-stefanb@linux.ibm.com>
 <avcaQGqHKnNFNFSG@kernel.org>
 <avcadBCRBGUXDapR@kernel.org>
 <5c9ba3d6-cf55-4a8d-914d-2c85f7b7f5cf@linux.ibm.com>
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
In-Reply-To: <5c9ba3d6-cf55-4a8d-914d-2c85f7b7f5cf@linux.ibm.com>

On Fri, Nov 13, 2026 at 09:45:05AM -0500, Stefan Berger wrote:
> 
> 
> On 11/13/26 9:11 AM, Jarkko Sakkinen wrote:
> > On Fri, Nov 13, 2026 at 04:10:12PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Nov 13, 2026 at 09:03:11AM -0500, Stefan Berger wrote:
> > > > Revert the changes made for signature verification in cb481e59ea6c back
> > > > to the old behavior where effectively the params->in2_len was set to the
> > > > length of the user provided buffer uparams.in2_len (out_len is an alias
> > > > for in2_len due to the union). We cannot use the max_sig_size in the
> > > > case of signature verification since this is neither the true size of the
> > > > input buffer nor would it pass tests of size indicators found in the ASN.1
> > > > in the buffer comparing against the input buffer size.
> > > > 
> > > > Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Cc: Florian Bauckholt <florian.bauckholt@cispa.de>
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > ---
> > > >   security/keys/keyctl_pkey.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> > > > index 15b6bf6399b5..794fa3d01911 100644
> > > > --- a/security/keys/keyctl_pkey.c
> > > > +++ b/security/keys/keyctl_pkey.c
> > > > @@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
> > > >   		    uparams.in2_len > info.max_sig_size)
> > > >   			return -EINVAL;
> > > > -		params->out_len = info.max_sig_size;
> > > > +		params->in2_len = uparams.in2_len;
> > > >   		break;
> > > >   	default:
> > > >   		return -EOPNOTSUPP;
> > > > -- 
> > > > 2.56.0
> > > > 
> > > 
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Did we have reported-by and closes tags for this?
> 
> Let me add this here for v2:
> 
> Link: https://lore.kernel.org/linux-crypto/473700a3-f5d7-4a7a-b89a-12c51adcc3df@cispa.de/T/#t
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> 
> Once Florian added his Tested-by: to v1 should I then add this?
> 
> Cc: stable@vger.kernel.org

Nah, I don't care about Sashiko tags, no need to add em.

Go ahead and add Florian's tested-by.

Br, Jarkko
