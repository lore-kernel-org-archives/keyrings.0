Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880770;
	b=YzIqq1R9e+X36XHpGZ4m3r8A6OhRXeTmLs5+gjr+vX0pC2CFDWgnAopJ1vuJ25VEJThn
	 RSl4LjO3jB5wRTMkuUhIoBloRBhe2uox+G70UmO7EUIZOgh3olM7rSUuSl0J7lCzdC8lM
	 Met/eKbw1/mb86Wewo915yTFNu0sSLX8ysOChfVQecCnhdFxo8ptOscSOeS3Up6mzArja
	 DNfviXK6cUi52MYRLgRsHZ2PTyTANoX6+63tlFiH0+AmjNdskhnCgUq/2KMpBJQ06ADPO
	 Dt1NruZa1WrnYjG54Ex91pHs2ZYjnbP+yo6tH1Z22sxwrD2D8E2FP+scD5rSlz+YRag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4LjsDDL7CSEil3Vbq1SCJ9NcZ77XkMeSExPsXRGmIaM=;
	b=q1VEN81pyHfTP3+ncyYelPaou0WUPP99cVoUq/8wj9ZIcKDw3zDvGDMQ7UE658Tw0Z77
	 l6tF+79FZ+9pHoyAZqDylC+OvtLoEBl4nOBQh5EqOqsB+kEJuH8al1bvahYm63O5D8asq
	 MyW2sNYIZcOT0zfYOPAVUy2PQ15vo6SSBq+WGPYGmH6hmr5F8JJh+gX8LEjilz81xIhQc
	 ysrZPdxL+dg88cI+D3B9HQM54vm7TNVF4+Yv4U6xiWzAunAkcDhCM8IAvqa5yjxu+Mkx1
	 Z8vP25yjjhmlqIDeRl37y3ofstgnvOefw3tt9s9Ba6VolnCFAPOYWq4F6+6VSkLmHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VIvtOaSZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E60606A31B;
	Thu,  5 Nov 2026 12:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VIvtOaSZ
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE9g33449860;
	Thu, 5 Nov 2026 12:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4LjsDDL7CSEil3Vbq
	1SCJ9NcZ77XkMeSExPsXRGmIaM=; b=VIvtOaSZTirX9/H/ea5nwjutJWZAgxEUt
	W4Kv0HnS+W7ZjlD6Gm+bp0F2tOYjRxpyy2Mc5RmZNNunGv1bBMAbLoZ49w11KDp8
	deA0Ts0XyuXVamM+q1DPvwT3CyFoNpE3SdRMjqVJhsg3ZPGH+WlRzRIBRt/lYjEU
	Gv3jsQ8pSuSqdTqNFz9lWAm4IA3R3ADgGhDDx7uaWnr7rD+uQA4FokiiQUMScGFt
	P5KzYyYRAQ565uKyQY7Xyea6jY22H5YpzQ8d9XRRjENchFka23yVRxwX3EJS1JcM
	IEjawP2K//A++Ng4mW3zdZ3pKPTAPBI6EMd4w2PQnk4d2qyjgwI3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3t2f1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4xsu271727;
	Thu, 5 Nov 2026 12:12:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5gb5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CCZKA43909584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:12:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB272004E;
	Thu,  5 Nov 2026 12:12:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E1F220040;
	Thu,  5 Nov 2026 12:12:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.54.214])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:12:33 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] certs: blacklist: define skid: entries and add is_key_blacklisted()
Date: Thu,  5 Nov 2026 07:12:25 -0500
Message-ID: <20261105121227.4089147-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105121227.4089147-1-zohar@linux.ibm.com>
References: <20261105121227.4089147-1-zohar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec72b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hWF8r1hdgRcWVEwHOtUA:9
X-Proofpoint-ORIG-GUID: TSWUfyDjPY5Q3Kg__W4Je-r2G1l9aGVz
X-Proofpoint-GUID: TSWUfyDjPY5Q3Kg__W4Je-r2G1l9aGVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfXzNLe25zhA47E
 a1oFWxCTBcd/TP0lD5aO3NDsA95pzpYBUrkhGbdyx4hKvHGg08bSUHygkg41cC6CQ/iLJp1mNCV
 iyIahG7V1y5zqbJzpBXfloXncpa2jsDC8dRTptJfNxLQYATxra15h6ujq0yklyFS9TmcTGS968P
 e/83TEj2OTD5B6ev7Ys0SvMMkVt9EhxVYRzFUrLiUFkNeHT2zO4TE79EkafjotoELkL+rU9mB38
 T0p04EFiMKXDKgr/s87VbdYr8CYXM55J52kY9vkTC9gaKMNpRZVpMPGBpcV1GkiJTtvjJCPuvFj
 mCIpIblRBbajgNTat2TfR9tLXbg8INzREO5+RcU8D08l+fUTqLFffW7dl6QrcroiVEW/6qKyMH6
 8lcWmX8+vo+RdPHE7xQM/3/a7zDEzuoBVF5L8ZIN4fz7zybmijK6S3sCTAQFuQ/SNHRtiF0VJuo
 YnEKU9CW1slzkjHnwEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfX/gKFzia2aNdN
 +Q5n1dYhFwlCP69YfhtkhGp18WMFyxzf8nOzm5yXocjs1V+tmABcP3UcjX3IAo/UMZqJUlpglpZ
 YY2wgOaFGD57viOU6GdeSRdw8mE1DTs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050046

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
 certs/Kconfig                 |  7 +--
 certs/blacklist.c             | 81 ++++++++++++++++++++++++-----------
 include/keys/system_keyring.h |  8 ++++
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 9d2bf7fb5b9e..9e51f988ba3b 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -155,10 +155,11 @@ config SYSTEM_BLACKLIST_HASH_LIST
 	  If set, this option should be the filename of a list of hashes in the
 	  form "<hash>", "<hash>", ... .  This will be included into a C
 	  wrapper to incorporate the list into the kernel.  Each <hash> must be a
-	  string starting with a prefix ("tbs" or "bin"), then a colon (":"), and
-	  finally an even number of hexadecimal lowercase characters (up to 128).
+	  string starting with a prefix ("tbs", "bin" or "skid"), then a colon
+	  (":"), and finally an even number of hexadecimal lowercase characters
+	  (up to 128).
 	  Certificate hashes can be generated with
-	  tools/certs/print-cert-tbs-hash.sh .
+	  tools/certs/print-cert-tbs-hash.sh.
 
 config SYSTEM_REVOCATION_LIST
 	bool "Provide system-wide ring of revocation certificates"
diff --git a/certs/blacklist.c b/certs/blacklist.c
index fa561c12eabf..b1e2c178d378 100644
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
@@ -244,6 +243,38 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 }
 EXPORT_SYMBOL_GPL(is_hash_blacklisted);
 
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
+
 int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 {
 	if (is_hash_blacklisted(hash, hash_len, BLACKLIST_HASH_BINARY) ==
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index a6c2897bcc63..48c830850b70 100644
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
@@ -79,6 +81,7 @@ extern int mark_hash_blacklisted(const u8 *hash, size_t hash_len,
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 			       enum blacklist_hash_type hash_type);
 extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
+extern int is_key_blacklisted(const struct key *key);
 #else
 static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 				      enum blacklist_hash_type hash_type)
@@ -90,6 +93,11 @@ static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
 {
 	return 0;
 }
+
+static inline int is_key_blacklisted(const struct key *key)
+{
+	return 0;
+}
 #endif
 
 struct pkcs7_message;
-- 
2.56.0

