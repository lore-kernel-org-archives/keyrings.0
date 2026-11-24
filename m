Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528622;
	b=beW6zEwhidoEgKqZqyljjmm2Km2GhxU4LejKk9rnlFDRDxAGF/bS6WkryriJKBievFHq
	 0EBrT++Ey7KXYQn5TvD79jNVW5693+2It+XMqxLSsV0F7didaCfFeW1FuNxOPJ4ShsczX
	 Z2TKaMmA23Nen4leJBy/tBYs3B8Qm/iMM/GvQErle1yjgj/MmEJxmzR2cKItf5R7ZPOrh
	 oWOjieG75kem9IFNGtHHcBTZObHqlqlu9yGz9anVoGyuL9c5z1kUpXhM+FPqeLKpMhObW
	 0DzrzxvHJfzn4KGnPy6GjSJRdnZ1NEzr8AR6sNWs2ZCzqGYLFh8Eo11mNNDdnHWp4qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528622;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=itbrjM4Vsygy1H0F0wv0PDqACzzXdZib2AUrYhCNxGE=;
	b=Nxr+KcARAi+Wur1kXrXjNdNpOiBwdrGZ2//M+YkVEGjMdK/Rx9rupdVZneRm2P7zs5t6
	 ZuO743XKo26sOe95hU9SZrHUyneWmMG8SMH81edvGaNf3xKkkQKZCOXRAvxFMDsCuacPF
	 B8gdgDxaLEvZquqbxRpEi/1gWKKSnZb3e8q2/XJlyUKCv72pKm0EbNJjeEtdIWIvrK+LH
	 fsg39K2v99axCUpoYPCs9ID/kSWU1QZE56ixi0jlwCLNP1y7pTO9kVHUS0UKv2jYK3By9
	 lb0/kiy1jAu/4phxw+rfYRap4/bVBEKNrIaiRHZcbhvgWwH0lI2HKecyi49amBkfW1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=UoaQYs4q;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474C6606A31E;
	Tue, 24 Nov 2026 13:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=UoaQYs4q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1795528620;
	bh=XlCM40uFy1qcEBiaeIgSy61xYvoYIP2WJvzH+1MvZ6w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UoaQYs4qL23we/csnAnk+lSTr86UZN7B2r4f1keQpo0tMXkCxm/VJkKVzNkdTX6oc
	 UmlFBQIrDP2CAhLMEUSHh7l5HdldjwrJA48mDyjjsTOmDVKZyJnpvas+KltDYPT1UP
	 ofLnkYXeanG+nKEp/W04fqAkmeUpw55K/QSZlWh4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 051FB1C01C9;
	Tue, 24 Nov 2026 08:56:59 -0500 (EST)
Message-ID: <b4c2860a41daafb789a2386f2779e5f9f8741d8e.camel@HansenPartnership.com>
Subject: Re: [PATCH] lib/asn1_encoder: fix encoding of zero OID components
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, zzz <abc0eichs@qq.com>
Cc: linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, David
 Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
 linux-integrity@vger.kernel.org
Date: Tue, 24 Nov 2026 08:56:59 -0500
In-Reply-To: <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
References: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
	 <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 22:03 -0800, Andrew Morton wrote:
> On Fri, 20 Nov 2026 21:00:55 +0800 zzz <abc0eichs@qq.com> wrote:
> > --- a/lib/asn1_encoder.c
> > +++ b/lib/asn1_encoder.c
> > @@ -97,7 +97,7 @@ static int asn1_encode_oid_digit(unsigned char
> > **_data, int *data_len, u32 oid)
> > =C2=A0
> > =C2=A0	/* quick case */
> > =C2=A0	if (oid =3D=3D 0) {
> > -		*data++ =3D 0x80;
> > +		*data++ =3D 0;
> > =C2=A0		(*data_len)--;
> > =C2=A0		goto out;
> > =C2=A0	}

Yes, well, I was just thinking about the single case when I wrote it.
Actually, wouldn't getting rid of all the special casing make this code
more maintainable.  Something like

diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 92f35aae13b1..fc97cb4d27fa 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -92,15 +92,9 @@ static int asn1_encode_oid_digit(unsigned char
**_data, int *data_len, u32 oid)
 	int start =3D 7 + 7 + 7 + 7;
 	int ret =3D 0;
=20
-	if (*data_len < 1)
-		return -EINVAL;
-
 	/* quick case */
-	if (oid =3D=3D 0) {
-		*data++ =3D 0x80;
-		(*data_len)--;
-		goto out;
-	}
+	if (oid >> 7 =3D=3D 0)
+		goto encode_last;
=20
 	while (oid >> start =3D=3D 0)
 		start -=3D 7;
@@ -116,6 +110,7 @@ static int asn1_encode_oid_digit(unsigned char
**_data, int *data_len, u32 oid)
 		(*data_len)--;
 	}
=20
+ encode_last:
 	if (*data_len > 0) {
 		*data++ =3D oid;
 		(*data_len)--;
@@ -123,7 +118,6 @@ static int asn1_encode_oid_digit(unsigned char
**_data, int *data_len, u32 oid)
 		ret =3D -EINVAL;
 	}
=20
- out:
 	*_data =3D data;
 	return ret;
 }

?

James
