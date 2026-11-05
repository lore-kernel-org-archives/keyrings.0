Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907398;
	b=zXec9mZ3/+9II41cCZcDoQoYfUC1BtyvGPitGGGY9F8B9YL9+arc2oHflHkB+KLcux4i
	 2YMulW6rEmMB7f2M7f6JcBUhzeA6V2k9BX1gk2W+ON05vjbLoqol0E03saxJAS6WThaOL
	 b2tsGI7S1Amb+DFqetB8giKyFfR7nuuMK67+0Eyr+eaIimc+lRWAOlhM9t9QaNYeJVjcg
	 5Fj61x2nbz0iOnJJnfreo+PDH+/no5kyUvUGqoujqqkStwsxgDGCr9rY0eqTRmtpj6CEr
	 HfqpnG/fpC82RfeCxabBCEPbYkMLzK1w/oPkMzfOZ7shu8GYJlYq5hgb/vT7mHCu1ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
	b=lN7G6LWiO7WjvQ3sMoW5sIcDgmS9tmtKSYteLSRpM9A1R5PBczl9VyILL1+J36GgNcbK
	 FfX7Bff1pm0qQWUVu2FLBLdCN7j0Tpc1r93QCqcasr93UladYiHx0SgzpnSf2xwI1dg0u
	 3pxtWzK8Dhka9b8m3AJQJQJajafiKeZvnCf1nhTV7dGJtVZ/g43QFsGxCZyK07rvqn0Hl
	 tW2a+DeeZMr/eqHzWFqsXPCI+xqigYQPZiqFqWK9CbwJgcwLXZIOD0yrMErGgkht957g3
	 K2Zq2SRVASfwma6Vq7O+arTG70vB2InlL3i3fj35ZDk3WF10bxLF4Gf1hoiAP51M6aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MrvVq/pA";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EE606A6F8
	for <keyrings@vger.kernel.org>; Thu,  5 Nov 2026 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387EE606A6F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrvVq/pA
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06210b29fso1252604b3a.1
        for <keyrings@vger.kernel.org>; Thu, 05 Nov 2026 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907397; x=1794512197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
        b=MrvVq/pAxeEpkWXJvxeD7gcR/Qrh87bKPPTXZNEO0tG57lXCu9eFrtFxefXkdMbQ+t
         +FiL/k3Ptej86tBsPDeoLoizkVTIBwROn8QWbNusVRS8R/bCWm9dd6AGcGB7ub/WtPGR
         UWy3DCVzTTXRt+1WOzTVq60M6NKtxfs+3JKFNAt/gZKsEsjG8TdLG+xv5InLaxogx2T5
         OmYwab8IEf/IYxJ3jC3/1u/celUFJj8e96sXYWLdq5SO7gk63YV8hC7JdeKci8xMXjEq
         4nI7GwwwC1aOwO/Mk+UIING/PbLJezKjiIG/tMhS17HnfXM8TKGnyuXPcUMKDSksixfU
         SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907397; x=1794512197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
        b=v6ahDsLt9jo1LUnc7PuyNlPfSIlMgS7vpUv9SmOL/jV5o7+sDUsvos2/0b5fvb7nzo
         m0CrMTO8Q6A0KvVn5K2zogIUn6mdOZO6ovt8Ndz6xCKC+bdHmP1ZeCiuUt9bc9Z0xlaZ
         fmGcgQT/EmDlPEvgezEUrcW2+BA6MbxXr9UCHqqAQZC3sYUBRNZ1f3OoX+2n9XlqXtJY
         DnAMmddAe0E5COkVmOCMarEoFpN642DhIMKtzvH1Rq0qYp1puKkCcykJ9ppXHeidEr6n
         Kjp+y5PprdyyBp6TsBlrCZUhCQRxyqyN4UVc+AyWT9Hgf2UwdTwyEVeqF8fCnDnlDIs1
         x8ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwkq+Z3uugRMqNpDwUXJ/jT4RHsxJKzWZ3fGP28hEX+KOHdcUG6RR8o70rRBHhZCwh0/ku6GnQaMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PnN2FUofCf9jGuVrsddYiF04WmnXVEuu4ojDqtPV8knbxjgSP
	5jC/Z1PzrgBHHOVVzynzv0tfm5xZYaunCPTuLI0DDdJ820Pz9M+KUpB8
