Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A26605BA;
	Fri, 20 Sep 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870611; cv=none; b=dC4/uEJBu3e5QhyvG9iTEuyZ4NWwTWGvRd/GAFL7TnktydsNAhgxI6CMndi3RmFgGcsK1kumZ4pLJkBJo5EldrdsOy6E2M/YwNHWwzcOAJ73mTADmG+ExQAnnN7JAm3KxvtScVteWzV/AhJ53ni9nuSbXIf1/2dxuZFSqvM/1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870611; c=relaxed/simple;
	bh=TzaIT5iXFdGr723fv6kTc8RsHivTNLi/fCWQEqat024=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UOKRdB3l2e5yM+rfC4P+V4WMwJjYmF+dvAoH8Jg9LnWn7Tnd7pcNx470ZQ/IS5I8GuG2F3afC5CTbFje0v+HEqDwMtThZJsW0uQCb/cD9oXMj2bxOcZ7Z8mp/uSUe+on9jIvKbrrNHvlb8lEMpIyRNj4DqKEqnKmOhA2bEhzV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ80pRyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ80pRyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEEEC4CEC3;
	Fri, 20 Sep 2024 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726870611;
	bh=TzaIT5iXFdGr723fv6kTc8RsHivTNLi/fCWQEqat024=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OQ80pRygHh5nT4XaT1EUSVY1MNtgkObb3uQhs8URtxqjGZgaIUM4967MGyulVroKw
	 M2wa3YdhYYW18beugL7z3NopHZa63icEWNhq05dN9yPcSV8wEaY3gynAfoVOVq0lXV
	 cyzEsPvUA7+EBnJWz/FtUgqgH+BuBdnr7qiz7U09+Rs0YwDjyw51gmO6fZXidSvx4O
	 7uVfkpRp94zwAVL0NcZKHfUliCwtSos2z8nlnfvhGedCJCDHrsex44wFlwneDai7aA
	 lMg33TmKakjHlJp0U+ywynsKYO7W3awvno3PGsp7dfDZLj1Djkio27gZI2Izfl5WzQ
	 gOPdtW/BbfrZg==
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Sep 2024 01:16:46 +0300
Message-Id: <D4BGJGUL3HSW.19HZANGB06JSW@kernel.org>
Cc: "Neal Gompa" <neal@gompa.dev>, "David Howells" <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <zxu@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Asahi Linux" <asahi@lists.linux.dev>,
 "Hector Martin" <marcan@marcan.st>, "Janne Grunau" <j@jannau.net>
Subject: Re: [PATCH 0/3] sign-file,extract-cert: switch to PROVIDER API for
 OpenSSL >= 3.0
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Stancek" <jstancek@redhat.com>, "Jarkko Sakkinen"
 <jarkko.sakkinen@iki.fi>
X-Mailer: aerc 0.18.2
References: <cover.1720728319.git.jstancek@redhat.com>
 <27899413.1r3eYUQgxm@skuld-framework>
 <CAEg-Je_MXyP_PNj_QOu66SW_XYHy0zv0PnTTxX2qWELRG+xM_w@mail.gmail.com>
 <D4B7ZCR4XWCT.3TWNN24TA8PSF@iki.fi>
 <CAASaF6zhiDdbfYkgg7wENih2Lp309eUgeu=FHZm0yYaEBt2gRg@mail.gmail.com>
In-Reply-To: <CAASaF6zhiDdbfYkgg7wENih2Lp309eUgeu=FHZm0yYaEBt2gRg@mail.gmail.com>

On Fri Sep 20, 2024 at 11:05 PM EEST, Jan Stancek wrote:
> This looks like false-positive. Following will produce same error:
> +#if TEST
> +       ENGINE *e;
> +#endif
> +
> $ git diff > 1.patch; ./scripts/checkpatch.pl 1.patch
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #10: FILE: scripts/sign-file.c:217:
> +       ENGINE *e;
>                ^
>
> total: 1 errors, 0 warnings, 10 lines checked
>
> but if first type in #if block is something checkpatch recognizes,
> then it reports no issues:
> +#if TEST
> +       int i;
> +       ENGINE *e;
> +#endif
> +
>
> $ git diff > 1.patch; ./scripts/checkpatch.pl 1.patch
> total: 0 errors, 0 warnings, 11 lines checked

I fixed a couple of alignment issues reported by "checkpatch.pl
--strict" and sent a pull request:

https://lore.kernel.org/keyrings/D4B9WXZC9B9U.34I6BHWMYXOS2@kernel.org/T/#u

> Regards,
> Jan

BR, Jarkko
