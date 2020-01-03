From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 03 Jan 2020 15:08:19 +0000
Subject: Re: [PATCH v6 0/3] IMA: Deferred measurement of keys
Message-Id: <1578064099.5874.170.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200103055608.22491-1-nramas@linux.microsoft.com>
In-Reply-To: <20200103055608.22491-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi Lakshmi,

Instead of loosing the cover letter, Jonathan Corbet suggested
including it as the merge comment.  I'd like to do that with this
cover letter.

On Thu, 2020-01-02 at 21:56 -0800, Lakshmi Ramasubramanian wrote:
> This patchset extends the previous version[1] by adding support for
> deferred processing of keys.
> 
> With the patchset referenced above, the IMA subsystem supports
> measuring asymmetric keys when the key is created or updated.

The first sentence and the clause of the next sentence are
unnecessary.  I would begin the cover letter with "The IMA subsystem
supports" and add the reference afterwards.

> But keys created or updated before a custom IMA policy is loaded
> are currently not measured. This includes keys added to, for instance,
> .builtin_trusted_keys which happens early in the boot process.

Let's not limit the example to just the .builtin_trusted_keys keyring.
 Please update it as:

This includes keys added, for instance, to either the .ima or
.builtin_trusted_keys keyrings, which happens early in the boot
process.

> 
> This change adds support for queuing keys created or updated before
> a custom IMA policy is loaded. The queued keys are processed when
> a custom policy is loaded. Keys created or updated after a custom policy
> is loaded are measured immediately (not queued).
> 
> If the kernel is built with both CONFIG_IMA and
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> must be applied as a custom policy for the keys to be measured.
> If a custom IMA policy is not provided within 5 minutes after
> IMA is initialized, any queued keys will be freed.

As the merge message, this is too much information.  I would extend
the previous paragraph and drop this one, like:
"... (not queued).  In the case when a custom policy is not loaded
within 5 minutes of IMA initialization, the queued keys are freed."

> This is by design.

It's unclear what "is by design" refers to.  Perhaps expand this
sentence like: "Measuring the early boot keys, by design, requires
loading a custom policy.

> 
> [1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

thanks,

Mimi
