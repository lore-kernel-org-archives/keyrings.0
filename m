From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 02 Nov 2019 20:31:10 +0000
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
Message-Id: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <25886.1572723272@warthog.procyon.org.uk>
In-Reply-To: <25886.1572723272@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



> On Nov 2, 2019, at 12:34 PM, David Howells <dhowells@redhat.com> wrote:
> 
> ﻿Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>>>> Similar synchronization is required for reusing memory after vmsplice()?
>>>> I don't see other way how sender could safely change these pages.
> 
> Actually, it's probably worse than that.  If the output of the pipe gets teed
> or spliced somewhere else, you still don't know when the vmspliced pages are
> finished with.
> 
> 

I sometimes wonder whether vmsplice should be disallowed or severely restricted. Even ignoring these usability issues, it makes me very uncomfortable that you can have some data queue up on a pipe, tee() it, and get *different* data in the original pipe and the teed copy because the sender used vmsplice and is messing with you.

Add in the fact that it’s not obvious that vmsplice *can* be used correctly, and I’m wondering if we should just remove it or make it just do write() under the hood.

I suppose the kernel could guarantee that it stops referring to the vmsplice source pages as soon as anything sees *or* tees the data. This way it would be, at least in principle, possible to say “hey, the pipe has consumed the first n vmspliced bytes, so I can reuse that memory”.
