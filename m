From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:08:12 +0000
Subject: [PATCHv2 58/59] x86/mktme: Document the MKTME API for anonymous memory encryption
Message-Id: <20190731150813.26289-59-kirill.shutemov@linux.intel.com>
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
 Documentation/x86/mktme/index.rst         |  1 +
 Documentation/x86/mktme/mktme_encrypt.rst | 56 +++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_encrypt.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/in=
dex.rst
index 8cf2b7d62091..ca3c76adc596 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -9,3 +9,4 @@ Multi-Key Total Memory Encryption (MKTME)
    mktme_mitigations
    mktme_configuration
    mktme_keys
+   mktme_encrypt
diff --git a/Documentation/x86/mktme/mktme_encrypt.rst b/Documentation/x86/=
mktme/mktme_encrypt.rst
new file mode 100644
index 000000000000..6dc8ae11f1cb
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_encrypt.rst
@@ -0,0 +1,56 @@
+MKTME API: system call encrypt_mprotect()
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Synopsis
+--------
+int encrypt_mprotect(void \*addr, size_t len, int prot, key_serial_t seria=
l);
+
+Where *key_serial_t serial* is the serial number of a key allocated
+using the MKTME Key Service.
+
+Description
+-----------
+    encrypt_mprotect() encrypts the memory pages containing any part
+    of the address range in the interval specified by addr and len.
+
+    encrypt_mprotect() supports the legacy mprotect() behavior plus
+    the enabling of memory encryption. That means that in addition
+    to encrypting the memory, the protection flags will be updated
+    as requested in the call.
+
+    The *addr* and *len* must be aligned to a page boundary.
+
+    The caller must have *KEY_NEED_VIEW* permission on the key.
+
+    The memory that is to be protected must be mapped *ANONYMOUS*.
+
+Errors
+------
+    In addition to the Errors returned from legacy mprotect()
+    encrypt_mprotect will return:
+
+    ENOKEY *serial* parameter does not represent a valid key.
+
+    EINVAL *len* parameter is not page aligned.
+
+    EACCES Caller does not have *KEY_NEED_VIEW* permission on the key.
+
+EXAMPLE
+--------
+  Allocate an MKTME Key::
+        serial =3D add_key("mktme", "name", "type=3Dcpu algorithm=AEs-xts-=
128" @u
+
+  Map ANONYMOUS memory::
+        ptr =3D mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1,=
 0);
+
+  Protect memory::
+        ret =3D syscall(SYS_encrypt_mprotect, ptr, size, PROT_READ|PROT_WR=
ITE,
+                      serial);
+
+  Use the encrypted memory
+
+  Free memory::
+        ret =3D munmap(ptr, size);
+
+  Free the key resource::
+        ret =3D keyctl(KEYCTL_INVALIDATE, serial);
--=20
2.21.0
