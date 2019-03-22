From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 22 Mar 2019 12:39:56 +0000
Subject: Re: [PATCH v7 00/11] crypto: add EC-RDSA (GOST 34.10) algorithm
Message-Id: <20190322123956.2zfdijje5wfajsyw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301175918.29694-1-vt@altlinux.org>
In-Reply-To: <20190301175918.29694-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 08:59:07PM +0300, Vitaly Chikunov wrote:
> This patchset changes akcipher API to support ECDSA style signature
> verification, augments x509 parser to make it work with EC-RDSA certificates,
> and, finally, implements EC-RDSA (GOST 34.10) signature verification and its
> integration with IMA.
> 
> This patchset should be applied over cryptodev commit 0918f18c7179e8cdf718d0.

I don't have any major issues with this patch-set (apart from the
minor issue with the crypto API).

However, as a number of patches are against areas outside of the
crypto API I would need to get acks for those patches from the
relevant maintainers.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
