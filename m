From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 25 Jan 2019 13:46:14 +0000
Subject: Re: [RFC PATCH v3] akcipher: Introduce verify_rsa/verify for public key algorithms
Message-Id: <20190125134614.jflpiybs2b5ezbha@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118205846.20309-1-vt@altlinux.org>
 <20190125100929.zxmqbsibnnikh7tv@gondor.apana.org.au>
 <20190125111808.slyoptlns53t7fiw@altlinux.org>
In-Reply-To: <20190125111808.slyoptlns53t7fiw@altlinux.org>
To: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 02:18:09PM +0300, Vitaly Chikunov wrote:
> 
> Well, if we allowed to reuse dst* fields why not just put digest over
> dst scatterlist? That would be much simpler.

Please see below.
 
> > The advantage of having it in one scatterlist is that for those
> > users that already have the two pieces together could simply provide
> > a single SG element (I don't know how likely that is in practice
> > though).
> > 
> > For others you would simply tack on an extra SG element.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
