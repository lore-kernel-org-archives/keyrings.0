From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 09:51:32 +0000
Subject: Re: [PATCH, RFC 18/62] x86/mm: Implement syncing per-KeyID direct mappings
Message-Id: <20190614095131.GY3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:43:38PM +0300, Kirill A. Shutemov wrote:
> For MKTME we use per-KeyID direct mappings. This allows kernel to have
> access to encrypted memory.
> 
> sync_direct_mapping() sync per-KeyID direct mappings with a canonical
> one -- KeyID-0.
> 
> The function tracks changes in the canonical mapping:
>  - creating or removing chunks of the translation tree;
>  - changes in mapping flags (i.e. protection bits);
>  - splitting huge page mapping into a page table;
>  - replacing page table with a huge page mapping;
> 
> The function need to be called on every change to the direct mapping:
> hotplug, hotremove, changes in permissions bits, etc.

And yet I don't see anything in pageattr.c.

Also, this seems like an expensive scheme; if you know where the changes
where, a more fine-grained update would be faster.

> The function is nop until MKTME is enabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/mktme.h |   6 +
>  arch/x86/mm/init_64.c        |  10 +
>  arch/x86/mm/mktme.c          | 441 +++++++++++++++++++++++++++++++++++
>  3 files changed, 457 insertions(+)


> @@ -1247,6 +1254,7 @@ void mark_rodata_ro(void)
>  	unsigned long text_end = PFN_ALIGN(&__stop___ex_table);
>  	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
>  	unsigned long all_end;
> +	int ret;
>  
>  	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
>  	       (end - start) >> 10);
> @@ -1280,6 +1288,8 @@ void mark_rodata_ro(void)
>  	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
>  	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
>  
> +	ret = sync_direct_mapping();
> +	WARN_ON(ret);
>  	debug_checkwx();
>  }
>  

If you'd done pageattr, the above would not be needed.
