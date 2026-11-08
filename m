Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143666;
	b=ugWttcf7bNarybnCr52WZjN9YA4t1bEr/Hv6iN2K8UyweZG/L3cHaieDJTQ6bYxO0O0E
	 seT+h1MxBHFnp9cB2df36SrkO2JA8lRxwBg6+k7KGzhyzmWFI9M1EXH5X9CRBxQ5gy5CN
	 D8dNpuqPLbotY8sfHVL+vSlG4khykMv/W65yR9DBvKhNr+5Z0iL2OyT/9V1VkoLxsOgHs
	 UhOmFjp1GzxAY52XABI/yxO+spacXJz7GhXh7CDHZ6Llmj7fE50b/s6p7qcH52psaSjz9
	 lhvfWoLlXqY7dstxx2ON3US6EnXQkWe7K4Pz43wioHzwRv9vSLs1Odt97wRK2awL6jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UPIbJgLYlLtieg0sQ/hF4HXStngZuJMWeYBhIiIHzok=;
	b=pC6TKtq4abZ7UuduxjAGyrnsI47KmTikgJe1Kylnh2zhVUaPdH+bbAGh85yyPLGjuWNl
	 Qab4U6Q0zva6xZwom9h3+JuJd2v+ZtXuvemf5YeO9Az4t6f3dCj2eusAjUN/8BoDr9gK/
	 7q9EPQX7M9fo8SEGB8sLU1yUlsJCr10LEXckC2HXZSFe6L3TPp8VlJzfdjkH/DMnvgGok
	 cAhX0+6jR09sSEKFbfWRT/X7qAyR7Zb32meME4oEMW0tPIPyEI9u6KMJPibnsqPgKRewt
	 ZGg7E+yodSs/lXVWuoJY/YfF/erP139xzVuGwqQihmlc2KHcdqKoStc94EWiQQRUhPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcOojZA0;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F7606A326
	for <keyrings@vger.kernel.org>; Sun,  8 Nov 2026 13:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D52F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AcOojZA0
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso29423a12.0
        for <keyrings@vger.kernel.org>; Sun, 08 Nov 2026 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794143665; x=1794748465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPIbJgLYlLtieg0sQ/hF4HXStngZuJMWeYBhIiIHzok=;
        b=AcOojZA0psLrwqIyKqUEvAvtS27i5/E649iK0TXinUu9RgKY69ROlUSPS865058+aB
         0rpzug/5Ybn/lybCz7iq6adkhQrZmysZ+D++bQw/AQUAz4UcQn7ZROLxV3g2QXUN+Ne+
         q9eNoBq0s4jdV4+5IC4CStws5Hb5HEsozC670lHmHGjpmn+zZ/wDrrxWXmUzhXVqsGkp
         bO9QUyoF8Q3k6ibE9MQ3GydNWaIPo6Fr5UBYq4Muz3okRHzGfZtz/Lt5LfDNAGsuihYP
         hI/fV2woFeQBJSn015Dr8ehtHPLJTavI2i18FDpU0RcTtA4xNeZl0Smu8i16Ad2VGA3I
         eq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143665; x=1794748465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPIbJgLYlLtieg0sQ/hF4HXStngZuJMWeYBhIiIHzok=;
        b=Zjlw6qStH3K0TM1FsrGdU4HxwH4TO2I90nzLSNDeZRRbulAXtYuYtOwE1ATfDRc4Td
         uzumEVVMK7w9JaEW5ziNlnBugJl7hxc43mwIhW68mW0SIXQhCb6YAEi9jeADhloKzUN4
         muaAsfvbEGm3QX/ZJJjX7P+gH2J+eHHwxXOTqkSzjCSnKipF58Zjb3TBf6R03iL2CF11
         focydtg7pDZ5Bj7a6WZvhikYHUDOwW5SXkDVCWO0pxj4Xt7G3UQQRVAoSQce6AyE+cmX
         TxWkEY9CoDCxxFZtqjt4SmJTqSUIRIQxh1Gg9aQHH7xSoek0gOSMqbs7j8ZXvp9fEtQa
         8yhg==
X-Forwarded-Encrypted: i=1; AL+hErHUtErg7HuyNrwS+1cLrISjnUrh9JFAfpIMVaMOXACf+CGCwqkLEFrwjX9aWaBGRbRPlR7Eo4tgsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oVwFehfmgyp77xNZE6jMG1g7liaDuhr1Ya7bgTdPfnwc8br5F
	kOS6yekDp2+vwkDlP+aaqLOcdb3rM9kLccYmbY1IPzn5WqNK/BXbKSaw
