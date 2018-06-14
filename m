From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Jun 2018 16:18:18 +0000
Subject: Re: [PATCH net] KEYS: DNS: fix parsing multiple options
Message-Id: <8385.1528993098@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180611094022.gvrefejktxzw44i7@netronome.com> <20180608162037.129802-1-ebiggers3@gmail.com>
In-Reply-To: <20180611094022.gvrefejktxzw44i7@netronome.com>
To: Simon Horman <simon.horman@netronome.com>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers3@gmail.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, Wang Lei <wang840925@gmail.com>, Eric Biggers <ebiggers@google.com>

Simon Horman <simon.horman@netronome.com> wrote:

> > -			eq = memchr(opt, '=', opt_len) ?: end;
> > +			eq = memchr(opt, '=', opt_len) ?: next_opt;
> >  			opt_nlen = eq - opt;
> >  			eq++;
> 
> It seems risky to advance eq++ in the case there the value is empty.
> Its not not pointing to the value but it may be accessed twice further on
> in this loop.
> 
> >  			opt_vlen = next_opt - eq; /* will be -1 if no value */

Yes, but note the next line ^^^ and the comment thereon.

This is followed later by a check:

				if (opt_vlen <= 0)
					goto bad_option_value;

in the dnserror option handler.

Note, also, there is guaranteed to be a NUL char included at the end of the
payload data, and that this is checked:

	if (datalen <= 1 || !data || data[datalen - 1] != '\0') {

David
