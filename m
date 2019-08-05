From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 05 Aug 2019 05:14:59 +0000
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
Message-Id: <CAFA6WYOMXc2y=vXOwRv+PYyF8oBV70G7CrJ81jvD5yJT41zLZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org> <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
 <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com> <20190802193802.jn56jhoz5crebggt@linux.intel.com>
In-Reply-To: <20190802193802.jn56jhoz5crebggt@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-security-module@vger.kernel.org, dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>

On Sat, 3 Aug 2019 at 01:08, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Aug 02, 2019 at 11:20:09AM +0530, Sumit Garg wrote:
> > On Thu, 1 Aug 2019 at 22:54, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Thu, Jul 18, 2019 at 04:54:45PM +0530, Sumit Garg wrote:
> > > > Move existing code to trusted keys subsystem. Also, rename files with
> > > > "tpm" as suffix which provides the underlying implementation.
> > > >
> > > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > What about TPM2 trusted keys code?
> >
> > Isn't TPM2 code located here: "drivers/char/tpm/"? Would you like to
> > move that code under trusted keys subsystem only?
>
> Yeah, we need a design decision here. What I care is that they should
> be in the same subsystem. I did trusted keys directly to TPM 2.0 subsys
> because the subsystem was not too robust back then.
>
> Right now I think it would be feasible to implement TPM2 trusted keys
> outside TPM driver since the whole transmit functionality is way more
> robust.
>

Okay, I will try to move TPM2 trusted keys code also.

-Sumit

> /Jarkko
