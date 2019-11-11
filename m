From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 11 Nov 2019 19:41:42 +0000
Subject: Re: [PATCH v5 0/10] KEYS: Measure keys when they are created or updated
Message-Id: <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/11/2019 11:32 AM, Lakshmi Ramasubramanian wrote:

Hi Mimi,

> Problem Statement:
> 
> Keys created or updated in the system are currently not being measured.
> 
> This change aims to address measuring keys created or updated
> in the system:
> 
>    => Patches #1 through #5 update IMA policy functions to handle
>       measurement of keys based on configured IMA policy.
> 
>    => Patches #6 and #7 add IMA hook for measuring keys and the call
>       to the IMA hook from key_create_or_update function.
>       Keys are processed immediately - no support for
>       deferred processing.
> 
>    => Patches #8 through #10 add support for queuing keys if
>       custom IMA policies have not been applied yet and process
>       the queued keys when custom IMA policies are applied.

I was wondering if it'd be better to split this patch set into two sets:

1st set including the patches for measuring keys without queuing support 
(Patches #1 through #7)

2nd set including the patches that add queuing support (Patches #8 
through #10).

thanks,
  -lakshmi
