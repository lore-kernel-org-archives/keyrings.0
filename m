From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 11:51:37 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <20190614115137.GF3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-46-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:44:05PM +0300, Kirill A. Shutemov wrote:

> @@ -347,7 +348,8 @@ static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
>  
>  int
>  mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
> -	unsigned long start, unsigned long end, unsigned long newflags)
> +	       unsigned long start, unsigned long end, unsigned long newflags,
> +	       int newkeyid)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long oldflags = vma->vm_flags;
> @@ -357,7 +359,14 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	int error;
>  	int dirty_accountable = 0;
>  
> -	if (newflags = oldflags) {
> +	/*
> +	 * Flags match and Keyids match or we have NO_KEY.
> +	 * This _fixup is usually called from do_mprotect_ext() except
> +	 * for one special case: caller fs/exec.c/setup_arg_pages()
> +	 * In that case, newkeyid is passed as -1 (NO_KEY).
> +	 */
> +	if (newflags = oldflags &&
> +	    (newkeyid = vma_keyid(vma) || newkeyid = NO_KEY)) {
>  		*pprev = vma;
>  		return 0;
>  	}
> @@ -423,6 +432,8 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	}
>  
>  success:
> +	if (newkeyid != NO_KEY)
> +		mprotect_set_encrypt(vma, newkeyid, start, end);
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_sem
>  	 * held in write mode.
> @@ -454,10 +465,15 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  }
>  
>  /*
> - * When pkey=NO_KEY we get legacy mprotect behavior here.
> + * do_mprotect_ext() supports the legacy mprotect behavior plus extensions
> + * for Protection Keys and Memory Encryption Keys. These extensions are
> + * mutually exclusive and the behavior is:
> + *	(pkey=NO_KEY && keyid=NO_KEY) => legacy mprotect
> + *	(pkey is valid)  => legacy mprotect plus Protection Key extensions
> + *	(keyid is valid) => legacy mprotect plus Encryption Key extensions
>   */
>  static int do_mprotect_ext(unsigned long start, size_t len,
> -		unsigned long prot, int pkey)
> +			   unsigned long prot, int pkey, int keyid)
>  {
>  	unsigned long nstart, end, tmp, reqprot;
>  	struct vm_area_struct *vma, *prev;
> @@ -555,7 +571,8 @@ static int do_mprotect_ext(unsigned long start, size_t len,
>  		tmp = vma->vm_end;
>  		if (tmp > end)
>  			tmp = end;
> -		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
> +		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags,
> +				       keyid);
>  		if (error)
>  			goto out;
>  		nstart = tmp;

I've missed the part where pkey && keyid results in a WARN or error or
whatever.
