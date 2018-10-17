From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 17 Oct 2018 14:43:33 +0000
Subject: Re: [PATCH] support other engines for module signing
Message-Id: <1539787413.3769.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171142300.20697@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171142300.20697@hatman>
To: keyrings@vger.kernel.org

On Wed, 2018-10-17 at 15:40 +0100, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > Allow sign-file to use any available OpenSSL engine, not limited
> > > to PKCS-11 by using "enginename:keyname" syntax.  We have to do a
> > > special case for pkcs11 key name passing.
> > 
> > There's actually already a proposal for this which David (Howells)
> > has
> > been ignoring:
> 
> Not so much ignoring as it just keeps getting buried.

Understood.  What I really need is my patch testing by someone at Red
Hat: the pkcs11 token you use looks highly non-standard so someone
needs to check that adding generic engine support doesn't break it.

> > https://marc.info/?l=linux-keyrings&m1845297302654&w=2
> > 
> > It tries to use the correct UI callbacks, which yours is missing.
> 
> If this works for Mark and Dave, then I could take this instead.

Hey, now I've got your attention, there's this one as well.  It's a bit
trivial but it is converting to a known API:

https://marc.info/?l=linux-keyrings&m1845291102622&w=2

James
