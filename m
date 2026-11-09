Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203531;
	b=zMgX3ynQ0mhQr5z4phRweRlO37BTFMVPyfxrucaeJg/p6r/ijDvRkjib32EQIth2byED
	 l4USbH+N01D5EVsfDuTYbEMsROH8v6fSCNUKJjJFv/Kv5okNx6RC+Yenrny1YNYuWfTKV
	 bGGPMYZ5puip+DEuLi9LwWFl9bC0EfLBi7dcfpdm43ESBPl5p7URd1JsBgEYyMbr4jbrL
	 OyI5Gvae8ZPX6prljIqnQy+rClZQDCUi01chNw1BtB7YdW9wgCQ1AbLT/kcL8f4gemnm7
	 d1ZIO0mTVC/Bc5FdW4PMoMWush3W5FCIh1Hs9W1FbaaWLgVLumWBmx36cH4CrS274Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DNOJI+lolXvHXOW0PP+vE0tHALj2mGjIcdNhMn8YUII=;
	b=wDaDl2PsboQT4QCxz9Ypmi0HqoF/0cKvlUWlrsp3yJAw7MRO0Pz0BIHz1rp4uJRaCpdf
	 4wduk/adyuUDQkaPI+eXfwKbc/O1LuK1UpRswF4EkQw0vOJDGZTRXK6jsUt9CvTzevO3u
	 GdNg28FGdlpHc5AF4Zmu0VI4h2HjR0z2qrcAWF8zbQBbBGmooDtxVXSl/doPrhiM6kXi9
	 nrCLSCqk9XmxJpkpIjANqzzdgjgw6Y2e7FSkglhYdgTGSmNncMKAKit8lEAcbZCnoF3Co
	 mVCsOrMipO92mfGcoXsRHEJ/8J8gHSbfLUP8yWgr2A/8DJoryyFSHx3uoIp3cRcW/HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWGFfAwU;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9386606A323
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 05:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9386606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWGFfAwU
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so181148a12.1
        for <keyrings@vger.kernel.org>; Sun, 08 Nov 2026 21:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794203529; x=1794808329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNOJI+lolXvHXOW0PP+vE0tHALj2mGjIcdNhMn8YUII=;
        b=uWGFfAwUYuTybFA3BUg7YgrZ16req13e1Sbxm9Q72g5f2WaVJhgZcswrez1A5BFSxN
         swJBTJCbXO4ZwbNKKfHD0h34kTNmuaeh3LMccAW0xO4TqctCmcON/3NdI9OJDbPVBK3V
         2JOIoD0yKNqMSS8hZORgEhjYUUHT90T26ORcMJX4ofSI3Lqg5RoMHe3DTBbjhBVoFBRV
         v2seXkM0KH7U1FHs7h8UTDw9XleKefJDMVZSRKvwwtvmXGvj5c/cp7tceaKg0auQLdM1
         pquvSmRAhDenv1dfYWY4DivWM5t8O2Uhd8Q452qpyG2/gdibME2KcmcPmoCuEN6i68s9
         xsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203529; x=1794808329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNOJI+lolXvHXOW0PP+vE0tHALj2mGjIcdNhMn8YUII=;
        b=b3y2T/9Uuz9Kq3cbdH1Fn91wG9Xm/P3hUi0lScuYpFdaLEtIt0vzxqBPkfDpsUGt9v
         UucqnvfDrRtUXwIx4IG9NpVTXY5KGki1iksUPiVvEkKXqx4TjILVO3jnb3gxmIodFIXB
         lKEeV7tfJbRteoIkaTkrBYBsRcgITOVJGGwNS1iv0+OYF7mV5KOZ0w9v8QL2C4jRoDP1
         LZdCm7NaPJKw3kh2IpgJDkI1okv2SGuCSnPeM9h1l/s7XiNYNoQTCIx89a9IhxTZx8pj
         QhAhHsBE0xyCxKoZtTixxi16qSVuzh7HkZH2opOPso/m3NBUqa8Me5elsdQFQZ+CnNs5
         ufGg==
X-Forwarded-Encrypted: i=1; AL+hErG8+uICr6hoZIUhxhFOo4+Iy6d0EkfdjvMe+FflNEX3o0uqy/F0MZvW7F28Y+KtwmlGCVV+zDSXrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yjqE6zR5i9+ba8f+iVWaywR9bb/wYkSgSgyhH7BWG86aboaHw
	i36f6aeEPXGEngwStSEu2Pxccd4bKerGGkZt79lLejPNRIewWE43Eiam
