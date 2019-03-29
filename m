From: jlee@suse.com
Date: Fri, 29 Mar 2019 17:47:07 +0000
Subject: Re: [PATCH] X.509: Add messages for obsolete OIDs
Message-Id: <20190329174707.GC3701@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190322062738.19852-1-jlee@suse.com>
 <1553715364.4608.36.camel@linux.ibm.com>
In-Reply-To: <1553715364.4608.36.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mimi,

On Wed, Mar 27, 2019 at 03:36:04PM -0400, Mimi Zohar wrote:
> On Fri, 2019-03-22 at 14:27 +0800, Lee, Chun-Yi wrote:
> > We found that the db in Acer machine has self signed certificates
> > (CN=3DDisablePW or CN=ABO) that they used obsolete OID 1.3.14.3.2.29
> > sha1WithRSASignature and 2.5.29.1 subjectKeyIdentifier. Kernel
> > emits -65 error code when loading those certificates to platform
> > keyring:
> >=20
> > [    1.484388] integrity: Loading X.509 certificate: UEFI:MokListRT
> > [    1.485557] integrity: Problem loading X.509 certificate -65
> > [    1.486100] Error adding keys to platform keyring UEFI:MokListRT
> >=20
> > Because the -65 error code is not enough for appeasing user when
> > loading a outdated certificate. This patch add messages against
> > 1.3.14.3.2.29 and 2.5.29.1 OIDs.
> >=20
> > Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1129471
> > Cc: David Howells <dhowells@redhat.com>=20
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>=20
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
>=20
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for your review!

Joey Lee
