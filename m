From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 21 Mar 2019 12:11:24 +0000
Subject: Re: [PATCH v7 02/11] crypto: akcipher - check the presence of callback before the call
Message-Id: <20190321121124.lg4fjitsew5kpvq6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301175918.29694-1-vt@altlinux.org>
 <20190301175918.29694-3-vt@altlinux.org>
 <20190321111918.4kr7vdgz23xzjwed@gondor.apana.org.au>
 <20190321114209.qdaql3kdtfsnfzla@altlinux.org>
In-Reply-To: <20190321114209.qdaql3kdtfsnfzla@altlinux.org>
To: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:42:10PM +0300, Vitaly Chikunov wrote:
>
> I guess patch "PATCH v7 01/11] KEYS: report to keyctl only actually
> supported key ops" should also be removed and will infer anything from
> presence of the callbacks.

Indeed.  Especially if this is exposed to user-space then you
need to be careful changing the user-space API by clearing the
verify/sign bits for raw RSA.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
