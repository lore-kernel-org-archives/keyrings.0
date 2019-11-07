From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 07 Nov 2019 18:42:55 +0000
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key create or update
Message-Id: <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-2-nramas@linux.microsoft.com>
 <1573080189.5028.313.camel@linux.ibm.com>
 <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
 <1573098037.5028.325.camel@linux.ibm.com>
In-Reply-To: <1573098037.5028.325.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/6/2019 7:40 PM, Mimi Zohar wrote:

>>> I would move the patch that defines the "keyring=" policy option prior
>>> to this one.  Include the call to process_buffer_measurement() in this
>>> patch.  A subsequent patch would add support to defer measuring the
>>> key, by calling a function named something like
>>> ima_queue_key_measurement().
>>>
>>> Mimi
>>
>> As I'd stated in the other response, I wanted to isolate all key related
>> code in a separate C file and build it if and only if all CONFIG
>> dependencies are met.
> 
> The basic measuring of keys shouldn't be any different than any other
> policy rule, other than it is a key and not a file.  This is the
> reason that I keep saying start out with the basics and then add
> support to defer measuring keys on the trusted keyrings.

I'll make the changes, rearrange the patches and send an updated set.

I do have a few questions since I am still not fully understanding the 
requirements you are targeting. Appreciate if you could please clarify.

As you already know, I am using the "public key" of the given asymmetric 
key as the "buffer" to measure in process_buffer_measurement().

The measurement decision is not based on whether the keyring is a 
trusted one or an untrusted one. As long as the IMA policy allows 
(through the "keyrings=" option) the key will be measured.

Do you want only trusted keyrings to be allowed in the measurement?
In my opinion, that decision should be deferred to whoever is setting up 
the IMA policy.

> Only the queueing code needed for measuring keys on the trusted
> keyrings would be in a separate file.
> 
> Mimi

The decision to process key immediately or defer (queue) is based on 
whether IMA has been initialized or not. Keyring is not used for this 
decision.

Could you please clarify how queuing is related to keyring's 
trustworthiness?

The check for whether the key is an asymmetric one or not, and 
extracting the "public key" if it is an asymmetric key needs to be in a 
separate file to handle the CONFIG dependencies in IMA.

thanks,
  -lakshmi
