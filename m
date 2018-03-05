From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 05 Mar 2018 11:23:34 +0000
Subject: Re: [PATCH 1/5] tpm: Trigger only missing TPM 2.0 self tests
Message-Id: <20180305112334.GI25377@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
 <1520107919.3105.9.camel@HansenPartnership.com>
In-Reply-To: <1520107919.3105.9.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Alexander Steffen <Alexander.Steffen@infineon.com>, stable@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Sat, Mar 03, 2018 at 12:11:59PM -0800, James Bottomley wrote:
> I still think removing all logging traces is a mistake for something
> that can consume a significant amount of time in the boot sequence.
> =A0It's going to cause lost of people doing boot timings to waste lots of
> effort.
>=20
> However, removing the log messages makes the above statement a lie, so
> one of the two needs fixing.

The commit itself makes sense but the implementation was sloppy to say
the least in v3. It was like prototype/PoC version of something that
could be merged to mainline, not something that can be merged to
mainline.

For example:

* You could have implemented it more cleanly without that new
  'tpm_transmit_check' helper function as can be seen.
* Many log messages contained a redundant "TPM:" prefix.
* There duplicate logs to tpm_transmit_cmd(). Pass a NULL as
  desc tpm_transmit_cmd() if you want to take care of logging
  yourself.
* The commit has the same short summary as the commit it fixes.
  This issue still persists. Open for suggestions.

Please state if v3 contains a log message that has been removed and is
still mandatory and I can add it if it makes sense.

> > +		rc =3D tpm_transmit_cmd(chip, NULL, buf.data,
> > PAGE_SIZE, 0, 0,
> > +				=A0=A0=A0=A0=A0=A0"attempting the self test\n");
>=20
> There shouldn't be a \n in the string: the failure message already
> appends one.

Oops, my bad, will fix it.

/Jarkko
