From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 03 Aug 2020 10:02:18 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
 <2023286.1595590563@warthog.procyon.org.uk>
In-Reply-To: <2023286.1595590563@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 1:36 PM David Howells <dhowells@redhat.com> wrote:
>
> Ian Kent <raven@themaw.net> wrote:
>
> > I was wondering about id re-use.
> >
> > Assuming that ids that are returned to the idr db are re-used
> > what would the chance that a recently used id would end up
> > being used?
> >
> > Would that chance increase as ids are consumed and freed over
> > time?
>
> I've added something to deal with that in the fsinfo branch.  I've given each
> mount object and superblock a supplementary 64-bit unique ID that's not likely
> to repeat before we're no longer around to have to worry about it.
>
> fsinfo() then allows you to retrieve them by path or by mount ID.

Shouldn't the notification interface provide the unique ID?

Thanks,
Miklos

>
> So, yes, mnt_id and s_dev are not unique and may be reused very quickly, but
> I'm also providing uniquifiers that you can check.
>
> David
>
