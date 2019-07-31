From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Wed, 31 Jul 2019 11:02:53 +0000
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
In-Reply-To: <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, Jul 31, 2019 at 1:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > Interesting, I wrote something similar and posted it to the lists a while back:
> > https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
> >
> > Since there are no generic 'TEEs' available,
>
> There is already a generic TEE interface driver available in kernel.
> Have a look here: "Documentation/tee.txt".

I guess my wording was wrong, tried to say that physical TEEs in the
wild vary massively hardware wise. Generalizing these things is rough.


> > I implemented the same
> > thing as a generic protocol translator. The shared memory binding for
> > instance already assumes fair amount about the TEE and how that is
> > physically present in the system. Besides, the help from usage of shm
> > is pretty limited due to the size of the keydata.
> >
>
> If you look at patch #1 and #2, they add support to register kernel
> memory buffer (keydata buffer in this case) with TEE to operate on. So
> there isn't any limitation due to the size of the keydata.

Ah, didn't mean that. Meant that the keydata is typically pretty small
in size, so there is limited benefit from passing that in via shm if
that complicates anything.


-- 
Janne
