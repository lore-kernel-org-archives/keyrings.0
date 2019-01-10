From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 10 Jan 2019 22:29:28 +0000
Subject: Re: Bug report: unaligned access with ext4 encryption
Message-Id: <20190110222928.GB22416@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190103171659.GA208343@gmail.com>
 <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
 <17391.1546622882@warthog.procyon.org.uk>
In-Reply-To: <17391.1546622882@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

Hi,

On Fri, Jan 04, 2019 at 05:28:02PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> > Hi Aaro, thanks for the bug report!  I think you're on the right track; it makes
> > much more sense to have the keyrings subsystem store the payload with better
> > alignment, than to work around the 2-byte alignment in fscrypt.
> > 
> > But how about '__aligned(__alignof__(u64))' instead?  4 bytes may not be enough.
> > 
> > David, what do you think?
> 
> Does that even work?

That should work.

> Might be better to just insert 6 bytes of padding with a comment, but yes I
> agree that it's probably better to align it to at least machine word size.

Padding is fragile, e.g. if struct rcu_head changes. Using __aligned should
make it always right automatically.

A.
