From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Thu, 01 Aug 2019 08:30:05 +0000
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
Message-Id: <CAE=NcrbujsM8wYJXq+s=o5Vy1xY1b0uKYBGvp6UP5ex70HrB2Q@mail.gmail.com>
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
 <CAE=NcraqD9FNM0Gk9UGhPGi3heVzZrAKGc1gNZxoe1OnDaQ=pA@mail.gmail.com>
 <CAFA6WYPt4q+jaJbaoauXKr2qKgBHvtQ663s4t=W3nuPJPe2xpw@mail.gmail.com>
In-Reply-To: <CAFA6WYPt4q+jaJbaoauXKr2qKgBHvtQ663s4t=W3nuPJPe2xpw@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: dhowells@redhat.com, Daniel Thompson <daniel.thompson@linaro.org>, Rouven Czerwinski <r.czerwinski@pengutronix.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, Aug 1, 2019 at 10:58 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> > Anyway, just my .02c. I guess having any new support in the kernel for
> > new trust sources is good and improvement from the current state. I
> > can certainly make my stuff work with your setup as well, what ever
> > people think is the best.
>
> Yes your implementation can very well fit under trusted keys
> abstraction framework without creating a new keytype: "ext-trusted".

The fundamental problem with the 'standardized kernel tee' still
exists - it will never be generic in real life. Getting all this in
the kernel will solve your problem and sell this particular product,
but it is quite unlikely to help that many users. If the security is
truly important to you, would you really trust any of this code to
someone else? In this day and age, I really doubt many do. Everyone
does their own thing, so this is why I really see all that as a
userspace problem.


--
Janne
