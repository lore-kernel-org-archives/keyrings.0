From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 02 Jun 2020 08:52:37 +0000
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Message-Id: <CAFA6WYOVho3sAO=ABaeO3CGw-DfWuGOE9H_D48pCwAq0+VX9Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
 <20200601021132.GA796225@linux.intel.com>
 <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com>
 <20200602071407.GB16602@linux.intel.com>
In-Reply-To: <20200602071407.GB16602@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, James Bottomley <jejb@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Tue, 2 Jun 2020 at 12:44, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 02:41:55PM +0530, Sumit Garg wrote:
> > > This, I think is wrong. You should have a compile time flag for TPM e.g.
> > > CONFIG_TRUSTED_TPM, not this dynamic mess.
> > >
> >
> > The whole idea to have it dynamic was to have a common trusted keys
> > module which could support both TPM and TEE implementation depending
> > on hardware. I guess it may be useful in scenarios where a particular
> > hardware supports a TPM chip while other doesn't but both need to run
> > a common kernel image.
>
> For now it should only scale to what is needed. No problems refining
> it later when there is something to enable.
>

Fair enough, will switch to compile time mode then.

-Sumit

> /Jarkko
