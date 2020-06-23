From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 23 Jun 2020 17:02:17 +0000
Subject: Re: LTP: crypto: af_alg02 regression on linux-next 20200621 tag
Message-Id: <20200623170217.GB150582@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
 <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
 <20200623064056.GA8121@gondor.apana.org.au>
In-Reply-To: <20200623064056.GA8121@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>, LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, lkft-triage@lists.linaro.org, linux-crypto@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>, "Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Jun 23, 2020 at 04:40:56PM +1000, Herbert Xu wrote:
> On Tue, Jun 23, 2020 at 11:53:43AM +0530, Naresh Kamboju wrote:
> >
> > Thanks for the investigation.
> > After reverting, two test cases got PASS out of four reported failure cases.
> >  ltp-crypto-tests:
> >      * af_alg02 - still failing - Hung and time out
> >      * af_alg05 - still failing - Hung and time out
> >   ltp-syscalls-tests:
> >      * keyctl07 - PASS
> >      * request_key03 - PASS
> > 
> > Please suggest the way to debug / fix the af_alg02 and af_alg05 failures.
> 
> Did you clear the MSG_MORE flag in the final send(2) call before
> you call recv(2)?
> 

The source code for the two failing AF_ALG tests is here:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg05.c

They use read() and write(), not send() and recv().

af_alg02 uses read() to read from a "salsa20" request socket without writing
anything to it.  It is expected that this returns 0, i.e. that behaves like
encrypting an empty message.

af_alg05 uses write() to write 15 bytes to a "cbc(aes-generic)" request socket,
then read() to read 15 bytes.  It is expected that this fails with EINVAL, since
the length is not aligned to the AES block size (16 bytes).

- Eric
