From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Oct 2020 19:28:38 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
To: Michael Kerrisk-manpages <mtk.manpages@gmail.com>, Alexander Viro <aviro@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Mon, Oct 12, 2020 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not [..]

That "writers" should be "readers", of course.

Although yes, that commit changed it for both readers and writers: if
the pipe was readable from before, then a writer adding new data to it
doesn't make it "more readable". Similarly, if a pipe was writable
before, and a reader made even more room in it, the pipe didn't get
"more writable".

So that commit removes the pointless extra wakeup calls that don't
actually make any sense (and that gave incorrect edges to the some
EPOLL case that saw an edge that didn't actually exist).

              Linus
