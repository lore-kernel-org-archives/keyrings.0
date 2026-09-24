Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703C370AE6;
	Thu, 24 Sep 2026 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229339; cv=none; b=Ztf1js/i27CovbTM7ijB0dZwnft+BD8wvPLVsIrUOVBipAPMY9kaF/Fqv+NzViuhCq6efrTXecSdAxZPZ/pAVuXXqKgoYomOvxZ/YlPtt+bx+T0OssKl/KOR1/CQfjiFr324K8kYwp0MmznSvSZ7ky1AReBhPw7YztDP5ZFA57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229339; c=relaxed/simple;
	bh=jH/4BwDYmH5pCVgnCgWRUnCUgAu9voGXuX0WUygE4xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shNgSpbh6fK29DsyrGcdlAEq/P3AeWbrI/0ZhhT++HC+Bzm1LoMGsHI3/Rv6/jTJBG5/EeXu+TCpqffhFcwc4KgQIoeDcZ7noXnWXzazXpjilCmclRcDwjZnRmU+G77EtZRAB9+TpEm3tec6vOdAgyxb3JGL3/r2JXlCiGhZyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM4UpJZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM4UpJZr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 311A61F000FF;
	Thu, 24 Sep 2026 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229337;
	bh=HhNLLsxjo5Gu8BwI2LxnCbyQjlLdeAmR0e50C8GFqIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WM4UpJZrUSsUswX3K8Q+Ibr8YRSJ/Vb+EO0gQqW0lzn0fsq6CFOJQTHF+FOIcw7en
	 KENbz1tWs3PSGL//QTLgCn0R7T0MGbo3jtAce5dTiqKX4xxjVefXF+8iudo8tldMZ+
	 T6kbnUa3NGZhw/SRqS1jH/jdY2ZJtF/zW523Oqjm+VZ+zlmfq9GhWEIazzwZwy+KF5
	 4oIlgfXutFur+Da6+7lzvBV+79T3B8/fLgFazBaXf4zXa5MW7cfk1lAu+wPu6hvedC
	 N+6p4MZw29Xpisg8Jq9zxMomlRSDtT6PKMN7+HZ7a/TWIgd1oQRxKmPVmq/H+r6e4Y
	 oq9l9aMCo0lkQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC PATCH 2/2] keys: Reject keyring creation with overridden credentials
Date: Thu, 24 Sep 2026 08:55:18 +0300
Message-ID: <20260924055521.1981957-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924055521.1981957-1-jarkko@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the current task is running with overridden credentials calling
commit_creds() is forbidden and triggers a BUG_ON().

Reject keyring creation with -EPERM when credentials are overridden.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 Documentation/security/keys/core.rst |  3 ++-
 security/keys/process_keys.c         | 31 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index c81a3a9fe236..9779ce71df47 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -168,7 +168,8 @@ The key service provides a number of features besides keys:
      If a process attempts to access its session keyring when it doesn't have
      one, the default user session keyring for its current UID is returned
      without being installed into its credentials.  If creation is requested,
-     an anonymous session keyring is installed.
+     an anonymous session keyring is installed, failing with -EPERM if
+     credentials are overridden.
 
   *  Each user has two quotas against which the keys they own are tracked. One
      limits the total number of keys and keyrings, the other limits the total
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a5aa056a6725..bd68dbc028e2 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -346,6 +346,14 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 	return 0;
 }
 
+/*
+ * Determine whether the current task is running with overridden credentials.
+ */
+static bool cred_overridden(void)
+{
+	return current_cred() != current_real_cred();
+}
+
 /*
  * Handle the fsuid changing.
  */
@@ -578,7 +586,8 @@ bool lookup_user_key_possessed(const struct key *key,
  * to a key or the best found key was a negative key; -EKEYREVOKED or
  * -EKEYEXPIRED if the best found key was revoked or expired; -EACCES if the
  * found key doesn't grant the requested permit or the LSM denied access to it;
- * or -ENOMEM if a special keyring couldn't be created.
+ * -ENOMEM if a special keyring couldn't be created; or -EPERM if creating one
+ * while credentials are overridden.
  *
  * In the case of a successful return, the possession attribute is set on the
  * returned key reference.
@@ -607,6 +616,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			if (!(lflags & KEY_LOOKUP_CREATE))
 				goto error;
 
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = install_thread_keyring();
 			if (ret < 0) {
 				key_ref = ERR_PTR(ret);
@@ -625,6 +639,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 			if (!(lflags & KEY_LOOKUP_CREATE))
 				goto error;
 
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = install_process_keyring();
 			if (ret < 0) {
 				key_ref = ERR_PTR(ret);
@@ -646,6 +665,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
 			if (lflags & KEY_LOOKUP_CREATE) {
 				key_put(user_session);
+				if (cred_overridden()) {
+					key_ref = ERR_PTR(-EPERM);
+					goto error;
+				}
+
 				ret = join_session_keyring(NULL);
 				if (ret < 0)
 					goto error;
@@ -658,6 +682,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		} else if (test_bit(KEY_FLAG_UID_KEYRING,
 				    &ctx.cred->session_keyring->flags) &&
 			   lflags & KEY_LOOKUP_CREATE) {
+			if (cred_overridden()) {
+				key_ref = ERR_PTR(-EPERM);
+				goto error;
+			}
+
 			ret = join_session_keyring(NULL);
 			if (ret < 0)
 				goto error;
-- 
2.47.3

