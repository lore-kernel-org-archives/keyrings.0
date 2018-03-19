From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 19 Mar 2018 14:42:05 +0000
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-Id: <20180319144205.GA4619@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520290344.10396.357.camel@linux.vnet.ibm.com>
 <20180316122129.GA2458@linux.intel.com>
 <1521203812.3503.19.camel@linux.vnet.ibm.com>
In-Reply-To: <1521203812.3503.19.camel@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Fri, Mar 16, 2018 at 08:36:52AM -0400, Mimi Zohar wrote:
> On Fri, 2018-03-16 at 14:21 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> > > Hi Jarrko,
> > >=20
> > > On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > > > In order to make struct tpm_buf the first class object for construc=
ting TPM
> > > > commands, migrate tpm2_probe() to use it.
> > > >=20
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >=20
> > > With this patch, the Pi doesn't find the TPM. =A0I'm seeing the
> > > following line in dmesg.
> > >=20
> > > [=A0=A0=A0=A01.087414] tpm_tis_spi: probe of spi0.0 failed with error=
 256
> >=20
> > Thank you for reporting this Mimi. Does it have TPM1/TPM2?
>=20
> The pi has a TPM 2.0 attached to the GPIO. =A0James pointed out the
> change in return codes.
>=20
>=20
> +       if (be16_to_cpu(out->tag) =3D TPM2_ST_NO_SESSIONS)
>                 chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> -
> -       return 0;
> +out:
> +       tpm_buf_destroy(&buf);
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
>=20
> Mimi

Oops, thank you James and Mimi for pointing this out. I'll refine
the patch set.

/Jarkko
