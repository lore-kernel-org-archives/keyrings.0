From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 09 Aug 2019 05:48:24 +0000
Subject: Re: [Tee-dev] [RFC v2 2/6] tee: enable support to register kernel memory
Message-Id: <CAFA6WYPUEUVJqk9E2F6z9oBW3VpC+xeqqpY4YrU9KPL1s0DTyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
 <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
In-Reply-To: <99777010-db74-096a-ce1a-da30539d6fb5@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: dhowells@redhat.com, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Fri, 9 Aug 2019 at 03:57, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 7/30/19 7:23 AM, Sumit Garg wrote:
>
> > @@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >               goto err;
> >       }
> >
> > -     rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
> > +     if (flags & TEE_SHM_USER_MAPPED) {
> > +             rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +                                      shm->pages);
> > +     } else {
> > +             const struct kvec kiov = {
> > +                     .iov_base = (void *)start,
> > +                     .iov_len = PAGE_SIZE
> > +             };
> > +
> > +             rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);
>
> Passing a single kvec struct is temporary I assume?  Because as currently
> written this will only work with num_pages=1.
>

Ah, thanks Stuart for pointing this out. It should rather be an array
of kvec struct. Will fix it in next version.

-Sumit

> Stuart
