From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Feb 2019 23:13:16 +0000
Subject: Re: [RFC PATCH 02/27] containers: Implement containers as kernel objects
Message-Id: <20058.1550617996@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <87h8czvhsq.fsf@xmission.com> <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk> <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
In-Reply-To: <87h8czvhsq.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> > +	c->id = atomic64_inc_return(&container_id_counter);
> 
> This id is not in a namespace, and it doesn't have enough bits
> of entropy to be globally unique.   Not that 64bit is enough
> to have a chance at being globablly unique.

It's in a container, so it doesn't need to be in a namespace.  The intended
purpose is for annotating audit messages.  Globally unique wasn't particularly
in mind.  It could be turned into, say, a uuid, so that isn't really a problem
at this point.

You are right, though, it really should be globally unique as best possible -
even the one in init_container should be.  Ideally, it would look the same
inside the root container as any subcontainer.

David
