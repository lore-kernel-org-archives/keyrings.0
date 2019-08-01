From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 01 Aug 2019 07:59:51 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
 <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
 <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, Aug 1, 2019 at 10:40 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> > I chose the userspace plugin due to this, you can use userspace aids
> > to provide any type of service. Use the crypto library you desire to
> > do the magic you want.
>
> Here TEE isn't similar to a user-space crypto library. In our case TEE
> is based on ARM TrustZone which only allows TEE communications to be
> initiated from privileged mode. So why would you like to route
> communications via user-mode (which is less secure) when we have
> standardised TEE interface available in kernel?

The physical access guards for reading/writing the involved critical
memory are identical as far as I know? Layered security is generally a
good thing, and the userspace pass actually adds a layer, so not sure
which is really safer?

In my case the rerouting was to done generalize it. Any type of trust
source, anywhere.


> > > Isn't actual purpose to have trusted keys is to protect user-space
> > > from access to kernel keys in plain format? Doesn't user mode helper
> > > defeat that purpose in one way or another?
> >
> > Not really. CPU is in the user mode while running the code, but the
> > code or the secure keydata being is not available to the 'normal'
> > userspace. It's like microkernel service/driver this way. The usermode
> > driver is part of the kernel image and it runs on top of a invisible
> > rootfs.
>
> Can you elaborate here with an example regarding how this user-mode
> helper will securely communicate with a hardware based trust source
> with other user-space processes denied access to that trust source?

The other user mode processes will never see the device node to open.
There is none in existence for them; it only exists in the ramfs based
root for the user mode helper.


--
Janne
