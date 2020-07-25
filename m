From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 25 Jul 2020 03:25:16 +0000
Subject: Re: [PATCH] watch_queue: Limit the number of watches a user can hold
Message-Id: <20200725032516.GA78242@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
In-Reply-To: <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:17:26PM +0100, David Howells wrote:
> Impose a limit on the number of watches that a user can hold so that they
> can't use this mechanism to fill up all the available memory.
> 
> This is done by putting a counter in user_struct that's incremented when a
> watch is allocated and decreased when it is released.  If the number
> exceeds the RLIMIT_NOFILE limit, the watch is rejected with EAGAIN.
> 
> This can be tested by the following means:
> 
>  (1) Create a watch queue and attach it to fd 5 in the program given - in
>      this case, bash:
> 
> 	keyctl watch_session /tmp/nlog /tmp/gclog 5 bash
> 
>  (2) In the shell, set the maximum number of files to, say, 99:
> 
> 	ulimit -n 99
> 
>  (3) Add 200 keyrings:
> 
> 	for ((i=0; i<200; i++)); do keyctl newring a$i @s || break; done
> 
>  (4) Try to watch all of the keyrings:
> 
> 	for ((i=0; i<200; i++)); do echo $i; keyctl watch_add 5 %:a$i || break; done
> 
>      This should fail when the number of watches belonging to the user hits
>      99.
> 
>  (5) Remove all the keyrings and all of those watches should go away:
> 
> 	for ((i=0; i<200; i++)); do keyctl unlink %:a$i; done
> 
>  (6) Kill off the watch queue by exiting the shell spawned by
>      watch_session.
> 
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/sched/user.h |    3 +++
>  kernel/watch_queue.c       |    8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index 917d88edb7b9..a8ec3b6093fc 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -36,6 +36,9 @@ struct user_struct {
>      defined(CONFIG_NET) || defined(CONFIG_IO_URING)
>  	atomic_long_t locked_vm;
>  #endif
> +#ifdef CONFIG_WATCH_QUEUE
> +	atomic_t nr_watches;	/* The number of watches this user currently has */
> +#endif
>  
>  	/* Miscellaneous per-user rate limit */
>  	struct ratelimit_state ratelimit;
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index f74020f6bd9d..0ef8f65bd2d7 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -393,6 +393,7 @@ static void free_watch(struct rcu_head *rcu)
>  	struct watch *watch = container_of(rcu, struct watch, rcu);
>  
>  	put_watch_queue(rcu_access_pointer(watch->queue));
> +	atomic_dec(&watch->cred->user->nr_watches);
>  	put_cred(watch->cred);
>  }
>  
> @@ -452,6 +453,13 @@ int add_watch_to_object(struct watch *watch, struct watch_list *wlist)
>  	watch->cred = get_current_cred();
>  	rcu_assign_pointer(watch->watch_list, wlist);
>  
> +	if (atomic_inc_return(&watch->cred->user->nr_watches) >
> +	    task_rlimit(current, RLIMIT_NOFILE)) {
> +		atomic_dec(&watch->cred->user->nr_watches);
> +		put_cred(watch->cred);
> +		return -EAGAIN;
> +	}
> +
>  	spin_lock_bh(&wqueue->lock);
>  	kref_get(&wqueue->usage);
>  	kref_get(&watch->usage);
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

David, BTW, would it be possible to push keyrings to lore.kernel.org?

I don't have an archive for keyrings, which means that I cannot push
this forward.

/Jarkko
