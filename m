Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0CC359A70;
	Thu, 24 Sep 2026 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229334; cv=none; b=p4YWkKcu9nhV4/++tkrnoIaeFxmE/wuXY8nyNz2tBFo+Y8x3RMfgl6qQvzGtdBT/F/LWKVZf3Znw5tZuT5ZvUeMwBsn8BFFsMrXl+fx9e7h2tmL6nXcIYSem73fh4kkOX0Pu0yGxVhX9rMB9QScHidqcRZ/j/xsdBlNqZjcd77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229334; c=relaxed/simple;
	bh=77iWY8iGZ4TI02K2SkQHbWhp/KboQTQ46tf/aeIWKHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5FbHIYwQRwShSgyArepF9xQHYwEuQAqfQVfwlq08cZNbNaz2qo3v00oC15KKOFHTEAdvdGYAbJV64apK3n6nTE7oE0NRuir1dbl/G6BJlelBbXG6UzIYOGwjR6f4nK+ktVkkcpw3PLh52NSH2eXz2Mb7BlynRRUR9Sqmoen+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJvDAJsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJvDAJsW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 26BA41F000FF;
	Thu, 24 Sep 2026 05:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229332;
	bh=tGDhpi/YZ/+AH1XKgeVw2fMLeUrE/d/2tBqyAIsO6t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJvDAJsWFGCgg8UQ9GEz7LY8bDnV0gnRZCCav7J8k4I8UG7e/6SwcRLkKZ8ibAijt
	 H3Oebl4fcDse78tf+iW/T12IlQ4hVmGgRhQ/TgJk1QrBwORwY1AnAO83iC6vMRlhmN
	 7qZXtk4fX+pv++nQAItxg5TzW/WHGx0snxiLjS/vnSO/e228wgOQUfepSwdyuHYZdd
	 XD6j1yNfgPb9k9QjtqsgfasdusR360L4wQ1giv8xz7fd9WSWpjH3we3q1UFpoO4SqL
	 e6S5304no9TeQC8EVw6uPY4ogfyPVPVayyi7aEELzfFIHymxmf0QC3auQBxwNzwTzc
	 pIIOo7uetFqYQ==
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
Subject: [RFC PATCH 1/2] keys: Return user session keyring on lookup
Date: Thu, 24 Sep 2026 08:55:17 +0300
Message-ID: <20260924055521.1981957-2-jarkko@kernel.org>
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

A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
without KEY_LOOKUP_CREATE mutates the credentials. This causes struct creds
instances shared with other subsystems to become stale.

Address this by returning the resolved user session keyring directly
without installing it into credentials.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 Documentation/security/keys/core.rst |  6 ++--
 security/keys/process_keys.c         | 44 +++++++---------------------
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..c81a3a9fe236 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -165,8 +165,10 @@ The key service provides a number of features besides keys:
      When a process changes its real UID, if it used to have no session key, it
      will be subscribed to the default session key for the new UID.
 
-     If a process attempts to access its session key when it doesn't have one,
-     it will be subscribed to the default for its current UID.
+     If a process attempts to access its session keyring when it doesn't have
+     one, the default user session keyring for its current UID is returned
+     without being installed into its credentials.  If creation is requested,
+     an anonymous session keyring is installed.
 
   *  Each user has two quotas against which the keys they own are tracked. One
      limits the total number of keys and keyrings, the other limits the total
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a63c46bb2d14..a5aa056a6725 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -346,31 +346,6 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 	return 0;
 }
 
-/*
- * Install the given keyring as the session keyring of the current task,
- * replacing the existing one if any.  If the given keyring is NULL, then
- * install a new anonymous session keyring.
- *
- * Return: 0 on success; -errno on failure.
- */
-static int install_session_keyring(struct key *keyring)
-{
-	struct cred *new;
-	int ret;
-
-	new = prepare_creds();
-	if (!new)
-		return -ENOMEM;
-
-	ret = install_session_keyring_to_cred(new, keyring);
-	if (ret < 0) {
-		abort_creds(new);
-		return ret;
-	}
-
-	return commit_creds(new);
-}
-
 /*
  * Handle the fsuid changing.
  */
@@ -665,20 +640,21 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 
 	case KEY_SPEC_SESSION_KEYRING:
 		if (!ctx.cred->session_keyring) {
-			/* always install a session keyring upon access if one
-			 * doesn't exist yet */
 			ret = look_up_user_keyrings(NULL, &user_session);
 			if (ret < 0)
 				goto error;
-			if (lflags & KEY_LOOKUP_CREATE)
+
+			if (lflags & KEY_LOOKUP_CREATE) {
+				key_put(user_session);
 				ret = join_session_keyring(NULL);
-			else
-				ret = install_session_keyring(user_session);
+				if (ret < 0)
+					goto error;
+				goto reget_creds;
+			}
 
-			key_put(user_session);
-			if (ret < 0)
-				goto error;
-			goto reget_creds;
+			key = user_session;
+			key_ref = make_key_ref(key, 1);
+			break;
 		} else if (test_bit(KEY_FLAG_UID_KEYRING,
 				    &ctx.cred->session_keyring->flags) &&
 			   lflags & KEY_LOOKUP_CREATE) {
-- 
2.47.3

