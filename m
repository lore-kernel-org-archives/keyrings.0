From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 03 Jun 2020 11:57:20 +0000
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
Message-Id: <CAFA6WYOFO8YptYp2JrY7nQL0MeM02VLCHvtnxUCEDd5-fb-z+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591108981.4253.17.camel@linux.ibm.com>
 <CAFA6WYOoMdLJ2g3gocZBZWdu-7Nfw7LKHnzX8S8FKeC7cuNwYg@mail.gmail.com>
 <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
In-Reply-To: <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
To: Luke Hinds <lhinds@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, James Bottomley <jejb@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, 3 Jun 2020 at 14:20, Luke Hinds <lhinds@redhat.com> wrote:
>
>
>
> On Wed, Jun 3, 2020 at 9:08 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Tue, 2 Jun 2020 at 20:14, James Bottomley <jejb@linux.ibm.com> wrote:
>> >
>> > On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
>> > > Add support for TEE based trusted keys where TEE provides the
>> > > functionality to seal and unseal trusted keys using hardware unique
>> > > key. Also, this is an alternative in case platform doesn't possess a
>> > > TPM device.
>> >
>> > So here's a meta problem: in the case when the platform possesses both
>> > TEE and TPM  what should it do?
>>
>> IMO, trust source (either a TPM or a TEE) should be unique and
>> carefully chosen as per platform security policy corresponding to a
>> particular threat model.
>>
>> And moreover TEEs have been mostly used in the embedded world where
>> having a hardware TPM is cumbersome given constraints regarding BoM
>> cost and hardware resources.
>>
>> >  Things like this:
>> >
>> > > --- a/security/keys/trusted-keys/trusted_core.c
>> > > +++ b/security/keys/trusted-keys/trusted_core.c
>> > > @@ -25,6 +25,8 @@
>> > >
>> > >  #if defined(CONFIG_TRUSTED_TPM)
>> > >  static struct trusted_key_ops *trusted_key_ops >> > > &tpm_trusted_key_ops;
>> > > +#elif defined(CONFIG_TRUSTED_TEE)
>> > > +static struct trusted_key_ops *trusted_key_ops >> > > &tee_trusted_key_ops;
>> > >  #else
>> >
>> > Say it's either/or at a Kconfig level: so if you select both TEE and
>> > TPM based trusted keys at compile time, we intall the TPM ops and
>> > ignore the TEE ops, is that right?  Surely this should be runtime
>> > selectable based on what the platform has ...
>>
>> This dynamic selection was already part of v4 patch-set but after
>> objection from Jarrko here [1], I switched to compile time mode
>> instead.
>>
>> [1] https://lkml.org/lkml/2020/6/2/139
>
>
> Unless I have misunderstood, my concerns about compile time are that distributors will be cornered into releasing kernels with an opinionated selection of either TEE or TPM and any users needing the non default will need to compile their own kernel.
>

I echo with your concerns.

Jarrko,

If it's fine with you then I can switch back to dynamic approach again
in the next version.

-Sumit

>>
>>
>> > perhaps it should even be
>> > selectable per key?
>> >
>> > Once it is runtime selectable, what should be selected in the both
>> > case?  Or should we allow the user to decide, if so, how?
>> >
>> > when you pipe a trusted key, I think the subtype (TEE or TPM) should be
>> > part of the piped information, so it loads again seamlessly.  This
>> > would actually be fixed by something like the ASN.1 scheme I'm trying
>> > to upstream, at least for TPM keys, but do TEE keys have a recognized
>> > ASN.1 format?
>> >
>>
>> I guess this is something which we can refine later if there are real
>> platforms that have a particular security requirement to support both
>> TPM and a TEE.
>>
>> -Sumit
>>
>> > James
>> >
>>
>
