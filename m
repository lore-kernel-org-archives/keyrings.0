From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Dec 2018 20:02:01 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
 <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com> <1545076260.2878.15.camel@HansenPartnership.com>
In-Reply-To: <1545076260.2878.15.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, Dec 17, 2018 at 11:51 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> If this is to replace Eric's patch, didn't you want to set token_mask
> to (1<<Opt_err)?

No, let's not add any extra code that is trying to be subtle. Subtle
interactions was where the bug came from.

The code already checks the actual Opt_xyz for errors in a switch
statement. The token_mask should be _purely_ about duplicate options
(or conflicting ones).

Talking about the conflicting ones: Opt_hash checks that
Opt_policydigest isn't set. But Opt_policydigest doesn't check that
Opt_hash isn't set, so you can mix the two if you just do it in the
right order.

But that's a separate bug, and doesn't seem to be a huge deal.

But it *is* an example of how bogus all of this stuff is. Clearly
people weren't really paying attention when writing any of this code.

                        Linus
