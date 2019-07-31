From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:08:13 +0000
Subject: [PATCHv2 59/59] x86/mktme: Demonstration program using the MKTME APIs
Message-Id: <20190731150813.26289-60-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-10"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/mktme/index.rst      |  1 +
 Documentation/x86/mktme/mktme_demo.rst | 53 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_demo.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/in=
dex.rst
index ca3c76adc596..3af322d13225 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -10,3 +10,4 @@ Multi-Key Total Memory Encryption (MKTME)
    mktme_configuration
    mktme_keys
    mktme_encrypt
+   mktme_demo
diff --git a/Documentation/x86/mktme/mktme_demo.rst b/Documentation/x86/mkt=
me/mktme_demo.rst
new file mode 100644
index 000000000000..5af78617f887
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_demo.rst
@@ -0,0 +1,53 @@
+Demonstration Program using MKTME API's
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+/* Compile with the keyutils library: cc -o mdemo mdemo.c -lkeyutils */
+
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <keyutils.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
+#define sys_encrypt_mprotect 434
+
+void main(void)
+{
+	char *options_CPU =3D "algorithm=AEs-xts-128 type=3Dcpu";
+	long size =3D PAGE_SIZE;
+        key_serial_t key;
+	void *ptra;
+	int ret;
+
+        /* Allocate an MKTME Key */
+	key =3D add_key("mktme", "testkey", options_CPU, strlen(options_CPU),
+                      KEY_SPEC_THREAD_KEYRING);
+
+	if (key =3D -1) {
+		printf("addkey FAILED\n");
+		return;
+	}
+        /* Map a page of ANONYMOUS memory */
+	ptra =3D mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (!ptra) {
+		printf("failed to mmap");
+		goto inval_key;
+	}
+        /* Encrypt that page of memory with the MKTME Key */
+	ret =3D syscall(sys_encrypt_mprotect, ptra, size, PROT_NONE, key);
+	if (ret)
+		printf("mprotect error [%d]\n", ret);
+
+        /* Enjoy that page of encrypted memory */
+
+        /* Free the memory */
+	ret =3D munmap(ptra, size);
+
+inval_key:
+        /* Free the Key */
+	if (keyctl(KEYCTL_INVALIDATE, key) =3D -1)
+		printf("invalidate failed on key [%d]\n", key);
+}
--=20
2.21.0
