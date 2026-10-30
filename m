Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393078;
	b=nQ3r/ELp5pCkjzMQeU0orEE8p3zwtrfm7NHQtXGJER+nT+Prxrt0A+CoRq08N71I4mMm
	 bCfLiRVUyvbtibfmswlmJEfulVKIjiLWERp8RR8XI2jmysSbZ16Oie/OGVHwBv0DmjrPl
	 Uym3a5Jk2C2U750CQACz6Sddr/bA+NTeGfusjw70L9F3JQiVDvolPIS/6Qd+ahe3G7qLk
	 6ZsdpkDUaMIfSkYToiZWCol/XKW1stRVpFscmamC1Lw9a7AX2p5/In7U2prk2l0p1kBE/
	 w8yLWi5GXKCfnnOoRt0d7+vYD9nFJOZovsKC92hInoiS0C5p6yZJXej1AHaAQ4V81vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z9ZE8eS15MJ+ylRJDKgrZQLjWpeIoPGwSPhCJilrp9M=;
	b=LXaBEMuObrqac86JBxBrjhaif2wYjd6vrjepQS5nDlMOuqpXfQtoYsjDjZ5gqgDMyfMJ
	 nxsUOjIIZp3ZeMpvM+3Ym43HM4oGJ78t9HlQIwTUeQ5mhqES3c9HbGsqVjkONnKoqvrW/
	 qE2q4S3Ytn2MA68gCRHRKMp+tBek60ejeCOlV6ViU8AyZuJtAVDbxj8/A/Dqk0+tD7b1u
	 RNGAtTqJJwRLEMyzXG81izxryijc+U7UCm3kKqBTcFl3Arvz26VjJvtdbJs953GbiUHDS
	 kqxReQBrUVifyz67Q/dS9n2k5J7f5dWj6oQHnjDs7I7XPsEefLA7mtJuF5ofhNwxRxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X9DK/OOS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6F493606A31E;
	Fri, 30 Oct 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9DK/OOS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 684A21F0093A;
	Fri, 30 Oct 2026 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393078;
	bh=z9ZE8eS15MJ+ylRJDKgrZQLjWpeIoPGwSPhCJilrp9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X9DK/OOSKVii770knUw9QrBOG33ULQa9nh66lPfm5M/eQNb75wx0zGJtlr8W4Id9S
	 E3XCZneqyO3/teP6xkd9hDDXsDCTZ0o4oVkaZmYyUIjvHYq09vg9vY/G6SN+s2ALSS
	 2DKp7aM2xSkOMxgB6NmvKvBQRBNmZYj/qtDCHibmxQ2W7CxFNB5ABv552V/WjrX5RW
	 yfmp0gqQ2rnIVq2ObnQKSgI/1iefmEBYpK4UCI42VpIhKHCqsor0PC02YnX545d+gJ
	 n96DH/D1DFZ2OM/FdiIecBeW93DsdHRRjcUbgbJwtHfDRjAnUTMeQJ2dq0QSfBjzNH
	 L01jks3G+In9g==
Date: Fri, 30 Oct 2026 22:44:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v7] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auUBsk7Gmcl7QiYO@kernel.org>
References: <20261030202457.3058665-1-jarkko@kernel.org>
 <sashiko-outbox-191485@kernel.org>
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
In-Reply-To: <sashiko-outbox-191485@kernel.org>

On Fri, Oct 30, 2026 at 08:38:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KEYS: key_put() sets KEY_GC_KEY_EXPIRED via key_schedule_gc(0)

Will be addressed.

Br, Jarkko
