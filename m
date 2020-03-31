From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Mar 2020 21:56:26 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2418581.1585691786@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200331122554.GA27469@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com> <20200331083430.kserp35qabnxvths@ws.net.home> <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
In-Reply-To: <20200331122554.GA27469@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

Lennart Poettering <mzxreary@0pointer.de> wrote:

> - We also have code that needs to check if /dev/ is plain tmpfs or
>   devtmpfs. We cannot use statfs for that, since in both cases
>   TMPFS_MAGIC is reported, hence we currently parse
>   /proc/self/mountinfo for that to find the fstype string there, which
>   is different for both cases.

btw, fsinfo(FSINFO_ATTR_IDS) gets you the name of the filesystem type in
addition to the magic number.

David