X-Gm-Gg: AYBFou26tMhDT/o9l8KjTOjvsYkRAeZAom8c235FvbCdkYEhTWy91KuuJNawIq7Eq6R
	P2U777R1UU1vwrRQ/KIKJpqvdx32qad59NPRePug0D/4jS7D1fwAmOsRwGq5LYQcUFiKm4dtVc7
	I/TUgDNpx/BfuJf77JeWi+64tEf3xkS91k4I/fvTvyhSpkt6s9GSu94tW27SY8FMgOaHOigWOBj
	IUQ/umRR9/53fz7GbsmJIl1AW8F/ilHxDmc9ErAg86NauSo/SUZHOd4OGT5JRnsRxo2pSfFNUDy
	B1P9xrtdjkUrqPS+ALsJUwvO8lqB2fSZv0Hto+C7bIW3S1vAQ+OYbt21EZl3jZzkgNAd6Oc8Qcp
	97phioXnvzbyIS4FYOOIh/MTWew/fJRG6YtS+r8u3KrX/O52K+bNVNc6w+zZbZysXdtXjoD3Gy9
	+EfQwuPcnCaBapYzDHydxJ0uBae9JoKAXezC6nLKg7Z8Mdax2i/AYIvByn5VnMvZM2lE8d++/9v
	tOW8lmOFc8TsTToRAgbGwHCAnZ/q2jFfcEMECR/mVsG+PNRP0N3674/6oYjpS79N/vfTIDlRUhR
	UJoSoj2YJOka/PAjG9Qon1RvaXmmD+to6y3jRgcGoSZvjx+D
X-Received: by 2002:a05:6a20:9d97:b0:3e2:2021:89c with SMTP id adf61e73a8af0-3eed0a6e354mr1399476637.5.1794143664923;
        Sun, 08 Nov 2026 05:14:24 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9696c959sm693211a12.28.2026.11.08.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:14:24 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] KEYS: Protect pkey method checks against type removal
Date: Sun,  8 Nov 2026 21:14:17 +0800
Message-ID: <20261108131417.77287-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au3fT5HMq7IF-M3e@kernel.org>
References: <au3fT5HMq7IF-M3e@kernel.org>
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

keyctl_pkey_query(), keyctl_pkey_e_d_s() and keyctl_pkey_verify() check
that key->type has the ->asym_*() method they need and call it later,
without holding key->sem.  A reference keeps the key alive, but does not
pin the module that provides its type.

When that module is unloaded, unregister_key_type() waits for the key GC
to process every remaining key of the type.  For each such key, the GC
takes key->sem for writing, switches key->type to key_type_dead, whose
->asym_*() methods are NULL, and destroys the payload.  If this happens
between the check and the call, the keyctl calls a NULL method:

  KEYCTL_PKEY_SIGN task              Module unload and key GC
  ------------------------           ------------------------
  keyctl_pkey_e_d_s()
    if (!key->type->asym_eds_op)     unregister_key_type()
                                       GC: down_write(&key->sem)
                                       GC: retype to key_type_dead
                                       GC: up_write(&key->sem)
                                     free_module()
    in = memdup_user(...)
    key->type->asym_eds_op(...)      -> NULL call

If it happens while the method is running, the method is left running in
freed module text.  In-tree, turris-signing-key provides ->asym_query()
and ->asym_eds_op() and can be built as a module.

Take key->sem for reading around each ->asym_*() call, and check the
method again under it, right before the call.  While key->sem is held,
the GC cannot switch the key to key_type_dead, so unregister_key_type(),
and with it the module unload, cannot complete: the type, its module and
the payload stay in place until the method returns.  If the type is
already gone when key->sem is taken, the check finds key_type_dead and
the keyctl fails with -EOPNOTSUPP, as it does for any key type without
the method.

Otherwise, behaviour is unchanged:

 - The existing checks in keyctl_pkey_params_get(), keyctl_pkey_e_d_s()
   and keyctl_pkey_verify() are kept, so key types without the method
   still fail at the same point with the same error.  No call relies on
   them any more.

 - memdup_user() and copy_to_user() stay outside key->sem, as in
   keyctl_read_key(), so no page fault is taken with key->sem held.

 - key->sem is only taken for reading, so pkey operations and KEYCTL_READ
   on the same key still run concurrently.  Writers such as KEYCTL_UPDATE,
   KEYCTL_REVOKE and KEYCTL_SETPERM now wait for a pkey operation in
   progress, as they already wait for ->read().  The in-tree ->asym_*()
   methods do not take key->sem themselves.

