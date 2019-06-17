From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Mon, 17 Jun 2019 15:17:17 +0000
Subject: Re: [PATCH, RFC 18/62] x86/mm: Implement syncing per-KeyID direct mappings
Message-Id: <20190617151717.ofjfbpsgv6hkj2jk@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
 <20190614095131.GY3436@hirez.programming.kicks-ass.net>
 <20190614224309.t4ce7lpx577qh2gu@box>
 <20190617092755.GA3419@hirez.programming.kicks-ass.net>
 <20190617144328.oqwx5rb5yfm2ziws@box>
 <20190617145158.GF3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190617145158.GF3436@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 04:51:58PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 17, 2019 at 05:43:28PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Jun 17, 2019 at 11:27:55AM +0200, Peter Zijlstra wrote:
> 
> > > > > And yet I don't see anything in pageattr.c.
> > > > 
> > > > You're right. I've hooked up the sync in the wrong place.
> 
> > I think something like this should do (I'll fold it in after testing):
> 
> > @@ -643,7 +641,7 @@ static int sync_direct_mapping_keyid(unsigned long keyid)
> >   *
> >   * The function is nop until MKTME is enabled.
> >   */
> > -int sync_direct_mapping(void)
> > +int sync_direct_mapping(unsigned long start, unsigned long end)
> >  {
> >  	int i, ret = 0;
> >  
> > @@ -651,7 +649,7 @@ int sync_direct_mapping(void)
> >  		return 0;
> >  
> >  	for (i = 1; !ret && i <= mktme_nr_keyids; i++)
> > -		ret = sync_direct_mapping_keyid(i);
> > +		ret = sync_direct_mapping_keyid(i, start, end);
> >  
> >  	flush_tlb_all();
> >  
> > diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> > index 6a9a77a403c9..eafbe0d8c44f 100644
> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -347,6 +347,28 @@ static void cpa_flush(struct cpa_data *data, int cache)
> >  
> >  	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
> >  
> > +	if (mktme_enabled()) {
> > +		unsigned long start, end;
> > +
> > +		start = *cpa->vaddr;
> > +		end = *cpa->vaddr + cpa->numpages * PAGE_SIZE;
> > +
> > +		/* Sync all direct mapping for an array */
> > +		if (cpa->flags & CPA_ARRAY) {
> > +			start = PAGE_OFFSET;
> > +			end = PAGE_OFFSET + direct_mapping_size;
> > +		}
> 
> Understandable but sad, IIRC that's the most used interface (at least,
> its the one the graphics people use).
> 
> > +
> > +		/*
> > +		 * Sync per-KeyID direct mappings with the canonical one
> > +		 * (KeyID-0).
> > +		 *
> > +		 * sync_direct_mapping() does full TLB flush.
> > +		 */
> > +		sync_direct_mapping(start, end);
> > +		return;
> 
> But it doesn't flush cache. So you can't return here.

Thanks for catching this.

	if (!cache)
		return;

should be fine.

-- 
 Kirill A. Shutemov
