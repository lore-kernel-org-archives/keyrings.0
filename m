Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE832D7C7
	for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802446; cv=none; b=leHC3dBsfSz5YNzDSjKlYltx5NoNv4tip9uPnJnfYJ/ePEMN/8Ok+GEaFSTGELcbJYIU4gSV/YAdA6JuuXX052xNQZiDtCDSHCN8wcC7ikX1aCDkAwo+QyoFW++yU03RdXDjHbFT01Gj+RKpYoOigUSZesbTEnBXBjrV3l7+iIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802446; c=relaxed/simple;
	bh=ejr+Ezvx0GfpWrz3IPZtiIpCLkRqRKO2Wr37PAjbg+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS95xtGpSaObFNMFH9zwKbiK/w+U6mW8b6YiSm5lkEB0F5bMJsNGGuFQGkGanIOXBtArkMZ9H4aIRjlXEMnYvvRVrg4VAPrysmTIQfZyAy1Rh0hAdqHRnpCa0auSN++j76ZHEzf4vtsdjjnq3KuJOBlYvzA3Ab4GTyTVPDYEYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=q7DbWkas; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="q7DbWkas"
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C8B83FCAB
	for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786802442;
	bh=xf+ocxeCJgdee/7hRS+EL0NVdP4x1nusrTTdX8m6N0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=q7DbWkas0KM+4CPBeZ/DjuXTe/yAyO7a9Y9SmdwdcTYThurYlJ9X97nbW8isu3hN8
	 wx8fkCneT7bTIjWCZ6j1ZVYMm6qe2KPXqG36XZ06cImBOQHsN+SzLUYwXNO/8Zdert
	 VK1rjDWa8uGJ6H/8RfHzhGVZZ4p3r3zgC95GrtNzo4TO1xyfyCu+lBHjRrGbzT3nVH
	 qnT5fhxBOQOANTmN5cCMwLkHEsi79eVf1ps/8gwqUne46+nVSw00fVyWadv7uMj7dN
	 yAyuCTDthJ6vKKeRV/xz7tfw7+pfgsiT8EzgodC8DR+jxfiCJrBAh26Ki32IiE7TvI
	 pCqLFPNwlBTZDRIiepp9YX8j4gExSici26n7qAKQY95lXy81MJ3Y/8L0Um3+kC3i4F
	 dCMZXPlZCE2GZDcF5eKXH3ULCtyhq0t0gVnXIQ8nIeWhSoqzMEN3rhfY+oSVOYA4az
	 jpKo1tD9xQ7tj4xaa+XROoY6uvYxKmVTfsr5Jxhoq1UkJT9ccR7a0+Y1bmBkOeHcXi
	 u4fO4abvnYPzp1yQRjeWHuufdnBeRMGZhb53K6AxTHZf6WDn240WcjWH/3eRN6Ts9y
	 8XuN6X0+/JyheUGXZjFRLFGj0n2UT1KhTH39KC/rm2IjFXvc9gWwYNQYQf4d8Ttrae
	 VMcW20YFq7Di55AvXosuOUGw=
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47faa02f707so1302638f8f.1
        for <keyrings@vger.kernel.org>; Sat, 15 Aug 2026 07:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786802442; x=1787407242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xf+ocxeCJgdee/7hRS+EL0NVdP4x1nusrTTdX8m6N0g=;
        b=LMpoEvgkspzHXRjhCQdtsmJDuLEJ/7hP+9g+1HTZCFnOT9xRYyh0azT2k5C3830oFB
         iOhBSMP5eCkDzq+9k7l7++FAG0b4G2uSVHiSaUVCwixq+Bbl2WBPtYPlSmlovo4KVXyl
         hfQZftOwH7ZgMKJgvdJ/MEhZtCK+ZvIBVldnUpF9QzLV9+jiTJt7+UI8S8Ba1d/mIzSX
         cW+KgLvjpEXAzwbjLdcQdYAdHMSnOIiNfrxgmIJhVWouv4xvraACHz00hnREJ1GsYp/0
         fCrnoEm3r/oPYNklmrYuCYhUOypc2jtxfrguWXoy5QmfDtl7ZplKl5ELcXkZDA81IJbb
         XOjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWl4i3vZj+7djxCQiYu0SElBmaCjONJNDANMx2+n22SG60ItHPPxF8jG7YbXBTpJ/jQxhP3i2fGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzugRNdZXWufozm3hZnHm7TJQ2Vkb7LKIKrEW/o9BeOvuT623y5
	165lrLj9wGSC2qCdCV4HlFuvwzAHMmf/4bEEVYz6sX2bbo09diFNLw8Enaei2bnpULCukUoDtPE
	5wzL1vCR/cURbzAbSQAOudCETNpMGGXHUpmm9l+H/ZhFu4oWbPpbMHZiGGKaFOMtbNYWImvDawM
	D6
