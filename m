From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 29 May 2019 18:20:04 +0000
Subject: Re: [PATCH, RFC 00/62] Intel MKTME enabling
Message-Id: <20190529182004.GA525@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190529073006.GG3656@rapoport-lnx>
In-Reply-To: <20190529073006.GG3656@rapoport-lnx>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:30:07AM +0300, Mike Rapoport wrote:
> On Wed, May 08, 2019 at 05:43:20PM +0300, Kirill A. Shutemov wrote:
> > = Intro > > 
> > The patchset brings enabling of Intel Multi-Key Total Memory Encryption.
> > It consists of changes into multiple subsystems:
> > 
> >  * Core MM: infrastructure for allocation pages, dealing with encrypted VMAs
> >    and providing API setup encrypted mappings.
> >  * arch/x86: feature enumeration, program keys into hardware, setup
> >    page table entries for encrypted pages and more.
> >  * Key management service: setup and management of encryption keys.
> >  * DMA/IOMMU: dealing with encrypted memory on IO side.
> >  * KVM: interaction with virtualization side.
> >  * Documentation: description of APIs and usage examples.
> > 
> > The patchset is huge. This submission aims to give view to the full picture and
> > get feedback on the overall design. The patchset will be split into more
> > digestible pieces later.
> > 
> > Please review. Any feedback is welcome.
> 
> It would be nice to have a brief usage description in cover letter rather
> than in the last patches in the series ;-)
>  

Thanks for making it all the way to the last patches in the set ;)

Yes, we will certainly include that usage model in the cover letters
of future patchsets. 

Alison
