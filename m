From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 26 Sep 2017 20:39:09 +0000
Subject: Re: [PATCH v2 1/6] KEYS: fix race between updating and finding negative key
Message-Id: <20170926203909.GA126069@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170926201105.126166-1-ebiggers3@gmail.com>
	<20170926201105.126166-2-ebiggers3@gmail.com>
In-Reply-To: <20170926201105.126166-2-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

On Tue, Sep 26, 2017 at 01:11:00PM -0700, Eric Biggers wrote:
> +static void mark_key_instantiated(struct key *key, unsigned int reject_error)
> +{
> +	unsigned long old, new;
> +
> +	do {
> +		old = READ_ONCE(key->flags);
> +		new = (old & ~(KEY_FLAG_NEGATIVE |
> +			       KEY_FLAGS_REJECT_ERROR_MASK)) |
> +		      KEY_FLAG_INSTANTIATED |
> +		      (reject_error ? KEY_FLAG_NEGATIVE : 0) |
> +		      (reject_error << KEY_FLAGS_REJECT_ERROR_SHIFT);
> +	} while (cmpxchg_release(&key->flags, old, new) != old);
> +}

Sorry, I realized I screwed this up --- the flags like KEY_FLAG_NEGATIVE need to
be (1 << KEY_FLAG_NEGATIVE).  I'll send another version which will be better
tested...

Eric
