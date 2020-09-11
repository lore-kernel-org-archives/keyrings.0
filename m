From: Alex Dewar <alex.dewar90@gmail.com>
Date: Fri, 11 Sep 2020 16:03:54 +0000
Subject: Re: [PATCH] security: keys: Use kvfree_sensitive in a few places
Message-Id: <20200911160354.72w6s2qu32hxrsp3@lenovo-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200911114400.82207-1-alex.dewar90@gmail.com>
 <1599836664.4041.21.camel@HansenPartnership.com>
 <20200911160009.n2drvcjpzrsloxcj@lenovo-laptop>
In-Reply-To: <20200911160009.n2drvcjpzrsloxcj@lenovo-laptop>
To: Alex Dewar <alex.dewar90@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, Sep 11, 2020 at 05:00:09PM +0100, Alex Dewar wrote:
> On Fri, Sep 11, 2020 at 08:04:24AM -0700, James Bottomley wrote:
> > On Fri, 2020-09-11 at 12:44 +0100, Alex Dewar wrote:
> > > In big_key.c, there are a few places where memzero_explicit + kvfree
> > > is used. It is better to use kvfree_sensitive instead, which is more
> > > readable and also prevents the compiler from eliding the call to
> > > memzero_explicit. Fix this.
> > 
> > That last bit is untrue: the compiler can't elide memzero_explicit ...
> > that's why it has the explicit suffix.
> > 
> > The original problem was a lot of people do memset(.., 0, ..); kfree()
> > which the compiler can elide if it understands the memory is going out
> > of scope.  Or the even more problematic memset(..., 0, ...) on a stack
> > variable before it goes out of scope.
> > 
> > We can argue about readability but there's no secret leak here.
> 
> Ahh, my mistake. Thanks for the explanation.
> 
> I'll send a v2 with an updated commit message. I think it would still
> make sense to use kfree_sensitive here as on next-20200911 this is the
> last use of kzfree in the tree and it would be nice to excise it
> altogether.

Ignore this! I thought we were talking about a different patch :-/

I'll send a respin with a better commit message anyways.

Cheers :-)

> 
> Best,
> Alex
> 
> > 
> > James
> > 
