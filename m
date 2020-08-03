From: David Howells <dhowells@redhat.com>
Date: Mon, 03 Aug 2020 11:49:36 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <1576646.1596455376@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com> <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk> <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net> <2023286.1595590563@warthog.procyon.org.uk> <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com> <1283475.1596449889@warthog.procyon.org.uk>
In-Reply-To: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Ian Kent <raven@themaw.net>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> OTOH mount notification is way smaller and IMO a more mature
> interface.  So just picking the unique ID patch into this set might
> make sense.

But userspace can't retrieve the unique ID without fsinfo() as things stand.

I'm changing it so that the fields are 64-bit, but initialised with the
existing mount ID in the notifications set.  The fsinfo set changes that to a
unique ID.  I'm tempted to make the unique IDs start at UINT_MAX+1 to
disambiguate them.

David
