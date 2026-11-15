Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786225;
	b=mSy+dv6S+zI2ZNgGvt39CtdKKaRQfFYofengh7akWE7PHr1AAVlrcBZkrHsZx/s+PySE
	 zo8EOxG+WY5PIBqY5GEPLo8GL7nilpj2IbCZzrX6LjaGcXpGqvkt0sdMFI7AxYN/3c5EP
	 lg+gbmDaA14l0oLfzMdNofOfZoc0FsTbSf6uZT1q2hUeBi4ZYStaP4WMeruf0JedrdXPX
	 U3XNg5toeZzsRR16le0Ltu4ACz/VyvElZXwqQTbDtwmiVqvQ0lCa+YJ26Fju0L7squmDk
	 VuF6rY3QQE5mxlTHndqyGOmXdpu+eyJGdb0XCpkyhuxu0/wqbXeI5gXcYwGcqHhoX1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZW65+5MT2c96E2OSwCr5awZ+x+R3327IpwSzmz05afU=;
	b=jcZrIJ8//wdDgiCdmqnqNs4t3sZoEx9CjXotBYU67T3TYzl4a4zY5R7cnB4w8sLsIlt/
	 YXglzJp0DCwqw+yCrZZnNktOG4rqursvFG73ONq6TC/gSJQV/yzKzMe3wajxlaZ/bj48x
	 wVvY7KL/kiYgm6iJISqB3rpPfVAZYA6BXqZVBUIiRlVZUBDEgdgeewZG7YgBlDrYLXBIp
	 Q+7ST9K/Xh27OfATwGfZY+in6zEbCA94haeUmGKOrbi0MeoYKncU5ULSIvZS8mV7UIxkA
	 I9+aVrsFhYsnfOn6Wrwb/zum/VCU3lQ7BIjO/As7pXw6wr2b6hLi97+0Lh6bfUyxXwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceNagz7J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 734AB606A323;
	Sun, 15 Nov 2026 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceNagz7J
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 740C51F000C4;
	Sun, 15 Nov 2026 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786225;
	bh=ZW65+5MT2c96E2OSwCr5awZ+x+R3327IpwSzmz05afU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ceNagz7JDgpG3rqgcWOoObSCI/MsqyAJblXoJa95r2KdqmwjytOJ0snC3uZUR1xE5
	 YJUkl3ACUCA8CSyFeevaM0cNyo4QFVoeaBtheJzMqialECTeIYsNbd3NfvKXYJujr7
	 IHmLBDuEYYTqMUjgnKi9FETk39EcqmW12tt3TxzO/DtCqIEuHaIhmkJaPJGqqIxXlG
	 CDyk8Zn5ItpZfzKSUdWsRWA+934C4f0pzSN6KpsXiG5AeUcoJhoqPFCIxyV1J9FRlf
	 mQ8CgTGjmWxEd8fxC0RzETFl2ngXq3yxdnIwuHyTEG4YUOC2taon2CF1z+jXBV67X2
	 Jv6YujI8WSmfg==
Date: Mon, 16 Nov 2026 01:43:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 0/4] Unsorted tpm2-sessions improvements
Message-ID: <avpDrQF4QAcCMnsr@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
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
In-Reply-To: <20261115233156.1485238-1-jarkko@kernel.org>

On Mon, Nov 16, 2026 at 01:31:52AM +0200, Jarkko Sakkinen wrote:
> v2:
> 
> - Based on Sashiko feedback I changed "offset += tpm_buf_read_u16()" into
>   "rc = tpm_buf_read_u16(...)" and "offset += rc". I'm convinced that this
>   was necessary but since it does not have a cost, at least this should
>   mute Sashiko.

No further Sashiko complains.

Br, Jarkko
