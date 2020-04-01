From: Karel Zak <kzak@redhat.com>
Date: Wed, 01 Apr 2020 08:43:46 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200401084346.kety7m2dwo7okeuk@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200331083430.kserp35qabnxvths@ws.net.home>
 <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <2418416.1585691663@warthog.procyon.org.uk>
In-Reply-To: <2418416.1585691663@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

On Tue, Mar 31, 2020 at 10:54:23PM +0100, David Howells wrote:
> Karel Zak <kzak@redhat.com> wrote:
> 
> > - improve fsinfo() to provide set (list) of the attributes by one call
> 
> That would be my preferred way.  I wouldn't want to let the user pin copies of
> state, and I wouldn't want to make open(O_PATH) do it automatically.

You can create cow object on first fsinfo() call, ideally add some
flags to control this behavior -- but you're right, this way is
complicated to implement and possibly dangerous.

I guess return some vector of attributes in one fsinfo() will be good
enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
