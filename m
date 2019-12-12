From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 12 Dec 2019 21:59:37 +0000
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <b4ff3607-076e-7b90-24d1-9a129d9ce720@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
 <20191211185116.2740-2-nramas@linux.microsoft.com>
 <1576138743.4579.147.camel@linux.ibm.com>
 <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
 <1576185189.4579.165.camel@linux.ibm.com>
In-Reply-To: <1576185189.4579.165.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/12/19 1:13 PM, Mimi Zohar wrote:

> 
> Looking at this again, something seems off or at least the comment
> doesn't match the code.
> 
>         /*
>           * To avoid holding the mutex while processing queued keys,
>           * transfer the queued keys with the mutex held to a temp list,
>           * release the mutex, and then process the queued keys from
>           * the temp list.
>           *
>           * Since ima_process_keys is set to true above, any new key will
>           * be processed immediately and not queued.
>           */
> 
> Setting ima_process_key before taking the lock won't prevent the race.
>   I think you want to test ima_process_keys before taking the lock and
> again immediately afterward taking the lock, before setting it.  Then
> the comment would match the code.
> 
> Shouldn't ima_process_keys be defined as static to limit the scope to
> this file?
> 
> Mimi
> 

In IMA hook, ima_process_key is checked without lock. If it is false, 
ima_queue_key is called. If the key was queued (by ima_queue_key()) then 
the hook defers measurement. Else, it processes it immediately.

In ima_queue_key() function the check for ima_process_key is done after 
taking the lock and the key queued if the flag is false.

In ima_process_keys() ima_process_key is set without lock and then the 
queued keys are moved to a temp list after taking the lock.

I have reviewed the changes myself and also with a few of my colleagues. 
I don't think there is a race condition. Please let me know if you do 
see a problem.

I can move the setting of ima_process_key flag inside the lock. But 
honestly I don't think that is necessary.

I agree that ima_process_keys should be static since it is used in this 
file one. I'll make that change.

I can also move the setting of ima_process_key flag inside the lock 
along with the above change.

thanks,
  -lakshmi
