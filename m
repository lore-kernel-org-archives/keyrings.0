From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 13 Dec 2019 13:06:46 +0000
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576242406.4579.239.camel@linux.ibm.com>
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
In-Reply-To: <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2019-12-12 at 18:59 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/2019 6:32 PM, Mimi Zohar wrote:
> 
> >>>
> >>> Don't you need a test here, before setting ima_process_keys?
> >>>
> >>> 	if (ima_process_keys)
> >>> 		return;

> >> That check is done before the comment - at the start of
> >> ima_process_queued_keys().
> > 
> > The first test prevents taking the mutex unnecessarily.
> > 
> 
> I am trying to understand your concern here. Could you please clarify?
> 
>   => If ima_process_keys is false
>        -> With the mutex held, should check ima_process_keys again 
> before setting?
> 
> Let's say 2 or more threads are racing in calling ima_process_queued_keys():
> 
> The 1st one will set ima_process_keys and process queued keys.
> 
> The 2nd and subsequent ones - even if they have gone past the initial 
> check, will find an empty list of keys (the list "ima_keys") when they 
> take the mutex. So they'll not process any keys.

I just need to convince myself that this is correct.  Normally before
reading and writing a flag, there is some sort of locking.  With
taking the mutex before setting the flag, there is now only a lock
around the single writer.

Without taking a lock before reading the flag, will the queue always
be empty is the question.  If it is, then the comment is correct, but
the code assumes not and processes the list again.  Testing the flag
after taking the mutex just re-enforces the comment.

Bottom line, does reading the flag need to be lock protected?

Mimi
