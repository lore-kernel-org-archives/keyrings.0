From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 17 Feb 2019 00:14:41 +0000
Subject: Re: [RFC PATCH 09/27] vfs: Allow mounting to other namespaces
Message-Id: <20190217001440.GS2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
 <155024692658.21651.7276705643207668882.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024692658.21651.7276705643207668882.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:08:46PM +0000, David Howells wrote:
> Currently sys_move_mount() and sys_mount(MS_MOVE) prevent the caller from
> moving a mount into a namespace not their own.  Relax this such that any
> mount can be mounted onto any given mountpoint provided that the source
> mount is either detached or the same namespace as the destination.
> 
> This permits container namespaces to be built from the outside rather than
> from the inside.

I'm looking forward to your analysis of security implications, as well as
the proof that attach_recursive_mnt() won't get confused by that...