X-Gm-Gg: AYBFou0xqCVMLxuJ2FW9z8UoeFf0cYc78qibzG/UlhBo19K6jiXPDdl2TGYLFgM8GqF
	3LEe847VV4EJPD1o5FMBAMVW3FWx+LI045yobZzm7Ln16bVnP8EkTkLibrXEivPcWDmW6aLMofh
	NIFRXNg/Q9a1wHGP57Vw4vdQjwExPS2/7f5TL8mJT2pLTjG7PZtnaNSrwZOPlMPHQVB5WfzH2nP
	YZBqrpoSxwdasjYqC0wzfPqInU31uVWidbpUzxtfemr6OZ8XPp7VL/4wvkb2zin/Vzvwtgqy+bK
	RP5HY97BNBTOOsQtEVrUl7cyv/C3HTM4B04TqRzkiYa0Vr/jXulxUiANWTgwnS3uTGlOoyRjrwm
	Cc638HFSvY5nxqkz+NYyR3F+dNn3njGATLjXois0oRKlXy4SspcWCK3L7Lxb63XJONMUDkg+oHs
	dXOWSXaSNx88/XH0KVzX443wB4b3K7RwMCOuoFn1dbEGXjoyFhwuV7mQQYYXXo2krshBXXmolGu
	Cdn2cWLSCNwSDsYZLu9b4Yqb8B5l7Ni2sRjN+ffOtT5samqtCb4mm2vxdAkSdMl3Dp7i7d6Uwby
	KAfhdXMTXsjZuM2D14VxDClK1f1hDRMYzi1sNYZa8PcuD1JQ
X-Received: by 2002:a17:90b:448f:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3b0db69ee38mr32308a91.14.1793907397392;
        Thu, 05 Nov 2026 11:36:37 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42932sm499331a91.6.2026.11.05.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:36:37 -0800 (PST)
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
Subject: [PATCH v4] KEYS: Protect pkey method checks against type removal
Date: Fri,  6 Nov 2026 03:36:31 +0800
Message-ID: <20261105193632.34363-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auy1ANMSKTXZb8GE@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org>
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

keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
key->type->asym_* outside key->sem.  A reference keeps the key alive, but
does not pin the module providing its type.

unregister_key_type() calls key_gc_keytype(), which retypes every
remaining key of the type to key_type_dead under key->sem for writing.
The pkey paths read key->type again after their checks, so a concurrent
module unload can turn the checked callback into the NULL key_type_dead
member and call through a NULL function pointer, e.g.:

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

In-tree, turris-signing-key provides such methods.

Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
runs without key->sem, so key_gc_keytype() can retype the key right after
it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
reading, check the key->type->asym_* method they are about to call, call
it and release key->sem.  As key_gc_keytype() takes key->sem for writing
before it retypes the key, key->type cannot change between the check and
the call.  Drop the asym_eds_op and asym_verify_signature checks that
keyctl_pkey_e_d_s() and keyctl_pkey_verify() did before memdup_user() for
the same reason; -EOPNOTSUPP is now returned from under key->sem.
memdup_user(), kmalloc() and copy_to_user() stay outside key->sem, as in
__keyctl_read_key().

This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
("keys: Protect the read method check against type removal") and for
key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
against type removal").

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v4:
- Rewrite the commit message: describe what changes in
  keyctl_pkey_params_get(), keyctl_pkey_params_get_2() and the three
  keyctl handlers and why, and cite the read/update fixes by subject.
- Rename the out_unlock labels to out_up_key_sem.
- Use out_up_key_sem / out_free_in / out_free_params in
  keyctl_pkey_verify(); leave the other functions' existing labels alone.
- No functional change relative to v3.

v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..3e3253330c 100644
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
 
@@ -129,7 +126,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
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
 
@@ -185,7 +191,16 @@ long keyctl_pkey_query(key_serial_t id,
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
 
@@ -230,10 +245,6 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_eds_op)
-		goto error_params;
-
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		params.op = kernel_pkey_encrypt;
@@ -260,7 +271,16 @@ long keyctl_pkey_e_d_s(int op,
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
 
@@ -305,31 +325,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
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

