From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Feb 2019 18:36:51 +0000
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <CAKwvOdnhDin6TJfBVxm6xsCh_nJeBuA7GqbgJwgLnqc3PrJGxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com> <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
 <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
In-Reply-To: <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, jarkko.sakkinen@linux.intel.com, zohar@linux.vnet.ibm.com
Cc: David Howells <dhowells@redhat.com>, Nathan Chancellor <natechancellor@gmail.com>, David.Laight@aculab.com, denkenz@gmail.com, jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, Oct 29, 2018 at 10:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 24, 2018 at 1:37 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> > > Fixes the warning reported by Clang:
> > > security/keys/trusted.c:146:17: warning: passing an object that
> > > undergoes default
> > >      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > >        va_start(argp, h3);
> > >                       ^
> > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > char' is declared here
> > > unsigned char *h2, unsigned char h3, ...)
> > >                               ^
> > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > standards explicitly call this out as undefined behavior:
> > >
> > > The parameter parmN is the identifier of the rightmost parameter in
> > > the variable parameter list in the function definition (the one just
> > > before the ...). If the parameter parmN is declared with ... or with a
> > > type that is not compatible with the type that results after
> > > application of the default argument promotions, the behavior is
> > > undefined.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > > Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > Suggested-by: Denis Kenzior <denkenz@gmail.com>
> > > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > /Jarkko
>
> Bumping the maintainers if this isn't already picked up?

James, Jarkko, or Mimi, can you please pick this up (and let me know
what tree it lands in)?
https://lkml.org/lkml/2018/10/23/116
-- 
Thanks,
~Nick Desaulniers
