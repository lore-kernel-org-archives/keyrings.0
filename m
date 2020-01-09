From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 Jan 2020 04:52:23 +0000
Subject: Re: [PATCH v1] IMA: fix measuring asymmetric keys Kconfig
Message-Id: <1578545543.5147.32.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200108160508.5938-1-nramas@linux.microsoft.com>
In-Reply-To: <20200108160508.5938-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, arnd@arndb.de, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org

On Wed, 2020-01-08 at 08:05 -0800, Lakshmi Ramasubramanian wrote:
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is a tristate. If this config
> is set to "=m", ima_asymmetric_keys.c is built as a kernel module.
> 
> Defined an intermediate boolean config namely
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS that is
> defined when CONFIG_IMA and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> are defined.
> 
> Asymmetric key structure is defined only when
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined. Since the IMA hook
> measures asymmetric keys, the IMA hook is defined in
> ima_asymmetric_keys.c which is built only if
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is defined.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

For the time being, I've pushed out this patch with the existing patch
description to next-integrity-testing, but the patch description
should be rewritten clearer.  For example,

As a result of the asymmetric public keys subtype being defined as a
tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
be built as a kernel module.  To prevent this from happening, this
patch defines and uses an intermediate Kconfig boolean option named
IMA_MEASURE_ASYMMETRIC_KEYS.

Please let me know if you're ok with this wording.

thanks,

Mimi