X-Gm-Gg: AYBFou081aIJtVd88n2u9PP1ohgpGQrjuxfpdKh+VJqnGGpNmwHgOsmwhuhhaPnebjb
	PPT5asjSY9wF87zx/rOo/ZUiGAvzTBZpWOniytee52oU9eyPR0BGeQvrvz8IQcqG+jj6OP7Ak5j
	nnogMu8pIJ3ny7bWenseKfdRyyvLqUFS06EKsZSiGzS8GAyX4hPxZCZYyvHqf5XNm0Rt8LbYK8Q
	I+wivXv1QjMrfaDTUXKR1uvVdfNXyyp4bqaAI/0Kqdvd6qOSmPrOTir4VUFK76ezMowb6SgzIPo
	tqahI8Ax1UeJrSIKcpCDVQHrqINQwb3Zgxc8mMi+ZDps53oBaPiavvntvdBSkmfYLP7TZoYCFYk
	SANqcZ2O/80a18369zbjzYAkFXfYjQEMa940p6iyWRtzojkaENGV08+EnVEM9EbHhlyJnNwpXdr
	pIQvoa46Vl6w6a/inlXTpK/CacmcbIyd7RbRoknmmf+aQMadWq5J75Q08WbVjRQPNHI/3jPZp4j
	AtWQY8vYe1AnHmtw54pugkujgwsf3F3Ip6B0rr3/VeoBmte5MZFX99ii9g65gC2xLkNu5gZvqlF
	tn/eJoOZMCPvfcizAs/Ht0CvhFCXWXj9VUXW
X-Received: by 2002:a05:6a21:880c:b0:3e0:d508:59a6 with SMTP id adf61e73a8af0-3eed2024dcamr2464402637.13.1794203528881;
        Sun, 08 Nov 2026 21:52:08 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b649438c46sm909905b3a.30.2026.11.08.21.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:52:08 -0800 (PST)
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
Subject: [PATCH v6] KEYS: Protect pkey method checks against type removal
Date: Mon,  9 Nov 2026 13:52:04 +0800
Message-ID: <20261109055204.31673-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avCZIMCsZ4um18e-@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org>
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

Every read of a ->asym_*() method pointer must therefore happen with
key->sem held for reading.  Take it around each method call and check the
method again under it, right before the call.  While key->sem is held,
the GC cannot switch the key to key_type_dead, so unregister_key_type(),
and with it the module unload, cannot complete: the type, its module and
the payload stay in place until the method returns.  If the type is
already gone when key->sem is taken, the check finds key_type_dead and
the keyctl fails with -EOPNOTSUPP, as it does for any key type without
the method.

The checks that keyctl_pkey_params_get(), keyctl_pkey_e_d_s() and
keyctl_pkey_verify() used to do before copying the input were themselves
unlocked reads of the method pointer.  Move them into the key->sem
critical section that keyctl_pkey_params_get_2() takes around
->asym_query(), after the buffer size validation, so that a key type
without the method still fails with -EOPNOTSUPP before memdup_user() and
with the same error precedence as before.  keyctl_pkey_params_get() no
longer looks at the type; its callers check ->asym_query() under key->sem
before they use it.

memdup_user() and copy_to_user() stay outside key->sem, as in
keyctl_read_key(), so no page fault is taken with key->sem held.  key->sem
is only taken for reading, so pkey operations and KEYCTL_READ on the same
key still run concurrently.  Writers such as KEYCTL_UPDATE,
KEYCTL_REVOKE and KEYCTL_SETPERM now wait for a pkey operation in
progress, as they already wait for ->read().  The in-tree ->asym_*()
methods do not take key->sem themselves.

Nothing else in the kernel calls these three methods, so the four call
sites below are the full coverage:

 - keyctl_pkey_query(): ->asym_query() for KEYCTL_PKEY_QUERY
 - keyctl_pkey_params_get_2(): ->asym_query() and the op-specific method
   check for KEYCTL_PKEY_ENCRYPT, _DECRYPT, _SIGN and _VERIFY
 - keyctl_pkey_e_d_s(): ->asym_eds_op() for KEYCTL_PKEY_ENCRYPT,
   _DECRYPT and _SIGN
 - keyctl_pkey_verify(): ->asym_verify_signature() for
   KEYCTL_PKEY_VERIFY

This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
("keys: Protect the read method check against type removal") and for
key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
against type removal").

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v6:
- Address the Sashiko review of v5: keyctl_pkey_params_get(),
  keyctl_pkey_e_d_s() and keyctl_pkey_verify() still read a ->asym_*()
  method pointer without key->sem in their early checks.  Those checks
  are gone.  The op-specific check now happens in
  keyctl_pkey_params_get_2(), in the same key->sem critical section that
  calls ->asym_query(), and after the buffer size validation, so a key
  type without the method still fails with -EOPNOTSUPP before
  memdup_user() and the error precedence is unchanged.
  keyctl_pkey_params_get() no longer looks at the key type at all; both
  of its callers check ->asym_query() under key->sem before using it.
