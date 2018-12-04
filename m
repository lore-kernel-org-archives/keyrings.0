From: Alison Schofield <alison.schofield@intel.com>
Date: Tue, 04 Dec 2018 07:39:49 +0000
Subject: [RFC v2 02/13] mm: Generalize the mprotect implementation to support extensions
Message-Id: <3389bc8e46479ba102f88c157aebd49b905ac289.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

Today mprotect is implemented to support legacy mprotect behavior
plus an extension for memory protection keys. Make it more generic
so that it can support additional extensions in the future.

This is done is preparation for adding a new system call for memory
encyption keys. The intent is that the new encrypted mprotect will be
another extension to legacy mprotect.

Change-Id: Ib09b9d1b605b12d0254d7fb4968dfcc8e3c79dd7
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mprotect.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index df408956dccc..b57075e278fb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,6 +35,8 @@
 
 #include "internal.h"
 
+#define NO_KEY	-1
+
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
@@ -451,9 +453,9 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 }
 
 /*
- * pkey=-1 when doing a legacy mprotect()
+ * When pkey=NO_KEY we get legacy mprotect behavior here.
  */
-static int do_mprotect_pkey(unsigned long start, size_t len,
+static int do_mprotect_ext(unsigned long start, size_t len,
 		unsigned long prot, int pkey)
 {
 	unsigned long nstart, end, tmp, reqprot;
@@ -577,7 +579,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
-	return do_mprotect_pkey(start, len, prot, -1);
+	return do_mprotect_ext(start, len, prot, NO_KEY);
 }
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -585,7 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
-	return do_mprotect_pkey(start, len, prot, pkey);
+	return do_mprotect_ext(start, len, prot, pkey);
 }
 
 SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
-- 
2.14.1
