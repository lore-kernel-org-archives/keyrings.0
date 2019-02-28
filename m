From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 28 Feb 2019 06:14:44 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190228061444.3escryzoit3idtwg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-2-vt@altlinux.org>
 <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
 <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
 <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
 <20190224064840.hii4ccjksjdnewae@altlinux.org>
In-Reply-To: <20190224064840.hii4ccjksjdnewae@altlinux.org>
To: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:48:40AM +0300, Vitaly Chikunov wrote:
> 
> If we pass SubjectPublicKeyInfo into set_pub_key itself (making
> set_params not needed) we will break ABI and compatibility with RSA
> drivers, because whole SubjectPublicKeyInfo is not expected by the

This compatibility does not matter.  We can always add translating
layers into the crypto API to deal with this.  The only ABI that
matters is the one to user-space.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
