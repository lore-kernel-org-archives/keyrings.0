From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 24 Jul 2020 07:16:34 +0000
Subject: Re: [PATCH] keys: asymmetric: fix error return code in software_key_query()
Message-Id: <20200724071634.GA1872662@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200723013223.GA45081@linux.intel.com>
 <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
 <1269137.1595490145@warthog.procyon.org.uk>
In-Reply-To: <1269137.1595490145@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, Wei Yongjun <weiyongjun1@huawei.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:42:25AM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Why f1774cb8956a lacked any possible testing? It extends ABI anyway.
> > 
> > I think it is a kind of change that would require more screening before
> > getting applied.
> 
> Yeah.  It went in via a round-about route.  I left off development of it when
> the tpm stuff I wrote broke because the tpm2 stuff went in upstream.  I then
> handed the patches off to Denis who did the tpm support, but I never got my
> stuff finished enough to work out how to do the testsuite (since it would
> involve using a tpm).  However, since I did the PKCS#8 testing module as well,
> I guess I don't need that to at least test the API.  I'll look at using that
> to add some tests.  Any suggestions as to how to do testing via the tpm?
> 
> David

The unfortunate thing is that I was not involved with asym_tpm.c review
process in any possible way, which means that at the moment I lack both:

1. Knowledge of crypto/asymmetric_keys.
2. How asym_tpm.c is implemented.

I only became aware of asym_tpm.c's existence last Sep [*].

I'll put to my backlog to try TPM asymmetric keys (earliest when I'm back
from vacation 08/10).

[*] https://lore.kernel.org/linux-integrity/20190926171601.30404-1-jarkko.sakkinen@linux.intel.com/

/Jarkko
