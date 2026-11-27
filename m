Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748402;
	b=VgSAov9hdEA6z27p0nY+oSqBzxThSc2YMrI6/ZtC5GuwGCuUGHSBfQZvPE4CkOYcuEFf
	 vtpU5vs8PA/aXH/SYcZ7ftlbNs2uwI5YyDbABPUw7wkxd0oT36CPtn0FM/ACiNmgiOXjj
	 FJIqes9uNrr1KCdsUPf5/SwYVNQbvVJjAyvmF4DtqBf46RGftNorlo0cKvedKHbPu4zoM
	 SJvFSauV6E+2V4hGlLkSUilQ5IGI3+JHRARblHdYGuEYBNpx1d/7n2h3bqmSCWoc+Ol0M
	 pEcEF/I/qTYdmuLQ5M3wLaI6vMDd/6IrBeFHGqtcUdkBqbTzRnCn+6AKJEIFeKBilIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748402;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=xHWWO6o99kjU2TzReE8Vn7pFee8z3fLYhbzMLKyNUlc=;
	b=qfNpYGEVIYEWPv6Uy8KUfc7xImwStXmxtvJV5zxnsepJZbYVJ/iKltMV4knfVxXClWNM
	 1CZQHxHJ0UzhC+LjpnyVZ3RLAFvHW/3cCV08JvYtX/hnnUMSSVVAZSbR+vM4pnwcVBrwO
	 5PXTq+vonC7TH8Q7eE8Xi8EnQVtCJ+Nrogyrw2O19ca2bJ1acnVdOPm1P/Of+k9Y08Bdm
	 BA2r1iWH/TkQQ5Tw73mAFAO5BBwA2bnl1Fs9Eyok9u0dzyRZaNpLFONG0oJe7pcIXshrg
	 uxk+o2T6aeO0XIjFF+E7qMqvWYH47vhOZey+CbDzEtjrAXHmCWyyKDHg4b+BmeptwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLjYxv2z;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95080606A324
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 03:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95080606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLjYxv2z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHWWO6o99kjU2TzReE8Vn7pFee8z3fLYhbzMLKyNUlc=;
	b=YLjYxv2zRd2fogOZvc8btsRK9ju02pg40V4T7Zy3yw7+dze6dZpf43XP9P2WYcHfLbogBL
	2LrG7eRj+V2/rikySWJRBS4B9PKtshEWK+HRvCm1gu2+3BjyZfb8kqu/ZnR0B11ZLIGA5v
	X8jJnWrc3emuxxVXiYsVsQdk8RuE/lw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-nX4TE-hdPRS1qYNP4mdjcg-1; Fri,
 27 Nov 2026 02:59:55 +0000
X-MC-Unique: nX4TE-hdPRS1qYNP4mdjcg-1
X-Mimecast-MFC-AGG-ID: nX4TE-hdPRS1qYNP4mdjcg_1795748394
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A321195608C;
	Fri, 27 Nov 2026 02:59:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00503180197D;
	Fri, 27 Nov 2026 02:59:53 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 6/8] ima: add the 'd-modsig-list' template field
Date: Thu, 26 Nov 2026 23:59:09 -0300
Message-ID: <20261127025912.1383750-7-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The 'd-modsig' field holds a single content digest, so it can't describe an
appended signature with more than one signer, let alone signers using
different algorithms. With that, add a 'd-modsig-list' field that records
an entry per signer as the following length-value table:

    <u32 count> x (<u32 entry_len><entry>)

with the entries in the order of the signers in the 'modsig' field, so
entry i describes signer i, and following the already known d-modsig
format:

    <hash algo>: <digest>

for a signer that signs an usual digest, and:

    <signature algo>: '\0'

for a signer that signs data directly (eg. ML-DSA). The idea of adding an
empty entry is to keep entries aligned with their signers in 'modsig'
field, easing verifiers work.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/security/IMA-templates.rst  |   3 +
 security/integrity/ima/ima_policy.c       |   3 +-
 security/integrity/ima/ima_template.c     |   6 +-
 security/integrity/ima/ima_template_lib.c | 103 ++++++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |   4 +
 5 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 4ec0440b27f1..161aed3da8b7 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -72,6 +72,9 @@ descriptors by adding their identifier to the format string
  - 'd-modsig': the digest of the event without the appended modsig or a signature
    algorithm name followed by an empty digest (<signing algo>: \0) when direct data
    algorithms are used, e.g. ML-DSA;
+ - 'd-modsig-list': a list of 'd-modsig' of each signer when multiple signatures are
+   present and which may use different algorithms
+   (field format: <entry count>[pairs of <entry length><d-modsig entry>]);
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature, based on either the file's/fsverity's digest[1],
    or the EVM portable signature, if 'security.ima' contains a file hash.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dc1d93aa768..bb68f78fdb0e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1242,7 +1242,8 @@ static void check_template_modsig(const struct ima_template_desc *template)
 	for (i = 0; i < template->num_fields; i++) {
 		if (!strcmp(template->fields[i]->field_id, "modsig"))
 			has_modsig = true;
-		else if (!strcmp(template->fields[i]->field_id, "d-modsig"))
+		else if (!strcmp(template->fields[i]->field_id, "d-modsig") ||
+			 !strcmp(template->fields[i]->field_id, "d-modsig-list"))
 			has_dmodsig = true;
 	}
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 16154078fd70..584f970e553e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -50,6 +50,9 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_buf},
 	{.field_id = "d-modsig", .field_init = ima_eventdigest_modsig_init,
 	 .field_show = ima_show_template_digest_ng},
