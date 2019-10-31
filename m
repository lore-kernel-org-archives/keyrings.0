From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 31 Oct 2019 15:09:44 +0000
Subject: Re: [PATCH v3 2/9] KEYS: Defined functions to queue and dequeue keys for measurement
Message-Id: <7ab62644-0465-ecaf-26e1-852d4ac66d94@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-3-nramas@linux.microsoft.com>
 <1572523841.5028.44.camel@linux.ibm.com>
In-Reply-To: <1572523841.5028.44.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

On 10/31/19 5:10 AM, Mimi Zohar wrote:

> On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
>> Key measurements cannot be done if the IMA hook to measure keys is
>> called before IMA is initialized. Key measurement needs to be deferred
>> if IMA is not yet initialized. Queued keys need to be processed when
>> IMA initialization is completed.
>>
>> This patch defines functions to queue and de-queue keys for measurement.
> 
> I would defer this patch until later in the patch set, after having
> the basic measuring of keys in place.

Ok - I'll move this this patch.

thanks,
  -lakshmi
