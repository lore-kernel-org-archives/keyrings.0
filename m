From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 25 Jan 2019 10:00:09 +0000
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public key algorithms
Message-Id: <20190125100009.i2ggpc7k7qvzayvj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190116164703.9267-1-vt@altlinux.org>
 <24887.1547658740@warthog.procyon.org.uk>
 <20190116182719.j6ii6nmn4ciiurqr@altlinux.org>
 <20190118204100.6o3ovctanb62nvd2@altlinux.org>
In-Reply-To: <20190118204100.6o3ovctanb62nvd2@altlinux.org>
To: David Howells <dhowells@redhat.com>, Tudor Ambarus <tudor-dan.ambarus@nxp.com>, "David S. Miller" <davem@davemloft.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Aymen Sghaier <aymen.sghaier@nxp.com>, Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, qat-linux@intel.com

On Fri, Jan 18, 2019 at 11:41:00PM +0300, Vitaly Chikunov wrote:
>
> a) RSA verify works differently (is it just disguised encrypt),
> b) We have separate wrapper module for it (pkcs1pad). Thus:
> 
> Old API can not be removed. In other words, we can not replace
> .verify_rsa with .verify in these drivers or PKCS1 will not work.
> 
> We can replace .verify_rsa with .verify in pkcs1pad, but there is no
> need for that if we stay with two API calls, which we can't avoid.

I think having two API calls during a transition period is fine.
But it must not be the long-term outcome.

In order to keep existing drivers working, I think we should make
the API wrap the legacy verify_rsa and implement verify directly
on top of it.  IOW the driver remains unchanged for now but the
crypto API code should provide a verify API that is implemented
on top of the driver's verify_rsa call.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
