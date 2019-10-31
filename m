From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 31 Oct 2019 12:10:41 +0000
Subject: Re: [PATCH v3 2/9] KEYS: Defined functions to queue and dequeue keys for measurement
Message-Id: <1572523841.5028.44.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-3-nramas@linux.microsoft.com>
In-Reply-To: <20191031011910.2574-3-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: prsriva@linux.microsoft.com

On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> Key measurements cannot be done if the IMA hook to measure keys is
> called before IMA is initialized. Key measurement needs to be deferred
> if IMA is not yet initialized. Queued keys need to be processed when
> IMA initialization is completed.
> 
> This patch defines functions to queue and de-queue keys for measurement.

I would defer this patch until later in the patch set, after having
the basic measuring of keys in place.

Mimi
