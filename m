From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 12 Oct 2020 21:43:13 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
Message-Id: <22d3e535-564e-ebb9-991b-b328f9f806ed@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
 <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
 <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
In-Reply-To: <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Alexander Viro <aviro@redhat.com>, David Howells <dhowells@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Davide Libenzi <davidel@xmailserver.org>

On 10/12/20 1:52 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
> 
> I'm busy merging, mind testing this odd patch out? It is _entirely_
> untested, but from the symptoms I think it's the obvious fix.
> 
> I did the same thing for the "reader starting out from a full pipe" case too.
> 
>                Linus
> 

and if that patch tests good, then fix this typo, please:

+	 * Epoll nonsensically wants a wakeup wheher the pipe was

	                                      whether

thanks.
-- 
~Randy
