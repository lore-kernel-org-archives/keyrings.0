From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 14 May 2020 00:28:18 +0000
Subject: Re: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-Id: <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, zohar@linux.ibm.com, jejb@linux.ibm.com
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, op-tee@lists.trustedfirmware.org, corbet@lwn.net, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

The implementation looks solid but how or who could possibly test this?

I do posses (personally, not from employer) bunch of ARM boards but my
TZ knowledge is somewhat limited (e.g. how can I get something running
in TZ).

/Jarkko
