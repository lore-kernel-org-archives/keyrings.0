From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 16 Dec 2019 06:53:07 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <1576479187.3784.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
In-Reply-To: <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Sun, 2019-12-15 at 17:12 -0800, Lakshmi Ramasubramanian wrote:
> On 12/15/2019 7:22 AM, James Bottomley wrote:
> 
> Hi James,
> 
> > 
> > This is the problem:
> > 
> > if (!flag)
> >      pre()
> > .
> > .
> > .
> > if (!flag)
> >      post()
> > 
> > And your pre and post function either have to both run or neither
> > must.
> >   However, the flag is set asynchronously, so if it gets set while
> > another thread is running through the above code, it can change
> > after
> > pre is run but before post is.
> > 
> > James
> 
> The pre() and post() functions you have referenced above including
> the 
> check for the flag are executed with the mutex held.
> 
> Please see Mimi's response to the v3 email. I have copied it below:
> 
> ************************************
> Reading the flag IS lock protected, just spread across two functions.
> For performance, ima_post_key_create_or_update() checks
> ima_process_keys, before calling ima_queue_key(), which takes the
> mutex before checking ima_process_keys again.
> 
> As long as both the reader and writer, take the mutex before checking
> the flag, the locking is fine.  The additional check, before taking
> the mutex, is simply for performance.
> ************************************
> 
> The flag is checked with the mutex held in the "reader" - 
> ima_queue_key(). The key is queued with the mutex held only if the
> flag 
> is false.
> 
> The flag is protected in the "writer" also -
> ima_process_queued_keys(). 
> The flag is checked with the mutex held, set to true, and queued
> keys 
> (if any) are transferred to the temp list.
> 
> As Mimi has pointed out the additional check of the flag, before
> taking 
> the mutex in ima_post_key_create_or_update() and in 
> ima_process_queued_keys(), is for performance reason.
> 
> If the flag is true, there is no need to take the mutex to check it 
> again in those functions.

That doesn't matter ... the question is, is the input assumption that
both pre/post have to be called or neither must correct?  If so, the
code is wrong, if not, explain why.

James
