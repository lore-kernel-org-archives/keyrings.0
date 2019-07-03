From: Rolf Eike Beer <eb@emlix.com>
Date: Wed, 03 Jul 2019 09:57:07 +0000
Subject: Re: [PATCH v3] scripts: use pkg-config to locate libcrypto
Message-Id: <1811702.YVQuMqyDZo@devpool35>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1729975.KOner38kvF"
List-Id: <keyrings.vger.kernel.org>
References: <20538915.Wj2CyUsUYa@devpool35>
In-Reply-To: <20538915.Wj2CyUsUYa@devpool35>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

--nextPart1729975.KOner38kvF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

> From 71e19be4247fbaa2540dfb321e2b148234680a13 Mon Sep 17 00:00:00 2001
> From: Rolf Eike Beer <eb@emlix.com>
> Date: Thu, 22 Nov 2018 16:40:49 +0100
> Subject: [PATCH] scripts: use pkg-config to locate libcrypto
>=20
> Otherwise build fails if the headers are not in the default location. Whi=
le
> at it also ask pkg-config for the libs, with fallback to the existing
> value.

Ping?
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1729975.KOner38kvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXRx78wAKCRCr5FH7Xu2t
/Ji/BACRSuxQHEqsw0qcdlknyNcG9PldpGMWh1OAgJeYQtOUH0cecj2XfUQuOXhL
chxN4YJsu6GCZG6sLYdoCPdYDO8WNN33vqXXD5JMYBzWIStR8ZyyzfJj1qFlgTRL
JqjrwrHLHAuGhJVyxHKr1IFjdLFfVgefpKkdaHFnK9CoEST2gg==
=yMur
-----END PGP SIGNATURE-----

--nextPart1729975.KOner38kvF--
