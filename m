Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D03A783F;
	Sun,  7 Jun 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840207; cv=none; b=g3iR5RwdF572IpevAqoKHnj7baGyDEWep1goZ0xRKUQGlx9G2wZt9t0tGS9tPkMgFsEau4nrsGbCx/AN/IKk+eif+hikre7iogPprIf2pbPj3gAzyPqlsP8xglVsmh6NorABT/bNmFLLici3rQIZG2kWHocsivtLUb/4Sv6D9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840207; c=relaxed/simple;
	bh=IQMmwQjkOuC3PKadL5K2kFtTRaWJEUCmtk1/aNeRp8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAO/6CE+sSKZL0LrfyqhvYApr00kxA43wDQG6qEd2uSDl1XtZIDHgR/EyEQrb1aG+o+Prxb8tuRJIdLbTVvT7ECjYR4w2kSkMFvSYz967OLsa7h1ll7SzNSV4s7j38oMbwRCh48aTccAT6S4SLESixxb2FvL4thlxES1BDshxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlOTACZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlOTACZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50211F00893;
	Sun,  7 Jun 2026 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780840206;
	bh=IxkrWMRntuKK+DdVWakQp3v+IyQ/eNGEQSjVtp5xgqY=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=AlOTACZem2KgcLfSSjS2/IZddmUuljqepNRC8fojRXGfNXXhlWTTDgExHr/ucVmyr
	 Y/2S/fSxwMYH2A/Mp/2v+C7vtRy7vhZxKjVVHA8uJ+0rsw19cPJmvi64HdMstOyRrM
	 1MHs2bsFf2AZ3QQsZp+wnVdI8Diw8qSMbGNT2nc39nKhHu5CnrIaijrJn+j9SEOfqJ
	 JQ6aPPfPhtFAe8Mw2FvJPVqQ9TUFhxBIEYNJ3YTSmNjyFAFCLulQqcplPI37Igu6dl
	 0Zt6LxZ0ulPVe9HjxEYwDVnxrKZuk7DKo4kXqeOojno/yBW5qJ5Nwi5obM3vcM7t9t
	 1HUsgsWXAtT3w==
From: Gary Guo <gary@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Gary Guo <gary@garyguo.net>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys: allow request-key path to be configured via Kconfig
Date: Sun,  7 Jun 2026 14:49:27 +0100
Message-ID: <20260607134928.2832202-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

Some Linux distributions (e.g. NixOS) does not have /sbin present, and they
currently carry patches to replace /sbin/request-key to some other path.

Follow the way modprobe handles this by making this a Kconfig option which
defaults to the current /sbin/request-key.

Also changed "char const" to "const char" as checkpatch complains
otherwise.

Link: https://github.com/NixOS/nixpkgs/blob/6b316287bae2ee04c9b93c8c858d930fd07d7338/pkgs/os-specific/linux/kernel/request-key-helper.patch
Signed-off-by: Gary Guo <gary@garyguo.net>
---
I did not update mentions of /sbin/request-key in documentation and
elsewhere, as "/sbin/request-key" is concise while "request-key UMH" is
more mouthful and less clear.

Number of distros that doesn't have /sbin is limited so I think it wouldn't
create much confusion. Similarly, there are a lot of places where
/sbin/modprobe is mentioned despite it is technically configurable.
---
 security/keys/Kconfig       | 9 +++++++++
 security/keys/request_key.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index f4510d8cb485..ee3c3d85fc03 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -40,6 +40,15 @@ config KEYS_REQUEST_CACHE
 	  key.  Pathwalk will call multiple methods for each dentry traversed
 	  (permission, d_revalidate, lookup, getxattr, getacl, ...).
 
+config REQUEST_KEY_PATH
+	string "Path to the request-key binary"
+	default "/sbin/request-key"
+	help
+	  Path of the request-key usermode helper binary.
+
+	  This program is invoked by the kernel when the kernel is asked for
+	  a key that it doesn't have immediately available.
+
 config PERSISTENT_KEYRINGS
 	bool "Enable register of persistent per-UID keyrings"
 	help
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18..ac8f9d1a87ad 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -117,7 +117,7 @@ static int call_usermodehelper_keys(const char *path, char **argv, char **envp,
  */
 static int call_sbin_request_key(struct key *authkey, void *aux)
 {
-	static char const request_key[] = "/sbin/request-key";
+	static const char request_key[] = CONFIG_REQUEST_KEY_PATH;
 	struct request_key_auth *rka = get_request_key_auth(authkey);
 	const struct cred *cred = current_cred();
 	key_serial_t prkey, sskey;

base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
-- 
2.54.0

