From: James Bottomley <jejb@linux.vnet.ibm.com>
Date: Thu, 11 Oct 2018 16:10:03 +0000
Subject: Re: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
Message-Id: <1539274203.2623.56.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
         <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
In-Reply-To: <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>
Cc: zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>

On Thu, 2018-10-11 at 18:02 +0200, Arnd Bergmann wrote:
> On 10/10/18, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Hello,
> > I noticed that compiling with
> > CONFIG_TCG_TPM=y
> > CONFIG_HW_RANDOM_TPM=y
> > and Clang produced the warning:
> > 
> >   CC      security/keys/trusted.o
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-
> > Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> > 
> > Specifically, it seems that both the C90 (4.8.1.1) and C11
> > (7.16.1.4) standards explicitly call this out as undefined
> > behavior:
> > 
> > The parameter parmN is the identifier of the rightmost parameter in
> > the variable parameter list in the function definition (the one
> > just before the ...). If the parameter parmN is declared with ...
> > or with a type that is not compatible with the type that results
> > after application of the default argument promotions, the behavior
> > is undefined.
> > 
> > So if I understand my C promotion/conversion rules correctly,
> > unsigned char would be promoted to int?
> > 
> > We had a few ideas for possible fixes in:
> > https://github.com/ClangBuiltLinux/linux/issues/41
> 
> I arrived at a similar patch as the one cited there, but it broke
> again after an 'extern' declaration was added in
> include/keys/trusted.h, so that has to be patched as well now

They look either over complicated or potentially problematic.  since
this is an internal API and a char * is always legal, what's wrong with
simply swapping h2 and h3?

James
