From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Jul 2020 07:31:23 +0000
Subject: Re: [PATCH] keys: asymmetric: fix error return code in software_key_query()
Message-Id: <1267853.1595489483@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200723013223.GA45081@linux.intel.com> <159485211858.2340757.9890754969922775496.stgit@warthog.procyon.org.uk>
In-Reply-To: <20200723013223.GA45081@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Wei Yongjun <weiyongjun1@huawei.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

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

I agree, but we have some people who will (or who used to) moan at you for
doing in four lines what you could've done in three.  I don't know if this is
still the standard.

David
