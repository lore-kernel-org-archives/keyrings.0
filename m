From: Karel Zak <kzak@redhat.com>
Date: Tue, 31 Mar 2020 09:21:01 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200331092101.fnipaxqewol2hzd2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
In-Reply-To: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:28:56PM +0200, Miklos Szeredi wrote:
> All this could be solved with a string key/value representation of the
> same data, with minimal performance loss on encoding/parsing.  The
> proposed fs interface[1] is one example of that, but I could also
> imagine a syscall based one too.

Yes, key/value is possible solution. The question is if we really 
need to add extra /sys-like filesystem to get key/value ;-) I can 
imagine key/value from FD based interface without open/read/close for
each attribute,

    fd = open("/mnt", O_PATH);
    fsinfo(fd, "propagation", buf, sizeof(buf));
    fsinfo(fd, "fstype", buf, sizeof(buf));
    close(fd);

why I need /mountfs/<id>/propagation and /mountfs/<id>/fstype to get
the same? It sounds like over-engineering without any extra bonus.

Anyway, if we have FD based interfaces like fsopen(), fsmount(),
open_tree() and move_mount() then it sounds strange that you cannot
use the FD to ask kernel for the mount node attributes and you need 
to open and read another /sys-like files. 

IMHO it would be nice that after open(/mnt, O_PATH) I can do whatever
with the mount point (umount, move, reconfigure, query, etc.). Please,
try to keep it simple and consistent ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
