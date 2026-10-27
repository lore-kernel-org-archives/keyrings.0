Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069882;
	b=5aaRGj92UL2CRXiLg5JvWwLMhbZ7dw0r08IW8j80h54z60w7mmBqE+ClJ6voY97idiyY
	 MPBNcxus/o2RwBMXkEUldfXFH52Nuy5+OaUuUYGEFIs7woweuICLbbAOzZ7O2feOoN0oP
	 jn/SWFFoMfMQOGU2dDuH6RWye2c4jqhXIP7rBKjijZ6z+/1euqWqeXteBOtmRxjtSN4uP
	 54uI/DZzRpTmfruF7X04193TggeONxxC+6PnxHyGAHfHznmKHkKPmywlwc39azgYIFbcg
	 3+uG1BMRH1wj1oMcpTlry1hJBFo4yvqbsGXCimvnCYQfJ7eMscxzasLIcQvHxZxhRuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=RzDuW1fDhj/bN/SCFcWzt38KwQN8yOJ4LZuXA6dl0rk=;
	b=e8NTmJXm7AGhZRtyONaKRhqq5zmqc1nV61k7yVQoBNb2SFGl2L5rRZCEAtg2X2f8H+hs
	 1SqL2QEgHJm8jvBBNKo7mx/vFa9/7M6FbWGVkOzZ4pdvgrzRgFhthRNzguQvW/43cP+v3
	 b2hkDFz1ann/wjKut6/ZqxIWkrkTPq6A+1off6H5597jptkj+hjifXulfMQMJaRUxHOhN
	 bfvNWnLotNAzLD8fNBROYmOIAwsq7dXxr/cptdamxQvp6f7teKkojm4tZxRQ4LVXjtklC
	 chzxyfMzNvgSO17s8dsdp4RTtBFeHD0JuM7w/GomaSCgMCUoIrM2qMuvoO6O//oX/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=benboeckel.net;
	spf=pass smtp.mailfrom=benboeckel.net;
	dkim=pass header.d=benboeckel.net header.i=@benboeckel.net header.a=rsa-sha256 header.s=fm1 header.b=UeNIr0Jh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cKQ5WR0w;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA1606A335
	for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 02:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CA1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=benboeckel.net header.i=@benboeckel.net header.a=rsa-sha256 header.s=fm1 header.b=UeNIr0Jh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cKQ5WR0w
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C20F214005D2
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 22:58:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 22:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793069880; x=
	1793156280; bh=RzDuW1fDhj/bN/SCFcWzt38KwQN8yOJ4LZuXA6dl0rk=; b=U
	eNIr0Jh2uPoH1auyN+hsH4853oN1mOuGOmAACZIZ8cozE1b8Gf3v2d9nMLbpu4bY
	4TtVy2qsi6UyRVVR+nx1tYYPfj1bpBMdH+ER8vl0Pdt302wgmyfzUhxZQwUwliCp
	mGe+4vgEUNFHfkcqdull7tiZhAIIv3cPoEPy/6Ozg07nmhhcVR7z1LMoIi8X0LdK
	iE6+JoS8qnUjeqUq1uvuwrP8mDFvRGg4SDHkME74Kfy5atSJACSB58MxeUQadRBn
	xGmvyCeKQBiRVhJ7MseLeLpziWDvy3yNznXZ5mlLYMd+IL0wA+EL+Aw1jfiB1vWo
	aLxszVyq8di/8tqtOVcgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793069880; x=1793156280; bh=RzDuW1fDhj/bN/SCFcWzt38KwQN8yOJ4LZu
	XA6dl0rk=; b=cKQ5WR0waNZuxt341vn7uPZy0fBNFZp+ivscc07L5/1xArmlvNL
	R8EzaRFtnYnx8+X7KBT56AQ0d2rh1frTzf4pUYYL7aol4Gr9/rIemkzLqGweHtd1
	gj02t7ezIKQml9hjp2uyGNOHdMkI0wm9AzpBPzvOTW+c6OZkUQ+30mLD2MKXmk+Q
	g5b6aWtacyJ4VfFpFnZL0DjRpowWZ/kh20dLuGNa2TayqCqu/HeP0ea1zGCx8LU4
	Rh1UWjEIHt/COJ/jYAxY0/Z6a+2qlpZV25yV90i+ZqfqS1siHBtNiSLzNQ0VfgNP
	QnyrfLtArFgwVlQLLTIDnXjxRm5hohtI09Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=benboeckel.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793069880; d=benboeckel.net;
	mf=PG1lQGJlbmJvZWNrZWwubmV0Pg==;
	rt=PGtleXJpbmdzQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:JqB9TBdiBkdRxt88TY/cJrRzxMXUCyZ+xc2LtaJkCitNHpz
	Q5aXsvt2U1q2RZkVzebkVkqbUJg8CMC505J6rc1//0lK5yrdSpfEDfVGQapeZADY
	ZTn3nyg9KJ1/cy+pjclXth39ryf4jnRXgbs9vlV69QbjF5xMDIRK20yYoVC5yoGP
	x6SK0KLElcuVDEQE85U2a4M//DhgRYKPVu4awBLrHDEDO1CMlKZT3CXt/DkH5ItT
	8GhZ0JuBlw4x+cb2XBXQOlqZq1OkKQ4M4NXSdobcrnzuRkN1l5OEHymV7UKOO0AT
	dbmAzwEeX6lBTr63M9tNzUihVNMiPA/+A2YTDvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:+4JOoAOpxmGwmiy8zJkbWfnT3k7Uc2NPoWUZjWpVx2U=:2GqvvgHS9vIpd+C3RxT/6sILK5vwn5b4h1g341jDraw=;
