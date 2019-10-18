From: David Howells <dhowells@redhat.com>
Date: Fri, 18 Oct 2019 16:45:41 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <31946.1571417141@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <b211005b-75de-7936-c97a-817f7100415a@I-love.SAKURA.ne.jp> <000000000000830fe50595115344@google.com> <00000000000071e2fc05951229ad@google.com> <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com> <20191017160028.GA726@sol.localdomain>
In-Reply-To: <b211005b-75de-7936-c97a-817f7100415a@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> I don't know about keys, but I rather suspect lack of serialization locks
> between "looking up for checking existing keys" versus "looking up for
> garbage collection".

The garbage collector holds key_serial_lock when walking key_serial_tree
looking for keys to destroy.

As the gc is the *only* thing that is permitted to remove a key from
key_serial_tree, it can safely keep a cursor pointer to the node it was
looking at when it drops the lock - and then resume scanning once it has taken
the lock again.

When find_key_to_update() is looking for a key that might be updated, the
caller *must* be holding the destination keyring lock and every key in the
keyring should have at least one ref on it held by the keyring - so none of
them should get destroyed by the garbage collector.

David
