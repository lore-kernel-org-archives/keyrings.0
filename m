From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:15 +0000
Subject: [PATCHv2 01/59] mm: Do no merge VMAs with different encryption KeyIDs
Message-Id: <20190731150813.26289-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

VMAs with different KeyID do not mix together. Only VMAs with the same
KeyID are compatible.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 fs/userfaultfd.c   |  7 ++++---
 include/linux/mm.h |  9 ++++++++-
 mm/madvise.c       |  2 +-
 mm/mempolicy.c     |  3 ++-
 mm/mlock.c         |  2 +-
 mm/mmap.c          | 31 +++++++++++++++++++------------
 mm/mprotect.c      |  2 +-
 7 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ccbdbd62f0d8..3b845a6a44d0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -911,7 +911,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX);
+				 NULL_VM_UFFD_CTX, vma_keyid(vma));
 		if (prev)
 			vma = prev;
 		else
@@ -1461,7 +1461,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }));
+				 ((struct vm_userfaultfd_ctx){ ctx }),
+				 vma_keyid(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
@@ -1623,7 +1624,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX);
+				 NULL_VM_UFFD_CTX, vma_keyid(vma));
 		if (prev) {
 			vma = prev;
 			goto next;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..5bfd3dd121c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1637,6 +1637,13 @@ int clear_page_dirty_for_io(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
+#ifndef vma_keyid
+static inline int vma_keyid(struct vm_area_struct *vma)
+{
+	return 0;
+}
+#endif
+
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -2301,7 +2308,7 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx);
+	struct mempolicy *, struct vm_userfaultfd_ctx, int keyid);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
diff --git a/mm/madvise.c b/mm/madvise.c
index 968df3aa069f..00216780a630 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -138,7 +138,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx);
+			  vma->vm_userfaultfd_ctx, vma_keyid(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f48693f75b37..14ee933b1ff7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -731,7 +731,8 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
-				 new_pol, vma->vm_userfaultfd_ctx);
+				 new_pol, vma->vm_userfaultfd_ctx,
+				 vma_keyid(vma));
 		if (prev) {
 			vma = prev;
 			next = vma->vm_next;
diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..3d0a31bf214c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -535,7 +535,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
 			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx);
+			  vma->vm_userfaultfd_ctx, vma_keyid(vma));
 	if (*prev) {
 		vma = *prev;
 		goto success;
diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..715438a1fb93 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1008,7 +1008,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
  */
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
 				struct file *file, unsigned long vm_flags,
-				struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				int keyid)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1022,6 +1023,8 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
 		return 0;
 	if (vma->vm_file != file)
 		return 0;
+	if (vma_keyid(vma) != keyid)
+		return 0;
 	if (vma->vm_ops && vma->vm_ops->close)
 		return 0;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
@@ -1058,9 +1061,10 @@ static int
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		     struct anon_vma *anon_vma, struct file *file,
 		     pgoff_t vm_pgoff,
-		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		     int keyid)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, keyid) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		if (vma->vm_pgoff = vm_pgoff)
 			return 1;
@@ -1079,9 +1083,10 @@ static int
 can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		    struct anon_vma *anon_vma, struct file *file,
 		    pgoff_t vm_pgoff,
-		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		    int keyid)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx) &&
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, keyid) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
@@ -1136,7 +1141,8 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
 			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			int keyid)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
@@ -1169,7 +1175,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			mpol_equal(vma_policy(prev), policy) &&
 			can_vma_merge_after(prev, vm_flags,
 					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx)) {
+					    vm_userfaultfd_ctx, keyid)) {
 		/*
 		 * OK, it can.  Can we now merge in the successor as well?
 		 */
@@ -1178,7 +1184,8 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 				can_vma_merge_before(next, vm_flags,
 						     anon_vma, file,
 						     pgoff+pglen,
-						     vm_userfaultfd_ctx) &&
+						     vm_userfaultfd_ctx,
+						     keyid) &&
 				is_mergeable_anon_vma(prev->anon_vma,
 						      next->anon_vma, NULL)) {
 							/* cases 1, 6 */
@@ -1201,7 +1208,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			mpol_equal(policy, vma_policy(next)) &&
 			can_vma_merge_before(next, vm_flags,
 					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx)) {
+					     vm_userfaultfd_ctx, keyid)) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(prev, prev->vm_start,
 					 addr, prev->vm_pgoff, NULL, next);
@@ -1746,7 +1753,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Can we just expand an old mapping?
 	 */
 	vma = vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX);
+			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, 0);
 	if (vma)
 		goto out;
 
@@ -3025,7 +3032,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 
 	/* Can we just expand an old private anonymous mapping? */
 	vma = vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
+			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, 0);
 	if (vma)
 		goto out;
 
@@ -3223,7 +3230,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		return NULL;	/* should never get here */
 	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+			    vma->vm_userfaultfd_ctx, vma_keyid(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bf38dfbbb4b4..82d7b194a918 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -400,7 +400,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	*pprev = vma_merge(mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx);
+			   vma->vm_userfaultfd_ctx, vma_keyid(vma));
 	if (*pprev) {
 		vma = *pprev;
 		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
-- 
2.21.0
