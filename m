From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 06 Jun 2019 08:45:34 +0000
Subject: Re: [PATCH v2 RESEND] scripts: use pkg-config to locate libcrypto
Message-Id: <9643543.8bRR4aT8lR@devpool35>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1801806.k86Mj31LU8"
List-Id: <keyrings.vger.kernel.org>
References: <3861016.XCek94Sdvs@devpool21> <4904761.bSUFNkusSJ@devpool35> <6fbc10d7addf5aaab7b4b52537e0f0af6e0f2d71.camel@infradead.org>
In-Reply-To: <6fbc10d7addf5aaab7b4b52537e0f0af6e0f2d71.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

--nextPart1801806.k86Mj31LU8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

David Woodhouse wrote:
> On Thu, 2019-06-06 at 09:55 +0200, Rolf Eike Beer wrote:
> > +CRYPTO_LIBS =3D $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null ||
> > -lcrypto)
> That's going to run:
>=20
> $ pkg-config --libs libcrypto || -lcrypto
>=20
>=20
> If libcrypto.pc isn't there, it's going to get this:
>=20
>=20
> -lcrypto: command not found
>=20
> I think you meant:
>=20
> +CRYPTO_LIBS =3D $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || e=
cho
> -lcrypto)

Doh! Thanks, v3 in a minute.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1801806.k86Mj31LU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXPjSrgAKCRCr5FH7Xu2t
/FGVBACDaZeAF1gv/N+Xaryn024glR1o0HYMeA4okZuBXinlGu7dz1NgjI3mVVPq
c6p0rOOZ7MyQAuQkeMFuYKNN4bPzCm2psxl9/HsFK9+GaYIj/T8n6FtFwIY+PX7o
PalkzHoHq/dSoWkNwA94MIRCDCYDeKrdEYoxQxxiNUy5CozvoA==
=h8oM
-----END PGP SIGNATURE-----

--nextPart1801806.k86Mj31LU8--
