Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECD2AE78
	for <keyrings@vger.kernel.org>; Wed, 18 Mar 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824638; cv=none; b=D0TQIu34qhTR4PjyMt3OPiaomemnnwIvwIJmc4bsoUK6FYqN93+Iielu673PvO9UlW0GDpA1rSNZolcLDXP5So7GgTOwaOG72WUy6m+BiYHC+Ek3YfSgT/2MOFmDPxaBCNKST+odtqb2Ww2g9D9ky0OKEntpmH2hBlnhCs4pf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824638; c=relaxed/simple;
	bh=W4+xe38yEjG9SWFKdDLcrWA/dwSTIcAsK1usgGIfwng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2EEbQjI1o5zpgOtJ6s+u03YJE1i96awBXMYPB2Ny0GSqEWWPcCesgRZyiceG4Peswhzgw8OcT6EZBM1uAdzxZz4zuAwanVJV7vget7r+DQhuMh8/9Ejpv/1fHmd/9Dj7c7wKmwDpfX+RO6LXT1tNegzGQ360bDv33ixZAw6+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b=saxSUnA7; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b="saxSUnA7"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 42F5244B91;
	Wed, 18 Mar 2026 10:03:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ac2.se; s=default;
	t=1773824628; bh=W4+xe38yEjG9SWFKdDLcrWA/dwSTIcAsK1usgGIfwng=;
	h=From:To:Cc:Subject:Date:From;
	b=saxSUnA7NOxuA0Y1hV4hz12meNgXOYCb3gRNF0+5e5jRmj1u25yrCXceb2hgJvkQu
	 blE86CqK6yKk3YiRKtIbumy3XSLHbzHMJeaVi8CFFJTk4SgI8/AM9zaVwNYlCc53+J
	 9qkjOqpBxY44LkZGBGEGZDBI1VmsFRpek7V57hX4=
Received: from suiko.ac2.se (suiko.ac2.se [130.239.18.162])
	by mail.acc.umu.se (Postfix) with ESMTP id 706C844B90;
	Wed, 18 Mar 2026 10:03:46 +0100 (CET)
Received: by suiko.ac2.se (Postfix, from userid 24471)
	id 635ED42B4B; Wed, 18 Mar 2026 10:03:46 +0100 (CET)
From: Anton Lundin <glance@ac2.se>
To: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Anton Lundin <glance@ac2.se>,
	stable@vger.kernel.org
Subject: [PATCHv2] sign-file,extract-cert: use KBUILD_SIGN_PIN in provider mode
Date: Wed, 18 Mar 2026 10:02:09 +0100
Message-ID: <20260318090336.556068-1-glance@ac2.se>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the documented KBUILD_SIGN_PIN functionality to
sign-file and extract-cert when built with USE_PKCS11_PROVIDER.

Signed-off-by: Anton Lundin <glance@ac2.se>
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Cc: stable@vger.kernel.org
---
 certs/extract-cert.c | 27 ++++++++++++++++++++++++++-
 scripts/sign-file.c  |  6 +++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

v2: Added the corresponding fix to extract-cert to

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 7d6d468ed612..30afdc296fff 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -25,6 +25,7 @@
 # define USE_PKCS11_PROVIDER
 # include <openssl/provider.h>
 # include <openssl/store.h>
+# include <openssl/ui.h>
 #else
 # if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
 #  define USE_PKCS11_ENGINE
@@ -62,18 +63,42 @@ static void write_cert(X509 *x509)
 		fprintf(stderr, "Extracted cert: %s\n", buf);
 }
 
+#ifdef USE_PKCS11_PROVIDER
+static int pem_pw_cb(char *buf, int len, int w, void *v)
+{
+	int pwlen;
+
+	if (!key_pass)
+		return -1;
+
+	pwlen = strlen(key_pass);
+	if (pwlen >= len)
+		return -1;
+
+	strcpy(buf, key_pass);
+
+	/* If it's wrong, don't keep trying it. */
+	key_pass = NULL;
+
+	return pwlen;
+}
+#endif
+
 static X509 *load_cert_pkcs11(const char *cert_src)
 {
 	X509 *cert = NULL;
 #ifdef USE_PKCS11_PROVIDER
 	OSSL_STORE_CTX *store;
+	UI_METHOD *ui_method = NULL;
 
 	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
 		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
 	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
 		ERR(1, "OSSL_PROVIDER_try_load(default)");
 
-	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
+	if (key_pass)
+		ui_method = UI_UTIL_wrap_read_pem_callback(pem_pw_cb, 0);
+	store = OSSL_STORE_open(cert_src, ui_method, NULL, NULL, NULL);
 	ERR(!store, "OSSL_STORE_open");
 
 	while (!OSSL_STORE_eof(store)) {
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 73fbefd2e540..9ac89fea9d73 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -32,6 +32,7 @@
 # define USE_PKCS11_PROVIDER
 # include <openssl/provider.h>
 # include <openssl/store.h>
+# include <openssl/ui.h>
 #else
 # if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
 #  define USE_PKCS11_ENGINE
@@ -90,13 +91,16 @@ static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
 	EVP_PKEY *private_key = NULL;
 #ifdef USE_PKCS11_PROVIDER
 	OSSL_STORE_CTX *store;
+	UI_METHOD *ui_method = NULL;
 
 	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
 		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
 	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
 		ERR(1, "OSSL_PROVIDER_try_load(default)");
 
-	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	if (key_pass)
+		ui_method = UI_UTIL_wrap_read_pem_callback(pem_pw_cb, 0);
+	store = OSSL_STORE_open(private_key_name, ui_method, NULL, NULL, NULL);
 	ERR(!store, "OSSL_STORE_open");
 
 	while (!OSSL_STORE_eof(store)) {
-- 
2.47.3

