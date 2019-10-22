From: David Howells <dhowells@redhat.com>
Date: Tue, 22 Oct 2019 13:17:36 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <24777.1571750256@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <11434.1571740533@warthog.procyon.org.uk>
 <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
 <000000000000830fe50595115344@google.com>
 <00000000000071e2fc05951229ad@google.com>
In-Reply-To: <11434.1571740533@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: aou@eecs.berkeley.edu, syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, Palmer Dabbelt <palmer@sifive.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, James Morris James Morris <jmorris@namei.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, LSM List <linux-security-module@vger.kernel.org>, keyrings@vger.kernel.org, linux-riscv@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, "Serge E. Hallyn" <serge@hallyn.com>

Okay, I managed to catch a backtrace for this line:

	encrypted_key: key user:syz not found (-126)

looking like:

	CPU: 0 PID: 8878 Comm: syz-executor.0 Not tainted 5.4.0-rc3+ #0
	Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
	Call Trace:
	 dump_stack+0x172/0x1f0
	 request_master_key.isra.0.cold+0x62/0xc3
	 encrypted_read+0x221/0x830
	 ? get_derived_key+0xf0/0xf0
	 ? keyctl_read_key+0x1c2/0x2b0
	 ? __kasan_check_write+0x14/0x20
	 ? down_read+0x109/0x430
	 ? security_key_permission+0x8d/0xc0
	 ? down_read_killable+0x490/0x490
	 ? key_task_permission+0x1b5/0x3a0
	 keyctl_read_key+0x231/0x2b0
	 __x64_sys_keyctl+0x171/0x470
	 do_syscall_64+0xfa/0x760
	entry_SYSCALL_64_after_hwframe+0x49/0xbe

So something somewhere is calling keyctl_read() in userspace on the encrypted
key and that is then referring across to the user key added.

Also, the encrypted key is being given the following payload:

	ENCRYPTED: 'new default user:syz 04096'

in at least one of the cases that encrypted_update() being called.

David
