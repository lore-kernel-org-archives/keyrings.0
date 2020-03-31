From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Mar 2020 21:54:23 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2418416.1585691663@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200331083430.kserp35qabnxvths@ws.net.home> <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
In-Reply-To: <20200331083430.kserp35qabnxvths@ws.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

Karel Zak <kzak@redhat.com> wrote:

> - improve fsinfo() to provide set (list) of the attributes by one call

That would be my preferred way.  I wouldn't want to let the user pin copies of
state, and I wouldn't want to make open(O_PATH) do it automatically.

David
