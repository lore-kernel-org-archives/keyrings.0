From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 14 Jun 2019 17:33:45 +0000
Subject: Re: [PATCH, RFC 44/62] x86/mm: Set KeyIDs in encrypted VMAs for MKTME
Message-Id: <20190614173345.GB5917@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-45-kirill.shutemov@linux.intel.com>
 <20190614114408.GD3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190614114408.GD3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:44:08PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:44:04PM +0300, Kirill A. Shutemov wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > MKTME architecture requires the KeyID to be placed in PTE bits 51:46.
> > To create an encrypted VMA, place the KeyID in the upper bits of
> > vm_page_prot that matches the position of those PTE bits.
> > 
> > When the VMA is assigned a KeyID it is always considered a KeyID
> > change. The VMA is either going from not encrypted to encrypted,
> > or from encrypted with any KeyID to encrypted with any other KeyID.
> > To make the change safely, remove the user pages held by the VMA
> > and unlink the VMA's anonymous chain.
> 
> This does not look like a transformation that preserves content; is
> mprotect() still a suitable name?

Data is not preserved across KeyID changes, by design.

Background:
We chose to implement encrypt_mprotect() as an extension
to the legacy mprotect so that memory allocated in any
method could be encrypted. ie. we didn't want to be tied
to mmap. As an mprotect extension, encrypt_mprotect also
supports the changing of access flags.

The usage we suggest is:
1) alloc the memory w PROT_NONE to prevent any usage before
   encryption
2) use encrypt_mprotect() to add the key and change the
   access to  PROT_WRITE|PROT_READ.

Preserving the data across encryption key changes has not
been a requirement. I'm not clear if it was ever considered
and rejected. I believe that copying in order to preserve
the data was never considered.

Back to your naming question:
Since it is an mprotect extension, it seems we need to keep
the mprotect in the name. 

Thanks for bringing it up. It would be good to hear more
thoughts on this.
