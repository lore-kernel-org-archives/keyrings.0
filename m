From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 17 Dec 2018 19:51:00 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <1545076260.2878.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com>
         <20181217181244.220052-1-ebiggers@kernel.org>
         <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
         <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
         <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
         <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
In-Reply-To: <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, 2018-12-17 at 11:39 -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 11:06 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Honestly, for being about "security", all of this code seems to be
> > doing some really questionable things with all those Opt_xyz enums.
> 
> Yeah, at least security/keys/trusted.c ends up mixing that enum and
> just using "int" completely randomly, and you have datablob_parse()
> returning either a negative integer _or_ an "Opt_xyz" value, so
> having Opt_err be -1 is doubly confusing there (it would also be "-
> EPERM" depending on how you treat it).
> 
> There doesn't seem to be any _actual_ confusion (because Opt_err is
> always turned into an actual real error code), but it's  just another
> sign of "those enums should not be negative".
> 
> So on the whole, I think that the "Opt_err = -1" is a serious
> mistake, but at least for now, ima_policy.c clearly has (bogus) code
> that relies on it.
> 
> But the two cases that use "test_and_set_bit()" do not seem to have
> any reason to use that -1 enum, so while we can't do the "just remove
> -1" in general, I do think the proper fix is to just do it for those
> two files.
> 
> Eric, mind testing a patch like that? Untested patch attached just
> for completeness..

If this is to replace Eric's patch, didn't you want to set token_mask
to (1<<Opt_err)?

James
