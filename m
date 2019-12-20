From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 20 Dec 2019 12:53:06 +0000
Subject: Re: [PATCH v5 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576846386.5241.13.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
         <20191218164434.2877-2-nramas@linux.microsoft.com>
         <1576761104.4579.426.camel@linux.ibm.com>
         <503845c9-beeb-b520-ec3f-af5fa7d2b91f@linux.microsoft.com>
In-Reply-To: <503845c9-beeb-b520-ec3f-af5fa7d2b91f@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2019-12-19 at 08:55 -0800, Lakshmi Ramasubramanian wrote:
> I am not sure if the mutex can be removed.
> 
> In ima_queue_key() we need to test the flag and add the key to the list 
> as an atomic operation:
> 
>   if (!test_bit())
>      insert_key_to_list
> 
> Suppose the if condition is true, but before we could insert the key to 
> the list, ima_process_queued_keys() runs and processes queued keys we'll 
> add the key to the list and never process it.
> 
> Is there an API in the kernel to test and add an entry to a list 
> atomically?

Ok, using test_and_set_bit() and test_bit() only helps, if we can get
rid of the mutex.  I'll queue these patches.

thanks,

Mimi
