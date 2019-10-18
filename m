From: David Howells <dhowells@redhat.com>
Date: Fri, 18 Oct 2019 16:38:05 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <31180.1571416685@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
 <000000000000830fe50595115344@google.com>
 <00000000000071e2fc05951229ad@google.com>
In-Reply-To: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aou@eecs.berkeley.edu, syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, Palmer Dabbelt <palmer@sifive.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, James Morris James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, LSM List <linux-security-module@vger.kernel.org>, keyrings@vger.kernel.org, linux-riscv@lists.infradead.org, "Serge E. Hallyn" <serge@hallyn.com>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The backtrace looks simple enough, though:
> 
>   RIP: 0010:refcount_inc_checked+0x2b/0x30 lib/refcount.c:156
>    __key_get include/linux/key.h:281 [inline]
>    find_key_to_update+0x67/0x80 security/keys/keyring.c:1127
>    key_create_or_update+0x4e5/0xb20 security/keys/key.c:905
>    __do_sys_add_key security/keys/keyctl.c:132 [inline]
>    __se_sys_add_key security/keys/keyctl.c:72 [inline]
>    __x64_sys_add_key+0x219/0x3f0 security/keys/keyctl.c:72
>    do_syscall_64+0xd0/0x540 arch/x86/entry/common.c:296
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> which to me implies that there's some locking bug, and somebody
> released the key without holding a lock.
>
> That code looks a bit confused to me. Releasing a key without holding
> a lock looks permitted, but if that's the case then __key_get() is
> complete garbage. It would need to use 'refcount_inc_not_zero()' and
> failure would require failing the caller.

find_key_to_update() must be called with the keyring-to-be-searched locked, as
stated in the comment on that function.

If a key-to-be-updated can be found in that keyring, then the keyring must be
holding a ref on that key already, so it's refcount must be > 0, so it
shouldn't be necessary to use refcount_inc_not_zero().

There shouldn't be a race with key_link(), key_unlink(), key_move(),
keyring_clear() or keyring_gc() (garbage collection) as all of those take a
write-lock on the keyring.

> But I haven't followed the key locking rules, so who knows. That "put
> without lock" scenario would explain the crash, though.

That shouldn't explain it.  When key_put() reduces the refcount to 0, it just
schedules the garbage collector.  It doesn't touch the key again directly.

I would guess that something incorrectly put a ref when it shouldn't have.  Do
we know which type of key is involved?  Looking at the syzkaller reproducer,
it's adding an encrypted key and a user key to the process keyring -
presumably repeating the procedure within the same process, hence how it finds
something to update.

David
