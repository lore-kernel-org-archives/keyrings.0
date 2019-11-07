From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 07 Nov 2019 02:20:11 +0000
Subject: Re: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue keys for measurement
Message-Id: <b9f293d8-6e58-4d56-1917-5819f0b8931a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-9-nramas@linux.microsoft.com>
 <1573080281.5028.314.camel@linux.ibm.com>
In-Reply-To: <1573080281.5028.314.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/6/19 2:44 PM, Mimi Zohar wrote:

Hi Mimi,

>> +
>> +	if (ima_initialized) {
> 
> ima_initialized is being set in ima_init(), before a custom policy is
> loaded.  I would think that is too early.  ima_update_policy() is
> called after loading a custom policy.  Please see how to detect when a
> custom policy is loaded.

ima_init_policy() is called before ima_initialized flag is set.

As far as I understand ima_init_policy() loads custom policies as well. 
So custom policies (such as arch specific policies, secure boot 
policies, etc.) are loaded before the queued keys are processed.

But if CONFIG_IMA_WRITE_POLICY is enabled, the policy can be updated 
anytime. This scenario is not handled in my implementation.

Please correct me if my understanding is wrong.

thanks,
  -lakshmi
