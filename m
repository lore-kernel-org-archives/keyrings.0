From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 12 Oct 2018 17:14:52 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <CAKwvOdnejRka4hP66zCGS+MSXx_z335qZUTU8J0UbEq-boRYjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com> <1539357759.2656.7.camel@linux.ibm.com>
 <16de2bb3-815a-f534-4618-af854c906017@gmail.com> <1539359181.2656.13.camel@linux.ibm.com>
 <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com> <1539360075.2656.18.camel@linux.ibm.com>
In-Reply-To: <1539360075.2656.18.camel@linux.ibm.com>
To: jejb@linux.ibm.com
Cc: denkenz@gmail.com, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Oct 12, 2018 at 9:01 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Fri, 2018-10-12 at 10:53 -0500, Denis Kenzior wrote:
> > Hi James,
> >
> > > >   From the links provided in the patch it seems that one cannot
> > > > pass char/float/short to va_start().  Fair enough.  So if we make
> > > > h3 an unsigned int, the issue goes away, no?
> > >
> > > For the current version of clang, yes.  However, if we're fixing
> > > this for good a char * pointer is the only guaranteed thing because
> > > it mirrors current use in printf.
> > >
> >
> > All right.  I guess I wasn't aware that non-printf like variadic
> > functions are now considered harmful or of the impending crusade
> > against them :)
>
> It's not, it's just a maintainer issue: The original problem is because
> we coded for gcc specifically; it doesn't complain and does the right
> thing, so everyone was happy.  Now Clang comes along and is unhappy
> with this, so the question a good maintainer should ask is "how do I
> fix this so it never comes back again?", not "what's the easiest
> bandaid to get both Clang and gcc to work?" because the latter is how
> we got here in the first place.

Clang is simply pointing out that this is explicitly undefined
behavior by the C90 spec.  As such, not only may the implementation be
different between compilers, but it is free to change between versions
of the same compiler (I haven't witnessed such a case yet in my
limited career, but I would never say never when it comes to relying
on undefined behavior).

>
> James
>
> > But in the context of this patch, can we please use something less
> > invasive than changing all the arguments around?  Promoting h3 to a
> > bool (if possible) or int/unsigned int would get my vote.
> >
> > Regards,
> > -Denis
> >
>


-- 
Thanks,
~Nick Desaulniers
