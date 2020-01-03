From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 03 Jan 2020 15:47:54 +0000
Subject: Re: [PATCH v6 0/3] IMA: Deferred measurement of keys
Message-Id: <1578066474.5874.174.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200103055608.22491-1-nramas@linux.microsoft.com>
         <1578064099.5874.170.camel@linux.ibm.com>
In-Reply-To: <1578064099.5874.170.camel@linux.ibm.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Fri, 2020-01-03 at 10:08 -0500, Mimi Zohar wrote:
> > This change adds support for queuing keys created or updated before
> > a custom IMA policy is loaded. The queued keys are processed when
> > a custom policy is loaded. Keys created or updated after a custom policy
> > is loaded are measured immediately (not queued).
> > 
> > If the kernel is built with both CONFIG_IMA and
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> > must be applied as a custom policy for the keys to be measured.
> > If a custom IMA policy is not provided within 5 minutes after
> > IMA is initialized, any queued keys will be freed.
> 
> As the merge message, this is too much information.  I would extend
> the previous paragraph and drop this one, like:
> "... (not queued).  In the case when a custom policy is not loaded
> within 5 minutes of IMA initialization, the queued keys are freed."
> 
> > This is by design.
> 
> It's unclear what "is by design" refers to.  Perhaps expand this
> sentence like: "Measuring the early boot keys, by design, requires
> loading a custom policy.

Instead of including this comment as the last sentence of the cover
letter, it would make a good opening sentence for the second
paragraph.

Mimi
