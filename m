From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 10 Jun 2017 04:18:20 +0000
Subject: Re: [PATCH v2] X.509: Fix error code in x509_cert_parse()
Message-Id: <20170610041820.GH14719@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <4045.1495558143@warthog.procyon.org.uk>
 <20170529132622.6tapug7i7aqmvnqz@mwanda>
In-Reply-To: <20170529132622.6tapug7i7aqmvnqz@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, May 29, 2017 at 04:26:22PM +0300, Dan Carpenter wrote:
> We forgot to set the error code on this path so it could result in
> returning NULL which leads to a NULL dereference.
> 
> Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2:  Style change

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
