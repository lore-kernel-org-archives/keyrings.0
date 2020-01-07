From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 07 Jan 2020 22:26:34 +0000
Subject: Re: [PATCH 1/4] IMA: Define an IMA hook to measure keys
Message-Id: <1578435994.4288.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
         <20200107194350.3782-2-nramas@linux.microsoft.com>
In-Reply-To: <20200107194350.3782-2-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Tue, 2020-01-07 at 11:43 -0800, Lakshmi Ramasubramanian wrote:
[...]
> diff --git a/security/integrity/ima/Kconfig
> b/security/integrity/ima/Kconfig
> index 838476d780e5..73a3974712d8 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -310,3 +310,12 @@ config IMA_APPRAISE_SIGNED_INIT
>  	default n
>  	help
>  	   This option requires user-space init to be signed.
> +
> +config IMA_MEASURE_ASYMMETRIC_KEYS
> +	bool "Enable measuring asymmetric keys on key create or
> update"

I don't believe there's a need to expose this to the person configuring
the kernel, is there?  It's just one more option no-one really wants to
have to understand.  Without the text following bool and the help, this
becomes a hidden config option, which is what I think it should be.

> +	depends on IMA=y

Not that it matters, but IMA is a bool, so this can be simply depends
on IMA

> +	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y

We only need the =y here becase the variable is a tristate, so this
becomes n for both the n and m cases.

> +	default y
> +	help
> +	   This option enables measuring asymmetric keys when
> +	   the key is created or updated.

And drop the help entry.  For future information, help text must be tab
followed by two spaces, not three ... checkpatch doesn't actually catch
this, unfortunately.

James
