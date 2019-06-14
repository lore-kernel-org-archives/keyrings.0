From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 14 Jun 2019 15:36:22 +0000
Subject: Re: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-Id: <20190614153622.GG11241@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-7-git-send-email-sumit.garg@linaro.org>
 <20190613153414.GG18488@linux.intel.com>
 <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
In-Reply-To: <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org

On Fri, Jun 14, 2019 at 11:07:23AM +0530, Sumit Garg wrote:
> On Thu, 13 Jun 2019 at 21:04, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Jun 13, 2019 at 04:00:32PM +0530, Sumit Garg wrote:
> > > Provide documentation for usage of TEE based Trusted Keys via existing
> > > user-space "keyctl" utility. Also, document various use-cases.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Sorry missed this patch. Anyway, I don't think we want multiple trusted
> > keys subsystems. You have to fix the existing one if you care to get
> > these changes in. There is no really other way around this.
> >
> 
> I understand your point.
> 
> When I initially looked at trusted key implementation, it seemed to be
> tightly coupled to use TPM device. So I implemented a parallel
> implementation to get initial feedback (functionality-wise) on this
> new approach.

Yeah, I completely get this. My feedback this is: we can definitely
consider TEE based trusted keys, and I know that trusted.ko is a mess,
but still that is the only right long-term path. Think about the
positive side: if you as a side-effect can make it cleaner and more
versatile, your patch set will improve the quality of the kernel as a
whole i.e. you benefit larger audience than just TEE user base :-)

> I will work on abstraction of trusted key apis to use either approach.
> But is it fine with you if I send if I send a separate RFC patch for
> abstraction and later once reviewed I will incorporate that patch in
> this patch-set.
> 
> It will be really helpful if you could help to test that abstraction
> patch with a real TPM device as I doesn't posses one to test.

I can, yes.

/Jarkko
