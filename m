From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 14 Jun 2019 18:26:10 +0000
Subject: Re: [PATCH, RFC 44/62] x86/mm: Set KeyIDs in encrypted VMAs for MKTME
Message-Id: <e0884a6b-78bc-209d-bc9a-90f69839189e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-45-kirill.shutemov@linux.intel.com>
 <20190614114408.GD3436@hirez.programming.kicks-ass.net>
 <20190614173345.GB5917@alison-desk.jf.intel.com>
In-Reply-To: <20190614173345.GB5917@alison-desk.jf.intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/14/19 10:33 AM, Alison Schofield wrote:
> Preserving the data across encryption key changes has not
> been a requirement. I'm not clear if it was ever considered
> and rejected. I believe that copying in order to preserve
> the data was never considered.

We could preserve the data pretty easily.  It's just annoying, though.
Right now, our only KeyID conversions happen in the page allocator.  If
we were to convert in-place, we'd need something along the lines of:

	1. Allocate a scratch page
	2. Unmap target page, or at least make it entirely read-only
	3. Copy plaintext into scratch page
	4. Do cache KeyID conversion of page being converted:
	   Flush caches, change page_ext metadata
	5. Copy plaintext back into target page from scratch area
	6. Re-establish PTEs with new KeyID

#2 is *really* hard.  It's similar to the problems that the poor
filesystem guys are having with RDMA these days when RDMA is doing writes.

What we have here (destroying existing data) is certainly the _simplest_
semantic.  We can certainly give it a different name, or even non-PROT_*
semantics where it shares none of mprotect()'s functionality.

Doesn't really matter to me at all.
