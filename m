From: James Bottomley <jejb@linux.ibm.com>
Date: Tue, 02 Jun 2020 14:43:01 +0000
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
Message-Id: <1591108981.4253.17.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, op-tee@lists.trustedfirmware.org, corbet@lwn.net, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the
> functionality to seal and unseal trusted keys using hardware unique
> key. Also, this is an alternative in case platform doesn't possess a
> TPM device.

So here's a meta problem: in the case when the platform possesses both
TEE and TPM  what should it do?  Things like this:

> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -25,6 +25,8 @@
>  
>  #if defined(CONFIG_TRUSTED_TPM)
>  static struct trusted_key_ops *trusted_key_ops > &tpm_trusted_key_ops;
> +#elif defined(CONFIG_TRUSTED_TEE)
> +static struct trusted_key_ops *trusted_key_ops > &tee_trusted_key_ops;
>  #else

Say it's either/or at a Kconfig level: so if you select both TEE and
TPM based trusted keys at compile time, we intall the TPM ops and
ignore the TEE ops, is that right?  Surely this should be runtime
selectable based on what the platform has ... perhaps it should even be
selectable per key?

Once it is runtime selectable, what should be selected in the both
case?  Or should we allow the user to decide, if so, how?

when you pipe a trusted key, I think the subtype (TEE or TPM) should be
part of the piped information, so it loads again seamlessly.  This
would actually be fixed by something like the ASN.1 scheme I'm trying
to upstream, at least for TPM keys, but do TEE keys have a recognized
ASN.1 format?

James
