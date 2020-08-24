From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Aug 2020 15:27:32 +0000
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
Message-Id: <329586.1598282852@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200807160531.GA1345000@erythro.dev.benboeckel.internal> <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
In-Reply-To: <20200807160531.GA1345000@erythro.dev.benboeckel.internal>
To: me@benboeckel.net
Cc: dhowells@redhat.com, mtk.manpages@gmail.com, torvalds@linux-foundation.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

> > +In the case of message loss,
> > +.BR read (2)
> > +will fabricate a loss message and pass that to userspace immediately after the
> > +point at which the loss occurred.
> 
> If multiple messages are dropped in a row, is there one loss message per
> loss message or per loss event?

One loss message.  I set a flag on the last slot in the pipe ring to say that
message loss occurred, but there's insufficient space to store a counter
without making the slot larger (and I really don't want to do that).

Note that every slot in the pipe ring has such a flag, so you could,
theoretically, get a loss message after every normal message that you read
out.

> > +A notification pipe allocates a certain amount of locked kernel memory (so that
> > +the kernel can write a notification into it from contexts where allocation is
> > +restricted), and so is subject to pipe resource limit restrictions.
> 
> A reference to the relevant manpage for resource limitations would be
> nice here. I'd assume `setrlimit(2)`, but I don't see anything
> pipe-specific there.

I can change that to:

	... and so is subject to pipe resource limit restrictions - see
	.BR pipe (7),
	in the section on
	.BR "/proc files" .

> > +of interest to the watcher, a filter can be set on a queue to determine whether
> 
> "a filter can be set"? If multiple filters are allowed, "filters can be
> added" might work better here to indicate that multiple filters are
> allowed. Otherwise, "a single filter" would make it clearer that only
> one is supported.

How about:

	Because a source can produce a lot of different events, not all of
	which may be of interest to the watcher, a single set of filters can
	be set on a queue to determine whether a particular event will get
	inserted in a queue at the point of posting inside the kernel.

> Are there macros for extracting these fields available?

WATCH_INFO_LENGTH, WATCH_INFO_ID and WATCH_INFO_TYPE_INFO are masks.  There
are also shift macros (you add __SHIFT to the mask macro name).  I'm not sure
how best to do this in troff.

> Why not also have bitfields for these?

It makes it a lot simpler to filter.

> Or is there some ABI issues with
> non-power-of-2 bitfield sizes? For clarity, which bit is bit 0? Low address
> or LSB? Is this documented in some other manpage?

bit 0 is 2^0 in this case.  I'm not sure how better to describe it.

> Also, bit 7 is unused (for alignment I assume)? Is it always 0, 1, or
> indeterminate?

It's reserved and should always be 0 - but that's solely at the kernel's
discretion (ie. userspace doesn't gets to set it).

> > +This is used to set filters on the notifications that get written into the
> 
> "set" -> "add"? If I call this multiple times, is only the last call
> effective or do I need to keep a list of all filters myself so I can
> append in the future (since I see no analogous GET_FILTER call)?

"Set".  You cannot add filters, you can only set/replace/remove the whole set.

Also, I didn't provide a GET_FILTER, assuming that you could probably keep
track of them yourself.

> Does this have implications for criu restoring a process?

Maybe?

> > +	unsigned char buf[128];
> 
> Is 128 the maximum message size?

127 actually.  This is specified earlier in the manual page.

> Do we have a macro for this? If it isn't, shouldn't there be code for
> detecting ENOBUFS and using a bigger buffer? Or at least not rolling with a
> busted buffer.

WATCH_INFO_LENGTH can be used for this.  I'll make the example say:

	unsigned char buf[WATCH_INFO_LENGTH];

> > +	case WATCH_TYPE_META:
> 
> From above, if a filter is added, all messages not matching a filter are
> dropped. Are WATCH_TYPE_META messages special in this case?

Yes.  They only do two things at the moment: Tell you that something you were
watching went away and tell you that messages were lost.  I've amended the
filter section to note that this cannot be filtered.

> The Rust developer in me wants to see:

I don't touch Rust ;-)

> 	default:
> 		/* Subtypes may be added in future kernel versions. */
> 		printf("unrecognized meta subtype: %d\n", n->subtype);
> 		break;
> 
> unless we're guaranteeing that no other subtypes exist for this type
> (updating the docs with new types doesn't help those who copy/paste from
> here as a seed).

I'm trying to keep the example small.  It's pseudo-code rather than real code.
I *could* expand it to a fully working program, but that would make it a lot
bigger and harder to read.  As you pointed out, I haven't bothered with the
error checking, for example.

David
