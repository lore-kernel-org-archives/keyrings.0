From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 18 Apr 2019 03:51:19 +0000
Subject: [PATCH v10 11/12] ima: Define ima-modsig template
Message-Id: <20190418035120.2354-12-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
In-Reply-To: <20190418035120.2354-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Define new "d-modsig" template field which holds the digest that is
expected to match the one contained in the modsig, and also new "modsig"
template field which holds the appended file signature.

Add a new "ima-modsig" defined template descriptor with the new fields as
well as the ones from the "ima-sig" descriptor.

Change ima_store_measurement() to accept a struct modsig * argument so that
it can be passed along to the templates via struct ima_event_data.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  7 ++-
 security/integrity/ima/ima.h              | 21 +++++++-
 security/integrity/ima/ima_api.c          |  6 ++-
 security/integrity/ima/ima_main.c         |  2 +-
 security/integrity/ima/ima_modsig.c       | 19 +++++++
 security/integrity/ima/ima_policy.c       | 42 +++++++++++++++-
 security/integrity/ima/ima_template.c     |  7 ++-
 security/integrity/ima/ima_template_lib.c | 60 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  4 ++
 9 files changed, 158 insertions(+), 10 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..8da20b444be0 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -68,15 +68,18 @@ descriptors by adding their identifier to the format string
  - 'd-ng': the digest of the event, calculated with an arbitrary hash
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
+ - 'd-modsig': the digest of the event without the appended modsig;
  - 'n-ng': the name of the event, without size limitations;
- - 'sig': the file signature.
+ - 'sig': the file signature;
+ - 'modsig' the appended file signature.
 
 
 Below, there is the list of defined template descriptors:
 
  - "ima": its format is ``d|n``;
  - "ima-ng" (default): its format is ``d-ng|n-ng``;
- - "ima-sig": its format is ``d-ng|n-ng|sig``.
+ - "ima-sig": its format is ``d-ng|n-ng|sig``;
+ - "ima-modsig": its format is ``d-ng|n-ng|sig|d-modsig|modsig``.
 
 
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e051477badf4..4e51290b149d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -64,6 +64,7 @@ struct ima_event_data {
 	const unsigned char *filename;
 	struct evm_ima_xattr_data *xattr_value;
 	int xattr_len;
+	const struct modsig *modsig;
 	const char *violation;
 };
 
@@ -205,7 +206,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
-			   int xattr_len, int pcr);
+			   int xattr_len, const struct modsig *modsig,
+			   int pcr);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -303,6 +305,10 @@ bool ima_hook_supports_modsig(enum ima_hooks func);
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
 void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
+int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
+			  const u8 **digest, u32 *digest_size);
+int ima_modsig_serialize(const struct modsig *modsig, const void **data,
+			 u32 *data_len);
 void ima_free_modsig(struct modsig *modsig);
 #else
 static inline bool ima_hook_supports_modsig(enum ima_hooks func)
@@ -321,6 +327,19 @@ static inline void ima_collect_modsig(struct modsig *modsig, const void *buf,
 {
 }
 
+static inline int ima_get_modsig_digest(const struct modsig *modsig,
+					enum hash_algo *algo,
+					const u8 **digest, u32 *digest_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int ima_modsig_serialize(const struct modsig *modsig,
+				       const void **data, u32 *data_len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_free_modsig(struct modsig *modsig)
 {
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 7c01b0a57a5a..3ef48d516f02 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -281,7 +281,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
-			   int xattr_len, int pcr)
+			   int xattr_len, const struct modsig *modsig,
+			   int pcr)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
@@ -291,7 +292,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	struct ima_event_data event_data = { .iint = iint, .file = file,
 					     .filename = filename,
 					     .xattr_value = xattr_value,
-					     .xattr_len = xattr_len };
+					     .xattr_len = xattr_len,
+					     .modsig = modsig };
 	int violation = 0;
 
 	if (iint->measured_pcrs & (0x1 << pcr))
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b5e44d03a0e3..8e6475854351 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -298,7 +298,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, pcr);
+				      xattr_value, xattr_len, modsig, pcr);
 	if (rc = 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 22a49f127437..3956a40ba60c 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -140,6 +140,25 @@ int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
 					VERIFYING_MODULE_SIGNATURE, NULL, NULL);
 }
 
+int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *algo,
+			  const u8 **digest, u32 *digest_size)
+{
+	*algo = modsig->hash_algo;
+	*digest = modsig->digest;
+	*digest_size = modsig->digest_size;
+
+	return 0;
+}
+
+int ima_modsig_serialize(const struct modsig *modsig, const void **data,
+			 u32 *data_len)
+{
+	*data = &modsig->raw_pkcs7;
+	*data_len = modsig->raw_pkcs7_len;
+
+	return 0;
+}
+
 void ima_free_modsig(struct modsig *modsig)
 {
 	if (!modsig)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a7a20a8c15c1..65989ffc05b1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -10,6 +10,9 @@
  *	- initialize default measure policy rules
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -756,6 +759,40 @@ static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 	ima_log_string_op(ab, key, value, NULL);
 }
 
