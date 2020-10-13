From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Tue, 13 Oct 2020 09:47:09 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <300cb158-5ab1-ed55-404f-8abc9cbdcae0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
 <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
 <CAHk-=wjYN_80i=9ALMwxZ77_TS_TMjkVyZ261xtuiMUaZsM4ng@mail.gmail.com>
In-Reply-To: <CAHk-=wjYN_80i=9ALMwxZ77_TS_TMjkVyZ261xtuiMUaZsM4ng@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mtk.manpages@gmail.com, Alexander Viro <aviro@redhat.com>, David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>

Hello Linus,

On 10/13/20 12:30 AM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> I don't think this is correct. The epoll(7) manual page
>> sill carries the text written long ago by Davide Libenzi,
>> the creator of epoll:
>>
>>     Since  even with edge-triggered epoll, multiple events can be gen‐
>>     erated upon receipt of multiple chunks of data, the caller has the
>>     option  to specify the EPOLLONESHOT flag, to tell epoll to disable
>>     the associated file descriptor after the receipt of an event  with
>>     epoll_wait(2).
> 
> Hmm.
> 
> The more I read that paragraph, the more I think the epoll man-page
> really talks about something that _could_ happen due to internal
> implementation details, but that isn't really something an epoll user
> would _want_ to happen or depend on.
> 
> IOW, in that whole "even with edge-triggered epoll, multiple events
> can be generated", I'd emphasize the *can* part (as in "might", not as
> in "will"), and my reading is that the reason EPOLLONESHOT flag exists
> is to avoid that whole "this is implementation-defined, and if you
> absolutely _must_ get just a single event, you need to use
> EPOLLONESHOT to make sure you remove yourself after you got the one
> single event you waited for".

I agree that that is also a valid alternate reading of the text, 
in particular, "can" could be read as "might" rather than "will".

I also agree that the semantics before the change were odd
(but see [3]).

But...

> The corollary of that reading is that the new pipe behavior is
> actually the _expected_ one, and the old pipe behavior where we would
> generate multiple events is the unwanted implementation detail of
> "this might still happen, and if you care, you will need to do extra
> stuff".

"expected" by who? I mean, there were established semantics
for pipes/FIFOs in this scenario. Those semantics changed in
Linux 5.5.

However, those established EPOLLET semantics are still (I tested
each of these) followed by:

* Sockets (tested in Internet domain)
* Terminals
* POSIX message queues
* Hierarchical epoll instances; for example:
  - epoll FD X monitors epoll FD Y with EPOLLET
  - epoll FD Y monitors two FDs, A and B, for EPOLLIN
  - input arrives on FD A
  - epoll_wait on X returns EPOLLIN for FD Y
  - next epoll_wait on X doesn't inform us that Y is ready
  - input arrives on B
  - epoll_wait on X returns EPOLLIN for FD Y

I would say that users *expect* at least the following:

* That semantics don't change unexpectedly.
* That semantics are consistent.

In Linux 5.5, the pipe EPOLLET semantics changed unexpectedly.
And now, pipes have EPOLLET semantics that are inconsistent with
every other type of FD (that I tested).

> Anyway, I don't absolutely hate that patch of mine, but it does seem
> nonsensical and pointless, and I think I'll just hold off on applying
> it until we hear of something actually breaking.

The problem is that sometimes it takes a very long time to hear
of something breaking. For example, a Linux 3.5 regression in
the POSIX message queue API was only fixed in 3.14 [1], and only
after the breakage was reported as a man-pages bug(!) a year
after the breakage.

And sometimes, if things don't get fixed soon enough, then
any fix will break new users. Thus we now have F_SETOWN_EX
(2.6.32) to do what F_SETOWN used to do before a regression
that occurred about 4 years earlier (2.6.12) (see [2]), because
reverting the F_SETOWN semantics to what they originally 
were might have broken some new apps that had appeared in
those four years.

> Which I suspect simply won't happen. Getting two epoll notifications
> when the pipe state didn't really change in between is not something I
> can see anybody really depending on.
> 
> You _will_ get the second notification if somebody actually emptied
> the pipe in between, and you have a real new "edge".
> 
> But hey, I am continually surprised by what user space code then
> occasionally does, despite my fairly low expectations.

Yes, user space code does surprising things. But, give people
enough time and every detail of API behavior will come
to be depended upon by someone. We don't know if anyone
depends on the old pipe EPOLLET behavior. I also imagine the
chances are small, but if users do depend on it, they are
in for an unpleasant surprise (missed notifications).

We can all agree that the existing EPOLLET are perhaps strange.
However, why change these semantics just for pipes? In other
words, given my notes above about consistency, what is the
argument for not applying the patch? IOW, I think "consistency"
is a rather stronger argument than "but it seems nonsensical
and pointless"; YMMV.

Cheers,

Michael

[1] See the discussion of HARD_QUEUESMAX in
https://www.man7.org/linux/man-pages/man7/mq_overview.7.html#BUGS

[2]
https://www.man7.org/linux/man-pages/man2/fcntl.2.html

[3]
Leakage of implementation details into the API is hardly
unprecedented; thus, for example, POSIX permits spurious
wake-ups on condition variable waiters to allow for
efficient CV implementation on multiprocessor systems.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
