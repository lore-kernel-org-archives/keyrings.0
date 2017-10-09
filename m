From: Eric Sesterhenn <eric.sesterhenn@x41-dsec.de>
Date: Mon, 09 Oct 2017 05:03:20 +0000
Subject: [PATCH] Prevent NULL pointer dereference if sinfo is not set
Message-Id: <5d131d8a-b075-7f8c-37ff-273a540b837f@x41-dsec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="h34mvcd5v46tqPWVTEL3n747SuHWxENbw"
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h34mvcd5v46tqPWVTEL3n747SuHWxENbw
Content-Type: multipart/mixed; boundary="06wAOU6sxtIAXPaGxQcbKvPsGkjSKdH0c";
 protected-headers="v1"
From: Eric Sesterhenn <eric.sesterhenn@x41-dsec.de>
To: keyrings@vger.kernel.org, dhowells@redhat.com
Message-ID: <5d131d8a-b075-7f8c-37ff-273a540b837f@x41-dsec.de>
Subject: [PATCH] Prevent NULL pointer dereference if sinfo is not set

--06wAOU6sxtIAXPaGxQcbKvPsGkjSKdH0c
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Prevent NULL pointer dereference, since sinfo is not always set.

Signed-off-by: Eric Sesterhenn <eric.sesterhenn@x41-dsec.de>

diff --git a/crypto/asymmetric_keys/pkcs7_parser.c
b/crypto/asymmetric_keys/pkcs7_parser.c
index af4cd8649117..d140d8bb2c96 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -88,6 +88,9 @@ static int pkcs7_check_authattrs(struct pkcs7_message
*msg)
 	bool want =3D false;

 	sinfo =3D msg->signed_infos;
+	if (!sinfo)
+		goto inconsistent;
+
 	if (sinfo->authattrs) {
 		want =3D true;
 		msg->have_authattrs =3D true;

--=20
Eric Sesterhenn (Principal Security Consultant)
X41 D-SEC GmbH, Dennewartstr. 25-27, D-52068 Aachen
T: +49 241 9809418-0, Fax: -9
Unternehmenssitz: Aachen, Amtsgericht Aachen: HRB19989
Gesch=C3=A4ftsf=C3=BChrer: Markus Vervier


--06wAOU6sxtIAXPaGxQcbKvPsGkjSKdH0c--

--h34mvcd5v46tqPWVTEL3n747SuHWxENbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE4kR6dD1Cx4CoBY4sFLXvnJmdoEMFAlnbAxgACgkQFLXvnJmd
oEP9pBAAurWhbYpPtbliGnNE7iowqlOzcY3CvQiSM4ql8CDPIL5+P0eeh4Sfp3XU
zsWAgV0nS6upSjzPH4Ldw5/ufIY5wDakeiJKV+n5Efu5SiWcJa2BL1+K61KlJB0n
U9r4aERF2UWAKeCH91HEEMTxSMpb992olNV3qp0PrvL0j0vsvtEuxp5gRVwc6BhG
CMDbUpk/LfBq0t4i9z5lI1os2P48ULMLIYDvYTCzR4D7BbSX6PTpELYKtt6fwtES
BnGuKFiZ40HvE86ztw4Vn5wYO9cYOJ7IrWhO6FfWqdimVRBJddrz1OaoDCp8QLcC
I2F0ySr/X/1NpMNu4e+yzABNmFuSDcmItYFJz8eueDnMeMSdU/4IVfhxfH8TPA2B
uFz3JnkeHI69Q09514W3mOK/aI3llrwNBjZfPqbWi3nwtUlRGLsFZP60V8iKs1zL
4v0ZucwNdzkdxLOIirSl5A/EImy2UyqiCpdrb+sI02tO8WM4zEpRFIBwiVt4Rl39
ieWOmxOq0rswzU+RgTXdXCgaSaqnw9IporpaCTDM7oerTgor59jEmv3EqJgd4J5U
O5Z+s72gNJ0agiyZkkjH5RqP1IFL3p/O/VTre7fuTnAWvJz5bpTwqY0Rmuh+g8zW
cJlQZyuj7E0I+avNmARWuTmxNvoXfsRGYsFeUErUQEKdx1xxCwE=
=MXn3
-----END PGP SIGNATURE-----

--h34mvcd5v46tqPWVTEL3n747SuHWxENbw--
