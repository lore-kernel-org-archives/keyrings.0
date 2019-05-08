From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 21:21:00 +0000
Subject: Re: [PATCH, RFC 52/62] x86/mm: introduce common code for mem encryption
Message-Id: <20190508212100.bnkgcy45xqd2o2d7@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-53-kirill.shutemov@linux.intel.com>
 <20190508165830.GA11815@infradead.org>
 <20190508135225.3cb0e638@jacob-builder>
In-Reply-To: <20190508135225.3cb0e638@jacob-builder>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 08:52:25PM +0000, Jacob Pan wrote:
> On Wed, 8 May 2019 09:58:30 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, May 08, 2019 at 05:44:12PM +0300, Kirill A. Shutemov wrote:
> > > +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_set);
> > > +
> > > +phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr)
> > > +{
> > > +	if (sme_active())
> > > +		return __sme_clr(paddr);
> > > +
> > > +	return paddr & ~mktme_keyid_mask;
> > > +}
> > > +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_clear);  
> > 
> > In general nothing related to low-level dma address should ever
> > be exposed to modules.  What is your intended user for these two?
> 
> Right no need to export. It will be used by IOMMU drivers.

I will drop these EXPORT_SYMBOL_GPL().

-- 
 Kirill A. Shutemov
