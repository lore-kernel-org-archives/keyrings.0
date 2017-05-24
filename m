From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 24 May 2017 03:51:32 +0000
Subject: Re: [PATCH v2 08/11] crypto: testmgr - check err on akcipher maxsize
Message-Id: <20170524035132.GB21629@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
 <1495033238-26016-9-git-send-email-tudor.ambarus@microchip.com>
 <20170523040836.GD12788@gondor.apana.org.au>
 <dcec37d7-888f-4903-2aeb-b287b5d1042c@microchip.com>
In-Reply-To: <dcec37d7-888f-4903-2aeb-b287b5d1042c@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: davem@davemloft.net, dhowells@redhat.com, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com

On Tue, May 23, 2017 at 12:18:23PM +0300, Tudor Ambarus wrote:
> 
> As of now, this call is reached only after a successful setkey.
> If some user call it before setkey we will end up in a NULL dereference.
> I tend to keep the error checking.

I fail to see how this could be an issue in testmgr.

Please just kill these unnecessary checks.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
