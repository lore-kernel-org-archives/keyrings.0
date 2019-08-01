From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 01 Aug 2019 07:30:06 +0000
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=NcraqD9FNM0Gk9UGhPGi3heVzZrAKGc1gNZxoe1OnDaQ=pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
 <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
 <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
 <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
In-Reply-To: <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Sumit Garg <sumit.garg@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, Aug 1, 2019 at 9:50 AM Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:

> > I'm aware of it - I have implemented a large part of the GP TEE APIs
> > earlier (primarily the crypto functions). Does the TEE you work with
> > actually support GP properly? Can I take a look at the code?
>
> AFAIK Sumit is working with the OP-TEE implementation, which can be
> found on github: https://github.com/op-tee/optee_os

Thanks, I will take a look. The fundamental problem with these things
is that there are infinite amount of ways how TEEs and ROTs can be
done in terms of the hardware and software. I really doubt there are 2
implementations in existence that are even remotely compatible in real
life. As such, all things TEE/ROT would logically really belong in the
userland and thanks to the bpfilter folks now the umh logic really
makes that possible ... I think. The key implementation I did was just
an RFC on the concept, what if we start to move the stuff that really
belongs in the userspace to this pseudo-userland. It's not kernel, but
it's not commonly accessible userland either. The shared memory would
also work without any modifications between the umh based TEE/ROT
driver and the userland if needed.

Anyway, just my .02c. I guess having any new support in the kernel for
new trust sources is good and improvement from the current state. I
can certainly make my stuff work with your setup as well, what ever
people think is the best.


--
Janne
