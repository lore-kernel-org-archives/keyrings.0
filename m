From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 20 Feb 2018 22:34:32 +0000
Subject: Re: [PATCH 4/9] X.509: fix BUG_ON() when hash algorithm is unsupported
Message-Id: <20180220223432.GE70958@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180207011012.5928-5-ebiggers3@gmail.com>
 <20180207011012.5928-1-ebiggers3@gmail.com>
 <16536.1518102450@warthog.procyon.org.uk>
In-Reply-To: <16536.1518102450@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Eric Biggers <ebiggers@google.com>, Paolo Valente <paolo.valente@linaro.org>, stable@vger.kernel.org

Hi David,

On Thu, Feb 08, 2018 at 03:07:30PM +0000, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > The X.509 parser mishandles the case where the certificate's signature's
> > hash algorithm is not available in the crypto API.  In this case,
> > x509_get_sig_params() doesn't allocate the cert->sig->digest buffer; this
> > part seems to be intentional.
> 
> Well, yes, that would be intentional: we can't digest the digestibles without
> access to a hash algorithm to do so and we can't allocate a digest buffer
> without knowing how big it should be.
> 
> > Fix this by making public_key_verify_signature() return -ENOPKG if the
> > hash buffer has not been allocated.
> 
> Hmmm...  I'm not sure that this is the right place to do this, since it
> obscures a potential invalid argument within the kernel.
> 
> I'm more inclined that the users of X.509 certs should check
> x509->unsupported_sig (pkcs7_verify_sig_chain() does this already partially).
> 

Well, either way using BUG_ON() is inappropriate for recoverable problems where
an error code can be returned.  In this case we can simply indicate that the
signature verification failed.  Note that unprivileged users can reach this
BUG_ON(), and it also appears to be reachable in at least 3 different ways...
So it really has to be fixed.

And considering that the ->unsupported_sig and ->unsupported_key flags are
almost completely broken anyway, it sounds like there would have to be a second
patchset to actually fix them.  So I'd rather you just took the more important
fixes in patches 1-5 now as-is, and then a patchset to make certificates with
unsupported algorithms be accepted in more cases can be done separately.

Thanks,

Eric
