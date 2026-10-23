Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780977;
	b=C2TKDgvR6GCzekDRnEp5GnKr6vd/fQD/YxoYf3UOEtsfVGpJ7ADYwRaaj95TbqkPiBv1
	 mfx6M0gr6rOWK/sPj3LU2FOW//3UGN1oGDMglg+i9L5Dne34o8S1wLg8RUmUF50m813/r
	 Wd2x+v13kFyfBwipamTiIPLjPQeP+sIaGA5ORd3utVohKPCLj+HzdDWiLScD228O4/UEp
	 f1pRDlC7R8PTkJ4QIXN3YYnOkH0dBhFmL6lDx/CDO8SLqOU9BSnqVdSSiXkv0x5rX6RVO
	 M3emM15eZuVP0/dKtQamjFkkiLMQAS16LlCvTwng/z/Wsilq1JQsbOKorex/kap62GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Lxkc2euE4T/djzzr4F++5fyZzMGHgZJ4J24aOu39flU=;
	b=CnPHmvIEh5eGnMiGqLBnfSUkUcIvDaDSI9QeMp3kjh21VUQUR2/jfWdZ0N0LUv/uskWD
	 9skD3+cXA/J3knuG53NKNmD5FcaFI4wfu1ajjMAADh8K2dJ82GMBRJgHJGEgWFsWDPVEl
	 r1rDmV5HuW3uASvCpmq643VkGVgcqmkf5JZiV9pTXMK3BnXN0W42ZCfgF/Nm5ej3aRlec
	 J2nB+WZsdn4JtoslUHgHNhnzyOYcbRbC/oiMSxnQgDNUDYcxcO3Uep/5MYmhxdEwSWtT1
	 DipTX3dNetvRs9bc2NT2NuLuc+Qq41kU/tft3Jcg71SnQpel6htJ7fKvTWb2jJUnnAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYXNbn2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AECB3606A31E;
	Fri, 23 Oct 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYXNbn2h
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CE4331F01829;
	Fri, 23 Oct 2026 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780976;
	bh=Lxkc2euE4T/djzzr4F++5fyZzMGHgZJ4J24aOu39flU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYXNbn2hX0/TAGp2UZLAu5Tlycz8+xz99pjBF75+xpxExWU4Iw8y+jVzEi8Gjl1We
	 irF9ZnY+buVfD82zsxdr5HHPtE+HULvI+gEHwsNe2rHC0vDLEHTjusyvZIkOpMxIzf
	 ckwthdpvRfUBDeFHJ9g7C+Rqnh9BRp+DEnwy7ynB2NWfESyRg3AJ44KlubY2cmXflN
	 R04BJ/ptmJwMUu/eSOlH/lYzSWwBkASAdQYkCQR//sAA9fQv2ClsYOtbtwivVRLF+k
	 agZM4gDiEhTQlaGlKODc/T1Z4ez90bjBxrAplFJR+lr21DlwzE7SMZHv8K/mQlBJri
	 LENuT1t2eGM+g==
Date: Fri, 23 Oct 2026 21:42:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH v5 3/5] userns: check the opener and the writer before
 mapping uid 0
Message-ID: <atuqrH6FMMECBLbH@kernel.org>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-3-0620223be951@toxicpanda.com>
 <sashiko-outbox-182977@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-182977@kernel.org>

On Fri, Oct 23, 2026 at 05:03:57PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review · https://sashiko.dev/#/patchset/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com?part=3

Interesting. For my patch set Sashiko is lacking the full cc list
(has only linux-security-module) but this came cc'd even directly 
to me. Any ideas what might be the problem?

Br, Jarkko
