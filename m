From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 19 Feb 2019 04:37:32 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-2-vt@altlinux.org>
 <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
 <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
In-Reply-To: <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
To: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:46:28PM +0300, Vitaly Chikunov wrote:
>
> >From the other point of view, set_params may never be called or
> implemented. So, making it called first and move memory zeroing
> into set_params may create more complications than simplicity.
> 
> Making both callbacks callable in any order also will not make
> things simpler. (Need to be prepared to be called in different
> order.)

How about encoding these parameters together with the public/private
keys so that they can be set through the existing setkey functions?

You might want to have a look at how we handle this in crypto/dh.c.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
