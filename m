From: Horia Geanta <horia.geanta@nxp.com>
Date: Fri, 22 Mar 2019 22:41:11 +0000
Subject: Re: [PATCH v7 03/11] crypto: rsa - unimplement sign/verify for raw RSA backends
Message-Id: <VI1PR0402MB34850609BF2BB886C029F0B398430@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190301175918.29694-1-vt@altlinux.org>
 <20190301175918.29694-4-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, "qat-linux@intel.com" <qat-linux@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, Aymen Sghaier <aymen.sghaier@nxp.com>

On 3/1/2019 7:59 PM, Vitaly Chikunov wrote:
> In preparation for new akcipher verify call remove sign/verify callbacks
> from RSA backends and make PKCS1 driver call encrypt/decrypt instead.
>=20
> This also complies with the well-known idea that raw RSA should never be
> used for sign/verify. It only should be used with proper padding scheme
> such as PKCS1 driver provides.
>=20
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: qat-linux@intel.com
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gary Hook <gary.hook@amd.com>
> Cc: Horia Geant=E3 <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>

Thanks,
Horia
