From: Christian Brauner <christian@brauner.io>
Date: Wed, 20 Feb 2019 13:26:02 +0000
Subject: Re: [RFC PATCH 02/27] containers: Implement containers as kernel objects
Message-Id: <20190220132600.c5ahsmnoihdrcqeq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
 <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
 <7923d4aa646fbe4bd71cfb4144f1c96f28cad972.camel@themaw.net>
In-Reply-To: <7923d4aa646fbe4bd71cfb4144f1c96f28cad972.camel@themaw.net>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org

On Wed, Feb 20, 2019 at 10:46:24AM +0800, Ian Kent wrote:
> On Fri, 2019-02-15 at 16:07 +0000, David Howells wrote:
> > Implement a kernel container object such that it contains the following
> > things:
> > 
> >  (1) Namespaces.
> > 
> >  (2) A root directory.
> > 
> >  (3) A set of processes, including one designated as the 'init' process.
> 
> Yeah, I think a name other than init needs to be used for this
> process.
> 
> The problem being that there is no requirement for container
> process 1 to behave in any way like an "init" process is
> expected to behave and that leads to confusion (at least
> it certainly did for me).

If you look at the documentation for pid namespaces(7) you can see that
the pid 1 inside a pid namespace is expected to behave like an init
process:
-  "The  first  process created in a new namespace [...] has  the PID 1,
   and is the "init" process for the namespace (see init(1))."
- "[...] child process that is orphaned within the namespace will be
  reparented to this process rather than init(1) [...]"
- "If the "init" process of a PID namespace terminates, the kernel
  terminates all of the processes in the  namespace  via a SIGKILL
  signal. This behavior reflects the fact that the "init" process is
  essential for the cor‐ rect operation of a PID namespace."
- "Only signals for which the "init" process has established a signal
  handler can be sent to the  "init" process by other members of the
  PID namespace."
- "[...] the reboot(2) system call causes a signal to be sent to the
  namespace "init" process."

This is one of the reasons why all major current container runtimes
finally after years of failing to realize this run a stub init process
that mimicks a dumb init. Sure, you get away with not having an init
that behaves like an init but this is inherently broken or at least
against the way pid namespaces were designed.
