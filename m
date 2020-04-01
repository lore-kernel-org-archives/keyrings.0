From: Karel Zak <kzak@redhat.com>
Date: Wed, 01 Apr 2020 09:04:45 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
In-Reply-To: <2418286.1585691572@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, dray@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lennart@poettering.net, cyphar@cyphar.com

On Tue, Mar 31, 2020 at 10:52:52PM +0100, David Howells wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > querying all properties of a mount atomically all-at-once,
> 
> I don't actually offer that, per se.
> 
> Having an atomic all-at-once query for a single mount is actually quite a
> burden on the system.  There's potentially a lot of state involved, much of
> which you don't necessarily need.

If all means "all possible attributes" than it is unnecessary, for
example ext4 timestamps or volume uuid/label are rarely necessary.
We usually need together (as consistent set):

    source
    mountpoint
    FS type
    FS root (FSINFO_ATTR_MOUNT_PATH)
    FS options (FSINFO_ATTR_CONFIGURATION)
    VFS attributes
    VFS propagation flags
    mount ID
    parent ID
    devno (or maj:min)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
