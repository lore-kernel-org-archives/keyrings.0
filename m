From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Jun 2017 16:14:00 +0000
Subject: Re: [RFC PATCH] KEYS: Allow a live daemon in a namespace to service request_key upcalls
Message-Id: <1856.1496420040@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1496418474.13822.6.camel@redhat.com> <1496239145.289295.994170312.57409998@webmail.messagingengine.com> <149616052408.10194.7774163568767478808.stgit@warthog.procyon.org.uk> <3412.1496242065@warthog.procyon.org.uk> <1496244979.313075.994296480.7C5735E8@webmail.messagingengine.com>
In-Reply-To: <1496418474.13822.6.camel@redhat.com>
To: Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Colin Walters <walters@verbum.org>, James.Bottomley@HansenPartnership.com, ebiederm@xmission.com, linux-nfs@vger.kernel.org, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> Ideally we'd like to run the upcall in the same set of namespaces that
> the user process initiating the activity is running.

Unfortunately, that's not necessarily good enough.  A process could see, for
example, a mounted network fs that it can interact with that has a different
network namespace to the one in that the process is in.

This is an issue that the in-kernel AFS fs has a particular problem with
because there is a userspace management tool suite that uses AF_RXRPC sockets,
but calling socket() will open it in the calling process's namespace, not the
target filesystem's namespace.

I think we need some sort of pin that you can put in the namespace map that
says that for certain combinations of namespaces, you come to this pin and
service requests here, in the set of namespaces at this point.

David