Nothing else in the kernel calls these three methods, so the four call
sites below are the full coverage:

 - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
 - keyctl_pkey_params_get_2(): ->asym_query() to check the buffer sizes
   for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
 - keyctl_pkey_e_d_s(): ->asym_eds_op() for KEYCTL_PKEY_ENCRYPT,
   _DECRYPT and _SIGN
 - keyctl_pkey_verify(): ->asym_verify_signature() for
   KEYCTL_PKEY_VERIFY

This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
("keys: Protect the read method check against type removal") and for
key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
against type removal").

LLM assistants, OpenAI Codex (gpt-6.1-sol) and Anthropic Claude
(claude-opus-5-5), found this while looking for other cases of the
KEYCTL_READ problem, and drafted this patch and this description.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v5:
- Keep the asym_query check in keyctl_pkey_params_get() (Jarkko), and
  for the same reason keep the asym_eds_op and asym_verify_signature
  checks that keyctl_pkey_e_d_s() and keyctl_pkey_verify() do before
  copying the input.  All four call sites now get the same change and
  nothing else moves.  This also restores the error for
  KEYCTL_PKEY_VERIFY with a bad input pointer on a key type without
  ->asym_verify_signature, such as turris-signing-key: v4 returned
  -EFAULT there instead of -EOPNOTSUPP.
- Rewrite the commit message around that change: what it does, why it
  is safe, and why the four call sites are all of them.
- Say in the changelog that LLM assistants found this bug and drafted
  the patch and its description.  They also wrote the tests below.

Tested on x86_64 under QEMU/KVM, with KASAN and lockdep, on 7.4-rc1
with and without this patch.  A test-only key type module (not for
merging) is unloaded while KEYCTL_PKEY_SIGN or KEYCTL_PKEY_VERIFY waits
in memdup_user() on a userfaultfd page, after the early check:

  without the patch: NULL call from keyctl_pkey_e_d_s() and
                     keyctl_pkey_verify()
  with the patch:    both return -EOPNOTSUPP

When the module's ->asym_eds_op() is sleeping as the unload starts, the
unpatched kernel faults on the freed module text; with the patch,
delete_module() returns only after the method has returned.
KEYCTL_PKEY_QUERY, _ENCRYPT, _DECRYPT, _SIGN and _VERIFY on an RSA-2048
asymmetric key give the same results with and without the patch.

In the two forced races lockdep also reports "bad unlock balance" for
key->sem.  Its lock class is the type's lock_class, which lockdep drops
when the module is freed, so any key->sem user that took its key
reference before the unload can hit this, e.g. keyctl_read_key().
Not tested on Turris hardware.

v4: https://lore.kernel.org/all/20261105193632.34363-1-0xbeac@gmail.com/
v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
v1: https://lore.kernel.org/all/20261103032940.51826-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 49 ++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..0ea6f2790e 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -129,7 +129,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	down_read(&params->key->sem);
+	if (!params->key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
+
+out_up_key_sem:
+	up_read(&params->key->sem);
 	if (ret < 0)
 		return ret;
 
@@ -185,7 +194,16 @@ long keyctl_pkey_query(key_serial_t id,
 	if (ret < 0)
 		goto error;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_query(&params, &res);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error;
 
@@ -260,7 +278,16 @@ long keyctl_pkey_e_d_s(int op,
 	if (!out)
 		goto error_in;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_eds_op) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_eds_op(&params, in, out);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error_out;
 
@@ -305,31 +332,41 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
 				       &params);
 	if (ret < 0)
-		goto error_params;
+		goto out_free_params;
 
 	ret = -EOPNOTSUPP;
 	if (!params.key->type->asym_verify_signature)
-		goto error_params;
+		goto out_free_params;
 
 	in = memdup_user(_in, params.in_len);
 	if (IS_ERR(in)) {
 		ret = PTR_ERR(in);
-		goto error_params;
+		goto out_free_params;
 	}
 
 	in2 = memdup_user(_in2, params.in2_len);
 	if (IS_ERR(in2)) {
 		ret = PTR_ERR(in2);
-		goto error_in;
+		goto out_free_in;
 	}
 
 	params.op = kernel_pkey_verify;
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_verify_signature) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_verify_signature(&params, in, in2);
 
+out_up_key_sem:
+	up_read(&params.key->sem);
 	kfree(in2);
-error_in:
+
+out_free_in:
 	kfree(in);
-error_params:
+
+out_free_params:
 	keyctl_pkey_params_free(&params);
 	return ret;
 }
-- 
2.43.0