X-Gm-Gg: AR+sD12DOi1d0QwOr06iQ6DMHA5B5PBz5IER6tVowjXf7AThQRQdLKp9uTVE08I1UWm
	6RFeAwPxZfXbhyA8DsmtmtP04VBO+VPg65jcdLUl/2MFic0q35tWXKztXv3LvlFPoadbqFeDK/X
	exiNwhKnYKPIdRKBue+pmCt0Yri+6uIeu/16Pxb4y4oihmOgKW7acKOdPSf4lseDOnwn6SRnnTi
	f3Q1aNgs2+Vm6t5FRPyJlmNJbSPWhZOyEONsWgpvKggHvoR5kDG5oZtzVVqSuaEyyhhcwssbRnV
	QOeLao5BTnV/6amxSCN00i5CAZaNjmBsMtazvm8av5AX1eruhM6A/tussaGayliUyatGfWNoUPQ
	Wel1B9Gv4NYoRgmN+52lRF/01faB0RgvenCz/kn+IC4r1f7Sp3P1yFJcuNYEQ/9yisIvMMZxqlH
	hBoZraekNSaTPxsRivek9Xn8J6YOGwa48=
X-Received: by 2002:a05:6000:1a8c:b0:481:562d:6fb1 with SMTP id ffacd0b85a97d-4816075be23mr18511403f8f.6.1786802441755;
        Sat, 15 Aug 2026 07:00:41 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8c:b0:481:562d:6fb1 with SMTP id ffacd0b85a97d-4816075be23mr18511293f8f.6.1786802441260;
        Sat, 15 Aug 2026 07:00:41 -0700 (PDT)
