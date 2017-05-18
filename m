From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 18 May 2017 05:09:34 +0000
Subject: Re: [PATCH 2/4] crypto: drbg wait for crypto op not signal safe
Message-Id: <20170518050933.GA32409@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1494503626-15877-1-git-send-email-gilad@benyossef.com>
 <1494503626-15877-3-git-send-email-gilad@benyossef.com>
In-Reply-To: <1494503626-15877-3-git-send-email-gilad@benyossef.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, Ofir Drang <ofir.drang@arm.com>, Gilad Ben-Yossef <gilad.benyossef@arm.com>, Eric Biggers <ebiggers3@gmail.com>, stable@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, May 11, 2017 at 02:53:43PM +0300, Gilad Ben-Yossef wrote:
> drbg_kcapi_sym_ctr() was using wait_for_completion_interruptible() to
> wait for completion of async crypto op but if a signal occurs it
> may return before DMA ops of HW crypto provider finish, thus
> corrupting the output buffer.
> 
> Resolve this by using wait_for_completion() instead.
> 
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> CC: stable@vger.kernel.org

This patch doesn't even compile.  Please test your work first.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
