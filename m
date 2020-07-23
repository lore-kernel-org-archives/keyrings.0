From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Jul 2020 07:42:25 +0000
Subject: Re: [PATCH] keys: asymmetric: fix error return code in software_key_query()
Message-Id: <1269137.1595490145@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200723013223.GA45081@linux.intel.com> <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
In-Reply-To: <20200723013223.GA45081@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Wei Yongjun <weiyongjun1@huawei.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Why f1774cb8956a lacked any possible testing? It extends ABI anyway.
> 
> I think it is a kind of change that would require more screening before
> getting applied.

Yeah.  It went in via a round-about route.  I left off development of it when
the tpm stuff I wrote broke because the tpm2 stuff went in upstream.  I then
handed the patches off to Denis who did the tpm support, but I never got my
stuff finished enough to work out how to do the testsuite (since it would
involve using a tpm).  However, since I did the PKCS#8 testing module as well,
I guess I don't need that to at least test the API.  I'll look at using that
to add some tests.  Any suggestions as to how to do testing via the tpm?

David
