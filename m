From: ira.weiny@intel.com
Date: Fri, 09 Oct 2020 20:14:09 +0000
Subject: [PATCH RFC PKS/Trusted keys 1/2] vmalloc: Add vmalloc_pks() call
Message-Id: <20201009201410.3209180-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20201009201410.3209180-1-ira.weiny@intel.com>
In-Reply-To: <20201009201410.3209180-1-ira.weiny@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, James Bottomley <jejb@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Add a vmalloc call which allocates and creates a new mapping with the
specified pkey in the mapping.

This is currently a placeholder for the idea of an interface.  This
does not attempt to update the direct map and as such leaves access via
that map open.  Protecting that map would potentially fragment the
direct map.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/protection-keys.rst |  4 ++++
 include/linux/vmalloc.h                    |  1 +
 mm/vmalloc.c                               | 28 ++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 9e8a98653e13..574c88f45830 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -121,6 +121,7 @@ mapping adds that mapping to the protection domain.
         int pks_key_alloc(const char * const pkey_user);
         #define PAGE_KERNEL_PKEY(pkey)
         #define _PAGE_KEY(pkey)
+        void * vmalloc_pks(unsigned long size, int pkey);
         void pks_mknoaccess(int pkey, bool global);
         void pks_mkread(int pkey, bool global);
         void pks_mkrdwr(int pkey, bool global);
@@ -138,6 +139,9 @@ Kernel users must set the PTE permissions in the page table entries for the
 mappings they want to protect.  This can be done with PAGE_KERNEL_PKEY() or
 _PAGE_KEY().
 
+Alternatively, vmalloc_pks() is provided to allocate memory within the pkey
+domain specified.
+
 The pks_mk*() family of calls allows kernel users the ability to change the
 protections for the domain identified by the pkey specified.  3 states are
 available pks_mknoaccess(), pks_mkread(), and pks_mkrdwr() which set the access
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 0221f852a7e1..f5aa1d54b9b7 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -115,6 +115,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller);
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller);
+extern void *vmalloc_pks(unsigned long size, int pkey);
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..8cc973a968c4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2589,6 +2589,34 @@ void *vmalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc);
 
+/**
+ * vmalloc_pks - allocate virtually contiguous memory within the specified pkey
+ * domain
+ *
+ * @size:     allocation size
+ * @pkey:     the pkey domain to allocate the memory under
+ *
+ * Allocate enough pages to cover @size from the page level allocator and map
+ * them into contiguous kernel virtual space with the specific PKS protections
+ * if the architecture supports it.
+ *
+ * NOTE: This does not change the PKS settings established with other mappings
+ * such as the direct map.
+ *
+ * WARNING: Calling this with an invalid pkey is undefined.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+void *vmalloc_pks(unsigned long size, int pkey)
+{
+	void *ret = __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+					 GFP_KERNEL, PAGE_KERNEL_PKEY(pkey), 0,
+					 NUMA_NO_NODE, __builtin_return_address(0));
+	vm_unmap_aliases();
+	return ret;
+}
+EXPORT_SYMBOL(vmalloc_pks);
+
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill
  * @size:    allocation size
-- 
2.28.0.rc0.12.gb6a658bd00c9
