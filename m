From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 12:04:24 +0000
Subject: Re: [PATCH, RFC 51/62] iommu/vt-d: Support MKTME in DMA remapping
Message-Id: <20190614120424.GJ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-52-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-52-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:44:11PM +0300, Kirill A. Shutemov wrote:
> @@ -603,7 +605,12 @@ static inline void dma_clear_pte(struct dma_pte *pte)
>  static inline u64 dma_pte_addr(struct dma_pte *pte)
>  {
>  #ifdef CONFIG_64BIT
> -	return pte->val & VTD_PAGE_MASK;

I don't know this code, but going by the below cmpxchg64, this wants to
be READ_ONCE().

> +	u64 addr = pte->val;
> +	addr &= VTD_PAGE_MASK;
> +#ifdef CONFIG_X86_INTEL_MKTME
> +	addr &= ~mktme_keyid_mask;
> +#endif
> +	return addr;
>  #else
>  	/* Must have a full atomic 64-bit read */
>  	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
> -- 
> 2.20.1
> 
