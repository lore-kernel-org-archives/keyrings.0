From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:26 +0000
Subject: [PATCH, RFC 06/62] mm/khugepaged: Handle encrypted pages
Message-Id: <20190508144422.13171-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

For !NUMA khugepaged allocates page in advance, before we found a VMA
for collapse. We don't yet know which KeyID to use for the allocation.

The page is allocated with KeyID-0. Once we know that the VMA is
suitable for collapsing, we prepare the page for KeyID we need, based on
vma_keyid().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 449044378782..96326a7e9d61 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1055,6 +1055,16 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 */
 	anon_vma_unlock_write(vma->anon_vma);
 
+	/*
+	 * At this point new_page is allocated as non-encrypted.
+	 * If VMA's KeyID is non-zero, we need to prepare it to be encrypted
+	 * before coping data.
+	 */
+	if (vma_keyid(vma)) {
+		prep_encrypted_page(new_page, HPAGE_PMD_ORDER,
+				vma_keyid(vma), false);
+	}
+
 	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl);
 	pte_unmap(pte);
 	__SetPageUptodate(new_page);
-- 
2.20.1