+	{.field_id = "d-modsig-list",
+	 .field_init = ima_eventdigest_modsig_list_init,
+	 .field_show = ima_show_template_modsig_list},
 	{.field_id = "modsig", .field_init = ima_eventmodsig_init,
 	 .field_show = ima_show_template_sig},
 	{.field_id = "evmsig", .field_init = ima_eventevmsig_init,
@@ -95,7 +98,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template)
 
 	for (i = 0; i < ima_template->num_fields; i++)
 		if (!strcmp(ima_template->fields[i]->field_id, "modsig") ||
-		    !strcmp(ima_template->fields[i]->field_id, "d-modsig"))
+		    !strcmp(ima_template->fields[i]->field_id, "d-modsig") ||
+		    !strcmp(ima_template->fields[i]->field_id, "d-modsig-list"))
 			return true;
 
 	return false;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index a2aeaae83065..eeb636155798 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -200,6 +200,40 @@ void ima_show_template_digest_ngv2(struct seq_file *m, enum ima_show_type show,
 				     field_data);
 }
 
+void ima_show_template_modsig_list(struct seq_file *m, enum ima_show_type show,
+				   struct ima_field_data *field_data)
+{
+	struct ima_field_data entry;
+	u32 count, i;
+	int parsed;
+	void *p = field_data->data;
+	void *end = p + field_data->len;
+
+	if (show != IMA_SHOW_ASCII || field_data->len < sizeof(count)) {
+		ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
+		return;
+	}
+
+	memcpy(&count, p, sizeof(count));
+	if (ima_canonical_fmt)
+		count = le32_to_cpu((__force __le32)count);
+	p += sizeof(count);
+
+	for (i = 0; i < count; i++) {
+		ima_parse_buf(p, end, &p, 1, &entry, &parsed, NULL, 0,
+			      "d-modsig-list");
+		if (parsed != 1)
+			break;
+
+		if (i)
+			seq_putc(m, ',');
+		if (entry.len)
+			ima_show_template_data_ascii(m, show,
+						     DATA_FMT_DIGEST_WITH_ALGO,
+						     &entry);
+	}
+}
+
 void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data)
 {
@@ -524,6 +558,75 @@ int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 					     field_data);
 }
 
+/*
+ *  ima_eventdigest_modsig_list_init - add the content digest of each modsig
+ *  signer to the template data.
+ *
+ *  Unlike 'd-modsig', this field describes an appended signature with any
+ *  number of signers, which may use different algorithms. It is a table as
+ *  follows:
+ *
+ *      <u32 count> x (<u32 entry_len><entry>)
+ *
+ *  with one entry per signer, in the order of the 'modsig' field, so entry i
+ *  describes signer i, and with the pair <entry_len><entry> repeating <count>
+ *  times.
+ *
+ *  An entry has the 'd-modsig' format, see ima_modsig_digest_entry().
+ */
+int ima_eventdigest_modsig_list_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data)
+{
+	unsigned int count, i, err_count = 0;
+	int len, rc;
+	size_t buf_len;
+	u8 *buf, *p;
+	u32 val;
+
+	if (!event_data->modsig)
+		return 0;
+
+	count = ima_get_modsig_signer_count(event_data->modsig);
+	if (!count)
+		return 0;
+
+	buf_len = size_add(sizeof(u32),
+			   size_mul(count, sizeof(u32) +
+				    IMA_MAX_DIGEST_ENTRY_SIZE - DIGEST_TYPE_NAME_LEN_MAX));
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	p = buf;
+	val = ima_canonical_fmt ? (__force u32)cpu_to_le32(count) : count;
+	memcpy(p, &val, sizeof(val));
+	p += sizeof(u32);
+
+	for (i = 0; i < count; i++) {
+		len = ima_modsig_digest_entry(event_data->modsig, i,
+					      p + sizeof(u32));
+		if (len < 0) {
+			/* Keep walking signers' list, even on failure, to
+			 * maintain allignament with modsig.
+			 */
+			rc = len;
+			len = 0;
+			err_count++;
+		}
+
+		val = ima_canonical_fmt ? (__force u32)cpu_to_le32(len) : len;
+		memcpy(p, &val, sizeof(val));
+		p += sizeof(u32) + len;
+	}
+
+	/* Like 'd-modsig', don't measure if the list has only bad digests */
+	if (err_count < count)
+		rc = ima_write_template_field_data(buf, p - buf, DATA_FMT_HEX,
+						   field_data);
+	kfree(buf);
+	return rc;
+}
+
 static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data,
 				     bool size_limit)
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9f7c335f304f..cf3d453d4c37 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -23,6 +23,8 @@ void ima_show_template_digest_ng(struct seq_file *m, enum ima_show_type show,
 				 struct ima_field_data *field_data);
 void ima_show_template_digest_ngv2(struct seq_file *m, enum ima_show_type show,
 				   struct ima_field_data *field_data);
+void ima_show_template_modsig_list(struct seq_file *m, enum ima_show_type show,
+				   struct ima_field_data *field_data);
 void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
 			      struct ima_field_data *field_data);
 void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
@@ -44,6 +46,8 @@ int ima_eventdigest_ngv2_init(struct ima_event_data *event_data,
 			      struct ima_field_data *field_data);
 int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 				struct ima_field_data *field_data);
+int ima_eventdigest_modsig_list_init(struct ima_event_data *event_data,
+				     struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
-- 
2.55.0

