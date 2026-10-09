Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5A4EE855;
	Fri,  9 Oct 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563178; cv=none; b=hS6HQoeaay83RJOyS5kPKFIjRPD4WHzKjF3eR1XOAVdYxLDagKOsmGL/6KNvDUq7OkAK36IRpjhxlhZMPtzdqcyovQB7FzPQ7d1/TmqSon2NdQWgyXq04NaAdtpkvADoSyTSrV2/wB7T2oMh8pC577qDrhbAzpaK7j/PdWjQKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563178; c=relaxed/simple;
	bh=ELlZU9yhMKc098kyO9J5uWm0TyAi/xkw+L7t7KrYmiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxM4N7H3vd1eWDm+5l4Zuj7qK8GlLcBP/NNCHJ9x4H3BgV9fYk3tgql3fAJy0FO04Wnq9KCe1OcEEx8dmA22ReKtQp3BKKFEWSlw7RTYB5X5Eg2yl/yZcpAjGyZG/LsAmU+nAglK8P6rImvB7wPkERepNbhnsKf93iN6FnAZSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZVo0dbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZVo0dbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B14A1F000FF;
	Fri,  9 Oct 2026 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791563176;
	bh=78F8N/xB1iVAPP5FIl6Zyl3+ctGuXp1Fs51JCP34W/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZVo0dbNtXOkw5TBLtrrbHA4e75HW+Y9fx5h4wD+0Z+HzSA4vdr8egVcy5rRv2FyZ
	 imoeSPgrFOhnA0sJSBhAjqhRqUqaqTwM6BJuWQ24X2O0bNdAZihjohUGw8wsTzRao3
	 BAKf/HTfOwROLmjlUacCssibwe4+V9L2X1dZn7Sa8OLVPjiI3zKBqCcoVybIGFGJME
	 rcyenL8YmF4qivRJ+aBubOWWedlaAaNP6wbjPNMPj3TWa5O7G60lhl21TxE+vS/RWt
	 EGMkQAvu2I3Oby47zOfPyOGrLDCOi2hLATPn05X7T1lrxXN/R9l9Die57xp7J+h8J/
	 r98czOrDZEF0w==
Date: Fri, 9 Oct 2026 18:26:08 +0200
From: Eric Biggers <ebiggers@kernel.org>
To: Massimiliano Marretta <massimiliano.marretta@egicon.com>
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, keyrings@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add bulk signing support for PKCS#11 keys
Message-ID: <20261009162442.GF321175@quark>
References: <20261009101915.495734-1-massimiliano.marretta@egicon.com>
 <20261009135228.GA321175@quark>
 <hhgoxv37uegtx3memo7spxlesoywbsnavzoezdg7rdrfwog3ml@tx73cw2yhu6n>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhgoxv37uegtx3memo7spxlesoywbsnavzoezdg7rdrfwog3ml@tx73cw2yhu6n>

On Fri, Oct 09, 2026 at 06:13:22PM +0200, Massimiliano Marretta wrote:
> Yes, I have been following that series. It is a useful approach for
> its stated goal, and I am not arguing against it.
> 
> However, in our case it is not applicable. Our product depends on
> Wi-Fi modules from Ezurio that are built out-of-tree against the
> Engicam/NXP kernel. In this case the module hash is not known at
> vmlinux link time, so a Merkle tree computed during the kernel build
> cannot cover them.

But do you actually deploy a kernel (maybe with some in-tree modules),
and then deploy the out-of-tree modules later at some totally separate
time?

Or do you actually just collect both in-tree and out-of-tree artifacts
into a build and deploy that, and the fact that the in-tree build
doesn't have visibility into out-of-tree modules built separately is
just a limitation of the build system?  If so, asymmetric signatures
seem like a really unnecessarily complicated workaround for that.

- Eric
