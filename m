Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC82BEC4E;
	Tue,  1 Sep 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266175; cv=none; b=t7E6wJiBdS9V06r21P4Q5sW+YrC6r0Pzi8GWshtXxIajukSr0kfzGJQPwp5vwH8ilTtHZhLMdCMG+9wWBbimAcdOU3aPKmDVQ5tncexsKzai5R1+GzFMiGaEV8wSgUMZECzGnGFBaT6ZFqqgyWhIrqlnWsgIJhBHa5MaRjj4n3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266175; c=relaxed/simple;
	bh=ws4WuC0eMJKoCH4w9N8CkkTzygn9xizaUdXaHbUci/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE5sNUMISFn7djR5orkdkI/g+Yo+SmbHKlkT94h3n4fSU3/9sBvGDl41noKRcFFr2ZsKT5XVYYkmisnVncWp6nufDOKjYsOew0889INiQyrOZ5I0GgrDs5ETWt84lwqUTXpRYII+dUCrZGtzJowffq50Y8krxJFKMylXLYHICp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcWc29xI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcWc29xI"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A5131F000E9;
	Tue,  1 Sep 2026 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788266174;
	bh=LgrF8psaUFYSat21EIpQspdX9+Q3GRe0b0KcwoOH+cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EcWc29xIb43uoAddUgm4L04EOe9nMX+Imr4NmHW7DTZ5i54NdqVAtewl9bXilW7YF
	 uiIktiDBOoh62KU3nyHKVpAfwwrEiblBulkQOf1mNTJUcel14exfT/ytht/tZTrjsh
	 al/jTgtMwHhMGxjwjYaXz22Vp1BondxMs/gf6dtFEgwVd8knmn4HcuB0ekz21/LeLR
	 GiRCIRSzQd6AhKHfctUIr/ZM4CrQW40BWsC8SPK+fPihdWqezixDqc3NoPxqWARO/S
	 yBRHvHAIEkCF3n2A+keuby0D6uGfgCb1uE4PX5fDW5AB/vi6Kys6LaRytw7mBfzzW3
	 5fatjHi/3FfSQ==
Date: Tue, 1 Sep 2026 15:36:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sanket sharma <sanketsharmacsec@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	zohar@linux.ibm.com, dhowells@redhat.com,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal()
 before memcpy
Message-ID: <apbGunvwQspU9lvA@kernel.org>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <2026082651-portal-valid-da58@gregkh>
 <apDocVfEfwX3hFa_@kernel.org>
 <CAEb43b2C_eyR8ncUbJ+3MsT3ap-tB3_O0Mbaqgy1ncXwZAd_Yw@mail.gmail.com>
 <2026082845-shredding-equation-8991@gregkh>
 <CAEb43b0bc7rNvrpLmjF-9HPEfUcOdTKsUC68vzh+JfDf7E+OcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEb43b0bc7rNvrpLmjF-9HPEfUcOdTKsUC68vzh+JfDf7E+OcA@mail.gmail.com>

On Sun, Aug 30, 2026 at 02:11:22PM +0530, sanket sharma wrote:
> Hi Jarkko,
> 
> Just checking in both patches (v3) have been sent as per the previous
> discussion: Message-ID: 20260826170700.616-1-sanketsharmacsec@gmail.com
> 
> Please let me know if anything else is needed from my side.
> 
> Also, regarding CVE assignment Greg pointed me to the kernel CVE doc, which
> mentions CVEs are assigned for security fixes. Given that these patches address
> an HMAC bypass and an unchecked memcpy, would these qualify for CVE assignment
> once merged, or is that at the discretion of the CVE team?
> 
> Thanks,
> Sanket Sharma
> sanketsharmacsec@gmail.com

1. Please use plain text and avoid top-posting:
   https://docs.kernel.org/process/email-clients.html
2. I asked to not document assumed attack scenarios to the commit
   message. It is not useful information to log.

> 
> On Fri, Aug 28, 2026 at 1:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>     On Fri, Aug 28, 2026 at 01:00:11PM +0530, sanket sharma wrote:
>     > Hi Team,
>     >
>     > Thank you both for the review feedback all points have been addressed in
>     > the latest versions.
>     >
>     > One quick question: once the patches are merged, will a CVE be assigned
>     > automatically by the kernel CVE team, or do I need to separately request
>     > one via security@kernel.org?
> 
>     <formletter>
> 
>     Please see:
>             https://www.kernel.org/doc/html/latest/process/cve.html
>     for how kernel CVEs are assigned.
> 
>     </formletter>
> 

BR, Jarkko
