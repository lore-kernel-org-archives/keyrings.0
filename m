Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955465;
	b=m0XLD/mgL/dy6CrGHK2lxH5Ym5/jMMbzzl+XKyV6d9prxNNCi67D1pOHTMTWwGiOTxAz
	 Q7MvMEOkZkpoEsnwK9Q4YpWUsF1omfg61l+ygVp0ijGet/SJ6S6VVjcPwaQIB8WRJkJjw
	 STvs59QMu8KW8UFWhdAjCtxs0xKfKKwuV4v5WniVduvwPEdCeVlFEoibWxDXl0/5ZdXfT
	 H9cmHd6c3Dz9YmSSu+WAFVhBZSU8xXrzLQPbRfAGxxUljv4hdG7bo92tBUYtbfri/zNqX
	 +RNQkmI4ZS7l5mMmdC/GpWmOKG+50EwbhbO3L3sb9Q6QZYGzVg3H6oKPw9pmmlQQERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955465;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MyFJieF3r5eDFjYYTkQgbnCX4mRrQ5XxDjaoExpEcCs=;
	b=PAMsLeHLYsiLdJg7RnAT21miT2eimzJoMw8MhN5AEEBwRcAcDwZ2CTCT/VnegVlhVPR9
	 BxLFE1GNYa4lq/obPm1VedLURVqwxH/3GoLcX0FgADCt2kGlhpMrf8DvkjsQk0TzenrNW
	 k/QutzDLANFNpj51PCu5SuSQROxYinMQsDOyPncnkks8HG7x1GmqCeon97o8NRSNksrFE
	 /2nX5kyL9cMBfheMF+pQahi8N/jy5RHSb55PBZnBusmlp2cu4eX98rqdgza01uiNkWzx6
	 807nmSovzR415uTKFANNZYSFg0dmpbUlnOgBGY53Qsv3e0XSwomfmV9WqHC25h8ujdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=GByO10jn;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D5606A31C;
	Tue, 17 Nov 2026 22:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=GByO10jn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794955462; x=1795214662;
	bh=MyFJieF3r5eDFjYYTkQgbnCX4mRrQ5XxDjaoExpEcCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GByO10jnaDgJi2csMx2yUkLB0bp6ka8l/BmU9Pax7uAg8aMJ0JPes+3dL1Mhr5dY5
	 gxtJhwAs+X06bLDlHs+dGUFVUtRNp64QEzOSdFyuMOUWUd/2U43WsfXw5mGbBfkQne
	 I5wjwE+AfOcZTgx8GZeAp1cly8zJk5+TfQsaS4sDaALKFpluWvBJ3oS4tvj59ZfU+Q
	 IurMrpT5KBWPH4mPsUDBmb52qosaLjN/creuLL+Et/KK39DP1UiVABoRF192d9cfaX
	 ll04YzFZQZifPCDzaLoTr7yyrFamacgJUwPMPjDNp+EDJeyuJjI/2nu1CKTjTCL7td
	 wCquaqpu2wPCA==
Date: Tue, 17 Nov 2026 22:44:17 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
From: William Chuang <founder@logarcheon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lib/asn1_decoder: add KUnit test suite
Message-ID: <20261117224411.7043-1-founder@logarcheon.com>
In-Reply-To: <avvI1PuQUtBlfZWP@kernel.org>
References: <20261117001711.47722-1-founder@logarcheon.com> <avuumVbCS2YQi4cv@kernel.org> <wzMUBnLl6Z2s-eoaXFHCl92wV6voRbr7imPSy9hdJzHqoxg3869_lCqHtMa3G5N3H0G9XfrGCW9Nzw0Vm0HCJhvNKkTUtUFDXuM7S821AIU=@logarcheon.com> <avvFgRqiYnBo9Q7c@kernel.org> <avvI1PuQUtBlfZWP@kernel.org>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 330b178547f6828f252dfb2afb09629a35cfddbd
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 05:24:04AM +0200, Jarkko Sakkinen wrote:
> Within past 17 years the total number of commits is 22. This includes
> all the possible. Of these total six carry a Fixes tag.
>
> That makes about 0.35 bug fixes annually. How do you explain this

That is a fair measure.  With a change to the decoder every nine
months or so, a regression suite has little to catch, and its upkeep
would fall on you and the other maintainers.  I'm withdrawing this
RFC.

> Your previous kunit supports this point of view given that it is
> a possible "LLM remix" of a patch (kunit for assoc_array) that I
> sent a month ago but we discarded the idea in favor of a better
> solution.

I had not seen your October patch when I sent mine.  I should have
searched lore first, and I will before sending anything further.

> Stop doing this.

Understood: no more test-only patches for this code from me.  Sorry
as well for the badly formatted reply earlier.

Thanks,
William

