From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 16 Oct 2017 18:31:41 +0000
Subject: Re: [RFC][PATCH 00/15] KEYS: Fixes
Message-Id: <20171016183141.GD121701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171012185612.GA11577@gmail.com>
	<150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
	<2176.1507909168@warthog.procyon.org.uk>
In-Reply-To: <2176.1507909168@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Fri, Oct 13, 2017 at 04:39:28PM +0100, David Howells wrote:
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 87cb260e4890..e7aeecbf7f19 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -129,14 +129,15 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
>  	while (!list_empty(keys)) {
>  		struct key *key >  			list_entry(keys->next, struct key, graveyard_link);
> +		short state = key->state;
> +
>  		list_del(&key->graveyard_link);
>  
>  		kdebug("- %u", key->serial);
>  		key_check(key);
>  
>  		/* Throw away the key data if the key is instantiated */
> -		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
> -		    !test_bit(KEY_FLAG_NEGATIVE, &key->flags) &&
> +		if (state = KEY_IS_INSTANTIATED &&
>  		    key->type->destroy)
>  			key->type->destroy(key);

Nit: put the two checks on the same line.

>  
> @@ -151,7 +152,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
>  		}
>  
>  		atomic_dec(&key->user->nkeys);
> -		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
> +		if (state = KEY_IS_INSTANTIATED)
>  			atomic_dec(&key->user->nikeys);

This changes the behavior.  Previously ->nikeys counted both negatively and
positively instantiated keys, while this change implies that it now will only
count positively instantiated keys.  I think you meant 'state !KEY_IS_UNINSTANTIATED'?  Renaming KEY_IS_INSTANTIATED to KEY_IS_POSITIVE or
KEY_IS_POSITIVELY_INSTANTIATED also might help reduce this confusion.

> @@ -901,7 +900,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		atomic_dec(&key->user->nkeys);
>  		atomic_inc(&newowner->nkeys);
>  
> -		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
> +		if (key->state = KEY_IS_INSTANTIATED) {
>  			atomic_dec(&key->user->nikeys);
>  			atomic_inc(&newowner->nikeys);
>  		}

Same problem: ->nikeys was previously counting negatively instantiated keys too.
Now it isn't.  Shouldn't it test 'key->state != KEY_IS_UNINSTANTIATED'?

> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index de834309d100..9510822c4d96 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -182,6 +182,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
>  	unsigned long timo;
>  	key_ref_t key_ref, skey_ref;
>  	char xbuf[16];
> +	short state;
>  	int rc;
>  
>  	struct keyring_search_context ctx = {
> @@ -236,17 +237,19 @@ static int proc_keys_show(struct seq_file *m, void *v)
>  			sprintf(xbuf, "%luw", timo / (60*60*24*7));
>  	}
>  
> +	state = key_read_state(key);
> +
>  #define showflag(KEY, LETTER, FLAG) \
>  	(test_bit(FLAG,	&(KEY)->flags) ? LETTER : '-')
>  
>  	seq_printf(m, "%08x %c%c%c%c%c%c%c %5d %4s %08x %5d %5d %-9.9s ",
>  		   key->serial,
> -		   showflag(key, 'I', KEY_FLAG_INSTANTIATED),
> +		   state = KEY_IS_INSTANTIATED ? 'I' : '-',

Similar problem.  Previously 'I' was shown for negatively instantiated keys; now
it's not.  Shouldn't it test 'state != KEY_IS_UNINSTANTIATED'?

> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index 293d3598153b..5a8b985d1d5f 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -729,8 +729,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
>  	}
>  
>  	ret = -EIO;
> -	if (!(lflags & KEY_LOOKUP_PARTIAL) &&
> -	    !test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
> +	if (!(lflags & KEY_LOOKUP_PARTIAL) && !key_is_instantiated(key))
>  		goto invalid_key;

Similar problem again.  Previously this allowed negatively instantiated keys
through whereas now it only allows positively instantiated keys.  Is that
intentional?

Eric
