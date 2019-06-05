From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Wed, 05 Jun 2019 10:19:28 +0000
Subject: Re: [PATCH v2 15/22] docs: security: core.rst: Fix several warnings
Message-Id: <20190605071928.704558cf@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <21350864823e07cc951e1dc7f0601baa09920ac4.1559656538.git.mchehab+samsung@kernel.org>
        <cover.1559656538.git.mchehab+samsung@kernel.org>
        <26617.1559728436@warthog.procyon.org.uk>
In-Reply-To: <26617.1559728436@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, keyrings@vger.kernel.org

Em Wed, 05 Jun 2019 10:53:56 +0100
David Howells <dhowells@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > +  *  ``asym_eds_op`` and ``asym_verify_signature``::
> > +
> > +       int (*asym_eds_op)(struct kernel_pkey_params *params,
> > +			  const void *in, void *out);
> > +       int (*asym_verify_signature)(struct kernel_pkey_params *params,
> > +				    const void *in, const void *in2);  
> 
> That's redundant and shouldn't be necessary.

This should equally fix it:

  * ::

       int (*asym_eds_op)(struct kernel_pkey_params *params,
			  const void *in, void *out);
       int (*asym_verify_signature)(struct kernel_pkey_params *params,
				    const void *in, const void *in2);  

The thing is that we need to teach Sphinx somehow that it should not
try to interpret '*' (with is used there to identify bold/italy blocks)

Using a '::' seems better than escaping all asterisks with a backslash.


Thanks,
Mauro
