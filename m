From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 09 Jul 2019 03:25:07 +0000
Subject: Re: keyrings pull requests for the next merge window
Message-Id: <CAHk-=wjEowdfG7v_4ttu3xhf9gqopj1+q1nGG86+mGfGDTEBBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <10976.1562256893@warthog.procyon.org.uk>
In-Reply-To: <10976.1562256893@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, keyrings@vger.kernel.org

[ Adding a few mailing lists, since the thrust of my email is about
more people being around and involved, and the pull requests
themselves were indeed cc'd to the mailing lists too ]

On Thu, Jul 4, 2019 at 9:15 AM David Howells <dhowells@redhat.com> wrote:
>
> I have a bunch of keyrings patches to be pulled in during the merge window.  I
> believe you want security patches to go directly to you rather than through
> James now?
>
> I've divided these patches into four logical sets, though due to conflicting
> changes the sets are in a sequence, built one upon another.
>
> How do you want them presenting?  Do you want a pull request for each set, one
> for all of them or would you prefer they go through James's security tree?

So I was traveling when this email came in, but in the meantime you
sent the four pull requests and I have now pulled them all. You should
have gotten the pr-tracker-bot notification already (or it will happen
soon).

An initial very positive comment: the pull requests themselves with
all the explanations were very good. That part of the process worked
very well, I think.

I felt like I got an explanation of what I pulled, and I think the
merge commits themselves are the better for it, so that the
explanation now remains in the git history, and other people too can
see what got merged and why.

HOWEVER.

There are parts I really didn't much like was when I look at all the
individual commits themselves.

Again, the commit messages there are good and that part all looks fine.

BUT.

The history itself looks questionable. The dates don't make sense, and
the different branches were obviously all done together as a linear
history, rebased, and worked on as one single branch, . Fine - it was
then at least partitioned into sensible parts, and sometimes this is
how it really ends up working, but I did get the feeling that this was
all very artificial and more importantly I get the feeling that none
of the commits had any real-life exposure.

That lack of real-life exposure also shows in the almost complete lack
of any reviews, any commentary from other people, and absolutely
nobody else seems to have been involved. Not as an author, but not in
any other capacity either. There were a couple of initial commits that
had reviewed-by's, but apart from that there really was *no* sign of
any outside involvement at all.

I looked up a couple of the patches on patchwork too, and saw zero
discussion. Maybe the ones I picked just happened to have none, but I
really get the feeling that pretty much none of this had any external
input what-so-ever.

And that makes me unhappy.

In other words: the pull requests, the explanations, everything looked
very good and I enjoyed that part. I don't see any new warnings, and
everything built fine at every stage. I have no real technical
complaints from that angle.

But I absolutely abhor how this seems to all have been developed in a
complete and utter vacuum. That just fundamentally worries me.  I
can't point to anything being bad, but the lack of any kind of work
from anybody else just makes me antsy.

Is there really nobody else working or caring about this at all?

This is not new, and I do note that your afs work tends to have the
same pattern (but honestly, when it comes to one particular odd
filesystem or driver, it's not something I react to). It's just
perhaps more noticeable to me now that I pull directly, and it's much
more noticeable when it's a _subsystem_ rather than something like a
end-point driver/filesystem. I think the pulls themselves worked, and
I don't mind the direct pulling, but I *do* notice that I end up
minding the fact that now with the direct pulls, there's even _less_
of a "at least somebody else looked and cared".

Put another way: I'd like other people to be involved. Either as
reviewers, or as intermediate people, or _something_. The "David
Howells lives in his own world and nobody else looks at it and then he
sends it directly to Linus" model makes me somewhat unhappy.

Again, I'd like to stress that the pull requests themselves were fine,
and I have no complaints on that side and I have (at least as of yet)
no reason to worry about the code itself. It's really the "lone
developer sends directly to me" that stands out as not happening
elsewhere that I'm worried about.

Hmm?

                   Linus
