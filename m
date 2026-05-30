Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86F31CA4E;
	Sat, 30 May 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159691; cv=none; b=FYkhYU5j8zQ5zpLr9XqjyhmNy/Y2vUJVCT/US9M2Y82uQ9+dZJUZGQjHJcVQ8/W8giWxlnYoNS6z5Y1IYxdCd5hK/NexpsDH0xpLVJLpMzRXeRwxlKKIUy8A7EO5SOVo+FhQQ0211n39O0wFCEd4Bz2vPLZA6tr8GUQzhBkaJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159691; c=relaxed/simple;
	bh=aQsuK9pWhdk60whanjNzLp/zIXmHsfnwytQ50BXo7Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx8uQCk7oJrjLO3WvZGTxXYOzTukCzSuuiROJwx8PUjSu+zUxHpjSo5vOMtR7Iw85HJdmcrucDCew3S+KOmMnOp7XiUE4qgyQFrEhzU1A6fS15OO/dc/qPydZNKpoROXNagxKV7Ifrw7UEvXtWHRv83dzfB7m9t1g9BEbY87jV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReIO++//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReIO++//"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 491231F00898;
	Sat, 30 May 2026 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780159689;
	bh=AniP0aLKdR6ZvxxLp1mEeLAcOlzpUl3mEOBcCgztE/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ReIO++//omSR3qCC1NKYIGC13cxZGBn62QQUhr80EoVUewjiEuw1TpNgpp0K6zmoE
	 4UY/Y/ao9qcIOeh7cTw2WlXzuXh0SF7P/flpx6Vq3+uDs7+Vp8y8sA/lKYhnJS3H0Q
	 bjz4E/1tK31EZ1UzHXVC8Q0SomgYoHb/D+wgb+65TpUgOvytP8lY3ZD62OsV12QBnH
	 gKmCGO+qbJOtX222W6sEfKTe76J30xp+YXSRTSHAbnF7XQKTHI8yqyehSpoOgntdiI
	 vnQIC7OzPwqn82bk2uNxiXF+UBKmvFvoLDTVj3OZgrk2N8yoyNODPdAS49IgoP1Nol
	 6VpReakOXfkHA==
Date: Sat, 30 May 2026 19:48:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: eee sss <eeesssooo020@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <ahsUxQryCvPggKBt@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <ahoY3mRUf5cF-tr3@kernel.org>
 <CA+TOyfhe=0Ty-FQDZy-9_LWJ6dgakzyjog5rNfQ2NdCc5X+dFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+TOyfhe=0Ty-FQDZy-9_LWJ6dgakzyjog5rNfQ2NdCc5X+dFQ@mail.gmail.com>

On Sat, May 30, 2026 at 09:19:33AM -0700, eee sss wrote:
> Hi Jarkko,
> 
> Yes, I have a reproducer available as a tar.gz file.
> 
> I am not attaching it directly here because I am not sure what the preferred
> way is to share a tar.gz reproducer in this mail context, especially with
> mailing lists on Cc. Please let me know whether you would prefer a direct
> attachment, a private upload location, encrypted transfer, or another channel.
> 
> BR,
> Shaomin

Drop it to me as private! I actually have now queue of total three
reproducers but I'll get to this sometime next week :-) Lots of stuff
apparently happening in sec.

BR, Jarkko
