From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Mon, 12 Oct 2020 21:51:37 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <85a6b7e0-d218-60e3-5147-b2548040de1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
 <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
 <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
In-Reply-To: <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mtk.manpages@gmail.com, Alexander Viro <aviro@redhat.com>, David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>

On 10/12/20 10:52 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> [CC += Davide]
> 
> I'm not sure how active Davide is any more..

Yep, I know. But just in case.

>> I don't think this is correct. The epoll(7) manual page
>> sill carries the text written long ago by Davide Libenzi,
>> the creator of epoll:
>>
>>     Since  even with edge-triggered epoll, multiple events can be gen‐
>>     erated upon receipt of multiple chunks of data, the caller has the
>>     option  to specify the EPOLLONESHOT flag, to tell epoll to disable
>>     the associated file descriptor after the receipt of an event  with
>>     epoll_wait(2).
>>
>> My reading of that text is that in the scenario that I describe a
>> readiness notification should be generated at step 3 (and indeed
>> should be generated whenever additional data bleeds into the channel).
> 
> Hmm.
> 
> That is unfortunate, because it basically exposes an internal wait
> queue implementation decision, not actual real semantics.

I don't disagree that the longstanding semantics are a little odd;
your comment explains perhaps why.

> I suspect it's easy enough to "fix" the regression with the attached
> patch. It's pretty nonsensical, but I guess there's not a lot of
> downside - if the pipe wasn't empty, there normally shouldn't be any
> non-epoll readers anyway.
> 
> I'm busy merging, mind testing this odd patch out? It is _entirely_
> untested, but from the symptoms I think it's the obvious fix.

Applied against current master (13cb73490f475). My test now
runs as I expected.

> I did the same thing for the "reader starting out from a full pipe" case too.

I haven't tested this, but thanks for thinking of it.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
