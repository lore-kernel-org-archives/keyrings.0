From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 17 Oct 2018 16:41:58 +0000
Subject: Re: [PATCH] support other engines for module signing
Message-Id: <1539794518.3769.47.camel@HansenPartnership.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-20MHwAfIi/Le+akvVCtu"
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171142300.20697@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171142300.20697@hatman>
To: keyrings@vger.kernel.org


--=-20MHwAfIi/Le+akvVCtu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-10-17 at 08:48 -0700, David Woodhouse wrote:
> On Wed, 2018-10-17 at 08:28 -0700, James Bottomley wrote:
> > On Wed, 2018-10-17 at 08:18 -0700, David Woodhouse wrote:
> > > It looks just like yours. It uses the UI callbacks, but you can
> > > bypass those by providing the password in advance with an
> > > ENGINE_ctrl
> > > if you want.
> >=20
> > Are we talking about the same thing?  This is the current RH code:
>=20
> Why are you calling this "RH code"? What does Red Hat have to do with
> it? This is code in the upstream kernel, that I added (IIRC).

At the time it was added, RH was the only company doing pkcs11 based
module signing, so I assumed it was a RH token.

> > 		ENGINE *e;
> >=20
> > 		e =3D ENGINE_by_id("pkcs11");
> > 		ERR(!e, "Load PKCS#11 ENGINE");
> > 		if (ENGINE_init(e))
> > 			ERR_clear_error();
> > 		else
> > 			ERR(1, "ENGINE_init");
> > 		if (key_pass)
> > 			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass,
> > 0),
> > 			    "Set PKCS#11 PIN");
> > 		private_key =3D ENGINE_load_private_key(e,
> > private_key_name,
> > 						      NULL, NULL);
> > 		ERR(!private_key, "%s", private_key_name);
> >=20
> > It uses an engine control command to load the key password not a
> > UI.=20
>=20
> James, that "PIN" ENGINE_ctrl is basically identical to what we need
> to do with your TPM2 engine to provide a parent key password (which
> your engine currently can't use a UI for =E2=98=B9). It's hardly a strang=
e
> and unusual concept.

OK, but this isn't the parent it's the key password, so what I think
you're saying is that all pkcs11 tokens can take either engine ctrl PIN
or a UI method to provide the password, so I can proceed with folding
the pkcs11 case into the UI engine path.  That's what I'll do.

James

--=-20MHwAfIi/Le+akvVCtu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCW8dmVgAKCRDnQslM7pis
hRQLAQDIshPuathVdz5t7BaWL224IiS57o6L8U6RysUoFoo4owD/XG9y093p+nY+
ds6O5Q2LqspRNDw/JDIy3WEZjLZcHVE=
=C3HN
-----END PGP SIGNATURE-----

--=-20MHwAfIi/Le+akvVCtu--
