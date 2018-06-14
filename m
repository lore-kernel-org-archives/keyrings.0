From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Jun 2018 16:14:30 +0000
Subject: Re: [PATCH net] KEYS: DNS: fix parsing multiple options
Message-Id: <8195.1528992870@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180608162037.129802-1-ebiggers3@gmail.com>
In-Reply-To: <20180608162037.129802-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, Wang Lei <wang840925@gmail.com>, Eric Biggers <ebiggers@google.com>

The fix seems to work, but the use of kstrtoul():

	ret = kstrtoul(eq, 10, &derrno);

is incorrect since the buffer can't been modified to block out the next
argument if there is one, so the following fails:

	perl -e 'print "#dnserror=1#", "\x00" x 1' |
	keyctl padd dns_resolver desc @s

(Note this is preexisting and nothing to do with your patch).

I'm not sure how best to handle this.

Anyway, Dave, can you take Eric's patch into the net tree with:

	Acked-by: David Howells <dhowells@redhat.com>

David
