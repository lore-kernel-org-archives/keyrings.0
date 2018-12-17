From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 17 Dec 2018 20:21:07 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <1545078067.10804.13.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com>
         <20181217181244.220052-1-ebiggers@kernel.org>
         <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
         <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
         <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, 2018-12-17 at 11:06 -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 10:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So the *simplest* fix would seem to be to literally remove all those
> > "= -1" for the Opt_err initialization.  Making the code smaller,
> > simpler, and fixing the bug in the process.
> 
> Something like this
> 
>     git  grep -l 'Opt_err = -1' | xargs sed -i 's/Opt_err = -1/Opt_err/'
> 
> would do it, but I also notice that
> security/integrity/ima/ima_policy.c then has some truly funky code
> that plays around with the enum numbers , ie
> 
>   #define pt(token)     policy_tokens[token + Opt_err].pattern

Yikes!

> which actually depends on the ordering of policy_tokens[], and depends
> on the exact values, ie it literally (and quite insanely) sets Opt_err
> to -1, and then Opt_measure to 1, and leaves 0 unused. That code
> seriously makes no sense at all, and is fundamentally broken.
> 
> It would be better to use
> 
>     #define pt(token)     policy_tokens[token - Opt_measure].pattern
> 
> instead, but even then you should have a huge comment about how the
> policy_tokens[] array absolutely has to be properly ordered.

Will do.

> 
> Honestly, for being about "security", all of this code seems to be
> doing some really questionable things with all those Opt_xyz enums.

It's being used for parsing and displaying the policy, which do need
to be in sync.

Mimi
