From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 25 Jun 2018 17:37:24 +0000
Subject: Re: [PATCH net] KEYS: DNS: fix parsing multiple options
Message-Id: <20180625173724.GB180889@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180608162037.129802-1-ebiggers3@gmail.com>
 <8195.1528992870@warthog.procyon.org.uk>
In-Reply-To: <8195.1528992870@warthog.procyon.org.uk>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Wang Lei <wang840925@gmail.com>, Eric Biggers <ebiggers@google.com>

On Thu, Jun 14, 2018 at 05:14:30PM +0100, David Howells wrote:
> The fix seems to work, but the use of kstrtoul():
> 
> 	ret = kstrtoul(eq, 10, &derrno);
> 
> is incorrect since the buffer can't been modified to block out the next
> argument if there is one, so the following fails:
> 
> 	perl -e 'print "#dnserror=1#", "\x00" x 1' |
> 	keyctl padd dns_resolver desc @s
> 
> (Note this is preexisting and nothing to do with your patch).
> 
> I'm not sure how best to handle this.
> 
> Anyway, Dave, can you take Eric's patch into the net tree with:
> 
> 	Acked-by: David Howells <dhowells@redhat.com>
> 
> David

It could be handled by copying the option value to a temporary buffer.
Anyway, that can be a separate fix...

David (Miller), are you planning to take this through -net?

Thanks!

- Eric
