From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 11 Jun 2019 06:28:16 +0000
Subject: [PATCH v11 12/13] ima: Store the measurement again when appraising a modsig
Message-Id: <20190611062817.18412-13-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

If the IMA template contains the "modsig" or "d-modsig" field, then the
modsig should be added to the measurement list when the file is appraised.

And that is what normally happens, but if a measurement rule caused a file
containing a modsig to be measured before a different rule causes it to be
appraised, the resulting measurement entry will not contain the modsig
because it is only fetched during appraisal. When the appraisal rule
triggers, it won't store a new measurement containing the modsig because
the file was already measured.

We need to detect that situation and store an additional measurement with
the modsig. This is done by adding an IMA_MEASURE action flag if we read a
modsig and the IMA template contains a modsig field.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      | 19 +++++++++++++++----
 security/integrity/ima/ima_main.c     | 15 ++++++++++++---
 security/integrity/ima/ima_template.c | 19 +++++++++++++++++++
 4 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a2b2c13ceda8..44f5f60424c2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -149,6 +149,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
+bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 32297d1e6164..bb887ed3d8a7 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -222,6 +222,14 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
 
+	/*
+	 * Always collect the modsig, because IMA might have already collected
+	 * the file digest without collecting the modsig in a previous
+	 * measurement rule.
+	 */
+	if (modsig)
+		ima_collect_modsig(modsig, buf, size);
+
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
 
@@ -255,9 +263,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
 
-	if (modsig)
-		ima_collect_modsig(modsig, buf, size);
-
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
@@ -307,7 +312,13 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 					     .modsig = modsig };
 	int violation = 0;
 
-	if (iint->measured_pcrs & (0x1 << pcr))
+	/*
+	 * We still need to store the measurement in the case of MODSIG because
+	 * we only have its contents to put in the list at the time of
+	 * appraisal, but a file measurement from earlier might already exist in
+	 * the measurement list.
+	 */
+	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 85afb31fafe0..e0ca39f81a59 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -307,9 +307,18 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		/* read 'security.ima' */
 		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
 
-		/* Read the appended modsig if allowed by the policy. */
-		if (iint->flags & IMA_MODSIG_ALLOWED)
-			ima_read_modsig(func, buf, size, &modsig);
+		/*
+		 * Read the appended modsig if allowed by the policy, and allow
+		 * an additional measurement list entry, if needed, based on the
+		 * template format and whether the file was already measured.
+		 */
+		if (iint->flags & IMA_MODSIG_ALLOWED) {
+			rc = ima_read_modsig(func, buf, size, &modsig);
+
+			if (!rc && ima_template_has_modsig(template_desc) &&
+			    iint->flags & IMA_MEASURED)
+				action |= IMA_MEASURE;
+		}
 	}
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e25bef419c87..00d9a6cc8a60 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -56,6 +56,25 @@ static int template_desc_init_fields(const char *template_fmt,
 				     const struct ima_template_field ***fields,
 				     int *num_fields);
 
+/**
+ * ima_template_has_modsig - Check whether template has modsig-related fields.
+ * @ima_template: IMA template to check.
+ *
+ * Tells whether the given template has fields referencing a file's appended
+ * signature.
+ */
+bool ima_template_has_modsig(const struct ima_template_desc *ima_template)
+{
+	int i;
+
+	for (i = 0; i < ima_template->num_fields; i++)
+		if (!strcmp(ima_template->fields[i]->field_id, "modsig") ||
+		    !strcmp(ima_template->fields[i]->field_id, "d-modsig"))
+			return true;
+
+	return false;
+}
+
 static int __init ima_template_setup(char *str)
 {
 	struct ima_template_desc *template_desc;
