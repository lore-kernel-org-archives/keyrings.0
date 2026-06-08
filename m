Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C98003D;
	Mon,  8 Jun 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894804; cv=none; b=ZfEQ7fyFTkU1Zxk4NLP4pOHlFgP5FGBZogvz7jUAzfLd4897iBhtKbPG/YVplELAYiqwPmVQtRdWJRsQSGecUNMnmk41reWTSzWlNEL1JNF+f12zTHr25JlMFjuE6OjAHJgyckSsXxlWzLTs4tnhvW9LD5LI4BIk+hvXbjL0z7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894804; c=relaxed/simple;
	bh=dGQJQWxJx7+bbbZVGsRh/ZYrdSsV6uUAH5EsUWIUSwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYdkCQbsEZ1HcmIKaKEZj+yz/LQECCDs8gsjxkVLxL7YFL15nV7HNjYOPhWj7lMV89ndMBmgw/SAZodW/FLdixgdGunNledVcYxAJIXc9JhAeinfGSuSFAdd+Q+mpiK/wePK1kqYLJ5FAOhcU51/5DDcHutq2eogNV35dlqLzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf+S2aXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf+S2aXj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 077531F00893;
	Mon,  8 Jun 2026 05:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780894803;
	bh=fzICLcaz8VYvlhvEPA600sqYgK0ULN6277H/u8x9SuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bf+S2aXjSYAwzCF2uA5zPZGYVh++YOy/u+WpxA09LddBOkuzjMFMBZEvA6qeqjpTa
	 tjCREvPjkxbnedRYkOrm8bEwWEMdg3YBK1ZrmTkS8sBlrGcudVrT7TnRjgN70VguG1
	 E5eorflYi1ZxDymkWAWF0Jat3g0u5PfxLf6VD1YowyCiEnVGLzYqVldl1oJZDrFv8D
	 aK3Q7wxm3dycYbY/sgziyUKB+TTzRFX5SuZRNsX3v9fLfjkRUN/HJJMTXJfaIdR7rb
	 ISjBuqaIdhQdGULsvhH8bWAY56RdLrX59sh3NQCbdNx2kssw8v58nIhvSbR/uoDLo6
	 CPCB3tgKBsbMw==
Date: Mon, 8 Jun 2026 07:59:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: allow request-key path to be configured via Kconfig
Message-ID: <aiZMT5UYhVDlLVHq@kernel.org>
References: <20260607134928.2832202-1-gary@kernel.org>
 <aiZJ94eugtNHcILD@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiZJ94eugtNHcILD@kernel.org>

On Mon, Jun 08, 2026 at 07:50:03AM +0300, Jarkko Sakkinen wrote:
> On Sun, Jun 07, 2026 at 02:49:27PM +0100, Gary Guo wrote:
> > From: Gary Guo <gary@garyguo.net>
> > 
> > Some Linux distributions (e.g. NixOS) does not have /sbin present, and they
> > currently carry patches to replace /sbin/request-key to some other path.
> 
> Sorry but no configuration for introducing API divergence.

Not sure right now but one option might kernel command-line. Then it is
known at run-time, can be signed etc. Compiled value has no identity in
the same way.

And I don't care if NixOS has such a problem as I've not have any stake
making of those decisions.

You really should explain why it makes sense to have such feature i.e.,
why is it useful. And if NixOS considered, why is it useful for NixOS.

This all should be in  the commit message.

BR, Jarkko
