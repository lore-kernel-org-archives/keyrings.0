From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Aug 2018 15:57:16 +0000
Subject: [PATCH 04/23] TPM: Expose struct tpm_chip and related find_get and put functions
Message-Id: <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

Expose struct tpm_chip and related find_get and put functions so that
TPM-using code can make sure it uses the same TPM for any related set of
operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/tpm/tpm-interface.c |   19 ++++++++++++++++---
 drivers/char/tpm/tpm.h           |    5 -----
 include/linux/tpm.h              |   10 ++++++++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index cfb9089887bd..b8f1df5b64fe 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -636,10 +636,11 @@ static int tpm_continue_selftest(struct tpm_chip *chip)
 	return rc;
 }
 
-/*
- * tpm_chip_find_get - return tpm_chip for given chip number
+/**
+ * tpm_chip_find_get - Look up a TPM chip by device index
+ * @chip_num: The index number of the chip to use or TPM_ANY_NUM
  */
-static struct tpm_chip *tpm_chip_find_get(int chip_num)
+struct tpm_chip *tpm_chip_find_get(int chip_num)
 {
 	struct tpm_chip *pos, *chip = NULL;
 
@@ -656,6 +657,18 @@ static struct tpm_chip *tpm_chip_find_get(int chip_num)
 	rcu_read_unlock();
 	return chip;
 }
+EXPORT_SYMBOL_GPL(tpm_chip_find_get);
+
+/**
+ * tpm_chip_put - Release a previously looked up TPM chip
+ * @chip: The chip to release
+ */
+void tpm_chip_put(struct tpm_chip *chip)
+{
+	if (chip)
+		module_put(chip->dev->driver->owner);
+}
+EXPORT_SYMBOL_GPL(tpm_chip_put);
 
 #define TPM_ORDINAL_PCRREAD cpu_to_be32(21)
 #define READ_PCR_RESULT_SIZE 30
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e4d0888d2eab..df6ffceb3429 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -115,11 +115,6 @@ struct tpm_chip {
 
 #define to_tpm_chip(n) container_of(n, struct tpm_chip, vendor)
 
-static inline void tpm_chip_put(struct tpm_chip *chip)
-{
-	module_put(chip->dev->driver->owner);
-}
-
 static inline int tpm_read_index(int base, int index)
 {
 	outb(index, base);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8350c538b486..44c8cad7132d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -46,11 +46,21 @@ struct tpm_class_ops {
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
+extern struct tpm_chip *tpm_chip_find_get(int chip_num);
+extern void tpm_chip_put(struct tpm_chip *chip);
+
 extern int tpm_pcr_read(u32 chip_num, int pcr_idx, u8 *res_buf);
 extern int tpm_pcr_extend(u32 chip_num, int pcr_idx, const u8 *hash);
 extern int tpm_send(u32 chip_num, void *cmd, size_t buflen);
 extern int tpm_get_random(u32 chip_num, u8 *data, size_t max);
 #else
+static inline struct tpm_chip *tpm_chip_find_get(int chip_num)
+{
+	return NULL;
+}
+static inline void tpm_chip_put(struct tpm_chip *chip)
+{
+}
 static inline int tpm_pcr_read(u32 chip_num, int pcr_idx, u8 *res_buf) {
 	return -ENODEV;
 }