+/*
+ * Validating the appended signature included in the measurement list requires
+ * the file hash calculated without the appended signature (i.e., the 'd-modsig'
+ * field). Therefore, notify the user if they have the 'modsig' field but not
+ * the 'd-modsig' field in the template.
+ */
+static void check_current_template_modsig(void)
+{
+#define MSG "template with 'modsig' field also needs 'd-modsig' field\n"
+	struct ima_template_desc *template;
+	bool has_modsig, has_dmodsig;
+	static bool checked;
+	int i;
+
+	/* We only need to notify the user once. */
+	if (checked)
+		return;
+
+	has_modsig = has_dmodsig = false;
+	template = ima_template_desc_current();
+	for (i = 0; i < template->num_fields; i++) {
+		if (!strcmp(template->fields[i]->field_id, "modsig"))
+			has_modsig = true;
+		else if (!strcmp(template->fields[i]->field_id, "d-modsig"))
+			has_dmodsig = true;
+	}
+
+	if (has_modsig && !has_dmodsig)
+		pr_notice(MSG);
+
+	checked = true;
+#undef MSG
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1039,10 +1076,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if ((strcmp(args[0].from, "imasig")) = 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED;
 			else if (ima_hook_supports_modsig(entry->func) &&
-				 strcmp(args[0].from, "imasig|modsig") = 0)
+				 strcmp(args[0].from, "imasig|modsig") = 0) {
 				entry->flags |= IMA_DIGSIG_REQUIRED
 						| IMA_MODSIG_ALLOWED;
-			else
+				check_current_template_modsig();
+			} else
 				result = -EINVAL;
 			break;
 		case Opt_permit_directio:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..b05a14821a08 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
+	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
@@ -43,8 +44,12 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "d-modsig", .field_init = ima_eventdigest_modsig_init,
+	 .field_show = ima_show_template_digest_ng},
+	{.field_id = "modsig", .field_init = ima_eventmodsig_init,
+	 .field_show = ima_show_template_sig},
 };
-#define MAX_TEMPLATE_NAME_LEN 15
+#define MAX_TEMPLATE_NAME_LEN sizeof("d|n|d-ng|n-ng|sig|d-modisg|modsig")
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..f549710f58ce 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -223,7 +223,8 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 	return 0;
 }
 
-static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
+static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
+				       u8 hash_algo,
 				       struct ima_field_data *field_data)
 {
 	/*
@@ -326,6 +327,41 @@ int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 					   hash_algo, field_data);
 }
 
+/*
+ * This function writes the digest of the file which is expected to match the
+ * digest contained in the file's embedded signature.
+ */
+int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data)
+{
+	enum hash_algo hash_algo;
+	const u8 *cur_digest;
+	u32 cur_digestsize;
+
+	if (!event_data->modsig)
+		return 0;
+
+	if (event_data->violation) {
+		/* Recording a violation. */
+		hash_algo = HASH_ALGO_SHA1;
+		cur_digest = NULL;
+		cur_digestsize = 0;
+	} else {
+		int rc;
+
+		rc = ima_get_modsig_digest(event_data->modsig, &hash_algo,
+					   &cur_digest, &cur_digestsize);
+		if (rc)
+			return rc;
+		else if (hash_algo = HASH_ALGO__LAST || cur_digestsize = 0)
+			/* There was some error collecting the digest. */
+			return -EINVAL;
+	}
+
+	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
+					   hash_algo, field_data);
+}
+
 static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data,
 				     bool size_limit)
@@ -389,3 +425,25 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
 					     DATA_FMT_HEX, field_data);
 }
+
+int ima_eventmodsig_init(struct ima_event_data *event_data,
+			 struct ima_field_data *field_data)
+{
+	const void *data;
+	u32 data_len;
+	int rc;
+
+	if (!event_data->modsig)
+		return 0;
+
+	/*
+	 * The xattr_value for IMA_MODSIG is a runtime structure containing
+	 * pointers. Get its raw data instead.
+	 */
+	rc = ima_modsig_serialize(event_data->modsig, &data, &data_len);
+	if (rc)
+		return rc;
+
+	return ima_write_template_field_data(data, data_len,
+					     DATA_FMT_HEX, field_data);
+}
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..1d7c690ebae5 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -38,8 +38,12 @@ int ima_eventname_init(struct ima_event_data *event_data,
 		       struct ima_field_data *field_data);
 int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
 		      struct ima_field_data *field_data);
+int ima_eventmodsig_init(struct ima_event_data *event_data,
+			 struct ima_field_data *field_data);
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
