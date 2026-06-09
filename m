Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2743C042;
	Tue,  9 Jun 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019389; cv=none; b=ad+KU9H4ugxnoFsp3L20Tb8s4mgI0cPfI21VH70gLpsAWOdUbHUAUxgSDtn78qPyC0c9VMXG6BFgTc2XlrRQYxFmALVEuiL68EPQsHLQBdCgWc26eGcxlOcykyabt0F9JWT+DhKLjtVrNVs1hQmimstScL1y5HQALYcohdXgBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019389; c=relaxed/simple;
	bh=sJLT7ust3eK4AjVBgfXuvxIp6XDZDoZw45IAwW/NcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCgaCoRWglqZ2CYYQIv2+Z3EqzaIqrxziA2bXXWRQC5dKSz/A+WymHWvu818b3Pv9A782L8l3W0RC6f5G5JaKmrLN2DF3o1FhfoagPw84/TCYFLGnSGhdUt40T81JQrgC80uaDp71WIAvsTdepbHqJMOyFwj8gGLq9nMHTiaEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dME7mYGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dME7mYGq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 13F1E1F00898;
	Tue,  9 Jun 2026 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019388;
	bh=Nq8WKrHgXt/YJ0v8QZq81z24VZXvt5LJCSs6FdxTvo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dME7mYGqdLjLB1wWxGFX6iHI2AmC9SaMB6lgiX2D9DebYTrcg3hTkM08ysAht/f0z
	 MaA7NZ4FYYlASU/E9QDcHTfKA7k50QvnYqY/bfA3MclPfwsBwwGHY2w6YXy3d9Enp2
	 jk+F6fMW0aTzsBiJVydSbepDr5G5bNfLlUoEcsRa8XXEIoeT11xNfzAm0KBhZ32itX
	 cfgTKnOYqE3a9KZgf1CPLRRs/b8A++rnh/1FRzIx/pg0XEILbaegrOLKFt24bCd0jL
	 eMFkPg8R061t1n1e0iAAfPAJArdwKveVNpXz5u4X1dQvWUK0hRivNMKz8aGpiRtRKW
	 xVxPxmBrrK4sw==
Date: Tue, 9 Jun 2026 18:36:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
Message-ID: <aigy-NpXyLrESpv-@kernel.org>
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org>
 <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
 <aigoZeoqygyBYCbR@kernel.org>
 <CAAMeuQTue5bkbhjYLjsRCnB9=KBifsPNQ=ZRVp+wCh2TiXE7Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMeuQTue5bkbhjYLjsRCnB9=KBifsPNQ=ZRVp+wCh2TiXE7Uw@mail.gmail.com>

On Tue, Jun 09, 2026 at 04:15:18PM +0100, Mohammed EL Kadiri wrote:
> Hi Jarkko, Vlastimil,
> 
> I will send a v2 this evening with the commit message reworked. I will
> remove CVE references and frame it as hardening rather than an active
> vulnerability. I'll also drop the inaccurate skbuff_head_cache
> comparison that Vlastimil flagged.
> 
> No need to strip it yourself, I'll have it out today.

Take your time :-) And thanks Vlastimil for the remark!

If I get the patch within this week, all is fine.

> 
> Thanks,
> Mohammed

BR, Jarkko
