From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 30 Nov 2018 23:46:46 +0000
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-Id: <20181130234646.GB3792@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
 <20181106164603.w46wspmdj5e4slwe@cantor>
 <1541528254.8568.48.camel@linux.ibm.com>
 <20181130234507.GA3792@linux.intel.com>
In-Reply-To: <20181130234507.GA3792@linux.intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:45:07PM -0800, Jarkko Sakkinen wrote:
> On Tue, Nov 06, 2018 at 01:17:34PM -0500, Mimi Zohar wrote:
> > On Tue, 2018-11-06 at 09:46 -0700, Jerry Snitselaar wrote:
> > > On Fri Oct 19 18, Stefan Berger wrote:
> > > >Extend the documentation for trusted keys with documentation for how=
 to
> > > >set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
> > > >
> > > >Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > >=20
> > > Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >=20
> > Thanks! =A0This patch is now staged in the #next-integrity-queued
> > branch.
> >=20
> > Mimi
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Brings to mind, in the long run where the backend code for trusted keys
should reside.

/Jarkko
