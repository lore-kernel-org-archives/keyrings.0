From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 08 Oct 2020 05:43:57 +0000
Subject: Re: [PATCH] X.509: fix error return value on the failed path
Message-Id: <20201008054357.GC9733@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201005144628.83875-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20201005144628.83875-1-tianjia.zhang@linux.alibaba.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gilad Ben-Yossef <gilad@benyossef.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 10:46:28PM +0800, Tianjia Zhang wrote:
> When memory allocation fails, an appropriate return value
> should be set.
> 
> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/public_key_sm2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
