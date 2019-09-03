From: David Howells <dhowells@redhat.com>
Date: Tue, 03 Sep 2019 16:06:37 +0000
Subject: Re: [PATCH 04/11] General notification queue with user mmap()'able ring buffer [ver #7]
Message-Id: <7403.1567526797@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190903085706.7700-1-hdanton@sina.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
In-Reply-To: <20190903085706.7700-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> > +	smp_store_release(&buf->meta.head, head);
> 
> Add a line of comment for the paring smp_load_acquire().
> I did not find it in 04/11.

You won't find smp_load_acquire() - it's not in the kernel, though if you look
in the sample, you'll find the corresponding barrier in userspace.  Note that
there's a further implicit barrier you don't see.

I've added the comments:

	/* Barrier against userspace, ordering data read before tail read */
	ring_tail = READ_ONCE(buf->meta.tail);

and:

	/* Barrier against userspace, ordering head update after data write. */
	smp_store_release(&buf->meta.head, head);

David
