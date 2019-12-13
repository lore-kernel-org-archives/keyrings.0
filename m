From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 13 Dec 2019 15:51:37 +0000
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <9938ff03-5cf2-5396-1172-5734cc10819e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
 <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
 <1576204377.4579.206.camel@linux.ibm.com>
 <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
 <1576242406.4579.239.camel@linux.ibm.com>
In-Reply-To: <1576242406.4579.239.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/13/19 5:06 AM, Mimi Zohar wrote:

> I just need to convince myself that this is correct.  Normally before
> reading and writing a flag, there is some sort of locking.  With
> taking the mutex before setting the flag, there is now only a lock
> around the single writer.
> 
> Without taking a lock before reading the flag, will the queue always
> be empty is the question.  If it is, then the comment is correct, but
> the code assumes not and processes the list again.  Testing the flag
> after taking the mutex just re-enforces the comment.
> 
> Bottom line, does reading the flag need to be lock protected?
> 
> Mimi
> 

I'll change this function to check the flag again after taking the lock 
and process only if the queue has entries. Will send an update today.

Please let me know if you have any concern in other functions in this 
file. I'll address them, if any, in today's update.

thanks,
  -lakshmi
