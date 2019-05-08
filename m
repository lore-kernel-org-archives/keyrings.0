From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:23 +0000
Subject: [PATCH, RFC 03/62] mm/ksm: Do not merge pages with different KeyIDs
Message-Id: <20190508144422.13171-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KeyID indicates what key to use to encrypt and decrypt page's content.
Depending on the implementation a cipher text may be tied to physical
address of the page. It means that pages with an identical plain text
would appear different if KSM would look at a cipher text. It effectively
disables KSM for encrypted pages.

In addition, some implementations may not allow to read cipher text at all.

KSM compares plain text instead (transparently to KSM code).

But we still need to make sure that pages with identical plain text will
not be merged together if they are encrypted with different keys.

To make it work kernel only allows merging pages with the same KeyID.
The approach guarantees that the merged page can be read by all users.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h |  7 +++++++
 mm/ksm.c           | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 13c40c43ce00..07c36f4673f6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1606,6 +1606,13 @@ static inline int vma_keyid(struct vm_area_struct *vma)
 }
 #endif
 
+#ifndef page_keyid
+static inline int page_keyid(struct page *page)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..91bce4799c45 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1227,6 +1227,23 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	if (!PageAnon(page))
 		goto out;
 
+	/*
+	 * KeyID indicates what key to use to encrypt and decrypt page's
+	 * content.
+	 *
+	 * KSM compares plain text instead (transparently to KSM code).
+	 *
+	 * But we still need to make sure that pages with identical plain
+	 * text will not be merged together if they are encrypted with
+	 * different keys.
+	 *
+	 * To make it work kernel only allows merging pages with the same KeyID.
+	 * The approach guarantees that the merged page can be read by all
+	 * users.
+	 */
+	if (kpage && page_keyid(page) != page_keyid(kpage))
+		goto out;
+
 	/*
 	 * We need the page lock to read a stable PageSwapCache in
 	 * write_protect_page().  We use trylock_page() instead of
-- 
2.20.1
