From: Vitaly Chikunov <vt@altlinux.org>
Date: Thu, 21 Mar 2019 11:42:10 +0000
Subject: Re: [PATCH v7 02/11] crypto: akcipher - check the presence of callback before the call
Message-Id: <20190321114209.qdaql3kdtfsnfzla@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301175918.29694-1-vt@altlinux.org>
 <20190301175918.29694-3-vt@altlinux.org>
 <20190321111918.4kr7vdgz23xzjwed@gondor.apana.org.au>
In-Reply-To: <20190321111918.4kr7vdgz23xzjwed@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Herbert,

On Thu, Mar 21, 2019 at 07:19:18PM +0800, Herbert Xu wrote:
> On Fri, Mar 01, 2019 at 08:59:09PM +0300, Vitaly Chikunov wrote:
> > Because with introduction of EC-RDSA and change in workings of RSA in
> > regard to sign/verify, akcipher could have not all callbacks defined,
> > check the presence of callbacks before calling them to increase
> > robustness.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  include/crypto/akcipher.h | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
> > index 2d690494568c..f537fad1989f 100644
> > --- a/include/crypto/akcipher.h
> > +++ b/include/crypto/akcipher.h
> > @@ -268,7 +268,10 @@ static inline unsigned int crypto_akcipher_maxsize(struct crypto_akcipher *tfm)
> >  {
> >  	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
> >  
> > -	return alg->max_size(tfm);
> > +	if (alg->max_size)
> > +		return alg->max_size(tfm);
> > +	else
> > +		return 0;
> >  }
> 
> Please do these checks at registration time instead and provide
> default implementations as needed.

I guess patch "PATCH v7 01/11] KEYS: report to keyctl only actually
supported key ops" should also be removed and will infer anything from
presence of the callbacks.


Thanks,


> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
