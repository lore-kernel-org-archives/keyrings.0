Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E472618;
	Sat, 18 Jul 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784413097; cv=none; b=Y2sxVex9uLdRMp1Ng60INxHBnCBqhh4FDuhFjBI740ZdvxcMQGTF1JNPW+c9MrFS1eWrTBtUL2JU4AEj9vqxeT8Z1iakoGWquptHtuVkHY6cyhXiP06fNWT8iU5xVx7W5VhgJU9LVkTKr+gYL+ipTpGRfctQrpdi4RZCLSw7bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784413097; c=relaxed/simple;
	bh=bTfcZ3vWD3k+UHaLxUsbma7kosQyDI8cE3L0cbDm6gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kArkylJdkIPp3XmlO9wIf3baGJZHBfuihtq1X3UajA4stytNVVaaYJi5/wdV2PWsBjDGknr4lYobuUmfl8Mg7SlCelJ1jXAAFWLVzNtWgMdiBwvAqlZmDdrPZ5IR6p3L5Sm7auOK+p9vgMUB3CsgoaO4xi3V/pd+W9YoTsyQw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmXr09Gz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmXr09Gz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B6DB01F000E9;
	Sat, 18 Jul 2026 22:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784413095;
	bh=OU/IeWkN4lxuIrlp0kUd+i1u80B2fvUENT6N8oZQwA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmXr09GzAsyKjY2oM5OH+GdS2iQQ/dPe0Uusy4r+7QTL1NU9VRq9Da6xZMsK2Gqn3
	 rPwhA+qo+3fCH2z8tZlyfREf4k+mDgC51l/c5SlyuAOwONXeRV25lkw5tW+uO6O1VV
	 xI8S3zLlM3PufUpezkOu4zP+LnDz5D3NXdnBMSLZs1f4BCTq1dn9HGwj4NbpWWovYo
	 jKWBFZHFOqRZxjDAoaUhO6zSaoCNY0XZ9WiIDxOtIEqz3yOK7t+4uUkKD/2Ya5wjYj
	 Baf2+o63gv/5VJ1y3oGDIA7ix076y9Xq97L619fw8aAnRxBzuEroZAMbWU/3WOTWrX
	 IljGgCAskDi1g==
Date: Sun, 19 Jul 2026 01:18:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] assoc_array: trim the final shortcut word using
 the current chunk end
Message-ID: <alv7o1VRGhJLxTtj@kernel.org>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-4-michael.bommarito@gmail.com>
 <alvIBm3Po_1gX6g_@kernel.org>
 <alvKED66fSFFcl1Z@kernel.org>
 <CAJJ9bXyHopjhwusu=yK5HzrF31N5QX0uU-WTRN0g=aSMc9HJmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXyHopjhwusu=yK5HzrF31N5QX0uU-WTRN0g=aSMc9HJmw@mail.gmail.com>

On Sat, Jul 18, 2026 at 04:35:17PM -0400, Michael Bommarito wrote:
> On Sat, Jul 18, 2026 at 2:46 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > Were you able to reproduce this with basic command-line tools? The
> > patches are verifiable by reading the code but asking this just in
> > case if you had a snippet at hand (not interested on complex
> > reproducers).
> 
> No, it's a little tricky to hit, definitely not just a few keyctl
> commands.  I can send offlist if you'd like but it requires at least
> ~50 or so lines of C/python

Hey, please do, I'm happy to at least try to test this.

> 
> PS - I'll send v3 with the nit fixed and carry your tags today/tomorrow
> 
> Thanks,
> Mike

BR, Jarkko
