From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 14 Nov 2019 18:30:37 +0000
Subject: Re: [PATCH v7 2/5] IMA: Define an IMA hook to measure keys
Message-Id: <56718c81-86db-c72b-19b7-c563838838d6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-3-nramas@linux.microsoft.com>
In-Reply-To: <20191114031202.18012-3-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/13/19 7:11 PM, Lakshmi Ramasubramanian wrote:

> The IMA hook is defined in a new file namely ima_asymmetric_keys.c
> which is built only if CONFIG_KEYS is enabled.

I think instead of CONFIG_KEYS I should use 
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE for ima_asymmetric_keys.c since 
this config is enabled only when both CONFIG_ASYMMETRIC_KEY_TYPE and 
CONFIG_KEYS are enabled.

Please see below taken from "crypto/asymmetric_keys/Kconfig"

# SPDX-License-Identifier: GPL-2.0
menuconfig ASYMMETRIC_KEY_TYPE
         bool "Asymmetric (public-key cryptographic) key type"
         depends on KEYS
         help
           This option provides support for a key type that holds the 
data for
           the asymmetric keys used for public key cryptographic 
operations such
           as encryption, decryption, signature generation and signature
           verification.

if ASYMMETRIC_KEY_TYPE

config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
         tristate "Asymmetric public-key crypto algorithm subtype"

endif # ASYMMETRIC_KEY_TYPE

thanks,
  -lakshmi
