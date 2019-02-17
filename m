From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 17 Feb 2019 00:11:52 +0000
Subject: Re: [RFC PATCH 08/27] containers, vfs: Honour CONTAINER_NEW_EMPTY_FS_NS
Message-Id: <20190217001152.GR2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
 <155024690964.21651.13823458384398366556.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024690964.21651.13823458384398366556.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:08:29PM +0000, David Howells wrote:

> +	mnt_ns = alloc_mnt_ns(container->cred->user_ns, false);
> +	if (IS_ERR(mnt_ns)) {
> +		ret = PTR_ERR(mnt_ns);
> +		goto out_fd;
> +	}
> +
> +	mnt = real_mount(path->mnt);
> +	mnt_add_count(mnt, 1);
> +	mnt->mnt_ns = mnt_ns;
> +	mnt_ns->root = mnt;
> +	mnt_ns->mounts++;
> +	list_add(&mnt->mnt_list, &mnt_ns->list);
> +
> +	ret = -EBUSY;
> +	spin_lock(&container->lock);
> +	if (!container->ns->mnt_ns) {
> +		container->ns->mnt_ns = mnt_ns;
> +		write_seqcount_begin(&container->seq);
> +		container->root.mnt = path->mnt;
> +		container->root.dentry = path->dentry;
> +		write_seqcount_end(&container->seq);
> +		path_get(&container->root);
> +		mnt_ns = NULL;
> +		ret = 0;
> +	}

Almost certainly buggered.  Assumptions that we _won't_ get
to absolute root of namespace (it's overmounted and we are
chrooted into it, basically) had been made in quite a few
places.  The thing you are creating is *not* like normal
namespaces in that respect.
