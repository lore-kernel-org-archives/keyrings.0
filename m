From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 03 Dec 2019 19:45:31 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
In-Reply-To: <1575375945.5241.16.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi Mimi,

On 12/3/2019 4:25 AM, Mimi Zohar wrote:

> 
> A keyring can be created by any user with any keyring name, other than
>   ones dot prefixed, which are limited to the trusted builtin keyrings.
>   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> example, keys loaded onto any keyring named "foo" will be measured.
>   For files, the IMA policy may be constrained to a particular uid/gid.
>   An additional method of identifying or constraining keyring names
> needs to be defined.
> 
> Mimi
> 

Are you expecting a functionality like the following?

  => Measure keys added to keyring "foo", but exclude certain keys 
(based on some key identifier)

Sample policy might look like below:

action=MEASURE func=KEY_CHECK keyrings=foo|bar
action=DONT_MEASURE key_magic=blah

So a key with key_magic "blah" will not be measured even though it is 
added to the keyring "foo". But any other key added to "foo" will be 
measured.

What would the constraining field in the key may be - Can it be SHA256 
hash of the public key? Or, some other unique identifier?

Could you please clarify?

thanks,
  -lakshmi
