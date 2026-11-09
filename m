Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254938;
	b=FLEgcuUuL9eAnQAjO4fOh7OtiinCTmhu38frC8cFStcZu9uEV3/Ci+tkZKiTWwgjeyAI
	 +WHQ40hLZYNCKQaf53QIZefmaD8arPTkBeEnYoLfapQ5tv8vKvP+IQuZzXCTIaSn7ceKW
	 QKWzAFixxrOpIQ4JgOFH9XeGxs5sTD/F9am0J/9l3tNQ/DOuyNvgvsP9s8oRkdKESRBdy
	 3KPfAiM66biboTnYZ/GfZ2eQ5ip97RWVs6lbCXqcdSx30np0ISMPoX8UHFRHACZiR8d+Q
	 Qwul+4K+FoWq9OMNvQzLNsAN5lnQO5N0+7YTLiDR68+MxxPZEyIUcbvGuMTHzBIiVfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254938;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YlcWrV3Np5BhV2TElnjjFDMRSjXy/5M7/zq2pOvPoRA=;
	b=xDB2RVIPOCjKdhatxo+TJR9OW+rGqjbOGeb3qxw+gT0XWoZHAOa+2WzcTtuhXig56jBU
	 MVMd5brsxPa0zVbdUdMOw/ovobe1gpUiy7/pMeZHXbLP3tiJZe6NfpASDN121cDOreOnc
	 UMFEG3z/bAsLJT4eqMAi1s2GZdm612slduNhFbA+mpgrhefoZz1T1VFSn9AthuDO1S7cL
	 BkLzYy/D96FL7ufxEac1okTdy62bTBfw+iV5pos8GPs6uzf1zFg5kE+xJZd1U9wuGtIb9
	 Q/0CfNKqJkLnJNwV5iUUheJVnrOju+FPWLUVZae9qZGxUcQvMKTnmj4m+5/IqAkY0nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8wClTWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 000E4606A31C;
	Mon,  9 Nov 2026 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8wClTWk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 24D0C1F008A1;
	Mon,  9 Nov 2026 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254937;
	bh=YlcWrV3Np5BhV2TElnjjFDMRSjXy/5M7/zq2pOvPoRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c8wClTWke1j1GyXzDWdfFYtr+1aNnpjiOF74UOCA5+ekBUB3XeOS+z2ZjNC1hrvTH
	 lLKMdEe2egOHio+9mXubnerjbg19xAv4FFKuj3OKoxKEU8n2s+FyNRo8sDnHkYqhJz
	 32OAZNElrvXZD4KPQbjvm4Hg8z3TP97syNVKpbmzVecoLxY8zek0riBp45KoUThjCp
	 PqDdHOP61UN7LOcASSgG6ibAnKo/tV/NmbV9N1twNf0aiItACUt9Tuhl62N6l7gqCT
	 rzd2BUjV7CwsGymz7alfSjyEU1YN9FwPlMHoUebYXSZNt16BRNPc75RTkTvUYKo0it
	 VBKq6wyt6vqLg==
Date: Mon, 9 Nov 2026 22:08:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dan Carpenter <dan@cryspen.com>
Cc: Dan Carpenter <error27@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avIoVVFxZ8PTniEz@kernel.org>
References: <avFcjHwnh9mrOEnz@stanley.mountain>
 <avHelQ1nxsDVcQkZ@kernel.org>
 <avIjqp3n29DKkpPp@stanley.mountain>
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
In-Reply-To: <avIjqp3n29DKkpPp@stanley.mountain>

On Mon, Nov 09, 2026 at 10:48:58PM +0300, Dan Carpenter wrote:
> On Mon, Nov 09, 2026 at 04:54:13PM +0200, Jarkko Sakkinen wrote:
> > 
> > Are we migrating to C23? I've not followed this too closely.
> 
> Google AI says that we will adopt C23 next year or the year after.
> I argued that it would be would be after 2030 but AI said, "No, there
> is too much juicy stuff in C23 for kernel developers to wait so long."
> 
> I don't have a pressing need for this patch to be merged.  I was
> just playing with some compiler related tools noticed this.  It's
> the only place in the kernel which uses "bool" as a variable name.

I do think that bool is not great choice for a variable name; in fact
it is quite horrible choice. But since there is no other force than being
horrible name, I think I'll pass...


> 
> regards,
> dan carpenter
> 

Br, Jarkko
