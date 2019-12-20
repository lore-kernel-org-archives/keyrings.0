From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 20 Dec 2019 19:01:46 +0000
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
Message-Id: <1576868506.5241.65.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
In-Reply-To: <20191218164434.2877-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-12-18 at 08:44 -0800, Lakshmi Ramasubramanian wrote:
> This patchset extends the previous version[1] by adding support for
> deferred processing of keys.
> 
> With the patchset referenced above, the IMA subsystem supports
> measuring asymmetric keys when the key is created or updated.
> But keys created or updated before a custom IMA policy is loaded
> are currently not measured. This includes keys added to, for instance,
> .builtin_trusted_keys which happens early in the boot process.
> 
> This change adds support for queuing keys created or updated before
> a custom IMA policy is loaded. The queued keys are processed when
> a custom policy is loaded. Keys created or updated after a custom policy
> is loaded are measured immediately (not queued).
> 
> If the kernel is built with both CONFIG_IMA and
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> must be applied as a custom policy. Not providing a custom policy
> in the above configuration would result in asymmeteric keys being queued
> until a custom policy is loaded. This is by design.

I didn't notice the "This is by design" here, referring to the memory
never being freed.  "This is by design" was suppose to refer to
requiring a custom policy for measuring keys.

For now, these two patches are queued in the next-integrity-testing
branch, but I would appreciate your addressing not freeing the memory
associated with the keys, if a custom policy is not loaded.

Please note that I truncated the 2/2 patch description, as it repeats
the existing verification example in commit ("2b60c0ecedf8 IMA: Read
keyrings= option from the IMA policy").

thanks,

Mimi
