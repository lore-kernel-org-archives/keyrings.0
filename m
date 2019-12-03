From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 03 Dec 2019 16:13:48 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <e2faf0d0-fee1-96fe-1120-c003761aa517@linux.microsoft.com>
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

On 12/3/2019 4:25 AM, Mimi Zohar wrote:

Hi Mimi,

> Hi Lakshmi,
> 
> A keyring can be created by any user with any keyring name, other than
>   ones dot prefixed, which are limited to the trusted builtin keyrings.
>   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> example, keys loaded onto any keyring named "foo" will be measured.
>   For files, the IMA policy may be constrained to a particular uid/gid.
>   An additional method of identifying or constraining keyring names
> needs to be defined.
> 

I agree - this is a good idea.

Do you think this can be added as a separate patch set - enhancement to 
the current one, or should this be addressed in the current set?

I was just about to send an update today that addresses your latest 
comments. Will hold it if you think the above change should be included 
now. Please let me know.

thanks,
  -lakshmi
