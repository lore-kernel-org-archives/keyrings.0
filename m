From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Date: Thu, 01 Aug 2019 06:50:22 +0000
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
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
In-Reply-To: <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
To: Janne Karhunen <janne.karhunen@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Daniel Thompson <daniel.thompson@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, jejb@linux.ibm.com, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, 2019-08-01 at 09:36 +0300, Janne Karhunen wrote:
> On Wed, Jul 31, 2019 at 5:23 PM Sumit Garg <sumit.garg@linaro.org>
> wrote:
> 
> > > I guess my wording was wrong, tried to say that physical TEEs in
> > > the
> > > wild vary massively hardware wise. Generalizing these things is
> > > rough.
> > > 
> > 
> > There are already well defined GlobalPlatform Standards to
> > generalize
> > the TEE interface. One of them is GlobalPlatform TEE Client API [1]
> > which provides the basis for this TEE interface.
> 
> I'm aware of it - I have implemented a large part of the GP TEE APIs
> earlier (primarily the crypto functions). Does the TEE you work with
> actually support GP properly? Can I take a look at the code?

AFAIK Sumit is working with the OP-TEE implementation, which can be
found on github: https://github.com/op-tee/optee_os

Regards,
Rouven
