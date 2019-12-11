From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 11 Dec 2019 17:12:22 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <20191211171222.GA4516@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
 <1575260220.4080.17.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
 <1575267453.4080.26.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
 <1575269075.4080.31.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
 <1575312932.24227.13.camel@linux.ibm.com>
 <20191209194715.GD19243@linux.intel.com>
 <1575926334.4557.17.camel@linux.ibm.com>
In-Reply-To: <1575926334.4557.17.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>, "Zhao, Shirley" <shirley.zhao@intel.com>, Jonathan Corbet <corbet@lwn.net>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Chen, Luhai" <luhai.chen@intel.com>

On Mon, Dec 09, 2019 at 04:18:54PM -0500, Mimi Zohar wrote:
> On Mon, 2019-12-09 at 21:47 +0200, Jarkko Sakkinen wrote:
> > On Mon, Dec 02, 2019 at 10:55:32AM -0800, James Bottomley wrote:
> > > blob but it looks like we need to fix the API.  I suppose the good ne=
ws
> > > is given this failure that we have the opportunity to rewrite the API
> > > since no-one else can have used it for anything because of this.  The
> >=20
> > I did successfully run this test when I wrote it 5 years ago:
> >=20
> > https://github.com/jsakkine-intel/tpm2-scripts/blob/master/keyctl-smoke=
.sh
>=20
> Thanks, Jarkko. =A0Is this test still working or is there a regression?

I will run it and in addition to that I will make a patch out of it.

Any suggestions for the script name (should probably have 'tpm2' in
it at least)?

/Jarkko
