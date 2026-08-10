Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCF2E738C;
	Mon, 10 Aug 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375871; cv=none; b=p1V+CNwtMnEbb5IySMqxIceVyUZv+4XvTm46AHpIlYTyReCPDm8NZjdZPscvWPsnIXx2dET0VA/PfnPZzV1HSeWakSXJxtMMF6cfE4DFdWCxlY754zOWyX+qmbiIXKX6s0SgFw8C/qsbOqTx4sp12YLZbtd2Bni0HaOpJjugyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375871; c=relaxed/simple;
	bh=kPV+sHff4PPrzBSe3o536KLHHI4Bnu7XwjBLAPMrpQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNH90eAkU27oKkYaLQZCVA3j0TERtoaT9HvRW+MkzkRRk6U1WRT3wFAqM/ecqTNESFTuzcnVprdYeibwjVSnVhUYK+qOJivF31hpeYrffbWVCPzU/ZaF1EIfVskeG3637RxCA/CUWzUG7gyS9SqycDimfFTO8poFZOdHQ5cZiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCwFFAEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCwFFAEe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 94C821F000E9;
	Mon, 10 Aug 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786375870;
	bh=ZgoC3EVHJl6ia8wuwHBh/UBVnOr2ch9hVINB/bxGV/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCwFFAEe1Sf0qajqt32ItNxUt9zLYHwaT1IcEnbSahBhN3nnERgPwaXvMP2QJCFMe
	 KQthG99ng2h3wLISdbzBBnE63ZRoecRSzYDITyeqXKdas3hAgjfs7+8wOXl1MyBxZE
	 R2f2d1JyTmu+tfyEhWytkipRiRCSGxyXqW+k883Ng9huX9i+mJqHUktkIM4iFxuiH0
	 Pq1/M2PcpIzjCy4ieeIhlG82xjElda7RKVQeD5gfgBAAbW1EcEHTvVWZZPvf7b82FD
	 lqvSzMWwI//qHCB13jg6xeEVStnFNEKvpYbhLTx6iiPtmb6g/W3WPQZaddeXKbK2wN
	 TlUP6SR1Ydacg==
Date: Mon, 10 Aug 2026 18:31:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 4/4] security/keys: zeroize key payloads before kdump
Message-ID: <annuus46w5SXmlsA@kernel.org>
References: <20260731154608.153258-5-linux@jaseg.de>
 <20260731154608.153258-1-linux@jaseg.de>
 <2259835.1785538211@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2259835.1785538211@warthog.procyon.org.uk>

On Fri, Jul 31, 2026 at 11:50:11PM +0100, David Howells wrote:
> I've no particular objection to this, though I'd prefer the name 'wipe' to
> 'zeroize'.

LOL, I responded exactly same before reading your response :-)

So yeah, +1 to this.

> 
> You should also wipe fscrypt, tls, rxrpc*, ceph and cifs spnego type keys and
> maybe asymmetric type keys.
> 
> David
> 


BR< Jarkko
