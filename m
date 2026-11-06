Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986339;
	b=I7P8wDdrAerWijJh7pcgx0xo/USeGSal8G2HGCsDL+xK6ptWYKxQLcZA1+yfXr14GbtI
	 9Eb924mJYIpwKIoHGuwFdGjMAgWejzVztIXlkyGlKwLTr/w6nDj+v5II9cb2o5Dg1LlhC
	 s6l4W4HO7X5Wlr9AVK/Cbk7G72u+KMTsbaXLeNTKcMS3c0PUEcShpQCi64suXEBx3PmiP
	 mySSCBwF4CLgZ07xBEC6BYfaZM1IbntFy6fschseqO/n3QRM37RH6m+vP6E7bOnhYxUI/
	 nMUXy2OBkGOS2ATAu0LfDFFj2pkJEl1tDnclGWPjJZeZ47TjD9xkt5m1zBQJZc0/wAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=82caRYp1FEwEXBHj87RGlLDQZHgPDt7d/+TDYokyOxM=;
	b=Va3IbcxLHroIQY7U4H7ERg6orCYSwuoEe3Kpl4biWbUTDi3EOkrBfAKTBrlnq5dd4W9q
	 viqP/NSG9kYoAQRIIKm96J0hVMePto7bedxryslbPbrI4aWjwXFZ0Fkj8FUDk4cT4MNZd
	 lkk1mQ98ottcTWEBNzbDdNUAKSZ60X+xVANkZNG/7lH1XP20Ap5pw7kIWnek5iZDnKBxd
	 CaGyfFsOInKx/DMaOKA1hzfmR7pVLUZpyAPeZNDlMsagGz6gVac7NirCg0fpuMnfG48WY
	 U+u8vUidoNnbFLv/chOz4l1g86joZaKAVWMqSzkm8Uxhk62JpCT3CdndZXHXen6NBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MPgU4QYl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F78606A33B;
	Fri,  6 Nov 2026 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F78606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MPgU4QYl
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEDMl1544317;
	Fri, 6 Nov 2026 17:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=82caRYp1FEwEXBHj8
	7RGlLDQZHgPDt7d/+TDYokyOxM=; b=MPgU4QYl0W9FGYkp8io9aSvWqWi3QbcZt
	NWOflpAv3V9o6+7T1DedPPQxbe0u3yXRO3Uoi6LHE4dUyXzmZ7uwmFPwPy5FIFJ2
	j0H9jp0403W+IMPrM/IjZDSvcwTcO3w+S41a3KQpCkW/ghmrTUlvrjF7IctIACRL
	2IUSW5dreddF2k6ThsDIAbCW7Vk9dcd+V9pW4daHhqfq2Wj75UH9yMKMBiBws8Ps
	2o5RUvqHeArPVwKvdOrSDUixd2cQc6ptaBgeT8RBsHDOEKx1etVm3l6f8Tu7YYbK
	zpMDxfl6r7ilZ6QfbZGwTKU5+dVjOa250t0M6/z8xvDUnNA20+b2Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbxat0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:32:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GwqOJ3584921;
	Fri, 6 Nov 2026 17:31:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka72xkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:31:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6HVwge50856236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 17:31:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF9120043;
	Fri,  6 Nov 2026 17:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5CF20040;
	Fri,  6 Nov 2026 17:31:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.47.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 17:31:55 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] certs: blacklist: define skid: entries and add is_key_blacklisted()
