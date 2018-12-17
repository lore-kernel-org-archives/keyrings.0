From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Dec 2018 18:43:34 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
In-Reply-To: <20181217181244.220052-1-ebiggers@kernel.org>
To: ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, Dec 17, 2018 at 10:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Linus, please consider applying this patch.  It's been ignored by the
> keyrings maintainer for a month and a half with multiple reminders.  It
> fixes an easily reachable stack corruption in the new keyctl operations
> that were added in v4.20.  It was immediately reached by syzbot even
> without any definitions for the new keyctls yet.

The getoptions() code in security/keys/trusted.c has exactly the same
buggy pattern, and seems to actually be the source of that idiocy.

Mind fixing that one too and getting rid of this incorrect code entirely?

Also, maybe the right fix is to do the "check for duplicate tokens"
only *after* all the other validation (ie after the switch())?

Or maybe just remove it entirely, since it's clearly entirely
incorrect from the very start.

Finally, the code was actually originally introduced in commit
5208cc83423d ("keys, trusted: fix: *do not* allow duplicate key
options"), this second place you found is just pattern matching from
that original garbage, that was acked and "reviewed" by several
people. The fix should have that clarification. Commit 00d60fd3b932
wasn't the _origin_ of this bug, even if it made a copy of it.

Looking around, nobody else has picked up that incorrect pattern.

                   Linus
