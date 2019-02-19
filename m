From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Feb 2019 23:16:59 +0000
Subject: Re: [RFC PATCH 04/27] containers: Allow a process to be forked into a container
Message-Id: <20295.1550618219@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <87tvgzwx4i.fsf@xmission.com> <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk> <155024686966.21651.5963892339360034863.stgit@warthog.procyon.org.uk>
In-Reply-To: <87tvgzwx4i.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> > Further attempts to fork into the container will be rejected.
>
> There are no technical reasons to disallow this, and may good practical
> reasons to allow this.

Fair enough; that can be done.  Could even emulate /sbin/request-key upcalling
that way, with the manager spawning the daemon into the container with it.

> So you are breaking nsenter, and it's like.

It shouldn't stop nsenter() from working.

David
