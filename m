Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794791373;
	b=2ZT+ZODoUB9iixj7Eqk8SZPXgbGLRTi/oPveCfsDN9HUx3E9XxbJiMALEE6BsLeYgoOh
	 i9T+t6u9XzN4hVkKB3mP5MmzSc8fW5Veoed4JYI0zJu2HYIDXYx9cb2OLhqAvugc1XlVR
	 8o94i1T0suYAjVUcXSddWFDvHWA8rk8DllZI6fgoqGMKQn5jVj11SR7sPao0ATKamXrm1
	 P6kMCFfzFJQQcxnBnvi9H2K5281qjoPsJ5wEF6ezNE0FozxT0cCKYCmt8mY74olFB1MHi
	 kOpcI3SkT1JFzibazoPGDP/l12J0qFtHu/pXrmOjDkdjnDCl8+UCnJQeRgTxAddgYJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794791373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+VXEokpVU9/GOy4FfvyqClp306Us9VBycMD9f9T4QD4=;
	b=bydUPFEGFBcHVqnSvWUT2MmVRVVf5m/dDtq+ZWKOVLOylB8lAXYEl7NfyuzYXmMQ1H26
	 kDlDaOM0Y84Jt772ESYnre0hDXjAjLO1jozUI84ZIIQsLaHBkJK2fXU7mmQGOAj+NcvDv
	 GSHhYU+9PKxvuSoapuu0ZtTa3RtyIdPAxQzWaXdQgR3MJSL1mA3RD9wSjoKGA77gV8DYy
	 Mdg2julqw/4CQZG+EbmANdKszvgrS0lMESM29b3nEzjTHNNKpfRJgdIkceyKlvoYv0AwR
	 DvI0ZkSmwWrYlqb/naiXZ6z+NBu5gqYNznv51j35fp3fAbYaS5IAqOHPkMNzgUsW+rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1TBAMJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978B606A31F;
	Mon, 16 Nov 2026 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1TBAMJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C73F1F000C4;
	Mon, 16 Nov 2026 01:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794791372;
	bh=+VXEokpVU9/GOy4FfvyqClp306Us9VBycMD9f9T4QD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1TBAMJplDRtoDGt9n6LSbsGpQxwK0/O5kBHaLcTs4mCpfS3R1fSKRaLaWWy+6Zmf
	 pG2WGhO23/emm+u3f/V9RUDs2G4tVGPNurD9YxlqB5/I1/3TH1/OgC2YYxonPeWO3o
	 3hOUHvJlr4atacuezE4gT98WAy/ucYSz2mB7MnPSWTDF6xBHTo4U21o3Od1mpk0PoH
	 YEyMdCxd52tkjy4A0iIHAijIBnpQ4DWRbbAmwGiwXU9ZTFQsdaJOeKzL67FZmjuoG+
	 rsUqTm9ZhLM/teZmsjWhMczJmXZgVUnOIzj5GEcwbEy/voOdLBzyGpb8etQxn1NkSn
	 E/SHScVJl2A8g==
Message-ID: <sashiko-outbox-215989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] tpm-buf: Make tpm_buf_read*() fallible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Alec
 Brown" <alec.r.brown@oracle.com>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, "David
 Howells" <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "James Morris" <jmorris@namei.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jonathan McDowell" <noodles@earth.li>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Paul
 Moore" <paul@paul-moore.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Ross Philipson" <ross.philipson@gmail.com>, "Serge
 E. Hallyn" <serge@hallyn.com>
In-Reply-To: <20261116005105.1573016-6-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:09:31 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tpm-buf: commit message says @offset instead of @value for
  tpm_buf_read*()
--

commit 1b879beddad8b2ec7e0adcfdce0e0fbb6825a4f9
Author: Jarkko Sakkinen <jarkko@kernel.org>

tpm-buf: Make tpm_buf_read*() fallible

This commit changes tpm_buf_read_u8(), tpm_buf_read_u16(), and
tpm_buf_read_u32() to return a boolean status and write the read word into
an output parameter, updating callers to check for out-of-bounds reads.

> Make tpm_buf_read_u8(), tpm_buf_read_u16() and tpm_buf_read_u32() flows
> unambiguous, and fallible by writing the updated offset to @offset.

[Severity: Low]
This isn't a bug, but the commit message says @offset where the patch adds
a @value output parameter for the read word; @offset was already updated in
place before this change.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116005105.1573=
016-1-jarkko@kernel.org?part=3D5
