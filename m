From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 28 Nov 2017 23:26:48 +0000
Subject: Re: [PATCH] crypto: rsa - fix buffer overread when stripping leading zeroes
Message-Id: <20171128232648.GB17611@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171127071649.25800-1-ebiggers3@gmail.com>
 <9913.1511866472@warthog.procyon.org.uk>
In-Reply-To: <9913.1511866472@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Alexander Potapenko <glider@google.com>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org, Tudor Ambarus <tudor-dan.ambarus@nxp.com>

On Tue, Nov 28, 2017 at 10:54:32AM +0000, David Howells wrote:
> Hi Herbert,
> 
> Are you going to take this?

Yes it's in my queue.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
