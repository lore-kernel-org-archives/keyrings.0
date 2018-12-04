From: Alison Schofield <alison.schofield@intel.com>
Date: Tue, 04 Dec 2018 07:39:54 +0000
Subject: [RFC v2 07/13] x86/mm: Add helpers for reference counting encrypted VMAs
Message-Id: <e4407d95c74300c4a6b4c5f9321660e9097fff8f.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

In order to safely manage the usage of memory encryption keys, VMAs
using each KeyID need to be counted. This count allows the MKTME
(Multi-Key Total Memory Encryption) Key Service to know when the KeyID
resource is actually in use, or when it is idle and may be considered
for reuse.

Define a global refcount_t array and provide helper functions to
manipulate the counts.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |  9 +++++++
 arch/x86/mm/mktme.c          | 58 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h           |  2 ++
 3 files changed, 69 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index de3e529f3ab0..22d52635562c 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -28,6 +28,15 @@ extern int mktme_map_get_free_keyid(void);
 extern void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
 				unsigned long start, unsigned long end);
 
+/* Manage the MTKME encrypt_count references */
+extern int mktme_alloc_encrypt_array(void);
+extern void mktme_free_encrypt_array(void);
+extern int mktme_read_encrypt_ref(int keyid);
+extern void vma_get_encrypt_ref(struct vm_area_struct *vma);
+extern void vma_put_encrypt_ref(struct vm_area_struct *vma);
+extern void key_get_encrypt_ref(int keyid);
+extern void key_put_encrypt_ref(int keyid);
+
 DECLARE_STATIC_KEY_FALSE(mktme_enabled_key);
 static inline bool mktme_enabled(void)
 {
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index e3fdf7b48173..facf08f9cb74 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -157,6 +157,64 @@ void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
 	unlink_anon_vmas(vma);
 }
 
+/*
+ *  Helper functions manage the encrypt_count[] array that counts
+ *  references on each MKTME hardware keyid. The gets & puts are
+ *  used in core mm code that allocates and free's VMA's. The alloc,
+ *  free, and read functions are used by the MKTME key service to
+ *  manage key allocation and programming.
+ */
+refcount_t *encrypt_count;
+
+int mktme_alloc_encrypt_array(void)
+{
+	encrypt_count = kvcalloc(mktme_nr_keyids, sizeof(refcount_t),
+				 GFP_KERNEL);
+	if (!encrypt_count)
+		return -ENOMEM;
+	return 0;
+}
+
+void mktme_free_encrypt_array(void)
+{
+	kvfree(encrypt_count);
+}
+
+int mktme_read_encrypt_ref(int keyid)
+{
+	return refcount_read(&encrypt_count[keyid]);
+}
+
+void vma_get_encrypt_ref(struct vm_area_struct *vma)
+{
+	if (vma_keyid(vma))
+		refcount_inc(&encrypt_count[vma_keyid(vma)]);
+}
+
+void vma_put_encrypt_ref(struct vm_area_struct *vma)
+{
+	if (vma_keyid(vma))
+		if (refcount_dec_and_test(&encrypt_count[vma_keyid(vma)])) {
+			mktme_map_lock();
+			mktme_map_free_keyid(vma_keyid(vma));
+			mktme_map_unlock();
+		}
+}
+
+void key_get_encrypt_ref(int keyid)
+{
+	refcount_inc(&encrypt_count[keyid]);
+}
+
+void key_put_encrypt_ref(int keyid)
+{
+	if (refcount_dec_and_test(&encrypt_count[keyid])) {
+		mktme_map_lock();
+		mktme_map_free_keyid(keyid);
+		mktme_map_unlock();
+	}
+}
+
 /* Prepare page to be used for encryption. Called from page allocator. */
 void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 09182d78e7b7..453d675dd116 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2812,6 +2812,8 @@ static inline void mprotect_set_encrypt(struct vm_area_struct *vma,
 					int newkeyid,
 					unsigned long start,
 					unsigned long end) {}
+static inline void vma_get_encrypt_ref(struct vm_area_struct *vma) {}
+static inline void vma_put_encrypt_ref(struct vm_area_struct *vma) {}
 #endif /* CONFIG_X86_INTEL_MKTME */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.14.1
