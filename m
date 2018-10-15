From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 15 Oct 2018 21:53:49 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
In-Reply-To: <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
To: David.Laight@aculab.com
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Oct 15, 2018 at 2:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: ndesaulniers@google.com
> > Sent: 11 October 2018 21:31
> ...
> > by swapping h2 and h3.
> >
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > standards explicitly call this out as undefined behavior:
>
> I guess that problems arise when all the arguments are stacked
> and va_start/va_arg use naive pointer manipulation.
> In that case &h3 might be 4n+3 aligned so va_arg() will access
> misaligned stack locations.
>
> I doubt any modern compilers (where va_start and va_arg are builtins)
> will get this 'wrong' even when all arguments are stacked.
>
> Seems clang is being over cautious.

Yes; did you have feedback on the Denis' proposed fix, or another?

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Thanks,
~Nick Desaulniers
