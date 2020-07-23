From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 23 Jul 2020 01:36:22 +0000
Subject: Re: [PATCH] keys: asymmetric: fix error return code in software_key_query()
Message-Id: <20200723013622.GB45081@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
 <20200723013223.GA45081@linux.intel.com>
In-Reply-To: <20200723013223.GA45081@linux.intel.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, Wei Yongjun <weiyongjun1@huawei.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:32:38AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 15, 2020 at 11:28:38PM +0100, David Howells wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > Fix to return negative error code -ENOMEM from kmalloc() error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Fixes: f1774cb8956a ("X.509: parse public key parameters from x509 for akcipher")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> 
> Why f1774cb8956a lacked any possible testing? It extends ABI anyway.
> 
> I think it is a kind of change that would require more screening before
> getting applied.
> 
> > ---
> > 
> >  crypto/asymmetric_keys/public_key.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> > index d7f43d4ea925..e5fae4e838c0 100644
> > --- a/crypto/asymmetric_keys/public_key.c
> > +++ b/crypto/asymmetric_keys/public_key.c
> > @@ -119,6 +119,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
> >  	if (IS_ERR(tfm))
> >  		return PTR_ERR(tfm);
> >  
> > +	ret = -ENOMEM;
> 
> This is extremely confusing to read way to handle 'ret'.
> 
> Would be way more cleaner to be just simple and stupid:
> 
> 	if (!key) {
> 		ret = -ENOMEM;
> 		goto error_free_tfm;
> 	}

To rationalize why the 2nd way is better: the diff would tell the
whole story. Now this commit requires to check *both* the diff and
the source file to get the full understanding what is going on.

/Jarkko
