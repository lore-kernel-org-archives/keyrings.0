From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 12 Oct 2017 15:19:03 +0000
Subject: Re: [PATCH 1/3] crypto: dh_helper - return unsigned int for dh_data_size()
Message-Id: <20171012151902.GE31122@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
In-Reply-To: <20170929092106.24276-1-tudor.ambarus@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

On Fri, Sep 29, 2017 at 12:21:04PM +0300, Tudor Ambarus wrote:
> p->key_size, p->p_size, p->g_size are all of unsigned int type.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
