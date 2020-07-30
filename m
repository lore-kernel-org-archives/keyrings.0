From: Rolf Eike Beer <eb@emlix.com>
Date: Thu, 30 Jul 2020 12:49:41 +0000
Subject: Re: [PATCH v4] scripts: use pkg-config to locate libcrypto
Message-Id: <1825784.enSSdDGVcg@devpool35>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart9679229.JMKxYvS3ME"
List-Id: <keyrings.vger.kernel.org>
References: <20538915.Wj2CyUsUYa@devpool35> <2278760.8Yd83Mgoko@devpool35>
In-Reply-To: <2278760.8Yd83Mgoko@devpool35>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

--nextPart9679229.JMKxYvS3ME
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Montag, 27. April 2020, 10:11:28 CEST schrieb Rolf Eike Beer:
> From 082ba542ca4c710dcf592a6f9233603b9275d05d Mon Sep 17 00:00:00 2001
> From: Rolf Eike Beer <eb@emlix.com>
> Date: Thu, 22 Nov 2018 16:40:49 +0100
> Subject: [PATCH 1/2] scripts: use pkg-config to locate libcrypto
>=20
> Otherwise build fails if the headers are not in the default location. Whi=
le
> at it also ask pkg-config for the libs, with fallback to the existing
> value.

Close to 2 years since the original patch=E2=80=A6 can this please be appli=
ed? It=20
get's annoying to patch every new kernel version the same way again.

Thx

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart9679229.JMKxYvS3ME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXyLB5gAKCRCr5FH7Xu2t
/OfFBADHZ2FrSoVi6DAf2H7CaJx74tezgvQax1e0nMjCGpnAgonXf4+y3bjHjNBI
mHCzvvybwqFG7hC3nVzw4mpptyc/nSv5kJGZZkxFvvJ3+YDWfhbtrovpAxKqBR9y
D/1YIQ8cR/WoONrRs0BGUf6lDN9BspoABK6gPoXztzT8mz+ODA==
=tpgR
-----END PGP SIGNATURE-----

--nextPart9679229.JMKxYvS3ME--
