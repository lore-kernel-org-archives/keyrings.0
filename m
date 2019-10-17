From: syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
Date: Thu, 17 Oct 2019 02:42:00 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <00000000000071e2fc05951229ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
In-Reply-To: <000000000000830fe50595115344@google.com>
References: <000000000000830fe50595115344@google.com>
In-Reply-To: <000000000000830fe50595115344@google.com>
To: aou@eecs.berkeley.edu, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, palmer@sifive.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org

syzbot has bisected this bug to:

commit 0570bc8b7c9b41deba6f61ac218922e7168ad648
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jul 18 19:26:59 2019 +0000

     Merge tag 'riscv/for-v5.3-rc1' of =20
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b6e2bb600000
start commit:   bc88f85c kthread: make __kthread_queue_delayed_work static
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b6e2bb600000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6e2bb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=E0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extidd55648abc28dbdd1e7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000

Reported-by: syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com
Fixes: 0570bc8b7c9b ("Merge tag 'riscv/for-v5.3-rc1' of =20
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
