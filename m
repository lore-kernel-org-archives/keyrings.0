From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Aug 2020 17:54:01 +0000
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
Message-Id: <348448.1598291641@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200824165802.GB408760@erythro.dev.benboeckel.internal> <20200807160531.GA1345000@erythro.dev.benboeckel.internal> <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk> <329586.1598282852@warthog.procyon.org.uk>
In-Reply-To: <20200824165802.GB408760@erythro.dev.benboeckel.internal>
To: me@benboeckel.net
Cc: dhowells@redhat.com, mtk.manpages@gmail.com, torvalds@linux-foundation.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

> > One loss message.  I set a flag on the last slot in the pipe ring to say that
> > message loss occurred, but there's insufficient space to store a counter
> > without making the slot larger (and I really don't want to do that).
> > 
> > Note that every slot in the pipe ring has such a flag, so you could,
> > theoretically, get a loss message after every normal message that you read
> > out.
> 
> Ah, so a "you lost something" is just a flag on the next event that does
> make it into the queue? I read it as a whole message existed indicating
> that data was lost. Not sure of the best wording here.

No.  That flag is internal.  It causes read() to fabricate a message and
insert it into the user buffer after the flagged message has been copied over.

> > bit 0 is 2^0 in this case.  I'm not sure how better to describe it.
> 
> OK, so the bits are in native-endian order in the enclosing bytes. But C
> just doesn't have a set ABI for bitfields (AFAIK), so I guess it's
> "whatever GCC does" in practice?

Hard to say - powerpc and s390 have bit 0 as the MSB:-/

But "& (1 << 0)" gets you 2^0, whatever the CPU book says.

David
