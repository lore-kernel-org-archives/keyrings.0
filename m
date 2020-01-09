From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 09 Jan 2020 16:38:11 +0000
Subject: Re: [PATCH v1] IMA: fix measuring asymmetric keys Kconfig
Message-Id: <5411bc3d-74eb-6868-5768-bba3726a661a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200108160508.5938-1-nramas@linux.microsoft.com>
 <1578545543.5147.32.camel@linux.ibm.com>
In-Reply-To: <1578545543.5147.32.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, James.Bottomley@HansenPartnership.com, arnd@arndb.de, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org

On 1/8/20 8:52 PM, Mimi Zohar wrote:

> 
> For the time being, I've pushed out this patch with the existing patch
> description to next-integrity-testing, but the patch description
> should be rewritten clearer.  For example,
> 
> As a result of the asymmetric public keys subtype being defined as a
> tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
> be built as a kernel module.  To prevent this from happening, this
> patch defines and uses an intermediate Kconfig boolean option named
> IMA_MEASURE_ASYMMETRIC_KEYS.
> 
> Please let me know if you're ok with this wording.
> 
> thanks,
> 
> Mimi
> 

That sounds perfect. Thanks for your help Mimi.

  -lakshmi
