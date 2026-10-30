Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390626;
	b=1dpPyws2rTGae7TWbCtRDv0R8fq+O1YE5i9VSru09QUc6KYqdU1ff2qZCILk3oid+rqa
	 eaK+CGKFTYx99w5vm6pejCYkkHKCnvyA4BvOPn9x1bMcEFY0egWlcz++3CBHMLR5OM5ru
	 gJnRr8zQ7gP68bgatYvIN8chOjvIZ81vt1hvrKmbwnH1i4VbfuVfN7HkKo4Vs2HndEbC9
	 mY22Jn8eYKDETfRaJtyKa5KJjIEmBCDMcuGk0F8NO0qB1bm3UZDjvv+g0q2rNjnEsfNf2
	 k1y+vX3uM24GcZsscZyVqI/YDk2SCYFa75Y66HQOVp3iDRioHabc0T35TWpDtFfhJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LMrpGWdovgMZm3Jh+xDymgzpR6x6xtVPMjUx+UZI4Fc=;
	b=g8/8Kn6sB4b0MjyR19iFQv63A4TzvfwV9tKBVbajXd4kHs+DtAU8qGYf+QxRRGI+3rdC
	 c0SZr8qCXSc1ggWBTMoe9Cgouz+xiUJgUMKlC24rzyATdWRYZ4KVuglrMpFJa2J0WxAsv
	 F2gPG2niG0Xu+vir72JNcSQxw2dreJ+OY42Z2kCTDTRaqmNr5UK1xcwaarvTgHIFcjI3K
	 Dptw5HHlK0ohTRfJ3Gx/aH6N6W+RoBcbCeJDxpWMNLyQYq22dJuyXX0Z+dBc7Efxl4las
	 ebugEqU0AXFZK6aqndqjK9fNJwle9avLuq6lrha17SL5O7RpZ6XAsM2UW6tAbkf0bJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1TKrk6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 58022606A31A;
	Fri, 30 Oct 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1TKrk6A
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6DB5C1F000C1;
	Fri, 30 Oct 2026 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793390626;
	bh=LMrpGWdovgMZm3Jh+xDymgzpR6x6xtVPMjUx+UZI4Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f1TKrk6Aby/BGX2H16b9sfxyMcoJQgwIZ2DVnXbv1K2wZCv27aNccT8u41H8gMORa
	 F8GU64l5tiid198wyLoIH78SlRdjy9ONQ/Q8X/OFNdjfUfOo/FCBm2aA0g31uCg6OZ
	 TIm0ff0lXKR513MM9Vi4myfqAFZThFLTniJoRVPHWI6gm4OuE9MLOwvJndQjeUGjxp
	 e328H9QD3LyQHyISQJVMTBRKJKgE6NsbPEqEcVnC4obxr1Sjwn/EmLUi/yibAG2XsN
	 MXLpgGICEszd00QqpxOJ/JAKoSgdBDapA6JAFISN03MCEIcXXVbSpeyEUYXubzk1Wi
	 BAhUiKcAWabBw==
Date: Fri, 30 Oct 2026 22:03:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v6] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auT4HmJImLQHmsTk@kernel.org>
References: <20261030160924.2919363-1-jarkko@kernel.org>
 <auTKovajh5MQlbre@kernel.org>
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
In-Reply-To: <auTKovajh5MQlbre@kernel.org>

On Fri, Oct 30, 2026 at 06:49:45PM +0200, Jarkko Sakkinen wrote:
> Interesting :-) It has been idential other than block size change
> for v4, v5 and v6 and updating benchmark result but this is the
> first version with Sashiko feedback.
> 
> Looking into it...

Couple of things:

1. Sashiko reported issue, which would result key_gc_schedule_links()
   call in the place of key_gc_schedule_work().
2. I think it would be best if flags were set in the expired case
   with a single atomic operation, which does not realize now when
   key_gc_schedule_links()->key_gc_schedule_work() call path is
   used.

I'll address the both issues.

Br, Jarkko
