From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:20 +0000
Subject: [PATCH, RFC 60/62] x86/mktme: Document the MKTME Key Service API
Message-Id: <20190508144422.13171-61-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-10"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/mktme/index.rst      |  1 +
 Documentation/x86/mktme/mktme_keys.rst | 96 ++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/x86/mktme/mktme_keys.rst

diff --git a/Documentation/x86/mktme/index.rst b/Documentation/x86/mktme/in=
dex.rst
index 0f021cc4a2db..8cf2b7d62091 100644
--- a/Documentation/x86/mktme/index.rst
+++ b/Documentation/x86/mktme/index.rst
@@ -8,3 +8,4 @@ Multi-Key Total Memory Encryption (MKTME)
    mktme_overview
    mktme_mitigations
    mktme_configuration
+   mktme_keys
diff --git a/Documentation/x86/mktme/mktme_keys.rst b/Documentation/x86/mkt=
me/mktme_keys.rst
new file mode 100644
index 000000000000..161871dee0dc
--- /dev/null
+++ b/Documentation/x86/mktme/mktme_keys.rst
@@ -0,0 +1,96 @@
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
+	When type=3Dno-encrypt this key field must not be present
+        in the payload.
+
+    tweak+	When type=3Duser the user must supply a 128 bit tweak key
+        as exactly 32 ASCII hexadecimal characters.
+
+	When type=3Dcpu the user may optionally supply 128 bits of
+        entropy for the CPU generated tweak key in this field.
+        It must be exactly 32 ASCII hexadecimal characters.
+
+        When type=3Dno-encrypt the tweak field must not be present
+        in the payload.
+
+ERRORS
+------
+    In addition to the Errors returned from the Kernel Key Service,
+    add_key(2) or keyctl(1) commands, the MKTME Key Service type may
+    return the following errors:
+
+    EINVAL for any payload specification that does not match the
+           MKTME type payload as defined above.
+
+    EACCES for access denied. The MKTME key type uses capabilities
+           to restrict the allocation of keys to privileged users.
+           CAP_SYS_RESOURCE is required, but it will accept the
+           broader capability of CAP_SYS_ADMIN. See capabilities(7).
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
+    Add a "no-encrypt' type key::
+
+	key =3D add_key("mktme", "name", "no-encrypt", strlen(options_CPU),
+		      KEY_SPEC_THREAD_KEYRING);
--=20
2.20.1
