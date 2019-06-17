From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Mon, 17 Jun 2019 11:25:00 +0000
Subject: Re: [PATCH, RFC 49/62] mm, x86: export several MKTME variables
Message-Id: <20190617112500.vmuu4kcjoep34hwe@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-50-kirill.shutemov@linux.intel.com>
 <20190614115647.GI3436@hirez.programming.kicks-ass.net>
 <1560741269.5187.7.camel@linux.intel.com>
 <20190617074643.GW3436@hirez.programming.kicks-ass.net>
 <1560760783.5187.10.camel@linux.intel.com>
In-Reply-To: <1560760783.5187.10.camel@linux.intel.com>
To: Kai Huang <kai.huang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:39:43PM +1200, Kai Huang wrote:
> On Mon, 2019-06-17 at 09:46 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2019 at 03:14:29PM +1200, Kai Huang wrote:
> > > On Fri, 2019-06-14 at 13:56 +0200, Peter Zijlstra wrote:
> > > > On Wed, May 08, 2019 at 05:44:09PM +0300, Kirill A. Shutemov wrote:
> > > > > From: Kai Huang <kai.huang@linux.intel.com>
> > > > > 
> > > > > KVM needs those variables to get/set memory encryption mask.
> > > > > 
> > > > > Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/mm/mktme.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> > > > > index df70651816a1..12f4266cf7ea 100644
> > > > > --- a/arch/x86/mm/mktme.c
> > > > > +++ b/arch/x86/mm/mktme.c
> > > > > @@ -7,13 +7,16 @@
> > > > >  
> > > > >  /* Mask to extract KeyID from physical address. */
> > > > >  phys_addr_t mktme_keyid_mask;
> > > > > +EXPORT_SYMBOL_GPL(mktme_keyid_mask);
> > > > >  /*
> > > > >   * Number of KeyIDs available for MKTME.
> > > > >   * Excludes KeyID-0 which used by TME. MKTME KeyIDs start from 1.
> > > > >   */
> > > > >  int mktme_nr_keyids;
> > > > > +EXPORT_SYMBOL_GPL(mktme_nr_keyids);
> > > > >  /* Shift of KeyID within physical address. */
> > > > >  int mktme_keyid_shift;
> > > > > +EXPORT_SYMBOL_GPL(mktme_keyid_shift);
> > > > >  
> > > > >  DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
> > > > >  EXPORT_SYMBOL_GPL(mktme_enabled_key);
> > > > 
> > > > NAK, don't export variables. Who owns the values, who enforces this?
> > > > 
> > > 
> > > Both KVM and IOMMU driver need page_keyid() and mktme_keyid_shift to set page's keyID to the
> > > right
> > > place in the PTE (of KVM EPT and VT-d DMA page table).
> > > 
> > > MKTME key type code need to know mktme_nr_keyids in order to alloc/free keyID.
> > > 
> > > Maybe better to introduce functions instead of exposing variables directly?
> > > 
> > > Or instead of introducing page_keyid(), we use page_encrypt_mask(), which essentially holds
> > > "page_keyid() << mktme_keyid_shift"?
> > 
> > Yes, that's much better, because that strictly limits the access to R/O.
> > 
> 
> Thanks. I think Kirill will be the one to handle your suggestion. :)
> 
> Kirill?

Will do.

-- 
 Kirill A. Shutemov
