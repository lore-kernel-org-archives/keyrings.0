From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 04 Aug 2019 20:48:07 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <20190804204807.ajhy3jhwie3oq6d5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Tue, Jul 30, 2019 at 05:53:34PM +0530, Sumit Garg wrote:
>   tee: optee: allow kernel pages to register as shm
>   tee: enable support to register kernel memory
>   tee: add private login method for kernel clients
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   doc: keys: Document usage of TEE based Trusted Keys
>   MAINTAINERS: Add entry for TEE based Trusted Keys

Skimmed through the patches. I think it is better to sort out the
current LKM dependency issue with trusted.ko and get TPM 1.2 and TPM 2.0
trusted keys code consolidated before it makes sense to really go detail
on this.

/Jarkko
