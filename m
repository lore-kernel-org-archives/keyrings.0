From: Ian Kent <raven@themaw.net>
Date: Wed, 20 Feb 2019 02:46:24 +0000
Subject: Re: [RFC PATCH 02/27] containers: Implement containers as kernel objects
Message-Id: <7923d4aa646fbe4bd71cfb4144f1c96f28cad972.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
         <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org, cgroups@vger.kernel.org

On Fri, 2019-02-15 at 16:07 +0000, David Howells wrote:
> Implement a kernel container object such that it contains the following
> things:
> 
>  (1) Namespaces.
> 
>  (2) A root directory.
> 
>  (3) A set of processes, including one designated as the 'init' process.

Yeah, I think a name other than init needs to be used for this
process.

The problem being that there is no requirement for container
process 1 to behave in any way like an "init" process is
expected to behave and that leads to confusion (at least
it certainly did for me).

Admittedly I haven't yet worked through the series but in the
light of the comments from James I wanted to chime in (probably
too early to be useful not having read the series but ...).

I believe what your trying to do here is so badly needed it
would be great if the needs of James could be met to some
(as yet undefined) satisfactory extent.

Would there be any possibility of introducing a concept of
inactive and active containers where the creation is a two
(maybe more) step procedure, first the creation of (if you like
a "true") container that's essentially empty, basically a shell
(not the program "shell" of course), inert wrt. events and such
and implement the ability to make the container active by adding
various things, like processes, to it?

Clearly the concepts of inactive and active require a definition
of what they mean and I don't have that, perhaps a starting point
could be a container that has a process 1 (which should also require
a root fs and namespaces) is active otherwise it's considered inactive.

Ian
