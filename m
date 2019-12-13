From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 13 Dec 2019 17:31:45 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-3-nramas@linux.microsoft.com>
 <1576257955.8504.20.camel@HansenPartnership.com>
In-Reply-To: <1576257955.8504.20.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/13/19 9:25 AM, James Bottomley wrote:

Hi James,

> 
> There's no locking around the ima_process_keys flag.  If you get two
> policy updates in quick succession can't this flag change as you're
> processing the second update meaning you lose it because the flag was
> false when you decided to build it for the queue but becomes true
> before you check above whether you need to queue it?
> 
> Note you don't need locking to fix this, you just need to ensure that
> you use the same copy of the flag value for both tests.
> 
> James
> 

Same flag (ima_process_keys) is used for making the queuing decision.

Taking a lock to access ima_process_keys is required only if the flag is 
false. That is handled in ima_queue_key() and ima_process_queued_keys() 
functions.

Queued keys are processed when the first policy update occurs. 
Subsequently, the keys are processed immediately (not queued).

Could you please review those functions in this patch and let me know if 
you see a problem?

thanks,
  -lakshmi
