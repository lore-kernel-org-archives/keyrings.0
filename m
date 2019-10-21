From: David Howells <dhowells@redhat.com>
Date: Mon, 21 Oct 2019 15:59:13 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <8509.1571673553@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000830fe50595115344@google.com>
In-Reply-To: <000000000000830fe50595115344@google.com>
To: syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com

syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:

> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000

How do I tell what's been passed into the add_key for the encrypted key?

David