Date: Fri,  6 Nov 2026 12:31:47 -0500
Message-ID: <20261106173149.707244-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106173149.707244-1-zohar@linux.ibm.com>
References: <20261106173149.707244-1-zohar@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _av4UAfr_JQG5LfvNCPTAKqq8RrLxJB7
X-Proofpoint-GUID: _av4UAfr_JQG5LfvNCPTAKqq8RrLxJB7
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aee0f10 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VWuc2nmrMmYy7wgmrS0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX0CDbhBcG8/Qx
 Ql2kOzK8xgZgtObyHPR59Jeyf6KCpjWA3nylaG9hwiRSikcuGdOCreu9in6qq6vLdgqUVyp5d7n
 fDYvM7OGn6wXWYXYS7TavKo9bb50ChU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX7i7aCxB4hYLp
 +YQW0Ix1TMs8bchAnxiLYMSAjoDPqNiZLVdN0KZVVi6R4pYJW+xzbhaSC6qAwi2S79RS+5K6DKZ
 J9IEK8J/VcMav55c4g+SXLaY0wNvgVik1/FdGgtrAfAkjfaepja9Y2rPS3z4FwbzVrvj0zzbwtN
 9LWY2PH5crYksfHMsJzBo8mF7fDD2WB4L99PXhwYk+BLOdRgkf9KRpPnt/StH4uVLl56SBWMfro
 tpAuhhW2B1W7rlBzih8n30i0g8W8B2jJ1DsJ3WxAJCzewDgUr0/0lm4vH6n7ABNlr3eouAdTIOB
 Pm38Q5HPskq34Qn+R1Y2hfyAHxKyolzW8LBaqfelhRYh6biTNO0uEzf7T7NSqjCqTeZYPHruF4V
 b4cXtsL0TTbkj1SIh+4vNeFvNOgQOqlxSknTZWHXKjAgoZgSXUpXDGg+W8UKG6p+o8NVeAYcnS7
 jkO3sorNyMCDOW1H33Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

A "tbs:" blacklist entry is only compared against certificates being
added to a keyring or presented in a signature chain, so it does not
stop a key that is already loaded from being used as a trust anchor.

Define a new "skid:<hex>" blacklist entry, holding a Subject Key
Identifier, and add is_key_blacklisted(), which looks up the SKID of an
asymmetric key in the system blacklist.  Entries are added like "tbs:"
and "bin:" entries and are subject to CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE.

blacklist_vet_description() now uses a prefix table, since the prefixes
no longer all have the same length.  "tbs:" and "bin:" entries behave
as before.

For example, to add an entry for a certificate (the signed string must
not include a trailing newline):

  skid=$(openssl x509 -in cert.pem -noout -ext subjectKeyIdentifier |
         sed -n '2s/[ :]//gp' | tr A-F a-f)
  printf 'skid:%s' "$skid" > skid.txt
  openssl smime -sign -binary -noattr -in skid.txt -signer signer.crt \
          -inkey signer.key -outform DER -out skid.p7s
  keyctl padd blacklist "skid:$skid" %:.blacklist < skid.p7s

The SKID is also the hex string in the description of the key on a
keyring, and its last four bytes are the key ID in the security.ima
xattr, so an entry is easy to correlate with the key it revokes:

  # keyctl show %:.ima | grep 073d
  927946571 --als--v  0  0   \_ asymmetric: test signing key: b7809c3372a07fe87248dcec7ff047a40fb3073d
  # keyctl show %:.blacklist | grep skid
  1014808518 ----s--v 0  0   \_ blacklist: skid:b7809c3372a07fe87248dcec7ff047a40fb3073d

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v1:
- Addressed Sashiko issues: drop Kconfig change, linking issues when
blacklist support configured, but without CONFIG_ASYMMETRIC_KEY_TYPE
configured.

 certs/blacklist.c             | 83 ++++++++++++++++++++++++-----------
 include/keys/system_keyring.h | 12 +++++
 2 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index fa561c12eabf..9158bd9f9fc9 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -32,6 +32,7 @@

 static const char tbs_prefix[] = "tbs";
 static const char bin_prefix[] = "bin";
+static const char skid_prefix[] = "skid";

 static struct key *blacklist_keyring;

@@ -40,36 +41,30 @@ extern __initconst const u8 revocation_certificate_list[];
 extern __initconst const unsigned long revocation_certificate_list_size;
 #endif

