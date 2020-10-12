From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Oct 2020 22:30:08 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <CAHk-=wjYN_80i=9ALMwxZ77_TS_TMjkVyZ261xtuiMUaZsM4ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com> <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
In-Reply-To: <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Alexander Viro <aviro@redhat.com>, David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>

On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> I don't think this is correct. The epoll(7) manual page
> sill carries the text written long ago by Davide Libenzi,
> the creator of epoll:
>
>     Since  even with edge-triggered epoll, multiple events can be gen‐
>     erated upon receipt of multiple chunks of data, the caller has the
>     option  to specify the EPOLLONESHOT flag, to tell epoll to disable
>     the associated file descriptor after the receipt of an event  with
>     epoll_wait(2).

Hmm.

The more I read that paragraph, the more I think the epoll man-page
really talks about something that _could_ happen due to internal
implementation details, but that isn't really something an epoll user
would _want_ to happen or depend on.

IOW, in that whole "even with edge-triggered epoll, multiple events
can be generated", I'd emphasize the *can* part (as in "might", not as
in "will"), and my reading is that the reason EPOLLONESHOT flag exists
is to avoid that whole "this is implementation-defined, and if you
absolutely _must_ get just a single event, you need to use
EPOLLONESHOT to make sure you remove yourself after you got the one
single event you waited for".

The corollary of that reading is that the new pipe behavior is
actually the _expected_ one, and the old pipe behavior where we would
generate multiple events is the unwanted implementation detail of
"this might still happen, and if you care, you will need to do extra
stuff".

Anyway, I don't absolutely hate that patch of mine, but it does seem
nonsensical and pointless, and I think I'll just hold off on applying
it until we hear of something actually breaking.

Which I suspect simply won't happen. Getting two epoll notifications
when the pipe state didn't really change in between is not something I
can see anybody really depending on.

You _will_ get the second notification if somebody actually emptied
the pipe in between, and you have a real new "edge".

But hey, I am continually surprised by what user space code then
occasionally does, despite my fairly low expectations.

              Linus
