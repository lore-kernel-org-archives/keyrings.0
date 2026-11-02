Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602810;
	b=vgG+dsTg1zsflDVOAMWOs4ifv8xG+EPFj5ERUzxLH7hkewYn2TyO3Cjfcyo+/hEIe2UP
	 fdCqYfMXM4rc5tDRhxSsNfUc0CfcEB+e7Rm/1CJpqIDXO89512RhJUiCIY3IDHj1JCC99
	 Sn5+dih/tGZC4+cnnqDW/zH3NM+0lV7ezvR0JYXT96dueTSxfw3J8mDPW2lynzPv81V+q
	 W7mTOCIj0V8Qn1IKd7vIXu6CI0fSd/8oCsov8W8txZFuQ/bMaXfMGrG0sIWcKDIxCa+Wa
	 I1I2UuHxH6+ll80e18I8pFqxDAMrGCamS1+VH5c+RGot/mDh17mXCTnRH+XwYHSzlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602810;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QhazFK2BxvBECN5RgcF69zEUpMOSy6hAZ3XTzXMTcVE=;
	b=rJ//uktIIQQuY8xqOJEXSvH36keCyp7sO0OS68GLmkRoFhqlX+zpCZVUoXQpQJiXxoAy
	 OHP30LQAnor/wBLYsLvLtkhuGslUruna9qDkfRa9iBravTaT9Lvldnl76cs+v5BPhwXbR
	 HTfiOdoPOUy2ECF6o8d1ARw/1101bflS3NphAppt/EDa9Nuw8COyXFYleyeAf/mC9rvVW
	 4h/YedDuOl+B8n3FqLPy/Qj2N5+Fy7pec1O78T5hGo94ZCCRtLx+mFVAtxdFGUvxfL9mS
	 QZWCA8tHta2LrME/oHGQttR6E5ddUQtGy8oOVsNY3TppzqIjj5CKn4SXfrEzd2sryLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ1fpzCa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A667D606A326;
	Mon,  2 Nov 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ1fpzCa
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A6621F000C1;
	Mon,  2 Nov 2026 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602803;
	bh=QhazFK2BxvBECN5RgcF69zEUpMOSy6hAZ3XTzXMTcVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZ1fpzCajPUVedS98lnw5TJ3fDB1QuJ3qI/LzCS9FDPP/jTPbjquXINWPZ4/Ew3nK
	 Q4Q5jEcWLPHNPa5B06AXjZZ0qQtdDXcoL8fRCsPNG0lzEBdeKyMib8VGfyU7n3MfUN
	 uAUjUvk5ye5I4rSVtD2hDmuHEfnlHTOmFoS4PMVNk4jL6jSwaWyICE02W5uhVlOCLl
	 h3T1+vMiEFtTB9eZvdrNklrMWdq62TiILaPI+6iNASJNl9YYlp3ahPiUShNr3zOiR2
	 rX6iB25+ST5TKDL+mD5yCmCpJPimzHtLwi7nbH35Oicb8Xzs75nPjDDc5NPD2hLjZY
	 yPUgXCbtZqJMA==
Date: Mon, 2 Nov 2026 08:59:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Cen Zhang <zzzccc427@gmail.com>, dhowells@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH v3] keys: Protect the update method check against type
 removalg
Message-ID: <aug072sNik47BXxQ@kernel.org>
References: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
 <20261101221519.GB2689@quark>
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
In-Reply-To: <20261101221519.GB2689@quark>

On Sun, Nov 01, 2026 at 02:15:19PM -0800, Eric Biggers wrote:
> On Sat, Oct 31, 2026 at 05:26:36PM +0800, Cen Zhang wrote:
> > Take key->sem before the first access to key->type and hold it until
> > the preparsed payload has been freed. Once a key exists, only the GC
> > changes key->type, and it does so with key->sem held for writing.
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> But it seems broken that a key type can be removed while keys of that
> type still exist.

It might sense add ->owner and use try_module_get(). That would lead
into removal of key_type_dead.

I'd think that is doable but I would first consider applying
https://lore.kernel.org/keyrings/20261030205412.3138975-1-jarkko@kernel.org/
as that is more substantial multi-subsystem change.

> 
> - Eric

Br, Jarkko
