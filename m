From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 17 Oct 2018 15:10:17 +0000
Subject: Re: [PATCH] support other engines for module signing
Message-Id: <1539789017.3769.14.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171142300.20697@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171142300.20697@hatman>
To: keyrings@vger.kernel.org

On Wed, 2018-10-17 at 08:05 -0700, David Woodhouse wrote:
> On Wed, 2018-10-17 at 07:43 -0700, James Bottomley wrote:
> > On Wed, 2018-10-17 at 15:40 +0100, David Howells wrote:
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > 
> > > > > Allow sign-file to use any available OpenSSL engine, not
> > > > > limited
> > > > > to PKCS-11 by using "enginename:keyname" syntax.  We have to
> > > > > do a
> > > > > special case for pkcs11 key name passing.
> > > > 
> > > > There's actually already a proposal for this which David
> > > > (Howells)
> > > > has
> > > > been ignoring:
> > > 
> > > Not so much ignoring as it just keeps getting buried.
> > 
> > Understood.  What I really need is my patch testing by someone at
> > Red
> > Hat: the pkcs11 token you use looks highly non-standard so someone
> > needs to check that adding generic engine support doesn't break it.
> 
> Que?
> 
> Which PKCS#11 token are you talking about? Or do you mean the PKCS#11
> engine, which is the normal one from https://github.com/OpenSC/libp11
> 
> I think it does support using the UI for callbacks. Your trick of
> passing through to pem_pw_cb should probably work fine, as long as
> there's only ever one password. It should be trivial to test using
> SoftHSM or any other soft token, even if you have no actual hardware-
> based PKCS#11 tokens.

It didn't look like a normal one.  In fact it doesn't use UI callbacks
at all: it passes the key password in with an engine command.  That's
why I left it specifically cased out in the file.  Now if it does
actually work normally, the special casing can be removed.

> > > > https://marc.info/?l=linux-keyrings&m1845297302654&w=2
> > > > 
> > > > It tries to use the correct UI callbacks, which yours is
> > > > missing.
> > > 
> > > If this works for Mark and Dave, then I could take this instead.
> 
> AFAICT you're still only ever loading the "pkcs11" engine there. Is
> there another patch I missed?

No, the requirement seemed to be to add the engine to the openssl
config file.  There's no reason why an additional command parameter
can't be added, though.

James
