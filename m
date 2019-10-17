From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Oct 2019 15:53:06 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000830fe50595115344@google.com>
 <00000000000071e2fc05951229ad@google.com>
In-Reply-To: <00000000000071e2fc05951229ad@google.com>
To: syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
Cc: aou@eecs.berkeley.edu, Palmer Dabbelt <palmer@sifive.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, James Morris James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, keyrings@vger.kernel.org, linux-riscv@lists.infradead.org, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, Oct 16, 2019 at 7:42 PM syzbot
<syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to 0570bc8b7c9b ("Merge tag
>  'riscv/for-v5.3-rc1' ...")

Yeah, that looks unlikely. The only non-riscv changes are from
documentation updates and moving a config variable around.

Looks like the crash is quite unlikely, and only happens in one out of
ten runs for the ones it has happened to.

The backtrace looks simple enough, though:

  RIP: 0010:refcount_inc_checked+0x2b/0x30 lib/refcount.c:156
   __key_get include/linux/key.h:281 [inline]
   find_key_to_update+0x67/0x80 security/keys/keyring.c:1127
   key_create_or_update+0x4e5/0xb20 security/keys/key.c:905
   __do_sys_add_key security/keys/keyctl.c:132 [inline]
   __se_sys_add_key security/keys/keyctl.c:72 [inline]
   __x64_sys_add_key+0x219/0x3f0 security/keys/keyctl.c:72
   do_syscall_64+0xd0/0x540 arch/x86/entry/common.c:296
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

which to me implies that there's some locking bug, and somebody
released the key without holding a lock.

That code looks a bit confused to me. Releasing a key without holding
a lock looks permitted, but if that's the case then __key_get() is
complete garbage. It would need to use 'refcount_inc_not_zero()' and
failure would require failing the caller.

But I haven't followed the key locking rules, so who knows. That "put
without lock" scenario would explain the crash, though.

David?

              Linus
