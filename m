From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 15 Nov 2017 21:12:46 +0000
Subject: Re: Draft manpage explaining kernel lockdown
Message-Id: <20171115211246.GF6183@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BzCohdixPhurzSK4"
List-Id: <keyrings.vger.kernel.org>
References: <7969.1507201224@warthog.procyon.org.uk>
In-Reply-To: <7969.1507201224-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Attached is a draft for a manual page (kernel_lockdown.7) that I intend to
> point at from messages emitted when the kernel prohibits something becaus=
e the
> kernel is in 'lockdown' mode, typically triggered by EFI secure
> boot.

What about livepatching? It allows kernel modifications.. and it has
some interestlingly insecure /sys controls being merged just now...

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMrc4ACgkQMOfwapXb+vKKUwCdEPbzuQ1Vu/ZnRIJJ/5GYsCxR
71oAn1YjfT8qBEhk2vvdlalbdg40uxkc
=mAAp
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