Received: from t-14.home (2a01cb000883230031a3fd8213e7cff4.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:31a3:fd82:13e7:cff4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20051esm18433563f8f.7.2026.08.15.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:00:40 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crypto: asymmetric_keys - add KUnit tests for the PE parser
Date: Sat, 15 Aug 2026 16:00:20 +0200
Message-ID: <73155550248025620873094809432c88ffa4c3d6.1786802052.git.fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
References: <CAOs+rJVztmvHSkNxP_voc7E=girsstCKmqxG37pvO2kTaEk1TQ@mail.gmail.com> <fcbc6b4d5855ba42a0fccf335b2604ef0b36f092.1786802052.git.fabrice.derepas@canonical.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add self-contained KUnit tests for pefile_parse_binary(), exercised
through verify_pefile_signature() -- which parses the image before any
signature check, so no keyring or real signature is needed. The cases
build small malformed PE images in memory:

  - a PE declaring 0 data-directory entries: the certificate table entry
    at fixed index 4 is absent and must be rejected (-ELIBBAD), not read
    out of bounds;
  - a PE declaring 5 entries with a zero (unsigned) certificate entry
    gets past the directory bound and is rejected as unsigned (-ENODATA).

verify_pefile_signature() is not exported, so the test is built-in only
(bool, not tristate).

Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
 crypto/asymmetric_keys/Kconfig              |  12 +++
 crypto/asymmetric_keys/Makefile             |   2 +
 crypto/asymmetric_keys/verify_pefile_test.c | 100 ++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 crypto/asymmetric_keys/verify_pefile_test.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 6a2f66404..c73979b2e 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -114,4 +114,16 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
 	depends on CRYPTO_SHA256=y || CRYPTO_SHA256=FIPS_SIGNATURE_SELFTEST
 	depends on CRYPTO_ECDSA=y || CRYPTO_ECDSA=FIPS_SIGNATURE_SELFTEST
 
+config VERIFY_PEFILE_KUNIT_TEST
+	bool "KUnit tests for signed PE file parsing" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && SIGNED_PE_FILE_VERIFICATION
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the PE binary parser used by signed PE file
+	  signature verification.  The tests build small malformed PE images in
+	  memory and check that pefile_parse_binary() rejects them instead of
+	  reading out of bounds.
+
+	  If unsure, say N.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98..35172685c 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -79,3 +79,5 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+obj-$(CONFIG_VERIFY_PEFILE_KUNIT_TEST) += verify_pefile_test.o
diff --git a/crypto/asymmetric_keys/verify_pefile_test.c b/crypto/asymmetric_keys/verify_pefile_test.c
new file mode 100644
index 000000000..8b42eb41e
--- /dev/null
+++ b/crypto/asymmetric_keys/verify_pefile_test.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the signed PE binary parser in verify_pefile.c.
+ *
+ * The cases build small malformed PE images in memory and call
+ * verify_pefile_signature(), which parses the image before any signature
+ * check, so the parser is exercised without a keyring or a real signature.
+ */
+#include <kunit/test.h>
+#include <linux/slab.h>
+#include <linux/pe.h>
+#include <linux/verification.h>
+
+/*
+ * Build a minimal PE32 image whose optional header declares @data_dirs data
+ * directory entries.  header_size is sized to hold them and the image is a few
+ * bytes larger.  With @data_dirs < 5 the certificate table entry (fixed index
+ * 4) lies outside the declared directory.
+ */
+static void *build_pe32(u16 data_dirs, unsigned int *out_len)
+{
+	size_t cursor = sizeof(struct mz_hdr) + sizeof(struct pe_hdr) +
+			sizeof(struct pe32_opt_hdr);
+	size_t header_size = cursor + ((size_t)data_dirs + 1) *
+				      sizeof(struct data_dirent);
+	size_t pelen = header_size + 8;
+	struct mz_hdr *mz;
+	struct pe_hdr *pe;
+	struct pe32_opt_hdr *opt;
+	void *buf = kzalloc(pelen, GFP_KERNEL);
+
+	if (!buf)
+		return NULL;
+
+	mz = buf;
+	mz->magic = IMAGE_DOS_SIGNATURE;
+	mz->peaddr = sizeof(struct mz_hdr);
+
+	pe = buf + sizeof(struct mz_hdr);
+	pe->magic = IMAGE_NT_SIGNATURE;
+
+	opt = buf + sizeof(struct mz_hdr) + sizeof(struct pe_hdr);
+	opt->magic = IMAGE_NT_OPTIONAL_HDR32_MAGIC;
+	opt->header_size = header_size;
+	opt->data_dirs = data_dirs;
+
+	*out_len = pelen;
+	return buf;
+}
+
+/*
+ * data_dirs = 0: the certificate table entry (index 4) is absent, so the
+ * parser must reject the image instead of reading ddir->certs past the end.
+ */
+static void pefile_missing_certs_dirent(struct kunit *test)
+{
+	unsigned int len;
+	void *buf = build_pe32(0, &len);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	ret = verify_pefile_signature(buf, len, NULL,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	KUNIT_EXPECT_EQ(test, ret, -ELIBBAD);
+	kfree(buf);
+}
+
+/*
+ * data_dirs = 5: the certificate table entry is present (and zero, i.e.
+ * unsigned), so the parser gets past the directory bound and rejects the image
+ * as unsigned (-ENODATA) rather than -ELIBBAD.
+ */
+static void pefile_present_certs_dirent(struct kunit *test)
+{
+	unsigned int len;
+	void *buf = build_pe32(5, &len);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	ret = verify_pefile_signature(buf, len, NULL,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	KUNIT_EXPECT_EQ(test, ret, -ENODATA);
+	kfree(buf);
+}
+
+static struct kunit_case verify_pefile_cases[] = {
+	KUNIT_CASE(pefile_missing_certs_dirent),
+	KUNIT_CASE(pefile_present_certs_dirent),
+	{}
+};
+
+static struct kunit_suite verify_pefile_suite = {
+	.name = "verify_pefile",
+	.test_cases = verify_pefile_cases,
+};
+
+kunit_test_suite(verify_pefile_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for the signed PE binary parser");
-- 
2.53.0

