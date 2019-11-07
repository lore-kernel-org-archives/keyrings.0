From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 07 Nov 2019 21:12:31 +0000
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key create or update
Message-Id: <f45593ae-823e-6d61-d14c-20726bd8cacc@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-2-nramas@linux.microsoft.com>
 <1573080189.5028.313.camel@linux.ibm.com>
 <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
 <1573098037.5028.325.camel@linux.ibm.com>
 <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
 <1573159988.5028.400.camel@linux.ibm.com>
In-Reply-To: <1573159988.5028.400.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/7/19 12:53 PM, Mimi Zohar wrote:

>>
>> The measurement decision is not based on whether the keyring is a
>> trusted one or an untrusted one. As long as the IMA policy allows
>> (through the "keyrings=" option) the key will be measured.
> 
> We should be able to measure all keys being loaded onto any keyring or
> onto a specific "keyring=".   This shouldn't be any different than any
> other policy rule.  Once you have this basic feature working, you
> would address loading keys during early boot.
Perfect - that's exactly how I have implemented it right now. Will 
continue to test it.

>> Do you want only trusted keyrings to be allowed in the measurement?
>> In my opinion, that decision should be deferred to whoever is setting up
>> the IMA policy.
> 
> Right, but it shouldn't be limited to just "trusted" keyrings.  This
> way you can first test loading keys onto any keyring.
Thank you.

> Queuing the keys should be independent of measuring the keys.
>   Initially you would start with just measuring the key.  From a high
> level it would look like:
> 
>      ima_post_key_create_or_update(...)
>      {
>         "measure key based on
>      policy(key, keyring, ...)"
>      }
> 
> This requires the IMA "keyring=" policy option support be defined
> first.
> 
> Subsequently you would add key queuing support, and then update
> ima_post_key_create_or_update().  It would look like:
> 
>          ima_post_key_create_or_update(...)
>          {
>              if (custom policy is loaded)
>                 "measure key based on policy(key, keyring, ...)"
>              else
>                  "queue key(key, keyring)"
>          }
> 
> Mimi

Yes - I have the above change working. Will continue testing.

thanks,
  -lakshmi
