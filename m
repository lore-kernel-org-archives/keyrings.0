From: Ian Kent <raven@themaw.net>
Date: Wed, 05 Aug 2020 11:36:05 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <013e9bb3cb1536c73a5b58c5ff000b3b00629561.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
         <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
         <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
         <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
         <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com>
In-Reply-To: <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 09:43 +0200, Miklos Szeredi wrote:
> On Wed, Aug 5, 2020 at 3:54 AM Ian Kent <raven@themaw.net> wrote:
> > > > It's way more useful to have these in the notification than
> > > > obtainable
> > > > via fsinfo() IMHO.
> > > 
> > > What is it useful for?
> > 
> > Only to verify that you have seen all the notifications.
> > 
> > If you have to grab that info with a separate call then the count
> > isn't necessarily consistent because other notifications can occur
> > while you grab it.
> 
> No, no no.   The watch queue will signal an overflow, without any
> additional overhead for the normal case.  If you think of this as a
> protocol stack, then the overflow detection happens on the transport
> layer, instead of the application layer.  The application layer is
> responsible for restoring state in case of a transport layer error,
> but detection of that error is not the responsibility of the
> application layer.

I can see in the kernel code that an error is returned if the message
buffer is full when trying to add a message, I just can't see where
to get it in the libmount code.

That's not really a communication protocol problem.

Still I need to work out how to detect it, maybe it is seen by
the code in libmount already and I simply can't see what I need
to do to recognise it ...

So I'm stuck wanting to verify I have got everything that was
sent and am having trouble moving on from that.

Ian
