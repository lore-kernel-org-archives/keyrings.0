From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 25 Jun 2017 15:52:33 +0000
Subject: [PATCH] modsign: add markers to endif-statements in certs/Makefile
Message-Id: <20170625155233.15848-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, dwmw2@infradead.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "open list:CERTIFICATE HANDLING:" <keyrings@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

It's a bit hard for eye to track certs/Makefile if you are not
accustomed to it. This commit adds comments to key endif statements in
order to help to keep the context while reading this file.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 certs/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 4119bb376ea1..847361ce14d1 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -26,7 +26,7 @@ quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
 targets += x509_certificate_list
 $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
 	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG_SYSTEM_TRUSTED_KEYS))
-endif
+endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 
 clean-files := x509_certificate_list .x509.list
 
@@ -87,7 +87,7 @@ $(obj)/x509.genkey:
 	@echo >>$@ "keyUsage=digitalSignature"
 	@echo >>$@ "subjectKeyIdentifier=hash"
 	@echo >>$@ "authorityKeyIdentifier=keyid"
-endif
+endif # CONFIG_MODULE_SIG_KEY
 
 $(eval $(call config_filename,MODULE_SIG_KEY))
 
@@ -102,4 +102,4 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x509
 targets += signing_key.x509
 $(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
 	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
-endif
+endif # CONFIG_MODULE_SIG
-- 
2.11.0

