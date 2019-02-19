From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 19 Feb 2019 16:56:05 +0000
Subject: Re: [RFC PATCH 02/27] containers: Implement containers as kernel objects
Message-Id: <87h8czvhsq.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
        <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Fri, 15 Feb 2019 16:07:33 +0000")
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

The container id details are ludicrous and will break practically
every use case.  This completely unacceptable.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> diff --git a/include/linux/container.h b/include/linux/container.h
> new file mode 100644
> index 000000000000..0a8918435097
> --- /dev/null
> +++ b/include/linux/container.h
> +/*
> + * The container object.
> + */
> +struct container {
> +	u64			id;		/* Container ID */
...

No.  This is absolutely unacceptable.
As this breaks breaks nested containers and process migration.

> +};
> +
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d2f90fa92468..073a3a930514 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -36,6 +36,7 @@ struct backing_dev_info;
>  struct bio_list;
>  struct blk_plug;
>  struct cfs_rq;
> +struct container;
>  struct fs_struct;
>  struct futex_pi_state;
>  struct io_context;
> @@ -870,6 +871,8 @@ struct task_struct {
>  
>  	/* Namespaces: */
>  	struct nsproxy			*nsproxy;
> +	struct container		*container;
> +	struct list_head		container_link;

Why?  nsproxy would be a much cheaper location to put this.
Less space and less foobar.

>  	/* Signal handlers: */
>  	struct signal_struct		*signal;
> diff --git a/kernel/container.c b/kernel/container.c
> new file mode 100644
> index 000000000000..ca4012632cfa
> --- /dev/null
> +++ b/kernel/container.c
> @@ -0,0 +1,348 @@
[...]
> +
> +	c->id = atomic64_inc_return(&container_id_counter);

This id is not in a namespace, and it doesn't have enough bits
of entropy to be globally unique.   Not that 64bit is enough
to have a chance at being globablly unique.


Eric
