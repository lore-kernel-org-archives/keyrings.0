From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Date: Thu, 07 Mar 2019 14:19:57 +0000
Subject: Re: [PATCH] MAINTAINERS: fix typo in Mimi Zohar's address
Message-Id: <20190307141957.GO13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <e186bbae367ceb7a2a71e2dea216838ac19dee8f.1545889849.git.baruch@tkos.co.il>
 <20181227165304.GA4170@linux.ibm.com>
 <87r2bj2ql4.fsf@tarshish>
In-Reply-To: <87r2bj2ql4.fsf@tarshish>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

On Thu, Mar 07, 2019 at 07:36:39AM +0200, Baruch Siach wrote:
> Hi Paul,
> 
> On Thu, Dec 27 2018, Paul E. McKenney wrote:
> 
> > On Thu, Dec 27, 2018 at 07:50:49AM +0200, Baruch Siach wrote:
> >> Fixes: ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >
> > Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >
> > And where is a brown paper bag when you need one?  :-/
> 
> This has missed v5.0.

And v5.1 unless someone is pushing it into this merge window.

> Which tree is this patch supposed to go through, anyway?

I was expecting you to push it somewhere, hence my Reviewed-by.  But I
can take it, and if I do it will be v5.2.

Or you could try sending it directly to Linus, which would very likely
get it into v5.1.

							Thanx, Paul

> baruch
> 
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 705555d9b3af..0b8b0d60833a 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -8339,7 +8339,7 @@ F:	security/keys/encrypted-keys/
> >>  KEYS-TRUSTED
> >>  M:	James Bottomley <jejb@linux.ibm.com>
> >>  M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> -M:	Mimi Zohar <zohar@linuxibm.com>
> >> +M:	Mimi Zohar <zohar@linux.ibm.com>
> >>  L:	linux-integrity@vger.kernel.org
> >>  L:	keyrings@vger.kernel.org
> >>  S:	Supported
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
> 
