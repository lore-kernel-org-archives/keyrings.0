From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 21 Oct 2019 16:05:41 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <CACT4Y+ZZ2tmUg9PAKouK5zhNw=BDWD7+jfo_JjB92Eb+g_gAQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000830fe50595115344@google.com> <8509.1571673553@warthog.procyon.org.uk>
In-Reply-To: <8509.1571673553@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, "Serge E. Hallyn" <serge@hallyn.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>

On Mon, Oct 21, 2019 at 5:59 PM David Howells <dhowells@redhat.com> wrote:
>
> syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:
>
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?xc8adab600000
>
> How do I tell what's been passed into the add_key for the encrypted key?

Hi David,

The easiest and most reliable would be to run it and dump the data in
the kernel function.
