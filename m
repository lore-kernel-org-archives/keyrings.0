From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 01 Aug 2019 07:52:38 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
 <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
In-Reply-To: <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
To: Janne Karhunen <janne.karhunen@gmail.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, 1 Aug 2019 at 11:51, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 4:58 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > To clarify a bit further - my thought was to support any type of trust
> > > source.
> >
> > That could be very well accomplished via Trusted Keys abstraction
> > framework [1]. A trust source just need to implement following APIs:
> >
> > struct trusted_key_ops ts_trusted_key_ops = {
> >        .migratable = 0, /* non-migratable */
> >        .init = init_ts_trusted,
> >        .seal = ts_key_seal,
> >        .unseal = ts_key_unseal,
> >        .get_random = ts_get_random,
> >        .cleanup = cleanup_ts_trusted,
> > };
>
> Which is basically the same as implementing a new keytype in the
> kernel; abstraction is not raised in any considerable manner this way?
>

It doesn't create a new keytype. There is only single keytype:
"trusted" which could be implemented via one of the trust source
available in the system like TPM, TEE etc.

> I chose the userspace plugin due to this, you can use userspace aids
> to provide any type of service. Use the crypto library you desire to
> do the magic you want.

Here TEE isn't similar to a user-space crypto library. In our case TEE
is based on ARM TrustZone which only allows TEE communications to be
initiated from privileged mode. So why would you like to route
communications via user-mode (which is less secure) when we have
standardised TEE interface available in kernel?

>
>
> > > With the
> > > user mode helper in between anyone can easily add their own thing in
> > > there.
> >
> > Isn't actual purpose to have trusted keys is to protect user-space
> > from access to kernel keys in plain format? Doesn't user mode helper
> > defeat that purpose in one way or another?
>
> Not really. CPU is in the user mode while running the code, but the
> code or the secure keydata being is not available to the 'normal'
> userspace. It's like microkernel service/driver this way. The usermode
> driver is part of the kernel image and it runs on top of a invisible
> rootfs.
>

Can you elaborate here with an example regarding how this user-mode
helper will securely communicate with a hardware based trust source
with other user-space processes denied access to that trust source?

-Sumit

>
> --
> Janne
