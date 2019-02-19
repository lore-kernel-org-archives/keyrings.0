From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Feb 2019 23:24:21 +0000
Subject: Re: [RFC PATCH 06/27] containers, vfs: Allow syscall dirfd arguments to take a container fd
Message-Id: <20784.1550618661@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <8736ojwwuq.fsf@xmission.com> <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk> <155024688620.21651.16013251077091180213.stgit@warthog.procyon.org.uk>
In-Reply-To: <8736ojwwuq.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> In fact if you take care to use a path that starts with '/' the normal
> dirfd based operations work just fine.

If the path starts with '/', dirfd is ignored.  And there's an error in my
patch description - it should be:

 	mkdirat(cfd, "fred", 0755);

David
