From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 16 Mar 2018 12:21:29 +0000
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-Id: <20180316122129.GA2458@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520290344.10396.357.camel@linux.vnet.ibm.com>
In-Reply-To: <1520290344.10396.357.camel@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> Hi Jarrko,
>=20
> On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing=
 TPM
> > commands, migrate tpm2_probe() to use it.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>=20
> With this patch, the Pi doesn't find the TPM. =A0I'm seeing the
> following line in dmesg.
>=20
> [=A0=A0=A0=A01.087414] tpm_tis_spi: probe of spi0.0 failed with error 256

Thank you for reporting this Mimi. Does it have TPM1/TPM2?

/Jarkko
