From: Karel Zak <kzak@redhat.com>
Date: Tue, 31 Mar 2020 09:49:30 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200331094930.3aipm3zrydpqqhms@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <20200331083430.kserp35qabnxvths@ws.net.home>
 <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
In-Reply-To: <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

On Tue, Mar 31, 2020 at 10:56:35AM +0200, Miklos Szeredi wrote:
> I think we are approaching this from the wrong end.   Let's just
> ignore all of the proposed interfaces for now and only concentrate on
> what this will be used for.
> 
> Start with a set of use cases by all interested parties.  E.g.
> 
>  - systemd wants to keep track attached mounts in a namespace, as well
> as new detached mounts created by fsmount()
> 
>  - systemd need to keep information (such as parent, children, mount
> flags, fs options, etc) up to date on any change of topology or
> attributes.
> 
>  - util linux needs to display the topology and state of mounts in the
> system that corresponds to a consistent state that set of mounts

  - like systemd we also need in mount/umount to query one mountpoint
  rather than parse all /proc/self/mountinfo

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
