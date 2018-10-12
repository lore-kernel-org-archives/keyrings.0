From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 12 Oct 2018 17:02:39 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
In-Reply-To: <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
To: denkenz@gmail.com
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Oct 12, 2018 at 5:29 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Nick,
>
> > @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
> >    */
> >   static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> >                       unsigned int keylen, unsigned char *h1,
> > -                     unsigned char *h2, unsigned char h3, ...)
> > +                     unsigned char h2, unsigned char *h3, ...)
> >   {
> >       unsigned char paramdigest[SHA1_DIGEST_SIZE];
> >       struct sdesc *sdesc;
>
> So my concern here is that this actually breaks the natural argument
> order compared to what the specification uses.  This in turn requires
> one to perform some mental gymnastics and I'm not sure that this is such
> a good idea.

Thanks for the review.

> Refer to
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
> for details.

 Can you cite the relevant section?

>
> Note that H3 is really the 'continueAuthSession' variable which is a
> bool.  In the above specification BOOL has a size of 1, and TSS_authhmac
> already assigns a h3 to 'c' which is used for the actual hashing.
>
> So can't we simply use 'bool' or uint32 as the type for h3 instead of
> re-ordering everything?

int was exactly what I originally proposed:
https://github.com/ClangBuiltLinux/linux/issues/41#issuecomment-428365339.
If that works for you and the maintainers, I can send that in patch
form.

>
> Regards,
> -Denis



-- 
Thanks,
~Nick Desaulniers