+static bool blacklist_prefix_valid(const char *desc, size_t len)
+{
+	return (len == sizeof(tbs_prefix) - 1 &&
+		!strncmp(desc, tbs_prefix, len)) ||
+	       (len == sizeof(bin_prefix) - 1 &&
+		!strncmp(desc, bin_prefix, len)) ||
+	       (len == sizeof(skid_prefix) - 1 &&
+		!strncmp(desc, skid_prefix, len));
+}
+
 /*
- * The description must be a type prefix, a colon and then an even number of
- * hex digits.  The hash is kept in the description.
+ * The description must be a type prefix ("tbs", "bin" or "skid"), a colon and
+ * then an even number of lower-case hex digits.  The hash (or, for "skid", the
+ * Subject Key Identifier) is kept in the description.
  */
 static int blacklist_vet_description(const char *desc)
 {
-	int i, prefix_len, tbs_step = 0, bin_step = 0;
-
-	/* The following algorithm only works if prefix lengths match. */
-	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
-	prefix_len = sizeof(tbs_prefix) - 1;
-	for (i = 0; *desc; desc++, i++) {
-		if (*desc == ':') {
-			if (tbs_step == prefix_len)
-				goto found_colon;
-			if (bin_step == prefix_len)
-				goto found_colon;
-			return -EINVAL;
-		}
-		if (i >= prefix_len)
-			return -EINVAL;
-		if (*desc == tbs_prefix[i])
-			tbs_step++;
-		if (*desc == bin_prefix[i])
-			bin_step++;
-	}
-	return -EINVAL;
+	const char *colon = strchr(desc, ':');
+	int i;

-found_colon:
-	desc++;
+	if (!colon || !blacklist_prefix_valid(desc, colon - desc))
+		return -EINVAL;
+
+	desc = colon + 1;
 	for (i = 0; *desc && i < MAX_HASH_LEN; desc++, i++) {
 		if (!isxdigit(*desc) || isupper(*desc))
 			return -EINVAL;
@@ -160,6 +155,10 @@ static char *get_raw_hash(const u8 *hash, size_t hash_len,
 		type_len = sizeof(bin_prefix) - 1;
 		type_prefix = bin_prefix;
 		break;
+	case BLACKLIST_HASH_SKID:
+		type_len = sizeof(skid_prefix) - 1;
+		type_prefix = skid_prefix;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return ERR_PTR(-EINVAL);
@@ -244,6 +243,40 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 }
 EXPORT_SYMBOL_GPL(is_hash_blacklisted);

+#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
+/**
+ * is_key_blacklisted - Determine if a key is blacklisted by its SKID
+ * @key: The key to be checked, e.g. a trust anchor found in a keyring
+ *
+ * Unlike a "tbs:" entry, which is only compared against certificates being
+ * added or presented in a chain, this checks a key that is already loaded, so
+ * that keys that cannot be unlinked from their keyring can still be revoked.
+ * The identifier is taken from the key itself, not from the caller.
+ *
+ * Returns -EKEYREJECTED if the key's Subject Key Identifier is blacklisted,
+ * 0 if it is not (or the key has no SKID), or another negative error.
+ */
+int is_key_blacklisted(const struct key *key)
+{
+	const struct asymmetric_key_ids *kids;
+	const struct asymmetric_key_id *skid;
+
+	if (!key || key->type != &key_type_asymmetric)
+		return 0;
+
+	kids = asymmetric_key_ids(key);
+	if (!kids)
+		return 0;
+
+	skid = kids->id[1];
+	if (!skid || !skid->len)
+		return 0;
+
+	return is_hash_blacklisted(skid->data, skid->len, BLACKLIST_HASH_SKID);
+}
+EXPORT_SYMBOL_GPL(is_key_blacklisted);
+#endif
+
 int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 {
 	if (is_hash_blacklisted(hash, hash_len, BLACKLIST_HASH_BINARY) ==
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index a6c2897bcc63..2ac1dae2063a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -15,6 +15,8 @@ enum blacklist_hash_type {
 	BLACKLIST_HASH_X509_TBS = 1,
 	/* Raw data hash */
 	BLACKLIST_HASH_BINARY = 2,
+	/* Subject Key Identifier of a key (not a hash) */
+	BLACKLIST_HASH_SKID = 3,
 };

 #ifdef CONFIG_SYSTEM_TRUSTED_KEYRING
@@ -92,6 +94,16 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 }
 #endif

+#if defined(CONFIG_SYSTEM_BLACKLIST_KEYRING) && \
+    defined(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int is_key_blacklisted(const struct key *key);
+#else
+static inline int is_key_blacklisted(const struct key *key)
+{
+	return 0;
+}
+#endif
+
 struct pkcs7_message;
 #ifdef CONFIG_SYSTEM_REVOCATION_LIST
 extern int add_key_to_revocation_list(const char *data, size_t size);
--
2.56.0

