From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 14 Jun 2019 05:24:59 +0000
Subject: Re: [RFC 1/7] tee: optee: allow kernel pages to register as shm
Message-Id: <CAFA6WYMjuEm8jwjteD1Wu2Uqs_O2jQuVyffqqpaNnSs0hksDMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-2-git-send-email-sumit.garg@linaro.org> <20190613151257.GA18488@linux.intel.com>
 <20190613151714.GC18488@linux.intel.com> <20190613151746.GD18488@linux.intel.com>
In-Reply-To: <20190613151746.GD18488@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org

On Thu, 13 Jun 2019 at 20:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 06:17:14PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jun 13, 2019 at 06:12:57PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jun 13, 2019 at 04:00:27PM +0530, Sumit Garg wrote:
> > > > Kernel pages are marked as normal type memory only so allow kernel pages
> > > > to be registered as shared memory with OP-TEE.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Just out of pure interest why this was not allowed before?
> >
> > Please spare me and ignore that one :-) Obviouslly because it
> > was not used.
> >
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Actually,
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks.

-Sumit

> /Jarkko
