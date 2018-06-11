From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 11 Jun 2018 17:57:42 +0000
Subject: Re: [PATCH net] KEYS: DNS: fix parsing multiple options
Message-Id: <20180611175742.GA33284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180608162037.129802-1-ebiggers3@gmail.com>
 <20180611094022.gvrefejktxzw44i7@netronome.com>
In-Reply-To: <20180611094022.gvrefejktxzw44i7@netronome.com>
To: Simon Horman <simon.horman@netronome.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Wang Lei <wang840925@gmail.com>, Eric Biggers <ebiggers@google.com>

Hi Simon,

On Mon, Jun 11, 2018 at 11:40:23AM +0200, Simon Horman wrote:
> On Fri, Jun 08, 2018 at 09:20:37AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > My recent fix for dns_resolver_preparse() printing very long strings was
> > incomplete, as shown by syzbot which still managed to hit the
> > WARN_ONCE() in set_precision() by adding a crafted "dns_resolver" key:
> > 
> >     precision 50001 too large
> >     WARNING: CPU: 7 PID: 864 at lib/vsprintf.c:2164 vsnprintf+0x48a/0x5a0
> > 
> > The bug this time isn't just a printing bug, but also a logical error
> > when multiple options ("#"-separated strings) are given in the key
> > payload.  Specifically, when separating an option string into name and
> > value, if there is no value then the name is incorrectly considered to
> > end at the end of the key payload, rather than the end of the current
> > option.  This bypasses validation of the option length, and also means
> > that specifying multiple options is broken -- which presumably has gone
> > unnoticed as there is currently only one valid option anyway.
> > 
> > Fix it by correctly calculating the length of the option name.
> > 
> > Reproducer:
> > 
> >     perl -e 'print "#A#", "\x00" x 50000' | keyctl padd dns_resolver desc @s
> > 
> > Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  net/dns_resolver/dns_key.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> > index 40c851693f77e..d448823d4d2ed 100644
> > --- a/net/dns_resolver/dns_key.c
> > +++ b/net/dns_resolver/dns_key.c
> > @@ -97,7 +97,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
> >  				return -EINVAL;
> >  			}
> >  
> > -			eq = memchr(opt, '=', opt_len) ?: end;
> > +			eq = memchr(opt, '=', opt_len) ?: next_opt;
> >  			opt_nlen = eq - opt;
> >  			eq++;
> 
> It seems risky to advance eq++ in the case there the value is empty.
> Its not not pointing to the value but it may be accessed twice further on
> in this loop.
> 

Sure, that's a separate existing issue though, and it must be checked that the
value is present before using it anyway, which the code already does, so it's
not a "real" bug.  I think I'll keep this patch simple and leave that part as-is
for now.

Eric
