From: Alison Schofield <alison.schofield@intel.com>
Date: Sat, 15 Jun 2019 00:07:05 +0000
Subject: Re: [PATCH, RFC 47/62] mm: Restrict MKTME memory encryption to anonymous VMAs
Message-Id: <20190615000705.GA14860@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-48-kirill.shutemov@linux.intel.com>
 <20190614115520.GH3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614115520.GH3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:55:20PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:44:07PM +0300, Kirill A. Shutemov wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Memory encryption is only supported for mappings that are ANONYMOUS.
> > Test the VMA's in an encrypt_mprotect() request to make sure they all
> > meet that requirement before encrypting any.
> > 
> > The encrypt_mprotect syscall will return -EINVAL and will not encrypt
> > any VMA's if this check fails.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> This should be folded back into the initial implemention, methinks.

It is part of the initial implementation. I looked for
places to split the implementation into smaller,
reviewable patches, hence this split. None of it gets
built until the CONFIG_X86_INTEL_MKTME is introduced
in a later patch.

The encrypt_mprotect() patchset is ordered like this:
1) generalize mprotect to support the mktme extension
2) wire up encrypt_mprotect()
3) implement encrypt_mprotect()
4) keep reference counts on encryption keys (was VMAs)
5) (this patch) restrict to anonymous VMAs.
  
I thought Patch 5) was a small, but meaningful split. It 
accentuates the fact that MKTME is restricted to anonymous
memory.

Alas, I want to make it logical to review, so I'll move it.
