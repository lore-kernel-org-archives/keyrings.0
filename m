From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 04 Dec 2018 09:10:44 +0000
Subject: Re: [RFC v2 09/13] mm: Restrict memory encryption to anonymous VMA's
Message-Id: <20181204091044.GP11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <0b294e74f06a0d6bee51efcd7b0eb1f20b00babe.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Mon, Dec 03, 2018 at 11:39:56PM -0800, Alison Schofield wrote:
> Memory encryption is only supported for mappings that are ANONYMOUS.
> Test the entire range of VMA's in an encrypt_mprotect() request to
> make sure they all meet that requirement before encrypting any.
> 
> The encrypt_mprotect syscall will return -EINVAL and will not encrypt
> any VMA's if this check fails.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

That SoB doesn't make sense; per the From you wrote the patch and signed
off on it, wth is Kirill's SoB doing there?

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ad8127dc9aac..f1c009409134 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -345,6 +345,24 @@ static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
>  	return walk_page_range(start, end, &prot_none_walk);
>  }
>  
> +/*
> + * Encrypted mprotect is only supported on anonymous mappings.
> + * All VMA's in the requested range must be anonymous. If this
> + * test fails on any single VMA, the entire mprotect request fails.
> + */
> +bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)

That's a 'weird' interface and cannot do what the comment says it should
do.

> +{
> +	struct vm_area_struct *test_vma = vma;

That variable is utterly pointless.

> +	do {
> +		if (!vma_is_anonymous(test_vma))
> +			return false;
> +
> +		test_vma = test_vma->vm_next;
> +	} while (test_vma && test_vma->vm_start < end);
> +	return true;
> +}
