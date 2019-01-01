From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 Jan 2019 21:08:41 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=whb31a-4-ac6iBM-2tDMb9cEHogU788ASpfw+Uk+DAM+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
 <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
 <1545076260.2878.15.camel@HansenPartnership.com> <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
 <20181231224530.GA12425@zzz.localdomain>
In-Reply-To: <20181231224530.GA12425@zzz.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, Dec 31, 2018 at 2:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> KEYCTL_PKEY_QUERY is still failing basic fuzzing even after Linus' fix that
> changed Opt_err from -1 to 0.  The crash is still in keyctl_pkey_params_parse():
>
>                 token = match_token(p, param_keys, args);
>                 if (__test_and_set_bit(token, &token_mask))
>                         return -EINVAL;
>                 q = args[0].from;
>                 if (!q[0])
>                         return -EINVAL;
>
> Now it crashes on '!q[0]' because 'args[0].from' is uninitialized when
> token = Opt_err.  args[0] is only initialized when the parsed token had a
> pattern that set it.

Argh., how embarrassing. And it turns out that James' suggestion to
initialize token_mask would actually have fixed that, for subtle
reasons (but subtle was what I didn't want).

I detest that match_token() interface, but this key code then mis-uses
it in ways it wasn't even meant for, and tries to "share" error paths
that aren't actually common.

I'll take your original patch, which I clearly should have done originally.

Thanks, and sorry for the wasted time,

             Linus
