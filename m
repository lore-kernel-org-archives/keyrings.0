From: Ian Kent <raven@themaw.net>
Date: Mon, 03 Aug 2020 14:30:26 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <bfba8e858885b8c507b8816d5296f7ab7f949e78.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <303106be4785135446e56cb606138a6e94885887.camel@themaw.net>
         <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <2003787.1595585999@warthog.procyon.org.uk>
         <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
         <2023286.1595590563@warthog.procyon.org.uk>
         <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
         <1283475.1596449889@warthog.procyon.org.uk>
         <1576646.1596455376@warthog.procyon.org.uk>
         <1692826.1596457912@warthog.procyon.org.uk>
In-Reply-To: <1692826.1596457912@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Mon, 2020-08-03 at 13:31 +0100, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > > I'm changing it so that the fields are 64-bit, but initialised
> > > with the
> > > existing mount ID in the notifications set.  The fsinfo set
> > > changes that
> > > to a unique ID.  I'm tempted to make the unique IDs start at
> > > UINT_MAX+1 to
> > > disambiguate them.
> > 
> > Mmm ... so what would I use as a mount id that's not used, like
> > NULL
> > for strings?
> 
> Zero is skipped, so you could use that.
> 
> > I'm using -1 now but changing this will mean I need something
> > different.
> 
> It's 64-bits, so you're not likely to see it reach -1, even if it
> does start
> at UINT_MAX+1.

Ha, either or, I don't think it will be a problem, there's
bound to be a few changes so the components using this will
need to change a bit before it's finalized, shouldn't be a
big deal I think. At least not for me and shouldn't be much
for libmount either I think.

Ian
