From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Mon, 17 Jun 2019 14:43:28 +0000
Subject: Re: [PATCH, RFC 18/62] x86/mm: Implement syncing per-KeyID direct mappings
Message-Id: <20190617144328.oqwx5rb5yfm2ziws@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-19-kirill.shutemov@linux.intel.com>
 <20190614095131.GY3436@hirez.programming.kicks-ass.net>
 <20190614224309.t4ce7lpx577qh2gu@box>
 <20190617092755.GA3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190617092755.GA3419@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:27:55AM +0200, Peter Zijlstra wrote:
> On Sat, Jun 15, 2019 at 01:43:09AM +0300, Kirill A. Shutemov wrote:
> > On Fri, Jun 14, 2019 at 11:51:32AM +0200, Peter Zijlstra wrote:
> > > On Wed, May 08, 2019 at 05:43:38PM +0300, Kirill A. Shutemov wrote:
> > > > For MKTME we use per-KeyID direct mappings. This allows kernel to have
> > > > access to encrypted memory.
> > > > 
> > > > sync_direct_mapping() sync per-KeyID direct mappings with a canonical
> > > > one -- KeyID-0.
> > > > 
> > > > The function tracks changes in the canonical mapping:
> > > >  - creating or removing chunks of the translation tree;
> > > >  - changes in mapping flags (i.e. protection bits);
> > > >  - splitting huge page mapping into a page table;
> > > >  - replacing page table with a huge page mapping;
> > > > 
> > > > The function need to be called on every change to the direct mapping:
> > > > hotplug, hotremove, changes in permissions bits, etc.
> > > 
> > > And yet I don't see anything in pageattr.c.
> > 
> > You're right. I've hooked up the sync in the wrong place.
> > > 
> > > Also, this seems like an expensive scheme; if you know where the changes
> > > where, a more fine-grained update would be faster.
> > 
> > Do we have any hot enough pageattr users that makes it crucial?
> > 
> > I'll look into this anyway.
> 
> The graphics people would be the most agressive users of this I'd think.
> They're the ones that yelled when I broke it last ;-)

I think something like this should do (I'll fold it in after testing):

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 6c973cb1e64c..b30386d84281 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -68,7 +68,7 @@ static inline void arch_free_page(struct page *page, int order)
 		free_encrypted_page(page, order);
 }
 
-int sync_direct_mapping(void);
+int sync_direct_mapping(unsigned long start, unsigned long end);
 
 int mktme_get_alg(int keyid);
 
@@ -86,7 +86,7 @@ static inline bool mktme_enabled(void)
 
 static inline void mktme_disable(void) {}
 
-static inline int sync_direct_mapping(void)
+static inline int sync_direct_mapping(unsigned long start, unsigned long end)
 {
 	return 0;
 }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index f50a38d86cc4..f8123aeb24a6 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -761,7 +761,7 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 		pgd_changed = true;
 	}
 
-	ret = sync_direct_mapping();
+	ret = sync_direct_mapping(vaddr_start, vaddr_end);
 	WARN_ON(ret);
 
 	if (pgd_changed)
@@ -1209,7 +1209,7 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	end = (unsigned long)__va(end);
 
 	remove_pagetable(start, end, true, NULL);
-	ret = sync_direct_mapping();
+	ret = sync_direct_mapping(start, end);
 	WARN_ON(ret);
 }
 
@@ -1315,7 +1315,6 @@ void mark_rodata_ro(void)
 	unsigned long text_end = PFN_ALIGN(&__stop___ex_table);
 	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
 	unsigned long all_end;
-	int ret;
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
 	       (end - start) >> 10);
@@ -1349,8 +1348,6 @@ void mark_rodata_ro(void)
 	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
 	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
 
-	ret = sync_direct_mapping();
-	WARN_ON(ret);
 	debug_checkwx();
 }
 
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 9d2bb534f2ba..c099e1da055b 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -76,7 +76,7 @@ static void init_page_mktme(void)
 {
 	static_branch_enable(&mktme_enabled_key);
 
-	sync_direct_mapping();
+	sync_direct_mapping(PAGE_OFFSET, PAGE_OFFSET + direct_mapping_size);
 }
 
 struct page_ext_operations page_mktme_ops = {
@@ -596,15 +596,13 @@ static int sync_direct_mapping_p4d(unsigned long keyid,
 	return ret;
 }
 
-static int sync_direct_mapping_keyid(unsigned long keyid)
+static int sync_direct_mapping_keyid(unsigned long keyid,
+		unsigned long addr, unsigned long end)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long addr, end, next;
+	unsigned long next;
 	int ret = 0;
 
-	addr = PAGE_OFFSET;
-	end = PAGE_OFFSET + direct_mapping_size;
-
 	dst_pgd = pgd_offset_k(addr + keyid * direct_mapping_size);
 	src_pgd = pgd_offset_k(addr);
 
@@ -643,7 +641,7 @@ static int sync_direct_mapping_keyid(unsigned long keyid)
  *
  * The function is nop until MKTME is enabled.
  */
-int sync_direct_mapping(void)
+int sync_direct_mapping(unsigned long start, unsigned long end)
 {
 	int i, ret = 0;
 
@@ -651,7 +649,7 @@ int sync_direct_mapping(void)
 		return 0;
 
 	for (i = 1; !ret && i <= mktme_nr_keyids; i++)
-		ret = sync_direct_mapping_keyid(i);
+		ret = sync_direct_mapping_keyid(i, start, end);
 
 	flush_tlb_all();
 
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6a9a77a403c9..eafbe0d8c44f 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -347,6 +347,28 @@ static void cpa_flush(struct cpa_data *data, int cache)
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
+	if (mktme_enabled()) {
+		unsigned long start, end;
+
+		start = *cpa->vaddr;
+		end = *cpa->vaddr + cpa->numpages * PAGE_SIZE;
+
+		/* Sync all direct mapping for an array */
+		if (cpa->flags & CPA_ARRAY) {
+			start = PAGE_OFFSET;
+			end = PAGE_OFFSET + direct_mapping_size;
+		}
+
+		/*
+		 * Sync per-KeyID direct mappings with the canonical one
+		 * (KeyID-0).
+		 *
+		 * sync_direct_mapping() does full TLB flush.
+		 */
+		sync_direct_mapping(start, end);
+		return;
+	}
+
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
 		return;
-- 
 Kirill A. Shutemov
