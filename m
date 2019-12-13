From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 13 Dec 2019 02:59:39 +0000
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
 <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
 <1576204377.4579.206.camel@linux.ibm.com>
In-Reply-To: <1576204377.4579.206.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/12/2019 6:32 PM, Mimi Zohar wrote:

>>>
>>> Don't you need a test here, before setting ima_process_keys?
>>>
>>> 	if (ima_process_keys)
>>> 		return;
>>>
>>> Mimi
>>
>> That check is done before the comment - at the start of
>> ima_process_queued_keys().
> 
> The first test prevents taking the mutex unnecessarily.
> 
> Mimi

I am trying to understand your concern here. Could you please clarify?

  => If ima_process_keys is false
       -> With the mutex held, should check ima_process_keys again 
before setting?

Let's say 2 or more threads are racing in calling ima_process_queued_keys():

The 1st one will set ima_process_keys and process queued keys.

The 2nd and subsequent ones - even if they have gone past the initial 
check, will find an empty list of keys (the list "ima_keys") when they 
take the mutex. So they'll not process any keys.

thanks,
  -lakshmi
