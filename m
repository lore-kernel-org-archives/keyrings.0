From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 14 Jun 2019 22:43:09 +0000
Subject: Re: [PATCH, RFC 18/62] x86/mm: Implement syncing per-KeyID direct mappings
Message-Id: <20190614224309.t4ce7lpx577qh2gu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
 <20190614095131.GY3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614095131.GY3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:51:32AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:38PM +0300, Kirill A. Shutemov wrote:
> > For MKTME we use per-KeyID direct mappings. This allows kernel to have
> > access to encrypted memory.
> > 
> > sync_direct_mapping() sync per-KeyID direct mappings with a canonical
> > one -- KeyID-0.
> > 
> > The function tracks changes in the canonical mapping:
> >  - creating or removing chunks of the translation tree;
> >  - changes in mapping flags (i.e. protection bits);
> >  - splitting huge page mapping into a page table;
> >  - replacing page table with a huge page mapping;
> > 
> > The function need to be called on every change to the direct mapping:
> > hotplug, hotremove, changes in permissions bits, etc.
> 
> And yet I don't see anything in pageattr.c.

You're right. I've hooked up the sync in the wrong place.
> 
> Also, this seems like an expensive scheme; if you know where the changes
> where, a more fine-grained update would be faster.

Do we have any hot enough pageattr users that makes it crucial?

I'll look into this anyway.

-- 
 Kirill A. Shutemov
