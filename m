Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626482;
	b=TtawdbXSPDUy0Lae3to8v4SqQm1O0+UXGtpFuaavUJw6IOQRkWoVwhtZj/hkgEgpd/Lt
	 j1K2qqfbh3uj5ZqgobngZ9cx/dGVwRO1AIahObGleDm8Xwo3MMyNZ+29uSyMcunhdJJWt
	 3NWE9s4dx2c4yhY9zftYrsFmaC8lhzGsXwPENAas1gjEVJmoYt0bhtrTFsOTZYBXG+xqz
	 wt2zFK8d5YVI7ZtKB0jv4dyfYsP8G+CLUmL/COZ1UixTY/jrlO1W1+hHuDFTTmFSOzNNy
	 E0unkErVACOocPe440+mRQWKupZa89jabZYAPJoBK7TBYNUqDENe/udyokb6cIyrqkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626482;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hHK7Mmgyiu+tDJa8gI3Bjskl7GXIjPStGml36Gdpu74=;
	b=RTdM5qde0avvNwEO6TKOWSbr1Bojb6LDTxLYLlgM5s9guNCqEuzp7nwbZ+gJ1QVovFCi
	 q0GqFDWCGbNw6guOUBz0Iwm1WwHxmdi66eCEVOOvdEBsfgfXRSlcuEdk4cIY/Gs7SS3yC
	 QSkiZuEuAtcaTe0zsmhIqT+J4xJZpHgli4Gnw5b+c3/A/l3Bs4Wq5axpm5miTMYEHf4ji
	 KK60o5rT6oue0EZDSCnGm2MNfNONtSPQQjbm/LR2vBkOzQU6Racffzv+Olk60xUdCDaRl
	 zsBMOTPF3Ugyvfxp2hNjJ0jXL/pI0HK4eDiEqFzmBrPwXyk4LloGMXhPdm9knVQRJ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xg53petf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A75FB60A3803;
	Mon,  2 Nov 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xg53petf
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A8A1C1F00A17;
	Mon,  2 Nov 2026 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793626482;
	bh=hHK7Mmgyiu+tDJa8gI3Bjskl7GXIjPStGml36Gdpu74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xg53petf/FtTy98vgvbgWIajMU729Bny6DZUrlEG2VarG6ItwOkRwcOFZ+MtJbMD4
	 AtEkUzaFLIQIlcEYq5LutiBcwZWF2kd3044av+9TYNk2O1bw6vw2fwzpUwJBaRrqQ0
	 IN46jDw/iLECQlHLYIQ7LYdqmhCTZXIA4WyJGRHbZRdjM/c+DbFi9WcEAEmbQmiWTz
	 VhQZuqZVYlH8uOei3GRGqIlHuHaCvMrMSafsHz4yp4fQrIH3nTJogYmZNPrB5obSTc
	 u8xufgakWbjXSfCs4sRy3oad7260hVFiljwObaoLZUry30J25HXu0lkYf9RH8lFY4x
	 JxrcmYmLDfu2g==
Date: Mon, 2 Nov 2026 15:34:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auiRbvC-tomWC_WD@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-5-jarkko@kernel.org>
 <sashiko-outbox-193421@kernel.org>
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
In-Reply-To: <sashiko-outbox-193421@kernel.org>

On Mon, Nov 02, 2026 at 12:32:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] keys: non-atomic flag clearing in key_garbage_collector() drops link reaping
> --
> 
> commit 9857f1d86bdced127ae471468f5b25b61aa04d0f
> Author: Jarkko Sakkinen <jarkko@kernel.org>
> 
> KEYS: key_garbage_collector(): process in chunks
> 
> This commit updates key_garbage_collector() to scan the serial tree and
> destroy unused keys in chunks of 64 items, tracking in-flight state across
> workqueue continuations to prevent workqueue lockups.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/package/keygcbench

I'm addressing all the Sashiko issues also for this.

Br, Jarkko
