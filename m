From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 07 Aug 2019 14:28:50 +0000
Subject: Re: [PATCHv2 47/59] kvm, x86, mmu: setup MKTME keyID to spte for given PFN
Message-Id: <20190807142850.mjp4ctqc7wttpser@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
 <20190731150813.26289-48-kirill.shutemov@linux.intel.com>
 <a3aee9ea-a3ce-1219-b7ff-5a1b291bffdd@amd.com>
In-Reply-To: <a3aee9ea-a3ce-1219-b7ff-5a1b291bffdd@amd.com>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On Tue, Aug 06, 2019 at 08:26:52PM +0000, Lendacky, Thomas wrote:
> On 7/31/19 10:08 AM, Kirill A. Shutemov wrote:
> > From: Kai Huang <kai.huang@linux.intel.com>
> > 
> > Setup keyID to SPTE, which will be eventually programmed to shadow MMU
> > or EPT table, according to page's associated keyID, so that guest is
> > able to use correct keyID to access guest memory.
> > 
> > Note current shadow_me_mask doesn't suit MKTME's needs, since for MKTME
> > there's no fixed memory encryption mask, but can vary from keyID 1 to
> > maximum keyID, therefore shadow_me_mask remains 0 for MKTME.
> > 
> > Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kvm/mmu.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index 8f72526e2f68..b8742e6219f6 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -2936,6 +2936,22 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
> >  #define SET_SPTE_WRITE_PROTECTED_PT	BIT(0)
> >  #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
> >  
> > +static u64 get_phys_encryption_mask(kvm_pfn_t pfn)
> > +{
> > +#ifdef CONFIG_X86_INTEL_MKTME
> > +	struct page *page;
> > +
> > +	if (!pfn_valid(pfn))
> > +		return 0;
> > +
> > +	page = pfn_to_page(pfn);
> > +
> > +	return ((u64)page_keyid(page)) << mktme_keyid_shift();
> > +#else
> > +	return shadow_me_mask;
> > +#endif
> > +}
> 
> This patch breaks AMD virtualization (SVM) in general (non-SEV and SEV
> guests) when SME is active. Shouldn't this be a run time, vs build time,
> check for MKTME being active?

Thanks, I've missed this.

This fixup should help:

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 00d17bdfec0f..54931acf260e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2947,18 +2947,17 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 
 static u64 get_phys_encryption_mask(kvm_pfn_t pfn)
 {
-#ifdef CONFIG_X86_INTEL_MKTME
 	struct page *page;
 
+	if (!mktme_enabled())
+		return shadow_me_mask;
+
 	if (!pfn_valid(pfn))
 		return 0;
 
 	page = pfn_to_page(pfn);
 
 	return ((u64)page_keyid(page)) << mktme_keyid_shift();
-#else
-	return shadow_me_mask;
-#endif
 }
 
 static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-- 
 Kirill A. Shutemov
