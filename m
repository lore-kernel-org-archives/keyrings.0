Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674969;
	b=wRzton1djbagF0oKS6qz+XwnayWXkB0LPOnj5ozA/SexN+EFN11VuAUGpvzmvvigKZ1o
	 pNKDTivPfC54hvc5koTqJsCFIOL3zbcflifIEhGJKAE4MHfp6RHyfmXNZGx9jimhi1DkH
	 fU51jrBMkDveem9amfRle+hdSPSQj2Ug9kIbutPT+drbjMudBXsWa2bPRyLK2SO8FUktU
	 eQp2Dxk6E9g2F+JzFz4jgCPq61qAcUfELG8ZdnL4c7c4VNQl3LV1GcV/yXF4FH4sFEZ0x
	 yayL2XHeHmrOiDLkQTo8W67sjSidu3IrPnojXUfwG6mT/XMS6F9Z7SqEcUnQgocdb1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PwfTh3H79bWphr6MScCLQETxuvA7JpmSk5fJb1bDGSs=;
	b=dCzWE1GAY6UIlmsx3D0JxqMbwil+XJSdB4Bb8jL3uFQMu92leR5KzvY8/16UDVX1rr+P
	 bP0WF7PZg3ANTf/1oMnWbvkJZjZb+Y9zAw5rQT6fA9FT42nvn6TaX99+6HD3HwgtWlWj6
	 lPrZtEL+7lqCUDHg8x9IyHjCT6x7+jAYRzxXT48E0SkfiuKtlJ3h3L/x2L1uDpqZSI8jl
	 Lo4utd8Jm6m8WDgjyT0+xg8Rc2YT2l3U6UVxxYfEvIJXOJtg9WK6klua3zxYEsHPLGmqH
	 zKqGbWwcOaAbzMNLy0ieQqEISy8Rk3DTEgarIOrcdtTqo3lQN7xSoX6POlTKtztiIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBtF7bts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 02DF7606A324;
	Tue,  3 Nov 2026 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBtF7bts
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1B71A1F00A15;
	Tue,  3 Nov 2026 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674968;
	bh=PwfTh3H79bWphr6MScCLQETxuvA7JpmSk5fJb1bDGSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBtF7bts2o2m4M+eHUHqLqTSTBL88JRitqUxd5oVo482gCT2RwAxKCNz5sqi0COO+
	 OyYEAlvFkFhTSF9FgpXOH6/XVmggjD2FCrvBR5+1iVE1fxc4RgdUPz3oK75VtbiEk9
	 U+UJiHzXnMoQW44b/nDmrqMqp2wbAEOZ/mQzOpHGjuQ8LZ3JPcePsljveRek0Z4Iv7
	 XlT40eVw+oFEKz1XLmO33PdN595XYKuUDn6J7kBe+IXrErWzuvNxXvlkFNJKPEktdT
	 GDTwrp38T+T2tjQHqMEMTTyKgVo/Odt0QFYi2oCNoppHa3z6OoQ9QjvTKj/V5/3K/G
	 FsutmOXz3SvRQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH v2 01/11] KEYS: Add key_gc_flush() for draining RCU callbacks
Date: Tue,  3 Nov 2026 05:02:06 +0200
Message-ID: <20261103030226.2685251-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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

keyring_clear() and key_invalidate() release keyring links via call_rcu(),
and key_put() defers final key destruction to key_gc_work.

Once live keys pin the key type until key_gc_unused_keys(), callers that
clear an internal cache before module unload need a synchronous barrier so
module references are dropped before delete_module() checks the refcount.

Add key_gc_flush() for draining RCU callbacks and flush key_gc_work until
no further garbage collection passes remain queued.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h |  2 ++
 security/keys/gc.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 420412aab926..0f408255f740 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -439,6 +439,7 @@ extern int restrict_link_reject(struct key *keyring,
 				struct key *restriction_key);
 
 extern int keyring_clear(struct key *keyring);
+void key_gc_flush(void);
 
 extern key_ref_t keyring_search(key_ref_t keyring,
 				struct key_type *type,
@@ -526,6 +527,7 @@ extern void key_init(void);
 #define key_free_user_ns(ns)		do { } while(0)
 #define key_remove_domain(d)		do { } while(0)
 #define key_lookup(k)			NULL
+#define key_gc_flush()			do { } while (0)
 
 #endif /* CONFIG_KEYS */
 #endif /* __KERNEL__ */
diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d4..3cfbf00085b3 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -21,6 +21,20 @@ unsigned key_gc_delay = 5 * 60;
 static void key_garbage_collector(struct work_struct *work);
 DECLARE_WORK(key_gc_work, key_garbage_collector);
 
+/**
+ * key_gc_flush - Wait for pending key unlinks and garbage collection.
+ *
+ * Drain RCU callbacks from keyring edits and wait for the key garbage
+ * collector work item to finish reaping unreferenced keys.
+ */
+void key_gc_flush(void)
+{
+	do {
+		rcu_barrier();
+	} while (flush_work(&key_gc_work));
+}
+EXPORT_SYMBOL_GPL(key_gc_flush);
+
 /*
  * Reaper for links from keyrings to dead keys.
  */
-- 
2.47.3

