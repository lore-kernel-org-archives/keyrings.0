From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 05 Mar 2018 11:11:07 +0000
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-Id: <20180305111107.GH25377@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
 <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
In-Reply-To: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
To: J Freyensee <why2jjj.linux@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Mar 01, 2018 at 02:10:17PM -0800, J Freyensee wrote:
> .
> .
> .
> I'm new to this area of the kernel, but I'm not getting these lines:
>=20
> > +	rc =3D tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> > +	tpm_buf_destroy(&buf);
> >   	if (rc <  0)
> Why is this if() check not directly after the tpm_transmit_cmd() call that
> sets rc?=A0 Is it correct you want to destroy buf regardless of the
> tpm_transmit_cmd() outcome?
> >   		return rc;
> > -
> > -	if (be16_to_cpu(cmd.header.out.tag) =3D TPM2_ST_NO_SESSIONS)
> > +	out =3D (struct tpm_output_header *)buf.data;
>=20
> So buf has been destroyed, buf.data sill has something valid to assign to
> out?
> > +	if (be16_to_cpu(out->tag) =3D TPM2_ST_NO_SESSIONS)
> >   		chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> >   	return 0;
> Thanks,
> Jay

Nope it is a regression in the patch. Thank you :-) tpm_buf_destroy()
can be called if the response data is not needed other than everything
went OK (tpm_transmit_cmd() already digs this info).

/Jarkko
