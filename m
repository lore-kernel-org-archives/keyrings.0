From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 16 Dec 2019 13:05:15 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <1576501515.4579.332.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
         <1576479187.3784.1.camel@HansenPartnership.com>
In-Reply-To: <1576479187.3784.1.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Mon, 2019-12-16 at 15:53 +0900, James Bottomley wrote:
> That doesn't matter ... the question is, is the input assumption that
> both pre/post have to be called or neither must correct?  If so, the
> code is wrong, if not, explain why.

Thanks, James, for looking at the locking.

"ima_process_keys" is set once.  Once it is set, the keys are measured
immediately.  For performance to avoid taking the mutex, both the
reader and writer check "ima_process_keys" twice, once without taking
the lock and, again, after taking the lock.  Based on the second test,
the reader queues the "key" or not.  Refer to ima_queue_key().

The latest patch version sets "ima_process_keys" after taking the
lock.  With this change, the comment in ima_process_queued_keys() is
now correct.  We're now guaranteed to process the queued "keys" just
once and not drop any "key" measurements.

I hope this answers your question.

Mimi
