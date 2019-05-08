From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:07 +0000
Subject: [PATCH, RFC 47/62] mm: Restrict MKTME memory encryption to anonymous VMAs
Message-Id: <20190508144422.13171-48-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Memory encryption is only supported for mappings that are ANONYMOUS.
Test the VMA's in an encrypt_mprotect() request to make sure they all
meet that requirement before encrypting any.

The encrypt_mprotect syscall will return -EINVAL and will not encrypt
any VMA's if this check fails.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mprotect.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 38d766b5cc20..53bd41f99a67 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -346,6 +346,24 @@ static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
 	return walk_page_range(start, end, &prot_none_walk);
 }
 
+/*
+ * Encrypted mprotect is only supported on anonymous mappings.
+ * If this test fails on any single VMA, the entire mprotect
+ * request fails.
+ */
+static bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
+{
+	struct vm_area_struct *test_vma = vma;
+
+	do {
+		if (!vma_is_anonymous(test_vma))
+			return false;
+
+		test_vma = test_vma->vm_next;
+	} while (test_vma && test_vma->vm_start < end);
+	return true;
+}
+
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	       unsigned long start, unsigned long end, unsigned long newflags,
@@ -532,6 +550,12 @@ static int do_mprotect_ext(unsigned long start, size_t len,
 				goto out;
 		}
 	}
+
+	if (keyid > 0 && !mem_supports_encryption(vma, end)) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (start > vma->vm_start)
 		prev = vma;
 
-- 
2.20.1
