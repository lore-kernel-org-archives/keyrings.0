From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 12 Oct 2018 17:17:50 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <CAKwvOdnRJtHEUf-2kObUiUCc_ZPRdYHxMft3s1YE6=9EnHYMMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com> <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
In-Reply-To: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
To: denkenz@gmail.com
Cc: jejb@linux.ibm.com, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Oct 12, 2018 at 10:05 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Oct 12, 2018 at 8:14 AM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > Hi James,
> >
> > >> So can't we simply use 'bool' or uint32 as the type for h3 instead
> > >> of re-ordering everything
> > >
> > > The problem is the standard is ambiguious.  The only thing that's
> > > guaranteed to work for all time is a char *.  If you want to keep the
> > > order, what I'd suggest is inserting a dummy pointer argument which is
> > > always expected to be NULL between the h3 and the varargs.
> >
> > So maybe I'm misunderstanding something, but the issue seems to be that
> > unsigned char is promoted to 'unsigned char *' by Clang and probably
> > unsigned int or int by gcc.
>
> No. This is extremely well defined behavior in C.  In C, integral
> types are NEVER promoted to pointer to integer types, only to larger
> integral types through rules more complicated than the correct flags
> to pass to `tar`.
> https://xkcd.com/1168/

And may have their signedness converted.
https://wiki.sei.cmu.edu/confluence/display/c/INT02-C.+Understand+integer+conversion+rules
is the reference I use, though I always feel like there's quite a bit
of mental gymnastics involved interpreting it.

>
> >
> > So instead of having unsigned char h3, can't we simply have bool h3 or
> > unsigned int h3?
>
> int is the default argument promotion. Proposed:
> https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339
>
> >
> > Regards,
> > -Denis
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
