From: Alison Schofield <alison.schofield@intel.com>
Date: Tue, 04 Dec 2018 07:39:48 +0000
Subject: [RFC v2 01/13] x86/mktme: Document the MKTME APIs
Message-Id: <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-10"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
To: dhowells@redhat.com, tglx@linutronix.de
Cc: jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

This includes an overview, a section on each API: MTKME Keys and
system call encrypt_mprotect(), and a demonstration program.

(Some of this info is destined for man pages.)

Change-Id: I34dc9ff1a1308c057ec4bb3e652c4d7ce6995606
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/mktme/index.rst          |  11 +++
 Documentation/x86/mktme/mktme_demo.rst     |  53 ++++++++++++++
 Documentation/x86/mktme/mktme_encrypt.rst  |  58 +++++++++++++++
 Documentation/x86/mktme/mktme_keys.rst     | 109 +++++++++++++++++++++++++=
++++
 Documentation/x86/mktme/mktme_overview.rst |  60 ++++++++++++++++
 5 files changed, 291 insertions(+)
 create mode 100644 Documentation/x86/mktme/index.rst
 create mode 100644 Documentation/x86/mktme/mktme_demo.rst
 create mode 100644 Documentation/x86/mktme/mktme_encrypt.rst
 create mode 100644 Documentation/x86/mktme/mktme_keys.rst
 create mode 100644 Documentation/x86/mktme/mktme_overview.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/in=
