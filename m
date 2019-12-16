From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 16 Dec 2019 21:37:11 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
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
 <1576479187.3784.1.camel@HansenPartnership.com>
 <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
 <1576531022.3365.6.camel@HansenPartnership.com>
In-Reply-To: <1576531022.3365.6.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org


On 12/16/2019 1:17 PM, James Bottomley wrote:
> On Mon, 2019-12-16 at 11:20 -0800, Lakshmi Ramasubramanian wrote:
>>    => If the flag is false, mutex is taken and the flag is checked
>> again. If the flag changed from false to true between the above two
>> tests, that means another thread had raced to call
>> ima_process_queued_keys() and has  processed the queued keys. So
>> again, no further action is required.
> 
> This is the problem: in the race case you may still be adding keys to
> the queue after the other thread has processed it. Those keys won't get
> processed because the flag is now false in the post check so the
> current thread won't process them either.
> 
> James
> 

I am not sure how a key could get added to the queue after another 
thread has processed the queued keys.

The flag changes from false to true only once - in 
ima_process_queued_keys(). This change is done under the lock. The 
thread that makes this change will process all the queued keys.

Once the above change is done, ima_process_keys flag will never become 
false again.

Another thread that is trying to queue the key will wait on the mutex - 
in ima_queue_key(). If this thread finds the flag is true after taking 
the mutex, it will NOT queue the key.

Please see my explanation below:


"READER" functions: ima_post_key_create_or_update() and ima_queue_key()
***********************************************************************
In ima_post_key_create_or_update() the flag is checked first without the 
mutex taken:

  => If the flag is true, then there is no need to queue the key and it 
can be processed immediately.

     This condition means that either queued keys have already been 
processed OR there is another thread in the middle of processing queued 
keys. In both these conditions, the new key should NOT be queued, but 
processed immediately.

  => If the flag is false, ima_queue_key() is called. In this function, 
the mutex is taken and flag checked again.

Say, the flag changed from false to true at this point, the key will NOT 
be queued. ima_queue_key() will return false and in response 
ima_post_key_create_or_update() will process the key immediately.

But if the flag is still false, the key will be queued by 
ima_queue_key() and will be processed later.
