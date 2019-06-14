From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jun 2019 12:15:14 +0000
Subject: Re: [PATCH, RFC 00/62] Intel MKTME enabling
Message-Id: <20190614121514.GK3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:43:20PM +0300, Kirill A. Shutemov wrote:
> = Intro > 
> The patchset brings enabling of Intel Multi-Key Total Memory Encryption.
> It consists of changes into multiple subsystems:
> 
>  * Core MM: infrastructure for allocation pages, dealing with encrypted VMAs
>    and providing API setup encrypted mappings.

That wasn't eye-bleeding bad. With exception of the refcounting; that
looks like something that can easily go funny without people noticing.

>  * arch/x86: feature enumeration, program keys into hardware, setup
>    page table entries for encrypted pages and more.

That seemed incomplete (pageattr seems to be a giant hole).

>  * Key management service: setup and management of encryption keys.
>  * DMA/IOMMU: dealing with encrypted memory on IO side.

Just minor nits, someone else would have to look at this.

>  * KVM: interaction with virtualization side.

You really want to limit the damage random modules can do. They have no
business writing to the mktme variables.

>  * Documentation: description of APIs and usage examples.

Didn't bother with those; if the Changelogs are inadequate to make sense
of the patches documentation isn't the right place to fix things.

> The patchset is huge. This submission aims to give view to the full picture and
> get feedback on the overall design. The patchset will be split into more
> digestible pieces later.
> 
> Please review. Any feedback is welcome.

I still can't tell if this is worth the complexity :-/

Yes, there's a lot of words, but it doesn't mean anything to me, that
is, nothing here makes me want to build my kernel with this 'feature'
enabled.
