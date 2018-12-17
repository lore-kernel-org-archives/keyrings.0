From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Dec 2018 18:49:59 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
To: ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, Dec 17, 2018 at 10:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or maybe just remove it entirely, since it's clearly entirely
> incorrect from the very start.

.. or another alternative: remove the "Opt_err = -1" entirely.

Again, this seems to be a buggy pattern exclusive to the security
code. Nobody else does it, and using that negative value is basically
the source of those two bugs. It seems pointless and wrong.

So the *simplest* fix would seem to be to literally remove all those
"= -1" for the Opt_err initialization.  Making the code smaller,
simpler, and fixing the bug in the process.

Hmm?

                 Linus
