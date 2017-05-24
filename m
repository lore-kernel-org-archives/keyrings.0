From: David Howells <dhowells@redhat.com>
Date: Wed, 24 May 2017 12:49:29 +0000
Subject: Re: [PATCH v2 10/11] crypto: KEYS: check err on akcipher maxsize
Message-Id: <21523.1495630169@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1495033238-26016-11-git-send-email-tudor.ambarus@microchip.com> <1495033238-26016-1-git-send-email-tudor.ambarus@microchip.com>
In-Reply-To: <1495033238-26016-11-git-send-email-tudor.ambarus@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, Nicolas.Ferre@microchip.com

Tudor Ambarus <tudor.ambarus@microchip.com> wrote:

> crypto_akcipher_maxsize() returns minimum length for output buffer
> or error code if key hasn't been set.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: David Howells <dhowells@redhat.com>
