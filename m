From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 12 Oct 2017 15:19:10 +0000
Subject: Re: [PATCH 2/3] crypto: dh_helper - return unsigned value for crypto_dh_key_len()
Message-Id: <20171012151909.GF31122@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
 <20170929092106.24276-2-tudor.ambarus@microchip.com>
In-Reply-To: <20170929092106.24276-2-tudor.ambarus@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

On Fri, Sep 29, 2017 at 12:21:05PM +0300, Tudor Ambarus wrote:
> DH_KPP_SECRET_MIN_SIZE and dh_data_size() are both returning
> unsigned values.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
