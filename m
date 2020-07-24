From: Ian Kent <raven@themaw.net>
Date: Fri, 24 Jul 2020 10:44:01 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <2003787.1595585999@warthog.procyon.org.uk>
In-Reply-To: <2003787.1595585999@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Fri, 2020-07-24 at 11:19 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > > What guarantees that mount_id is going to remain a 32bit entity?
> > 
> > You think it likely we'd have >4 billion concurrent mounts on a
> > system?  That
> > would require >1.2TiB of RAM just for the struct mount allocations.
> > 
> > But I can expand it to __u64.
> 
> That said, sys_name_to_handle_at() assumes it's a 32-bit signed
> integer, so
> we're currently limited to ~2 billion concurrent mounts:-/

I was wondering about id re-use.

Assuming that ids that are returned to the idr db are re-used
what would the chance that a recently used id would end up
being used?

Would that chance increase as ids are consumed and freed over
time?

Yeah, it's one of those questions ... ;)

Ian
