From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 02 Dec 2019 18:00:22 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <1575309622.4793.413.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
         <1574887137.4793.346.camel@linux.ibm.com>
         <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
In-Reply-To: <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>

On Wed, 2019-11-27 at 13:11 -0800, Lakshmi Ramasubramanian wrote:
> On 11/27/19 12:38 PM, Mimi Zohar wrote:

> > I'm not sure why you want to differentiate between IMA being
> > initialized vs. an empty policy.  I would think you would want to know
> > when a custom policy has been loaded.
> 
> You are right - When custom ima policy rules are loaded (in 
> ima_update_policy() function), ima_process_queued_keys_for_measurement() 
> function is called to process queued keys.
> 
> The flag ima_process_keys_for_measurement is set to true in 
> ima_process_queued_keys_for_measurement(). And, subsequent keys are 
> processed immediately.
> 
> Please take a look at ima_process_queued_keys_for_measurement() in this 
> patch (v0 1/2) and the ima_update_policy() change in "PATCH v0 2/2".

ima_update_policy() is called from multiple places.  Initially, it is
called before a custom policy has been loaded.  The call to
ima_process_queued_keys_for_measurement() needs to be moved to within 
the test, otherwise it runs the risk of dropping "key" measurements.

All the queued keys need to be processed at the same time.  Afterwards
the queue should be deleted.  Unfortunately, the current queue locking
assumes ima_process_queued_keys_for_measurement() is called multiple
times.

Perhaps using the RCU method of walking lists would help.  I need to
think about it some more.

Mimi