X-ME-Sender: <xms:NhPgaitRVOpMXH8K_XVoCpLdKPzdqROcoCxc1rneEytKgr-o0QnikQ>
    <xme:NhPgateoeX3srGscpmIuQLzPfd7EhqEkbsoC3iMA6f7AtijwrMNZC9vya9R8BJDdU
    kZPo17BqXcpvGJRc66bNLNwSk_eMbSqt8qXQdoHm749hRrAs5rM-qcV>
X-ME-Received: <xmr:NhPgaol2cmY2S12dM36SiXOQi2dAz3SvKQoQUrbs4FJ1Bd23E5a6Q9NwQw>
X-ME-Proxy-Cause: dmFkZTFCDO9tIo5qGgC4lPr4j0mlKGdDLgUIJRjYgHUovDj6WV7SvLBEDePAMPdxZpTSOS
    LkWKH48+tetCfZoL6oWN6O+w1QYH7Bayi2nMyxO2a7kmQoWgRkbdD82y8J5vxF313F7VfH
    4cyoIWJRzD0BJPqUjHlGFomneVHkd9iY3LkviyfHWUEqzKtIJkyov716cjSOlohHOL69Sm
    NrYYYwidtkHv0ocNVvwYIQ54qllW7iWKx3qjfTGpDOLQbEwx8/ouVtQJeHrByjj2BB5n3S
    MMNPcutB1sKqHsX9L1hppBl9qvYY+Odpmm6jfwpTaU3mYKvHEwI+xUv84rnxnNiX3949kk
    er/8NTsXj2PS6Jr3KeJFSecKGHEUKs4ktrhNbbvoGH2tr3JQp4OZo/eNmMo+BzP78tVaY2
    FjjNC2+BVDhIYYN3l+vT2+lE2Ii/0I6zxHfqVw/zbxGIdfOvw0hPDLhRmWbsR3zwKrOpAJ
    RdJ2Lb5ethWUZrnsD6Q+bdua9qtzA9AdcpHlKAXsurrJopc3DcbDPIH+y/7XvAjaylaaPN
    1vm7SpjVjzgUbpgXZDhVwksKaf2whZTtVFbOGa0un/uf9tvhZNP6HcZIPMMi2hgS4lmQ2S
    TkyHe42wKFsTWBNXSFLVKgtJ9TMHaJQZfHuUh2+f+9/0kO3fSsZJHaX4GlkQ
X-ME-Proxy: <xmx:NhPgagCf-Uvlu7wbWnv8-7H7FXjKy0uVg6Ztv1wmY5MkjaRT32t0Fg>
    <xmx:NhPgaiN1nbuqWBEQ20waHDqF1GF6zMsQZDJdayp0117-8X727meJ2w>
    <xmx:NhPgavPXBBIre349XTx6KJMNj3yoYVfARAgdgtX00TqvzTPVwCpt2g>
    <xmx:NhPgaimIZstfhwy0GN38ViotyYb506Y4MKbxGGsEc9nfuGH7IPtBNA>
    <xmx:OBPgaqYUpQ7hasDMyY7Bn045gFrO0rDO1HaAdcQ_eYDzrIvTyay5WvjL>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 22:57:58 -0400 (EDT)
Date: Mon, 26 Oct 2026 22:57:55 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: dhowells@redhat.com, lukas@wunner.de, ignat@linux.win,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] certs: Print correct error on pkcs7_parse_message()
 failure
Message-ID: <auATM8gAJhFngmQ_@rotor.dev.benboeckel.internal>
References: <20261025025830.2239-1-tangbin@cmss.chinamobile.com>
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
Content-Disposition: inline
In-Reply-To: <20261025025830.2239-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/2.4.2 (2026-08-30)

On Sun, Oct 25, 2026 at 10:58:29 +0800, Tang Bin wrote:
> The panic on IS_ERR(pkcs7) printed 'ret', which still holds the result of
> the prior successful x509_load_certificate_list() (0) rather than the pkcs7
> parse error. Use PTR_ERR(pkcs7) and %ld so the real failure code is
> reported.
> 
> Fixes: 8cd9f234f706 ("certs: Move RSA self-test data to separate file")
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Already submitted:

    https://www.spinics.net/lists/keyrings/msg19526.html

--Ben
