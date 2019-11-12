From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 12 Nov 2019 17:08:46 +0000
Subject: Re: [PATCH v5 0/10] KEYS: Measure keys when they are created or updated
Message-Id: <1573578526.17949.47.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
In-Reply-To: <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 11:41 -0800, Lakshmi Ramasubramanian wrote:
> On 11/11/2019 11:32 AM, Lakshmi Ramasubramanian wrote:
> 
> Hi Mimi,
> 
> > Problem Statement:

The above line isn't needed.

> > 
> > Keys created or updated in the system are currently not being measured.
> > 
> > This change aims to address measuring keys created or updated
> > in the system:
> > 
> >    => Patches #1 through #5 update IMA policy functions to handle
> >       measurement of keys based on configured IMA policy.
> > 
> >    => Patches #6 and #7 add IMA hook for measuring keys and the call
> >       to the IMA hook from key_create_or_update function.
> >       Keys are processed immediately - no support for
> >       deferred processing.
> > 
> >    => Patches #8 through #10 add support for queuing keys if
> >       custom IMA policies have not been applied yet and process
> >       the queued keys when custom IMA policies are applied.
> 
> I was wondering if it'd be better to split this patch set into two sets:
> 
> 1st set including the patches for measuring keys without queuing support 
> (Patches #1 through #7)

I've commented on patches 1 - 4.  There's still so much wrong with
this patch set.  Limiting the scope of the patch set sounds like
really a good idea. 

Mimi

> 
> 2nd set including the patches that add queuing support (Patches #8 
> through #10).
