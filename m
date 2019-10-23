From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 23 Oct 2019 17:52:19 +0000
Subject: Re: [PATCH v1 5/6] KEYS: measure queued keys
Message-Id: <1571853139.5104.154.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-6-nramas@linux.microsoft.com>
         <1571836990.5104.96.camel@linux.ibm.com>
         <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
In-Reply-To: <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 2019-10-23 at 10:34 -0700, Lakshmi Ramasubramanian wrote:
> On 10/23/19 6:23 AM, Mimi Zohar wrote:
> 
> > The ordering of this patch set is awkward.  It should first introduce
> > a generic method for measuring keys based on the keyring.  Then add
> > the additional support needed for the specific builtin_trusted_keys
> > keyring usecase.
> 
> Would the following ordering of the patch set be acceptable:
> 
>   => PATCH 0/5: Cover letter
> 
>   => PATCH 1/5: Define the enum "hook(BUILTIN_TRUSTED_KEYS)" in ima.h
> 
>   => PATCH 2/5: Define ima hook
>                 This will initially do nothing if ima is not yet
>                 initialized.
>                 Call process_buffer_measurement() if ima is initialized.
> 
>   => PATCH 3/5: key_create_or_update change and the call to ima hook
> 
>   => PATCH 4/5: Queue\De-Queue of key measurement requests.
>                 Enable queuing of key in the ima hook if ima is not
>                 initialized.
> 
>   => PATCH 5/5: ima policy to enable measurement of keys which will
>                 enable end-to-end working of this feature.

The first patches need to introduce the generic concept of measuring
keys based on policy.  Only afterwards would you add any builtin
trusted keyring specific code.

Mimi
