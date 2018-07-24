From: David Howells <dhowells@redhat.com>
Date: Tue, 24 Jul 2018 19:22:49 +0000
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
Message-Id: <14831.1532460169@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com> <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com> <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk> <23894.1532448035@warthog.procyon.org.uk>
In-Reply-To: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >>>  (1) Mount topology and reconfiguration change events.
> >> With the possibility of unprivileged mounting you're going to have to
> >> address access control on events.  If root in a user namespace mounts a
> >> filesystem you may have a case where the "real" user wouldn't want the
> >> listener to receive a notification.
> > Can you clarify who the listener is in this case?
> 
> That would be anyone with a watchpoint set.

I was wanting clarification on how you viewed events being generated inside
the namespace being seen by an external listener, vs events being generated
outside the namespace being seen by an internal listener.

Hmmm...  OTOH, maybe it's not a problem - can a mount namespace intersect with
two different user namespaces, given it has its own user_ns pointer?

> > But for each event, I can associate an object label, derived from the
> > source, and use f_cred on the notification queue to provide a subject
> > label.
> 
> ... or UID or groups.

Might not be useful if the watched object doesn't have UID or GID - a
superblock say.

Also, that raises an additional question: if someone triggers an event - say a
mount - there is an additional set of creds (that of the triggering process).
Do I need to consider that?

> >>    (4) User injected events
> >>
> >> at this point, but it's an obvious extension. That is going
> >> to require access controls (remember kdbus) so I think you'd
> >> do well to design them in now rather than have some security
> >> module hack like me come along later and "fix" it. 
> > Yeah - the thought had occurred to me, but there needs to be some way to
> > define a 'source' and a way to connect them.  Also, would you want a general
> > source that anyone can contribute through, specific sources where you have to
> > directly connect or namespace-restricted sources?
> 
> My guess is that the consensus would be "Yes" to all the above.

I thought you might say that.

David
