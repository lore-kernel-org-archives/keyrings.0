Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512096;
	b=me20RYofKZDE5ElFkvEKYVbV5hHs5QzAwGabyNq5wn855zwtBoKX5x7nch/xc7fCHe71
	 WyRy4pscHMdtKyotr2HydnECCvm3p0nA6U3UdUNyu45igAf3fBiXsfqvSrpiaj3EnYM4O
	 icyNE0nJPn1EiFAuXWndx1wf0YixIJFsnS/gJGXRr7Trb9W5ptevwobPLoiz5oU95THOB
	 HwFa2swzxOTeFIkhFo+vs6v481/+tOZX1rth/PJhVJrem8/hVo0eaAv/ljLnJVjl/1wEY
	 MwdXfQ8ogu48sX9t5qDHnPfAO/6HbK4ZFgHO10bytpSxXxPBtCXTCzoCE5lo3MUlm6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512096;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zJsi/WC3zPmgvcD35Det+4bgrU4fyX7tqm3dNPyLicw=;
	b=adeugPt9/TwTn367Hx7nyAZx0ouoznPFvEnSUNFgPVeXnTRXlSYGYzehY4G9DVMX8AN1
	 M1XFMs4TOTFU7Z4u9fxPicfEq9PQ/rw3u27wdBTtqGmaVYFM4PI6sC6eILIckDX4vUmOl
	 xd9Xt49qHZz5TICrHnyYe28PHIBaplspQBcFv6Ngfye0wgJqEVDyDuByfq1S4AZxfSi9i
	 gJ2UxDsioew6wYytfLfFKBo0jBXXYkxbXcXIcb+aEyPC7y7Yl+ERi7osQ7YDfH5JUU3cj
	 oPbRmG7idboAt7kdMl441aU4xbHZWOkJtiCy5NOvlnR74NlRbdF5oGJJxDLvHN7d5Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcvnihYl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6596F606A69C;
	Tue, 24 Nov 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcvnihYl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5E9471F000D1;
	Tue, 24 Nov 2026 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512095;
	bh=zJsi/WC3zPmgvcD35Det+4bgrU4fyX7tqm3dNPyLicw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jcvnihYl9sVDRh4+cYmUxPrINT/17wcAZxtL4afND7xVQfcNZDgNkoGy4nkoEiiXO
	 Qo8Vcdi2vXumcrR1a0ZSLOYUQdU/DtBIAb6tX/ihiBwfJlcKaF49tP6eMy1GyupZJf
	 1Q86N38vidpk5hcUuO2SEcRXub7KxNyr+LvwzBzmowdtM5k0DzwcGvchJXyn2xnMhT
	 /1+aG9zgoENDGULWU1ZHCX2Qk/vANIVJ8xFumGJgXVZmUp9BRSFOE+O/zZQfCQlSmL
	 lFYh5ld8LpAnET9bqpnQO0+Rpi9CDCRoUvATWrqaOh2EzRys54EZs50mZR7MeFR0rG
	 GTaVICBRBcu1w==
Date: Tue, 24 Nov 2026 11:21:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: zzz <abc0eichs@qq.com>, linux-kernel@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] lib/asn1_encoder: fix encoding of zero OID components
Message-ID: <awVXHD7YY8FWKzTa@kernel.org>
References: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
 <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
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
In-Reply-To: <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>

On Mon, Nov 23, 2026 at 10:03:11PM -0800, Andrew Morton wrote:
> > For example, 1.2.0 is encoded as 06 02 2a 80 instead of 06 02 2a 00.
> > Emit zero without the continuation bit, as required for the final
> > octet of a base-128 subidentifier.
> 
> Super-slim bug and it appears that nothing in the current tree uses
> this code path.  But a bug is a bug.

It's a good catch :-)

But yeah, we need a person, this is not anonymous/pseudonym project but
the change itself is apppreciated.

Br, Jarkko
