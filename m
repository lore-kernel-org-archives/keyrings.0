From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 02 Nov 2019 22:30:49 +0000
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
Message-Id: <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
In-Reply-To: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



> On Nov 2, 2019, at 3:04 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> ﻿On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>> 
>> Add in the fact that it’s not obvious that vmsplice *can* be used correctly, and I’m wondering if we should just remove it or make it just do write() under the hood.
> 
> Sure it can. Just don't modify the data you vmsplice. It's really that simple.

So you allocate memory, vmsplice, and munmap() without reusing it?  Just plain free() won’t be good enough. I suspect the TLB overhead will make this a loss in most workloads?

Or maybe you vmsplice from a read-only mapping of a file that you know no one modifies?  This could be useful, but you can just splice() from the file directly.
