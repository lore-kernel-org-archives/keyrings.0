From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 01 Aug 2019 06:36:44 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
 <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
 <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
In-Reply-To: <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, Jul 31, 2019 at 5:23 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > I guess my wording was wrong, tried to say that physical TEEs in the
> > wild vary massively hardware wise. Generalizing these things is rough.
> >
>
> There are already well defined GlobalPlatform Standards to generalize
> the TEE interface. One of them is GlobalPlatform TEE Client API [1]
> which provides the basis for this TEE interface.

I'm aware of it - I have implemented a large part of the GP TEE APIs
earlier (primarily the crypto functions). Does the TEE you work with
actually support GP properly? Can I take a look at the code?

Normally the TEE implementations are well-guarded secrets and the
state of the implementation is quite random. In many cases keeping
things secret is fine from my point of view, given that it is a RoT
after all. The secrecy is the core business here. So, this is why I
opted the userspace 'secret' route - no secrets in the kernel, but
it's fine for the userspace. Umh was a logical fit to implement it.


--
Janne
