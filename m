Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783390;
	b=CezvH+ZefL7Qsk0NXIoaR3iMjOYLjXf9Q4f40YcmeBvWNfscpyAwcWzb8ciILMWCE+n/
	 kwhUGb8TFue6q8bLKF8AE9jkgq5CktrzCrIMFf3eFIdSlRBiwAqF5bQvgqTNEsYxlg89n
	 /ePt3STJzHuR8s1lBZvXyjVL8MdQ0QUTayzxvLIGzxEbEbwSK7axthn4X/u27H8s8cajz
	 974Vvv5WaWYMI+JThWJ7JtJZW4tMa3lyx9h/H/OfCEkn8l1X6YYLRjaLeqEFb6/YnpXqK
	 BSv3xROIKgm4dakjw4zuFrJyXjkJK64pDYJ9Hw4EVId8EmSOe/AuoEfCMd6JpTrGUEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WtU9Z8TSxlHMpGHiPInsH1M6zG29MxKJi38CBFy/D9I=;
	b=Ry0+x9z3+7FJveZmpKqyAnZp4rLcgttEqwqjfDA+EgB/pOys87JWxbbMSji2ZV4av682
	 kTIFA1svD2uTqDF5QBXVvJDRGq/R+Vv/WbTCZOXXtGQqccB7zlkD1DrclqQJrI+wD6wJ6
	 KkOxG1lBK6adzs1Rwomk/FlABqkrS3TIbehwDOie9kmBVlBS1R9PWytUi5+GV+y6Ua0Qp
	 NJFfyzbW+ThLyYqJQ0fwQ5s54Cy5gDf/H4vpBOidowgSWnl1TF/w/PSTob1jVEnXqW+SP
	 I4L7tm13dQe4FqemFCXFwAuHQlw3BM61LvYxF8UsXtUdSdbHjYvg11F+uI3Eem2TS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRddIEx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C7606A31F;
	Sun, 15 Nov 2026 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRddIEx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125BB1F000C4;
	Sun, 15 Nov 2026 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783389;
	bh=WtU9Z8TSxlHMpGHiPInsH1M6zG29MxKJi38CBFy/D9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRddIEx7tguTBcetbrqJFQ26UCKsw8enZcgne6imNwlAQ+z6hS/mANrIY+5mwZbgu
	 bE6/FvV215i2f/P+0ytszub7EHbERxmlxHsdicNYcFLgpcye/UQ7XXHgqOcRkKHHSg
	 mYTKqQIFNfhmYfMOQs3NdMXMr+p9DnA2HIrkVnBW4NP5ksy93ixUioysPKCkkgE82D
	 eIbw9zFD7meyMRy3is+H2ZR4C/JZqQbgNw1LTQIlzKa3G9MidSVlzijhU8mvHj1qJL
	 oJSvPi60qaVc8XiL9PGB/Z8Xe6vSqlGWNQZT4I9eQccNkkzX8LTi5Z6T5XRAlMxpTu
	 fK6Zu/JcTzDcA==
Message-ID: <sashiko-outbox-215893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] tpm2-sessions: Re-orchestrate tpm2_read_public()
 use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Alec
 Brown" <alec.r.brown@oracle.com>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "James Morris" <jmorris@namei.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jonathan McDowell" <noodles@earth.li>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Paul
 Moore" <paul@paul-moore.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Ross
 Philipson" <ross.philipson@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>
In-Reply-To: <20261115224722.1450498-5-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
 <20261115224722.1450498-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 22:56:28 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] tpm: unsequenced modification of offset in tpm2_read_public()
  [1]
--

commit ebd1e7509520c997eb3480a23e996d7c9abd6acd
Author: Jarkko Sakkinen <jarkko@kernel.org>

tpm2-sessions: Re-orchestrate tpm2_read_public() use

This commit exports tpm2_read_public() and moves TPM handle name
resolution out of tpm_buf_append_name() so that callers resolve handle
names explicitly before starting an authorization session.

> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 94c11135beb3f..36308b384a5e3 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
[ ... ]
> @@ -163,7 +163,17 @@ static int name_size(const u8 *name)
>  	}
>  }
> =20
> -static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *nam=
e)
> +/**
> + * tpm2_read_public() - Resolve TPM name for a handle
> + * @chip:	TPM chip to use.
> + * @handle:	TPM handle.
> + * @name:	Buffer for returning the name blob. Must have a capacity of at
> + *		least %TPM2_MAX_NAME_SIZE bytes.
> + *
> + * Return: Size of the TPM handle name on success, or a negative errno w=
hen
> + * TPM2_ReadPublic fails.
> + */
> +int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>  {
>  	u32 mso =3D tpm2_handle_mso(handle);
>  	off_t offset =3D TPM_HEADER_SIZE;
> @@ -172,7 +182,7 @@ static int tpm2_read_public(struct tpm_chip *chip, u3=
2 handle, void *name)
> =20
>  	if (mso !=3D TPM2_MSO_PERSISTENT && mso !=3D TPM2_MSO_VOLATILE &&
>  	    mso !=3D TPM2_MSO_NVRAM) {
> -		memcpy(name, &handle, sizeof(u32));
> +		put_unaligned_be32(handle, name);
>  		return sizeof(u32);
>  	}
> =20
> @@ -212,39 +222,34 @@ static int tpm2_read_public(struct tpm_chip *chip, =
u32 handle, void *name)
>  	memcpy(name, &buf->data[offset], rc);
>  	return name_size_alg;
>  }
> +EXPORT_SYMBOL_GPL(tpm2_read_public);

[Severity: High]
This problem wasn't introduced by this patch, but does the modification of
offset in tpm2_read_public() [1] have unsequenced side effects?

drivers/char/tpm/tpm2-sessions.c:tpm2_read_public() {
	...
	/* Skip TPMT_PUBLIC: */
	offset +=3D tpm_buf_read_u16(buf, &offset);
	...
}

tpm_buf_read_u16() increments offset by 2 through &offset, while the +=3D
operator also reads and writes offset without a sequence point between
evaluating the left operand and calling tpm_buf_read_u16().  If the
compiler evaluates the left operand before the call, +=3D adds the returned
length to the old offset and discards the +2 increment, misaligning the
subsequent TPM2B_NAME and TPMT_HA reads.

[1] https://sashiko.dev/#/bug/linux-332997a7-b4f3-4fb9-b9c8-65529918139d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115224722.1450=
498-1-jarkko@kernel.org?part=3D4
