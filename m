From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 11:54:24 +0000
Subject: Re: [PATCH, RFC 46/62] x86/mm: Keep reference counts on encrypted VMAs for MKTME
Message-Id: <20190614115424.GG3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-47-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-47-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:44:06PM +0300, Kirill A. Shutemov wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The MKTME (Multi-Key Total Memory Encryption) Key Service needs
> a reference count on encrypted VMAs. This reference count is used
> to determine when a hardware encryption KeyID is no longer in use
> and can be freed and reassigned to another Userspace Key.
> 
> The MKTME Key service does the percpu_ref_init and _kill, so
> these gets/puts on encrypted VMA's can be considered the
> intermediaries in the lifetime of the key.
> 
> Increment/decrement the reference count during encrypt_mprotect()
> system call for initial or updated encryption on a VMA.
> 
> Piggy back on the vm_area_dup/free() helpers. If the VMAs being
> duplicated, or freed are encrypted, adjust the reference count.

That all talks about VMAs, but...

> @@ -102,6 +115,22 @@ void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
>  
>  		page++;
>  	}
> +
> +	/*
> +	 * Make sure the KeyID cannot be freed until the last page that
> +	 * uses the KeyID is gone.
> +	 *
> +	 * This is required because the page may live longer than VMA it
> +	 * is mapped into (i.e. in get_user_pages() case) and having
> +	 * refcounting per-VMA is not enough.
> +	 *
> +	 * Taking a reference per-4K helps in case if the page will be
> +	 * split after the allocation. free_encrypted_page() will balance
> +	 * out the refcount even if the page was split and freed as bunch
> +	 * of 4K pages.
> +	 */
> +
> +	percpu_ref_get_many(&encrypt_count[keyid], 1 << order);
>  }
>  
>  /*
> @@ -110,7 +139,9 @@ void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
>   */
>  void free_encrypted_page(struct page *page, int order)
>  {
> -	int i;
> +	int i, keyid;
> +
> +	keyid = page_keyid(page);
>  
>  	/*
>  	 * The hardware/CPU does not enforce coherency between mappings
> @@ -125,6 +156,8 @@ void free_encrypted_page(struct page *page, int order)
>  		lookup_page_ext(page)->keyid = 0;
>  		page++;
>  	}
> +
> +	percpu_ref_put_many(&encrypt_count[keyid], 1 << order);
>  }

counts pages, what gives?
