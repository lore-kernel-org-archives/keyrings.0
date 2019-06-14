From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 11:47:32 +0000
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call for MKTME
Message-Id: <20190614114732.GE3436@hirez.programming.kicks-ass.net>
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
> diff --git a/fs/exec.c b/fs/exec.c
> index 2e0033348d8e..695c121b34b3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -755,8 +755,8 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  	vm_flags |= mm->def_flags;
>  	vm_flags |= VM_STACK_INCOMPLETE_SETUP;
>  
> -	ret = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end,
> -			vm_flags);
> +	ret = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end, vm_flags,
> +			     -1);

You added a nice NO_KEY helper a few patches back, maybe use it?

>  	if (ret)
>  		goto out_unlock;
>  	BUG_ON(prev != vma);
