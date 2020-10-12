From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Mon, 12 Oct 2020 20:30:50 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <aviro@redhat.com>
Cc: mtk.manpages@gmail.com, David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>

[CC += Davide]

Hello Linus,

Thanks for your quick reply.

On 10/12/20 9:25 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 11:40 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Between Linux 5.4 and 5.5 a regression was introduced in the operation
>> of the epoll EPOLLET flag. From some manual bisecting, the regression
>> appears to have been introduced in
>>
>>          commit 1b6b26ae7053e4914181eedf70f2d92c12abda8a
>>          Author: Linus Torvalds <torvalds@linux-foundation.org>
>>          Date:   Sat Dec 7 12:14:28 2019 -0800
>>
>>              pipe: fix and clarify pipe write wakeup logic
>>
>> (I also built a kernel from the  immediate preceding commit, and did
>> not observe the regression.)
> 
> So the difference from that commit is that now we only wake up a
> reader of a pipe when we add data to it AND IT WAS EMPTY BEFORE.
> 
>> The aim of ET (edge-triggered) notification is that epoll_wait() will
>> tell us a file descriptor is ready only if there has been new activity
>> on the FD since we were last informed about the FD. So, in the
>> following scenario where the read end of a pipe is being monitored
>> with EPOLLET, we see:
>>
>> [Write a byte to write end of pipe]
>> 1. Call epoll_wait() => tells us pipe read end is ready
>> 2. Call epoll_wait() [again] => does not tell us that the read end of
>> pipe is ready
> 
> Right.
> 
>> If we go further:
>>
>> [Write another byte to write end of pipe]
>> 3. Call epoll_wait() => tells us pipe read end is ready
> 
> No.
> 
> The "read end" readiness has not changed. It was ready before, it's
> ready now, there's no change in readiness.
> 
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not, so epoll got woken up even if the readiness
> didn't actually change.
> 
> So we do have a change in behavior.
> 
> However, clearly your test is wrong, and there is no edge difference.
> 
> Now, if this is more than just a buggy test - and it actually breaks
> some actual application and real behavior - we'll need to fix it. A
> regression is a regression, and we'll need to be bug-for-bug
> compatible for people who depended on bugs.

I don't think this is correct. The epoll(7) manual page
sill carries the text written long ago by Davide Libenzi,
the creator of epoll:

    Since  even with edge-triggered epoll, multiple events can be gen‐
    erated upon receipt of multiple chunks of data, the caller has the
    option  to specify the EPOLLONESHOT flag, to tell epoll to disable
    the associated file descriptor after the receipt of an event  with
    epoll_wait(2).

My reading of that text is that in the scenario that I describe a
readiness notification should be generated at step 3 (and indeed
should be generated whenever additional data bleeds into the channel).
Indeed, the very rationale for the existence of the EPOLLONESHOT flag
is to *prevent* notifications in such circumstances. And, as I noted,
sockets and terminals do (still) behave in the way that I expect in
this scenario.

So, I don't think this is a buggy test. It (still) appears to me
that this is a breakage of intended and documented behavior.
(Whether it breaks some actual application, I do not know. But
I have also seen that sometimes reports of such breakages take
a very time to come in.)

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
