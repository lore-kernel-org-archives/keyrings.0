From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Oct 2020 19:25:44 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
In-Reply-To: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
To: Michael Kerrisk-manpages <mtk.manpages@gmail.com>, Alexander Viro <aviro@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Mon, Oct 12, 2020 at 11:40 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Between Linux 5.4 and 5.5 a regression was introduced in the operation
> of the epoll EPOLLET flag. From some manual bisecting, the regression
> appears to have been introduced in
>
>          commit 1b6b26ae7053e4914181eedf70f2d92c12abda8a
>          Author: Linus Torvalds <torvalds@linux-foundation.org>
>          Date:   Sat Dec 7 12:14:28 2019 -0800
>
>              pipe: fix and clarify pipe write wakeup logic
>
> (I also built a kernel from the  immediate preceding commit, and did
> not observe the regression.)

So the difference from that commit is that now we only wake up a
reader of a pipe when we add data to it AND IT WAS EMPTY BEFORE.

> The aim of ET (edge-triggered) notification is that epoll_wait() will
> tell us a file descriptor is ready only if there has been new activity
> on the FD since we were last informed about the FD. So, in the
> following scenario where the read end of a pipe is being monitored
> with EPOLLET, we see:
>
> [Write a byte to write end of pipe]
> 1. Call epoll_wait() => tells us pipe read end is ready
> 2. Call epoll_wait() [again] => does not tell us that the read end of
> pipe is ready

Right.

> If we go further:
>
> [Write another byte to write end of pipe]
> 3. Call epoll_wait() => tells us pipe read end is ready

No.

The "read end" readiness has not changed. It was ready before, it's
ready now, there's no change in readiness.

Now, the old pipe behavior was that it would wake up writers whether
they needed it or not, so epoll got woken up even if the readiness
didn't actually change.

So we do have a change in behavior.

However, clearly your test is wrong, and there is no edge difference.

Now, if this is more than just a buggy test - and it actually breaks
some actual application and real behavior - we'll need to fix it. A
regression is a regression, and we'll need to be bug-for-bug
compatible for people who depended on bugs.

But if it's only a test, and no actual workflow that got broken, then
it's just a buggy test.

[ Adding Al to the participants, not because he has anything to do
with this pipe change, but because he's been working on epoll
cleanups, and I just want him to be aware of this thread. Al - Michael
has a test program for this thing that may or may not be worth keeping
in mind ]

                  Linus
