From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 23 Jun 2020 06:40:56 +0000
Subject: Re: LTP: crypto: af_alg02 regression on linux-next 20200621 tag
Message-Id: <20200623064056.GA8121@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
 <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, lkft-triage@lists.linaro.org, linux-crypto@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>, "Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>

On Tue, Jun 23, 2020 at 11:53:43AM +0530, Naresh Kamboju wrote:
>
> Thanks for the investigation.
> After reverting, two test cases got PASS out of four reported failure cases.
>  ltp-crypto-tests:
>      * af_alg02 - still failing - Hung and time out
>      * af_alg05 - still failing - Hung and time out
>   ltp-syscalls-tests:
>      * keyctl07 - PASS
>      * request_key03 - PASS
> 
> Please suggest the way to debug / fix the af_alg02 and af_alg05 failures.

Did you clear the MSG_MORE flag in the final send(2) call before
you call recv(2)?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
