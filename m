From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 17 Jun 2019 09:10:40 +0000
Subject: Re: [PATCH, RFC 44/62] x86/mm: Set KeyIDs in encrypted VMAs for MKTME
Message-Id: <20190617091040.GZ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-45-kirill.shutemov@linux.intel.com>
 <20190614114408.GD3436@hirez.programming.kicks-ass.net>
 <20190614173345.GB5917@alison-desk.jf.intel.com>
 <e0884a6b-78bc-209d-bc9a-90f69839189e@intel.com>
 <20190614184602.GB7252@alison-desk.jf.intel.com>
 <ca62a921-e60c-6532-32c3-f02e15ba69aa@intel.com>
In-Reply-To: <ca62a921-e60c-6532-32c3-f02e15ba69aa@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:11:23PM -0700, Dave Hansen wrote:
> On 6/14/19 11:46 AM, Alison Schofield wrote:
> > On Fri, Jun 14, 2019 at 11:26:10AM -0700, Dave Hansen wrote:
> >> On 6/14/19 10:33 AM, Alison Schofield wrote:
> >>> Preserving the data across encryption key changes has not
> >>> been a requirement. I'm not clear if it was ever considered
> >>> and rejected. I believe that copying in order to preserve
> >>> the data was never considered.
> >>
> >> We could preserve the data pretty easily.  It's just annoying, though.
> >> Right now, our only KeyID conversions happen in the page allocator.  If
> >> we were to convert in-place, we'd need something along the lines of:
> >>
> >> 	1. Allocate a scratch page
> >> 	2. Unmap target page, or at least make it entirely read-only
> >> 	3. Copy plaintext into scratch page
> >> 	4. Do cache KeyID conversion of page being converted:
> >> 	   Flush caches, change page_ext metadata
> >> 	5. Copy plaintext back into target page from scratch area
> >> 	6. Re-establish PTEs with new KeyID
> > 
> > Seems like the 'Copy plaintext' steps might disappoint the user, as
> > much as the 'we don't preserve your data' design. Would users be happy
> > w the plain text steps ?
> 
> Well, it got to be plaintext because they wrote it to memory in
> plaintext in the first place, so it's kinda hard to disappoint them. :)
> 
> IMNHO, the *vast* majority of cases, folks will allocate memory and then
> put a secret in it.  They aren't going to *get* a secret in some
> mysterious fashion and then later decide they want to protect it.  In
> other words, the inability to convert it is pretty academic and not
> worth the complexity.

I'm not saying it is (required to preserve); but I do think it is
somewhat surprising to have an mprotect() call destroy content. It's
traditionally specified to not do that.
