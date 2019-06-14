From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 14 Jun 2019 13:03:22 +0000
Subject: Re: [PATCH, RFC 09/62] x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
Message-Id: <20190614130322.zbpubyxcncysgyi3@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-10-kirill.shutemov@linux.intel.com>
 <20190614091513.GW3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614091513.GW3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:15:14AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:29PM +0300, Kirill A. Shutemov wrote:
> > + * Cast PAGE_MASK to a signed type so that it is sign-extended if
> > + * virtual addresses are 32-bits but physical addresses are larger
> > + * (ie, 32-bit PAE).
> 
> On 32bit, 'long' is still 32bit, did you want to cast to 'long long'
> instead? Ideally we'd use pteval_t here, but I see that is unsigned.

It will be cased implecitly to unsigned long long by '& ((1ULL <<
__PHYSICAL_MASK_SHIFT) - 1)' and due to sign-extension it will get it
right for PAE.

Just to be on safe side, I've re-checked that nothing changed for PAE by
the patch using the test below. PTE_PFN_MASK and PTE_PFN_MASK_MAX are
identical when compiled with -m32.

> >   */
> > -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> > +#define PTE_PFN_MASK_MAX \
> > +	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> > +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >  			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> >  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
> 

#include <stdio.h>

typedef unsigned long long u64;
typedef u64 pteval_t;
typedef u64 phys_addr_t;

#define PAGE_SHIFT		12
#define PAGE_SIZE		(1UL << PAGE_SHIFT)
#define PAGE_MASK		(~(PAGE_SIZE-1))
#define __PHYSICAL_MASK_SHIFT	52
#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
#define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
#define PTE_PFN_MASK		((pteval_t)PHYSICAL_PAGE_MASK)
#define PTE_PFN_MASK_MAX	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))

int main(void)
{
	printf("PTE_PFN_MASK: %#llx\n", PTE_PFN_MASK);
	printf("PTE_PFN_MASK_MAX: %#llx\n", PTE_PFN_MASK_MAX);

	return 0;
}
-- 
 Kirill A. Shutemov
