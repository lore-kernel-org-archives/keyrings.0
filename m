From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 09:34:09 +0000
Subject: Re: [PATCH, RFC 13/62] x86/mm: Add hooks to allocate and free encrypted pages
Message-Id: <20190614093409.GX3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:43:33PM +0300, Kirill A. Shutemov wrote:

> +/* Prepare page to be used for encryption. Called from page allocator. */
> +void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
> +{
> +	int i;
> +
> +	/*
> +	 * The hardware/CPU does not enforce coherency between mappings
> +	 * of the same physical page with different KeyIDs or
> +	 * encryption keys. We are responsible for cache management.
> +	 */

On alloc we should flush the unencrypted (key=0) range, while on free
(below) we should flush the encrypted (key!=0) range.

But I seem to have missed where page_address() does the right thing
here.

> +	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		/* All pages coming out of the allocator should have KeyID 0 */
> +		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
> +		lookup_page_ext(page)->keyid = keyid;
> +

So presumably page_address() is affected by this keyid, and the below
clear_highpage() then accesses the 'right' location?

> +		/* Clear the page after the KeyID is set. */
> +		if (zero)
> +			clear_highpage(page);
> +
> +		page++;
> +	}
> +}
> +
> +/*
> + * Handles freeing of encrypted page.
> + * Called from page allocator on freeing encrypted page.
> + */
> +void free_encrypted_page(struct page *page, int order)
> +{
> +	int i;
> +
> +	/*
> +	 * The hardware/CPU does not enforce coherency between mappings
> +	 * of the same physical page with different KeyIDs or
> +	 * encryption keys. We are responsible for cache management.
> +	 */

I still don't like that comment much; yes the hardware doesn't do it,
and yes we have to do it, but it doesn't explain the actual scheme
employed to do so.

> +	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		/* Check if the page has reasonable KeyID */
> +		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);

It should also check keyid > 0, so maybe:

	(unsigned)(keyid - 1) > keyids-1

instead?

> +		lookup_page_ext(page)->keyid = 0;
> +		page++;
> +	}
> +}
> -- 
> 2.20.1
> 
