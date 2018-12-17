From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Dec 2018 20:31:31 +0000
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <CAHk-=whO8vApZK-4zBeEhUm4Mp-OMii1V9oVCmoOaGZ2faitcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com> <1545078067.10804.13.camel@linux.ibm.com>
In-Reply-To: <1545078067.10804.13.camel@linux.ibm.com>
To: zohar@linux.ibm.com
Cc: ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com

On Mon, Dec 17, 2018 at 12:21 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> It's being used for parsing and displaying the policy, which do need
> to be in sync.

Yes, but it needs a comment somewhere.

Also, the way you use those enums as array indices also implies that
for your case, Opt_err should definitely not be -1, and it should
instead be at the *end* of the enum list (the same way it's at the end
of the array).

That would also automatically mean that "Opt_measure" would have value
0, and the pl(token) macro shouldn't need any offsetting at all,
because the enums and the array indices just automatically match up
(as long as they are always updated together!)

               Linus
