From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Aug 2018 15:59:18 +0000
Subject: [PATCH 22/23] TPMLIB: Provide call for TPM_FlushSpecific
Message-Id: <153486715863.13066.9507446322086735862.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org


---

 drivers/char/tpm/tpm-library.c |   31 +++++++++++++++++++++++++++++++
 include/linux/tpm.h            |   17 +++++++++++++++++
 include/linux/tpm_command.h    |    1 +
 3 files changed, 49 insertions(+)

diff --git a/drivers/char/tpm/tpm-library.c b/drivers/char/tpm/tpm-library.c
index d279243ccc00..27e993f0b0b7 100644
--- a/drivers/char/tpm/tpm-library.c
+++ b/drivers/char/tpm/tpm-library.c
@@ -1110,6 +1110,37 @@ out:
 }
 EXPORT_SYMBOL_GPL(tpm_load_key2);
 
+/**
+ * tpm_flush_specific - Tell the TPM to discard a handle and associated resources
+ * @chip: The chip to use
+ * @handle: The handle to discard
+ * @handle_type: The type of handle
+ */
+int tpm_flush_specific(struct tpm_chip *chip,
+		       uint32_t handle, enum tpm_resource_type handle_type)
+{
+	struct tpm_buf *tb;
+	int ret;
+
+	/* alloc some work space */
+	tb = kmalloc(sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	/* build and send the TPM request packet */
+	INIT_BUF(tb);
+	store16(tb, TPM_TAG_RQU_COMMAND);
+	store32(tb, TPM_DATA_OFFSET + 8);
+	store32(tb, TPM_ORD_FLUSHSPECIFIC);
+	store32(tb, handle);
+	store32(tb, handle_type);
+
+	ret = tpm_send_dump(chip, tb, "flushing handle");
+	kfree(tb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tpm_flush_specific);
+
 /**
  * tpm_library_use - Tell the TPM library we want to make use of it
  *
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 2be0decff93b..753ffd3799a1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -109,6 +109,19 @@ enum tpm_entity_type {
 	TPM_ET_RESERVED_HANDLE		= 0x40,
 };
 
+enum tpm_resource_type {
+	TPM_RT_KEY			= 0x00000001,
+	TPM_RT_AUTH			= 0x00000002,
+	TPM_RT_HASH			= 0x00000003,
+	TPM_RT_TRANS			= 0x00000004,
+	TPM_RT_CONTEXT			= 0x00000005,
+	TPM_RT_COUNTER			= 0x00000006,
+	TPM_RT_DELEGATE			= 0x00000007,
+	TPM_RT_DAA_TPM			= 0x00000008,
+	TPM_RT_DAA_V0			= 0x00000009,
+	TPM_RT_DAA_V1			= 0x0000000a,
+};
+
 struct tpm_buf {
 	unsigned short len;
 	unsigned short offset;
@@ -154,4 +167,8 @@ extern int tpm_load_key2(struct tpm_chip *chip,
 			 const struct tpm_wrapped_key *wrapped_key,
 			 uint32_t *_key_handle);
 
+extern int tpm_flush_specific(struct tpm_chip *chip,
+			      uint32_t handle,
+			      enum tpm_resource_type handle_type);
+
 #endif
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 211d4ce75f67..8b52447bbee3 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -30,6 +30,7 @@ enum tpm_ordinal {
 	TPM_ORD_READPUBEK		= 124,
 	TPM_ORD_SAVESTATE		= 152,
 	TPM_ORD_STARTUP			= 153,
+	TPM_ORD_FLUSHSPECIFIC		= 186,
 };
 
 /* Other constants */
