From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 19 Feb 2019 16:45:33 +0000
Subject: Re: [RFC PATCH 06/27] containers, vfs: Allow syscall dirfd arguments to take a container fd
Message-Id: <8736ojwwuq.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
        <155024688620.21651.16013251077091180213.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024688620.21651.16013251077091180213.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Fri, 15 Feb 2019 16:08:06 +0000")
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Some filesystem system calls, such as mkdirat(), take a 'directory fd' to
> specify the pathwalk origin.  This takes either AT_FDCWD or a file
> descriptor that refers to an open directory.
>
> Make it possible to supply a container fd, as obtained from
> container_create(), instead thereby specifying the container's root as the
> origin.  This performs the filesystem operation into the container's mount
> namespace.  For example:
>
> 	int cfd = container_create("fred", CONTAINER_NEW_MNT_NS, 0);
> 	mkdirat(cfd, "/fred", 0755);
>
> A better way to do this might be to temporarily override current->fs and
> current->nsproxy, but this requires splitting those fields so that procfs
> doesn't see the override.
>
> A sequence number and lock are available to protect the root pointer in
> case container_chroot() and/or container_pivot_root() are implemented.

If this is desirable we can do this without a ``container''.  We already
have mount namespaces.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

In fact if you take care to use a path that starts with '/' the normal
dirfd based operations work just fine.

So I don't see the point of this system call at all.


> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/namei.c |   45 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index a85deb55d0c9..4932b5467285 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2232,20 +2232,43 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  		if (!f.file)
>  			return ERR_PTR(-EBADF);
>  
> -		dentry = f.file->f_path.dentry;
> +		if (is_container_file(f.file)) {
> +			struct container *c = f.file->private_data;
> +			unsigned seq;
>  
> -		if (*s && unlikely(!d_can_lookup(dentry))) {
> -			fdput(f);
> -			return ERR_PTR(-ENOTDIR);
> -		}
> +			if (!*s)
> +				return ERR_PTR(-EINVAL);
>  
> -		nd->path = f.file->f_path;
> -		if (flags & LOOKUP_RCU) {
> -			nd->inode = nd->path.dentry->d_inode;
> -			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
> +			if (flags & LOOKUP_RCU) {
> +				do {
> +					seq = read_seqcount_begin(&c->seq);
> +					nd->path = c->root;
> +					nd->inode = nd->path.dentry->d_inode;
> +					nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
> +				} while (read_seqcount_retry(&c->seq, seq));
> +			} else {
> +				spin_lock(&c->lock);
> +				nd->path = c->root;
> +				path_get(&nd->path);
> +				spin_unlock(&c->lock);
> +				nd->inode = nd->path.dentry->d_inode;
> +			}
>  		} else {
> -			path_get(&nd->path);
> -			nd->inode = nd->path.dentry->d_inode;
> +			dentry = f.file->f_path.dentry;
> +
> +			if (*s && unlikely(!d_can_lookup(dentry))) {
> +				fdput(f);
> +				return ERR_PTR(-ENOTDIR);
> +			}
> +
> +			nd->path = f.file->f_path;
> +			if (flags & LOOKUP_RCU) {
> +				nd->inode = nd->path.dentry->d_inode;
> +				nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
> +			} else {
> +				path_get(&nd->path);
> +				nd->inode = nd->path.dentry->d_inode;
> +			}
>  		}
>  		fdput(f);
>  		return s;
