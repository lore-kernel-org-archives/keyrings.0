From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 17 Dec 2019 10:54:24 +0000
Subject: Re: [PATCH v4 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576580064.4579.374.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-2-nramas@linux.microsoft.com>
         <1576499400.4579.305.camel@linux.ibm.com>
         <0223b52e-50d6-ebce-840c-0364b24b1b30@linux.microsoft.com>
In-Reply-To: <0223b52e-50d6-ebce-840c-0364b24b1b30@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Mon, 2019-12-16 at 15:44 -0800, Lakshmi Ramasubramanian wrote:
> On 12/16/2019 4:30 AM, Mimi Zohar wrote:
> 
> >> +
> >> +		if (!list_empty(&ima_keys)) {
> >> +			list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> >> +				list_move_tail(&entry->list, &temp_ima_keys);
> >> +			process = true;
> >> +		}
> >> +	}
> >> +
> >> +	mutex_unlock(&ima_keys_mutex);
> >> +
> >> +	if (!process)
> >> +		return;
> > 
> > The new changes - checking if the list is empty and this test - are
> > unnecessary, as you implied earlier.
> > 
> > Mimi
> 
> Do you want me to remove this check? I feel it is safer to have this 
> check - use a local flag "process" to return if no keys were moved to 
> the temp list. Would like to leave it as is - if you don't mind.

Sure
  
