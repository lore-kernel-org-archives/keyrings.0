From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 14 May 2020 11:00:40 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <1158ff38-c65d-379f-8ae7-6f507d9fc8dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
In-Reply-To: <20200407200318.11711-1-longman@redhat.com>
To: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>


On 8/4/20 6:03 am, Waiman Long wrote:
> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.
> 
> This patch introduces a new kvfree_sensitive() for freeing those
> sensitive data objects allocated by kvmalloc(). The relevnat places
> where kvfree_sensitive() can be used are modified to use it.
> 
> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mm.h       |  1 +
>  mm/util.c                | 18 ++++++++++++++++++
>  security/keys/internal.h | 11 -----------
>  security/keys/keyctl.c   | 16 +++++-----------
>  4 files changed, 24 insertions(+), 22 deletions(-)
> 
>  [v3: Fix kerneldoc errors]
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7dd5c4ccbf85..9b3130b20f42 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  }
>  
>  extern void kvfree(const void *addr);
> +extern void kvfree_sensitive(const void *addr, size_t len);
>  
>  static inline int compound_mapcount(struct page *page)
>  {
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..dc1c877d5481 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -604,6 +604,24 @@ void kvfree(const void *addr)
>  }
>  EXPORT_SYMBOL(kvfree);
>  
> +/**
> + * kvfree_sensitive - Free a data object containing sensitive information.
> + * @addr: address of the data object to be freed.
> + * @len: length of the data object.
> + *
> + * Use the special memzero_explicit() function to clear the content of a
> + * kvmalloc'ed object containing sensitive data to make sure that the
> + * compiler won't optimize out the data clearing.
> + */
> +void kvfree_sensitive(const void *addr, size_t len)
> +{
> +	if (likely(!ZERO_OR_NULL_PTR(addr))) {
> +		memzero_explicit((void *)addr, len);
> +		kvfree(addr);
> +	}
> +}
> +EXPORT_SYMBOL(kvfree_sensitive);
> +

I wonder if the right thing to do is also to disable pre-emption, just so that the thread does not linger on with sensitive data.

void kvfree_sensitive(const void *addr, size_t len)
{
	preempt_disable();
	if (likely(!ZERO_OR_NULL_PTR(addr))) {
		memzero_explicit((void *)addr, len);
		kvfree(addr);
	}
	preempt_enable();
}
EXPORT_SYMBOL(kvfree_sensitive);



Balbir Singh.
