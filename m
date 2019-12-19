From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 19 Dec 2019 16:55:38 +0000
Subject: Re: [PATCH v5 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <503845c9-beeb-b520-ec3f-af5fa7d2b91f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
 <20191218164434.2877-2-nramas@linux.microsoft.com>
 <1576761104.4579.426.camel@linux.ibm.com>
In-Reply-To: <1576761104.4579.426.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/19/19 5:11 AM, Mimi Zohar wrote:

> 
> Getting rid of the temporary list is definitely a big improvement.  As
> James suggested, using test_and_set_bit() and test_bit() would improve
> this code even more.  I think, James correct me if I'm wrong, you
> would be able to get rid of both the mutex and "process".
> 
> Mimi

I am not sure if the mutex can be removed.

In ima_queue_key() we need to test the flag and add the key to the list 
as an atomic operation:

  if (!test_bit())
     insert_key_to_list

Suppose the if condition is true, but before we could insert the key to 
the list, ima_process_queued_keys() runs and processes queued keys we'll 
add the key to the list and never process it.

Is there an API in the kernel to test and add an entry to a list 
atomically?

thanks,
  -lakshmi
