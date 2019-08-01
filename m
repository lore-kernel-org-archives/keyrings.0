From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 01 Aug 2019 10:40:26 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=NcrY7zA1OkKwpVrPbPd+c0OymZeAgT2hp6xZ3HQOgbXaZjg@mail.gmail.com>
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
 <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com>
 <CAFA6WYOwcO5-cyaJf3tMMAdyVHJo=BzmCWtsjA3S8aj5g-GZxQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOwcO5-cyaJf3tMMAdyVHJo=BzmCWtsjA3S8aj5g-GZxQ@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, Aug 1, 2019 at 1:00 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > > Here TEE isn't similar to a user-space crypto library. In our case TEE
> > > is based on ARM TrustZone which only allows TEE communications to be
> > > initiated from privileged mode. So why would you like to route
> > > communications via user-mode (which is less secure) when we have
> > > standardised TEE interface available in kernel?
> >
> > The physical access guards for reading/writing the involved critical
> > memory are identical as far as I know? Layered security is generally a
> > good thing, and the userspace pass actually adds a layer, so not sure
> > which is really safer?
>
> AFAIK, layered security is better in case we move from lower privilege
> level to higher privilege level rather than in reverse order.

You can look at this in many ways. Another way to look at it is that
the services should be provided with the least amount of permissions
required for the task. Further you can containerize something, the
better.

As for your PLATFORMS support: it is all nice, but there is no way to
convince op-tee or any other tee to be adopted by many real users.
Every serious user can and will do their own thing, or at very best,
buy it from someone who did their own thing and is trusted. There is
zero chance that samsung, huawei, apple, nsa, google, rambus, payment
system vendors, .. would actually share the tee (or probably even the
interfaces). It is just too vital and people do not trust each other
anymore :(

Anyway, enough about the topic from my side. I guess people will tell
what they want, I'm fine with any, and it is all progress from the
current state :)


--
Janne
