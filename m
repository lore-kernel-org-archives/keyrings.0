From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 12 Oct 2017 18:56:12 +0000
Subject: Re: [RFC][PATCH 00/15] KEYS: Fixes
Message-Id: <20171012185612.GA11577@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
In-Reply-To: <150782504738.1655.12882942775980793687.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi David, a few comments:

On Thu, Oct 12, 2017 at 05:17:27PM +0100, David Howells wrote:
> ---
> Arnd Bergmann (1):
>       security/keys: BIG_KEY requires CONFIG_CRYPTO

Doesn't this need 'Cc: <stable@vger.kernel.org>	[v4.9+]',
since the commit it fixes is there?

> 
> David Howells (2):
>       KEYS: Fix race between updating and finding a negative key

I guess the 'state' variable is fine, though it makes this patch (which will
need to be backported) a tad larger.  I'd also prefer a bit more information in
the commit message about the problem being solved.  But anyway, there are also
some problems in how READ_ONCE() and memory barriers are used (or not used) in
the new/changed code, and there is one other bug:

>  static inline bool key_is_instantiated(const struct key *key)
>  {
> -       return test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
> -               !test_bit(KEY_FLAG_NEGATIVE, &key->flags);
> +       return key->state = KEY_IS_INSTANTIATED;
> +}

This should use 'smp_load_acquire(&key->state) = KEY_IS_INSTANTIATED', since
some ->describe() methods expect to access the payload after this.  Yes, it's no
worse than before, but as long as the line of code is being replaced we might as
well get it right...

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 87cb260e4890..1578f671a213 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -129,14 +129,15 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
>        while (!list_empty(keys)) {
>                struct key *key >                        list_entry(keys->next, struct key, graveyard_link);
> +              short state = READ_ONCE(key->state);
> +

Here the key has no more references, so nothing can be changing the state.
Thus, the READ_ONCE() isn't actually needed.

> +/*
> + * Change the key state to being instantiated.
> + */
> +static void mark_key_instantiated(struct key *key, int reject_error)
> +{
> +       smp_wmb(); /* Commit the payload before setting the state */
> +       key->state = (reject_error < 0) ? reject_error : KEY_IS_INSTANTIATED;
> +}
> +

smp_store_release() would make this simpler as well as guarantee that the write
is atomic.

> +       ret = key->state;
> +       if (ret < 0)
> +               goto error2; /* Negatively instantiated */

Not too important in practice (as this is constantly gotten wrong all over the
kernel, and compilers play nice enough to make it not a huge deal), but
READ_ONCE(key->state) will guarantee that the read of 'key->state' is atomic and
not e.g. done byte-by-byte.


> -       if (key->type->describe)
> +       if (key->type->describe) {
> +               smp_rmb(); /* Order access to payload after state set. */
>		  key->type->describe(key, m);
> +       }

This is the wrong place for this memory barrier.  The state is checked
separately in ->describe() and it may have changed between when it was shown in
proc_keys_show() vs. when it is checked in ->describe().  We can't actually make
these two access to ->state consistent with respect to each other right now.
The most we can do is use smp_load_acquire() in key_is_instantiated() so that at
least ->describe() isn't broken by itself.  So the change here is pointless.

> -       if (!(lflags & KEY_LOOKUP_PARTIAL) &&
> -           !test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
> -               goto invalid_key;
> +       if (!(lflags & KEY_LOOKUP_PARTIAL)) {
> +               if (key->state != KEY_IS_INSTANTIATED)
> +                       goto invalid_key;
> +               smp_rmb(); /* Order access to payload after state set. */
> +       }

This should be simply:

	if (!(lflags & KEY_LOOKUP_PARTIAL) && !key_is_instantiated(key))
		goto invalid_key;

> @@ -595,10 +595,9 @@ int wait_for_key_construction(struct key *key, bool intr)
>                          intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
>        if (ret)
>                return -ERESTARTSYS;
> -       if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
> -               smp_rmb();
> -               return key->reject_error;
> -       }
> +       ret = READ_ONCE(key->state);
> +       if (ret < 0)
> +               return ret;
>        return key_validate(key);
> }
> EXPORT_SYMBOL(wait_for_key_construction);

smp_load_acquire() rather than READ_ONCE(), in case the caller uses this as an
indication that it is safe to access the payload.

> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> index 3d8c68eba516..9afa64817d4f 100644
> --- a/security/keys/user_defined.c
> +++ b/security/keys/user_defined.c
> @@ -114,7 +114,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
> 
>        /* attach the new data, displacing the old */
>        key->expiry = prep->expiry;
>-       if (!test_bit(KEY_FLAG_NEGATIVE, &key->flags))
>+       if (key->state < 0)
>                zap = dereference_key_locked(key);
>        rcu_assign_keypointer(key, prep->payload.data[0]);
>        prep->payload.data[0] = NULL;

This is backwards; it should be 'if (!key_is_negative(key))'.

>       KEYS: don't let add_key() update an uninstantiated key
> 

>
> +       if (test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags)) {
> +               ret = wait_for_key_construction(key_ref_to_ptr(key_ref), true);
> +               if (ret < 0) {
> +                       key_ref_put(key_ref);
> +                       key_ref = ERR_PTR(ret);
> +                       goto error_free_prep;
> +               }
> +       }
> +

'key' is NULL here.  It should be 'key_ref_to_ptr(key_ref)'.


>       KEYS: load key flags and expiry time atomically in keyring_search_iterator()

The commit message refers to both flags and expiry time, but now it only
actually updates how the expiry time is loaded, as the flags were already done
by "KEYS: Fix race between updating and finding a negative key".

>       KEYS: load key flags and expiry time atomically in proc_keys_show()

The commit message refers to negative ('N') but not instantiated ('I') as the
example, but that is no longer a valid example since this patch comes after
"KEYS: Fix race between updating and finding a negative key".

Eric
