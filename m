From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 02 Dec 2019 19:11:31 +0000
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
Message-Id: <1575313891.4793.423.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
         <1574887137.4793.346.camel@linux.ibm.com>
         <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
         <1575309622.4793.413.camel@linux.ibm.com>
         <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
In-Reply-To: <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>

On Mon, 2019-12-02 at 10:39 -0800, Lakshmi Ramasubramanian wrote:
> On 12/2/19 10:00 AM, Mimi Zohar wrote:
> 
> > 
> > ima_update_policy() is called from multiple places.  Initially, it is
> > called before a custom policy has been loaded.  The call to
> > ima_process_queued_keys_for_measurement() needs to be moved to within
> > the test, otherwise it runs the risk of dropping "key" measurements.
> 
> static const struct file_operations ima_measure_policy_ops = {
> 	.release = ima_release_policy,
> };
> 
> ima_update_policy() is called from ima_release_policy() function.
> 
> On my test machine I have the IMA policy in /etc/ima/ima-policy file. 
> When IMA policy is setup from this file, I see ima_release_policy() 
> called (which in turn calls ima_update_policy()).
> 
> How can I have ima_update_policy() called before a custom policy is loaded?

Oops, you're right.  My concern was ima_init_policy(), but it calls
ima_update_policy_flag() directly.

Mimi