dex.rst
new file mode 100644
index 000000000000..8c556d04cbc4
--- /dev/null
+++ b/Documentation/x86/mktme/index.rst
@@ -0,0 +1,11 @@
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+Multi-K=
ey Total Memory Encryption (MKTME) API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+.. toctree::
+
+   mktme_overview
+   mktme_keys
+   mktme_encrypt
+   mktme_demo
diff --git a/Documentation/x86/mktme/mktme_demo.rst b/Documentation/x86/mkt=
me/mktme_demo.rst
new file mode 100644
index 000000000000..afd50772e65d
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
+#define sys_encrypt_mprotect 335
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
diff --git a/Documentation/x86/mktme/mktme_encrypt.rst b/Documentation/x86/=
mktme/mktme_encrypt.rst
new file mode 100644
index 000000000000..ede5237183fc
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_encrypt.rst
@@ -0,0 +1,58 @@
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
+    The range of memory that is to be protected must be mapped as
+    *ANONYMOUS*.
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
+
diff --git a/Documentation/x86/mktme/mktme_keys.rst b/Documentation/x86/mkt=
me/mktme_keys.rst
new file mode 100644
index 000000000000..5837909b2c54
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_keys.rst
@@ -0,0 +1,109 @@
+MKTME Key Service API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+MKTME is a new key service type added to th=
e Linux Kernel Key Service.
+
+The MKTME Key Service type is available when CONFIG_X86_INTEL_MKTME is
+turned on in Intel platforms that support the MKTME feature.
+
+The MKTME Key Service type manages the allocation of hardware encryption
+keys. Users can request an MKTME type key and then use that key to
+encrypt memory with the encrypt_mprotect() system call.
+
+Usage
+-----
+    When using the Kernel Key Service to request an *mktme* key,
+    specify the *payload* as follows:
+
+    type+        *user*	User will supply the encryption key data. Use this
+                type to directly program a hardware encryption key.
+
+        *cpu*	User requests a CPU generated encryption key.
+                The CPU generates and assigns an ephemeral key.
+
+        *clear* User requests that a hardware encryption key be
+                cleared. This will clear the encryption key from
+                the hardware. On execution this hardware key gets
+                TME behavior.
+
+        *no-encrypt*
+                 User requests that hardware does not encrypt
+                 memory when this key is in use.
+
+    algorithm+        When type=3Duser or type=3Dcpu the algorithm field m=
ust be
+        *aes-xts-128*
+
+        When type=3Dclear or type=3Dno-encrypt the algorithm field
+        must not be present in the payload.
+
+    key+        When type=3Duser the user must supply a 128 bit encryption
+        key as exactly 32 ASCII hexadecimal characters.
+
+	When type=3Dcpu the user may optionally supply 128 bits of
+        entropy for the CPU generated encryption key in this field.
+        It must be exactly 32 ASCII hexadecimal characters.
+
+	When type=3Dclear or type=3Dno-encrypt this key field must
+        not be present in the payload.
+
+    tweak+	When type=3Duser the user must supply a 128 bit tweak key
+        as exactly 32 ASCII hexadecimal characters.
+
+	When type=3Dcpu the user may optionally supply 128 bits of
+        entropy for the CPU generated tweak key in this field. It
+        must be exactly 32 ASCII hexadecimal characters.
+
+        When type=3Dclear or type=3Dno-encrypt the tweak field must
+	not be present in the payload.
+
+ERRORS
+------
+    In addition to the Errors returned from the Kernel Key Service,
+    add_key(2) or keyctl(1) commands, the MKTME Key Service type may
+    return the following errors:
+
+    EINVAL for any payload specification that does not match the
+           MKTME type payload as defined above.
+    EACCES for access denied. MKTME key type uses capabilities to
+           restrict the allocation of keys. CAP_SYS_RESOURCE is
+           required, but it will accept the broader capability of
+           CAP_SYS_ADMIN.  See capabilities(7).
+
+    ENOKEY if a hardware key cannot be allocated. Additional error
+           messages will describe the hardware programming errors.
+
+EXAMPLES
+--------
+    Add a 'user' type key::
+
+        char \*options_USER =3D "type=3Duser
+                               algorithm=AEs-xts-128
+                               key=12345678912345671234567891234567
+                               tweak=12345678912345671234567891234567";
+
+        key =3D add_key("mktme", "name", options_USER, strlen(options_USER=
),
+                      KEY_SPEC_THREAD_KEYRING);
+
+    Add a 'cpu' type key::
+
+        char \*options_USER =3D "type=3Dcpu algorithm=AEs-xts-128";
+
+        key =3D add_key("mktme", "name", options_CPU, strlen(options_CPU),
+                      KEY_SPEC_THREAD_KEYRING);
+
+    Update a key to 'Clear' type::
+
+        Note: This has the effect of clearing out the previously programmed
+        encryption data in the hardware. Use this to clear the hardware sl=
ot
+        prior to invalidating the key.
+
+        ret =3D keyctl(KEYCTL_UPDATE, key, "type=3Dclear", strlen(options_=
CLEAR);
+
+    Add a "no-encrypt' type key::
+
+	key =3D add_key("mktme", "name", "no-encrypt", strlen(options_CPU),
+		      KEY_SPEC_THREAD_KEYRING);
+
diff --git a/Documentation/x86/mktme/mktme_overview.rst b/Documentation/x86=
/mktme/mktme_overview.rst
new file mode 100644
index 000000000000..cc2c4a8320e7
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_overview.rst
@@ -0,0 +1,60 @@
+Overview
+=3D=3D=3D=3D
+MKTME (Multi-Key Total Memory Encryption) is a technology that allows
+memory encryption on Intel platforms. The main use case for the feature
+is virtual machine isolation. The API should apply to a wide range of
+use cases.
+
+Find the Intel Architecture Specification for MKTME here:
+https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Tot=
al-Memory-Encryption-Spec.pdf
+
+The Encryption Process
+----------------------
+Userspace will see MKTME encryption as a Step Process.
+
+Step 1: Use the MKTME Key Service API to allocate an encryption key.
+
+Step 2: Use the encrypt_mprotect() system call to protect memory
+        with the encryption key obtained in Step 1.
+
+Definitions
+-----------
+Keys:	References to Keys in this document are to Userspace Keys.
+	These keys are requested by users and jointly managed by the
+	MKTME Key Service Type, and more broadly by the Kernel Key
+        Service of which MKTME is a part.
+
+	This document does not intend to document KKS, but only the
+	MKTME type of the KKS. The options of the KKS can be grouped
+	into 2 classes for purposes of understanding how MKTME operates
+	within the broader KKS.
+
+KeyIDs: References to KeyIDs in this document are to the hardware KeyID
+	slots that are available on Intel Platforms. A KeyID is a
+	numerical index into a software programmable slot in the Intel
+	hardware. Refer to the Intel specification linked above for
+	details on the implementation of MKTME in Intel platforms.
+
+Key<-->KeyID Mapping:
+	The MKTME Key Service maintains a mapping between Keys and KeyIDS.
+	This mapping is known only to the kernel. Userspace does not need
+	to know which hardware KeyID slot it's Userspace Key has been
+	assigned.
+
+Configuration
+-------------
+
+CONFIG_X86_INTEL_MKTME
+        MKTME is enabled by selecting CONFIG_X86_INTEL_MKTME on Intel
+        platforms supporting the MKTME feature.
+
+mktme_savekeys
+        mktme_savekeys is a kernel cmdline parameter.
+
+        This parameter allows the kernel to save the user specified
+        MKTME key payload. Saving this payload means that the MKTME
+        Key Service can always allow the addition of new physical
+        packages. If the mktme_savekeys parameter is not present,
+        users key data will not be saved, and new physical packages
+        may only be added to the system if no user type MKTME keys
+        are in use.
--=20
2.14.1
