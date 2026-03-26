Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8D361659;
	Thu, 26 Mar 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774487963; cv=none; b=hSoF9B8kTk+5xHbmuqr3FFRU07hSJJaudQ1WcoOGSIdRBqZAuVtNQghxEc8FSzqSu/vRQ2kimFQlzpcA2c4BId2v/yvQI31ZSPlWBlPxOyRkyODBGxM6rO/09o3LWEUuiXTQD8A45NQ6Xqddv+1LoaS62XLqpOUr4AeN/iDkC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774487963; c=relaxed/simple;
	bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bl0Fqv5kvYzzq2K0Z6PL+HhO8F16M9r2l1Ukvv+cLg0wjA9ir0hKslOUj3oSF0U/b7T+GXqVyU7L4CV3A/z5T0s6/rqg+WR8Iefou3LO3kKcNez0+dyXf0iZNG0eW8zs/G9mMPVhNv8aUQLyiHavS5guFcXk7/4WYztyqhBEK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4ZPxP0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4ZPxP0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA83FC4CEF7;
	Thu, 26 Mar 2026 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774487962;
	bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
	h=From:Date:Subject:To:Cc:From;
	b=R4ZPxP0Kt1Y4XjHNcIkz/AnEPuldifIGo0Jv3O8R3cnZizBDhTHc6WRYmUYUY88tl
	 JbbvTjs3aduTrqDwh59MqAagbkPM0sJJkyb3TnfcRkyRqIsX7c0Ltae3H0FBCjxWIt
	 tnkScoMZdIDzEuT4l1aFAjX/alGWz7FNTwCjmoZ8AP5Z3j55XDLi085b0TTrKdjP7Z
	 43OQjD/d8me+SrrbB/Ael0qax391V73/uFvbRtD3zTFUNrZpeAptOfS3Uprraz+cLv
	 qk3+zdY5xlafVM1nsSC1phFwl34+ymRYdp8njsz21SEMHnEH5p8oZnhkQwO6Neg9Oy
	 a1gzVP8dv1gjw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 25 Mar 2026 18:19:15 -0700
Subject: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNWwrCMBBG4a2UeXYgpqjoVkQkl781WtKSSaRSu
 ndjffxezllIkAKELs1CCe8gYYwV+11D7mFiDw6+mrTSR9XqAzukLIw5J+PyJn7hc5+MCJdYBJ5
 tySzI3A+jNQPrVqkTXGd8d6banRK6MG/P6+1vKfYJl38jWtcv1/+4opUAAAA=
X-Change-ID: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlHOmc0mUyYdHWZZzzXeodzCTs2ZX+JWSZoEHRX8cyfj
 U/DvqpO7yhlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATkbNl+J87L/Jx7MyC1x6C
 wgd3rNgjGRnouHO/xOJ5K2NiJ4jzH4xi+KcwYZ9SB6NDdoPw+af1Zy6znbnZ5an2f59f07ROvkz
 pD3wA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in certs/extract-cert.c:

  certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
     46 | static const char *key_pass;
        |                    ^

After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
API, not the new provider API. Wrap key_pass's declaration and
assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
with its use to clear up the warning. While this is a little uglier than
just marking key_pass with the unused attribute, this will make it
easier to clean up all code associated with the use of the engine API if
it were ever removed in the future. While in the area, use a tab for
the key_pass assignment line to match the rest of the file.

Cc: stable@vger.kernel.org
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am taking a fix for a similar warning in modpost through the kbuild
tree so I don't mind picking this up with an appropriate Ack or it can
just go through the keyring tree, does not matter to me.
---
 certs/extract-cert.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 7d6d468ed612..54ecd1024274 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -43,7 +43,9 @@ void format(void)
 	exit(2);
 }
 
+#ifdef USE_PKCS11_ENGINE
 static const char *key_pass;
+#endif
 static BIO *wb;
 static char *cert_dst;
 static bool verbose;
@@ -135,7 +137,9 @@ int main(int argc, char **argv)
 	if (verbose_env && strchr(verbose_env, '1'))
 		verbose = true;
 
-        key_pass = getenv("KBUILD_SIGN_PIN");
+#ifdef USE_PKCS11_ENGINE
+	key_pass = getenv("KBUILD_SIGN_PIN");
+#endif
 
 	if (argc != 3)
 		format();

---
base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
change-id: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