- Drop the LLM paragraph from the commit message (Jarkko).

Tested on x86_64 under QEMU/KVM, with KASAN, lockdep and
DEBUG_ATOMIC_SLEEP, on 7.4-rc1 with and without this patch.  The
test-only key type module is not for merging.

  race_sign, race_verify: the module is unloaded while the keyctl waits
  in memdup_user() after the type check.  Without the patch: NULL call
  from keyctl_pkey_e_d_s() / keyctl_pkey_verify().  With the patch: both
  return -EOPNOTSUPP and delete_module() has returned first.

  inop: the module's ->asym_eds_op() sleeps in module text while the
  module is unloaded.  Without the patch: return into freed module text.
  With the patch: delete_module() returns only after the method has
  returned (about 3.0 s vs 3.1 s).

  func_asym, func_fake: KEYCTL_PKEY_QUERY, _ENCRYPT, _DECRYPT, _SIGN and
  _VERIFY on a real RSA-2048 asymmetric key and on the test type; the
  CASE lines are identical with and without the patch.

  errno: a type with ->asym_query() but no ->asym_verify_signature()
  returns -EOPNOTSUPP before reading the input; a request with an
  oversized length still returns -EINVAL first, as before.  The CASE
  lines are identical with and without the patch.

In the forced races lockdep can report "bad unlock balance" for
key->sem.  Its lock class is the type's lock_class, which lockdep drops
when the module is freed, so any key->sem user on a key whose type was
unregistered can hit this, e.g. keyctl_read_key().  KASAN reports
nothing.  Not tested on Turris hardware.

v5: https://lore.kernel.org/all/20261108131417.77287-1-0xbeac@gmail.com/
v4: https://lore.kernel.org/all/20261105193632.34363-1-0xbeac@gmail.com/
v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/
v1: https://lore.kernel.org/all/20261103032940.51826-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 103 ++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 27 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..5ac049b71a 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -100,9 +100,6 @@ static int keyctl_pkey_params_get(key_serial_t id,
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
 
-	if (!params->key->type->asym_query)
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -129,45 +126,77 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	down_read(&params->key->sem);
+
+	if (!params->key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
 	if (ret < 0)
-		return ret;
+		goto out_up_key_sem;
 
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		if (uparams.in_len  > info.max_dec_size ||
-		    uparams.out_len > info.max_enc_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_enc_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_enc_size;
 		break;
 	case KEYCTL_PKEY_DECRYPT:
 		if (uparams.in_len  > info.max_enc_size ||
-		    uparams.out_len > info.max_dec_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_dec_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_dec_size;
 		break;
 	case KEYCTL_PKEY_SIGN:
 		if (uparams.in_len  > info.max_data_size ||
-		    uparams.out_len > info.max_sig_size)
-			return -EINVAL;
+		    uparams.out_len > info.max_sig_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_sig_size;
 		break;
 	case KEYCTL_PKEY_VERIFY:
 		if (uparams.in_len  > info.max_data_size ||
-		    uparams.in2_len > info.max_sig_size)
-			return -EINVAL;
+		    uparams.in2_len > info.max_sig_size) {
+			ret = -EINVAL;
+			goto out_up_key_sem;
+		}
 
 		params->out_len = info.max_sig_size;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
 	}
 
 	params->in_len  = uparams.in_len;
-	return 0;
+
+	switch (op) {
+	case KEYCTL_PKEY_VERIFY:
+		if (!params->key->type->asym_verify_signature)
+			ret = -EOPNOTSUPP;
+		break;
+	case KEYCTL_PKEY_ENCRYPT:
+	case KEYCTL_PKEY_DECRYPT:
+	case KEYCTL_PKEY_SIGN:
+		if (!params->key->type->asym_eds_op)
+			ret = -EOPNOTSUPP;
+		break;
+	}
+
+out_up_key_sem:
+	up_read(&params->key->sem);
+	return ret;
 }
 
 /*
@@ -185,7 +214,16 @@ long keyctl_pkey_query(key_serial_t id,
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
 
@@ -230,10 +268,6 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_eds_op)
-		goto error_params;
-
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		params.op = kernel_pkey_encrypt;
@@ -260,7 +294,16 @@ long keyctl_pkey_e_d_s(int op,
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
 
@@ -305,31 +348,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
 				       &params);
 	if (ret < 0)
-		goto error_params;
-
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_verify_signature)
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

