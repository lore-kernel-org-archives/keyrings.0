From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 20 Dec 2019 19:36:35 +0000
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
Message-Id: <1576870595.5241.83.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
         <1576868506.5241.65.camel@linux.ibm.com>
         <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
In-Reply-To: <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Fri, 2019-12-20 at 11:25 -0800, Lakshmi Ramasubramanian wrote:
> On 12/20/2019 11:01 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> >> If the kernel is built with both CONFIG_IMA and
> >> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> >> must be applied as a custom policy. Not providing a custom policy
> >> in the above configuration would result in asymmeteric keys being queued
> >> until a custom policy is loaded. This is by design.
> > 
> > I didn't notice the "This is by design" here, referring to the memory
> > never being freed.  "This is by design" was suppose to refer to
> > requiring a custom policy for measuring keys.
> > 
> > For now, these two patches are queued in the next-integrity-testing
> > branch, but I would appreciate your addressing not freeing the memory
> > associated with the keys, if a custom policy is not loaded.
> > 
> > Please note that I truncated the 2/2 patch description, as it repeats
> > the existing verification example in commit ("2b60c0ecedf8 IMA: Read
> > keyrings= option from the IMA policy").
> > 
> > thanks,
> > 
> > Mimi
> > 
> 
> Sure - I am fine with truncating the 2/2 patch description. Thanks for 
> doing that.
> 
> Regarding "Freeing the queued keys if custom policy is not loaded":
> 
> Shall I create a new patch set to address that and have that be reviewed 
> independent of this patch set?

If it is just a single additional patch, feel free to post it without
a cover letter.

> 
> Like you'd suggested earlier, we can wait for a certain time, after IMA 
> is initialized, and free the queue if a custom policy was not loaded.

Different types of systems vary in boot time, but perhaps a certain
amount of time after IMA is initialized would be consistent.  This
would need to work for IoT devices/sensors to servers.

Mimi 
