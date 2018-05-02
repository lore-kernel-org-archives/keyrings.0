From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 23:08:08 +0000
Subject: [PATCH v6 1/4] KEYS: Insert incompressible bytes to reserve space in bzImage
Message-Id: <20180502230811.2751-2-mkayaalp@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>, Linux Security <linux-security-module@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, George Wilson <gcwilson@us.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Include a random filled binary in vmlinux at the space reserved with
CONFIG_SYSTEM_EXTRA_CERTIFICATE. This results in an uncompressed reserved
area inside the bzImage as well, so that it can be replaced with an actual
certificate later (after the bzImage is distributed).

The bzImage contains a stripped ELF file with one section containing the
compressed vmlinux. If the reserved space is initially filled with zeros,
certificate insertion will cause a size increase in the compressed vmlinux.
In that case, reconstructing the bzImage would require relocation. To avoid
this situation, the reserved space is initially filled with random bytes.
Since a certificate contains some compressible bytes, after insertion the
vmlinux will hopefully be compressed to a smaller size.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 certs/.gitignore            |  1 +
 certs/Makefile              | 21 ++++++++++++++++++---
 certs/system_certificates.S |  2 +-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/certs/.gitignore b/certs/.gitignore
index f51aea4a71ec..4ecc8dd7559d 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -2,3 +2,4 @@
 # Generated files
 #
 x509_certificate_list
+extra_cert_placeholder
diff --git a/certs/Makefile b/certs/Makefile
index 5d0999b9e21b..a284c0c72ce5 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -16,7 +16,12 @@ ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
 $(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
 
 # GCC doesn't include .incbin files in -MD generated dependencies (PR#66871)
-$(obj)/system_certificates.o: $(obj)/x509_certificate_list
+ifeq ($(CONFIG_SYSTEM_EXTRA_CERTIFICATE),y)
+system_certs_incbin = $(obj)/x509_certificate_list $(obj)/extra_cert_placeholder
+else
+system_certs_incbin = $(obj)/x509_certificate_list
+endif
+$(obj)/system_certificates.o: $(system_certs_incbin)
 
 # Cope with signing_key.x509 existing in $(srctree) not $(objtree)
 AFLAGS_system_certificates.o := -I$(srctree)
@@ -24,12 +29,22 @@ AFLAGS_system_certificates.o := -I$(srctree)
 quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
       cmd_extract_certs  = scripts/extract-cert $(2) $@ || ( rm $@; exit 1)
 
-targets += x509_certificate_list
+targets += $(system_certs_incbin)
 $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
+
+ifeq ($(CONFIG_SYSTEM_EXTRA_CERTIFICATE),y)
+# Generate incompressible bytes. Use seed to make it reproducible
+quiet_cmd_placeholder = EXTRA_CERT_PLACEHOLDER
+      cmd_placeholder = perl -e 'srand(0); printf("%c", int(rand(256))) for (1..$(2))' > $@
+
+$(obj)/extra_cert_placeholder: FORCE
+	$(call if_changed,placeholder,$(CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE))
+endif # CONFIG_SYSTEM_EXTRA_CERTIFICATE
+
 endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
-clean-files := x509_certificate_list .x509.list
+clean-files := $(system_certs_incbin) .x509.list
 
 ifeq ($(CONFIG_MODULE_SIG),y)
 ###############################################################################
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 3918ff7235ed..e23de70c1a30 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -18,7 +18,7 @@ __cert_list_end:
 	.globl VMLINUX_SYMBOL(system_extra_cert)
 	.size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
 VMLINUX_SYMBOL(system_extra_cert):
-	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
+	.incbin "certs/extra_cert_placeholder"
 
 	.align 4
 	.globl VMLINUX_SYMBOL(system_extra_cert_used)
-- 
2.17.0

