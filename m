From: David Howells <dhowells@redhat.com>
Date: Tue, 22 Oct 2019 10:35:33 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <11434.1571740533@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
 <000000000000830fe50595115344@google.com>
 <00000000000071e2fc05951229ad@google.com>
In-Reply-To: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc: aou@eecs.berkeley.edu, syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, Palmer Dabbelt <palmer@sifive.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, James Morris James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, LSM List <linux-security-module@vger.kernel.org>, keyrings@vger.kernel.org, linux-riscv@lists.infradead.org, "Serge E. Hallyn" <serge@hallyn.com>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > syzbot has bisected this bug to 0570bc8b7c9b ("Merge tag
> >  'riscv/for-v5.3-rc1' ...")
> 
> Yeah, that looks unlikely. The only non-riscv changes are from
> documentation updates and moving a config variable around.
> 
> Looks like the crash is quite unlikely, and only happens in one out of
> ten runs for the ones it has happened to.
> 
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

I'm wondering if this is actually a bug in the error handling in the encrypted
key type.  Looking in the syzbot console log, there's a lot of output from
there prior to the crash, of which the following is an excerpt:

[  248.516746][T27381] encrypted_key: key user:syz not found
[  248.524392][T27382] encrypted_key: key user:syz not found
[  248.616141][T27392] encrypted_key: key user:syz not found
[  248.618890][T27393] encrypted_key: key user:syz not found
[  248.690844][T27404] encrypted_key: key user:syz not found
[  248.739405][T27403] encrypted_key: key user:syz not found
[  248.804881][T27417] encrypted_key: key user:syz not found
[  248.828354][T27418] encrypted_key: keyword 'new' not allowed when called from .update method
[  248.925249][T27427] encrypted_key: keyword 'new' not allowed when called from .update method
[  248.928200][T27415] Bad refcount user syz
[  248.934043][T27428] encrypted_key: key user:syz not found
[  248.939502][T27429] encrypted_key: key user:syz not found
[  248.968744][T27434] encrypted_key: key user:syz not found
[  248.982201][T27415] ==================================================================
[  248.996072][T27415] BUG: KASAN: use-after-free in refcount_inc_not_zero_checked+0x81/0x200

Note that the "Bad refcount user syz" is a bit I patched in to print the type
and description of the key that incurred the error.

It's a tad difficult to say exactly what's going on since I've no idea what
the syzbot reproducer is actually doing.

#{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"namespace","fault_call":-1,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"tmpdir":true,"segv":true}
perf_event_open(&(0x7f000001d000)={0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0, 0x7f, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x7, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
keyctl$instantiate(0xc, 0x0, &(0x7f0000000100)=ANY=[@ANYBLOB='new default user:syz 04096'], 0x1, 0x0)
r0 = add_key(&(0x7f0000000140)='encrypted\x00', &(0x7f0000000180)={'syz'}, &(0x7f0000000100), 0xca, 0xfffffffffffffffe)
add_key$user(&(0x7f0000000040)='user\x00', &(0x7f0000000000)={'syz'}, &(0x7f0000000440)='X', 0x1, 0xfffffffffffffffe)
keyctl$read(0xb, r0, &(0x7f0000000240)=""/112, 0x349b7f55)

However, it looks like the encrypted key type is trying to access a user key,
so maybe there's an overput there?  I'm trying to insert more debugging, but
the test doesn't always fail.

syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:

> HEAD commit:    bc88f85c kthread: make __kthread_queue_delayed_work static
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1730584b600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
> dashboard link: https://syzkaller.appspot.com/bug?extid=6455648abc28dbdd1e7f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000

David
