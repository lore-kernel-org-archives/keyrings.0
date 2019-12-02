From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 02 Dec 2019 18:39:25 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-2-nramas@linux.microsoft.com>
 <1574887137.4793.346.camel@linux.ibm.com>
 <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
 <1575309622.4793.413.camel@linux.ibm.com>
In-Reply-To: <1575309622.4793.413.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>

On 12/2/19 10:00 AM, Mimi Zohar wrote:

> 
> ima_update_policy() is called from multiple places.  Initially, it is
> called before a custom policy has been loaded.  The call to
> ima_process_queued_keys_for_measurement() needs to be moved to within
> the test, otherwise it runs the risk of dropping "key" measurements.

static const struct file_operations ima_measure_policy_ops = {
	.release = ima_release_policy,
};

ima_update_policy() is called from ima_release_policy() function.

On my test machine I have the IMA policy in /etc/ima/ima-policy file. 
When IMA policy is setup from this file, I see ima_release_policy() 
called (which in turn calls ima_update_policy()).

How can I have ima_update_policy() called before a custom policy is loaded?

If CONFIG_IMA_WRITE_POLICY is enabled, IMA policy can be updated at 
runtime - which would invoke ima_update_policy().

Is there any other way ima_update_policy() can get called?

> All the queued keys need to be processed at the same time.  Afterwards
> the queue should be deleted.  Unfortunately, the current queue locking
> assumes ima_process_queued_keys_for_measurement() is called multiple
> times.

When ima_process_queued_keys_for_measurement() is called the first time, 
the flag ima_process_keys_for_measurement is set to true and all queued 
keys are processed at that time.

The queue is not used after this point - In the IMA hook the key is 
processed immediately when ima_process_keys_for_measurement is set to true.

ima_process_queued_keys_for_measurement() can be called multiple times, 
but on 2nd and subsequent calls it will be a NOP.

> 
> Perhaps using the RCU method of walking lists would help.  I need to
> think about it some more.
> 
> Mimi

Please let me know how using RCU method would help.

thanks,
  -lakshmi
