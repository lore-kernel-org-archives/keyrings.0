From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 11:55:20 +0000
Subject: Re: [PATCH, RFC 47/62] mm: Restrict MKTME memory encryption to anonymous VMAs
Message-Id: <20190614115520.GH3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-48-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-48-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:44:07PM +0300, Kirill A. Shutemov wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Memory encryption is only supported for mappings that are ANONYMOUS.
> Test the VMA's in an encrypt_mprotect() request to make sure they all
> meet that requirement before encrypting any.
> 
> The encrypt_mprotect syscall will return -EINVAL and will not encrypt
> any VMA's if this check fails.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

This should be folded back into the initial implemention, methinks.
