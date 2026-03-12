Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D03A6B83
	for <keyrings@vger.kernel.org>; Thu, 12 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322875; cv=none; b=ByZzaCcdSzopeIvg8L4cX4YiAhwY4HH1PFvrsTvzCeR3WFfgegVX/puQSj9sj3LUu0VDaEng2B7tE0tRQffG23kFPdYqgKp9J4FBR2CtmVKWNpHPdR4MUipE6GA3PTwDBpXsucQSMLct9R1o339ZMrzrV2F8AVvaCe4L5O52arA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322875; c=relaxed/simple;
	bh=Ndn3/sS9hKibGeS+MjXJBSXMdLr3jWey2xTeGHrf3r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lzp4ihA5NFpgVoKQ7GT6mA78JCt2ppINPT1X0TpVaQoQ98mVKnXq76g9QCnSh+ZNXd2ERaQe0ID2fayLHSFd1jk6qubDGMBS2BkXscTE8hKnRfiGDU/DVC41usdgJ4QSFXnIqTGbshHUJhqHljvSg9D1xboFKxlsRD7wcVl1eVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b=Pju2dU3R; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b="Pju2dU3R"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 38A2A44B91;
	Thu, 12 Mar 2026 14:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ac2.se; s=default;
	t=1773322331; bh=Ndn3/sS9hKibGeS+MjXJBSXMdLr3jWey2xTeGHrf3r8=;
	h=From:To:Cc:Subject:Date:From;
	b=Pju2dU3R0maVncdhRePZk0YFYYLTsykBczZb/vOfVPHxs94AbqTT0I21x2ZtCqY2h
	 ffopMO5bSQi/UPxit3oxN9fX1TLcWrURAFKVjNBa9yNNQI3U99+4oqeeiumR44hkuX
	 zqTikLrPe6lEUj/b0szHPfhLStwpn5JzjsIGsBkQ=
Received: from suiko.ac2.se (suiko.ac2.se [130.239.18.162])
	by mail.acc.umu.se (Postfix) with ESMTP id 99D0B44B90;
	Thu, 12 Mar 2026 14:32:10 +0100 (CET)
Received: by suiko.ac2.se (Postfix, from userid 24471)
	id 8E69442B4B; Thu, 12 Mar 2026 14:32:10 +0100 (CET)
From: Anton Lundin <glance@ac2.se>
To: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Anton Lundin <glance@ac2.se>,
	stable@vger.kernel.org
Subject: [PATCH] sign-file: use KBUILD_SIGN_PIN in provider mode
Date: Thu, 12 Mar 2026 14:31:39 +0100
Message-ID: <20260312133139.3168334-1-glance@ac2.se>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the documented KBUILD_SIGN_PIN functionality to
sign-file when built with USE_PKCS11_PROVIDER.

Signed-off-by: Anton Lundin <glance@ac2.se>
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Cc: stable@vger.kernel.org
---
 scripts/sign-file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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

