Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676588;
	b=gWsPG46t6gc8+WKKs+qORZRrab+p1vUjax7idZ7nybknRXTlm5XR4FmH6Xje25aRBioJ
	 OMcf2GGwR3SxzqeSluMeIC5llteeNet8lns/5gKJ2SIZUO/CL76m2tk+WvynMK6NykYZv
	 ZJgD5PsSNBlwQSpNAjhsrJg3+j+dxWWctpTxAxZ+Cst0cpmG4rny+z9iyemd0qwT+2RYd
	 NwJekHytGo8bFSTBUWX1BCindqA1WyUFAaNgwawBDic2eFx+XIUhgdEwpptQiJjjCoQGk
	 L9iBJUbPnqVH5a/gJkRXaSPx3bLHveyOEKJY80l7Wn2t0T619Uds/iOO4q5lvDKqpVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
	b=RPgtumWmOxAmpvFjUMJ3NKh1Phgiw7gXtBMud1KcxtaPgV1oFsixudSLVCHhkrFNklGl
	 l4hgEpu4P4FNvIhm6F8/KAcTxiO7N17YRqeUYbBs7gYm1auFST01ER90mxsVzvQm+lSfi
	 EI4EzjimKcq44B6B5tVXoLrNXlBfKxahLNDeuI8affW7oj62EYcU8VjjwEm5SFEgJZQUu
	 FUMETm0/4vAUTs9PhziDoQm0lo93CxsNsiKEGzXCLyGQ/5vmjpg26cmfoPAh1aLAy1/Cq
	 e52Uf/9U9dnJ22MYiSm3iX3+x5FR5riqwEFSK3/8ciTFBcZgWn98Kj8hRt28AnFB2FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMWhhZqm;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5196606A327
	for <keyrings@vger.kernel.org>; Tue,  3 Nov 2026 03:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5196606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMWhhZqm
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e5fb79ce82so24230985ad.0
        for <keyrings@vger.kernel.org>; Mon, 02 Nov 2026 19:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676587; x=1794281387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
        b=AMWhhZqmR9TIixkMWH2d0/BwYbLF9qPxWAXEhyiHO0dl08UPkkEwn0TtRUjxhKaVlk
         MyQmbcDYkioBdJ6E80jsPgMZJN5E8Xl1u4bP6ieiuCXyoQgRoftMj7BrLkQTGb0EU00j
         m62A/BdB/rS2zyz3voYU5ZBko+EjPFc8q4igOgLoS5gnnNSrAnEBajB4Y4u0zRIeShXX
         IbOPx7YD1GF+6QCl7LT7mAS55Dp+ZqvFa/aPxCxjBUi9Jms/ET7Xvozb1hNLXDqUDXFk
         U8zzcNfmayibIlOmv7uafT3IPx4cUp8mhMtQvWsXjH8EPNzCOvVlTjvvobfTKXAVZoab
         edwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676587; x=1794281387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
        b=cLaycV8hRE3+eMX+U6/y2Tdt+h7CDh67u/Jh6a9ugVM7bNCGIQtXrCqL8K5mA8IgUc
         hfMsL3KfFjkzqJFOhSfv8MAny4s7Xbw/XYerOuYa4LPLgabnd8C12wDDZWSfpTwOOfr1
         9l6Dtgvg0XMeT8+JrX8vXQAs7G58+P7jnL91VdsvkgP0D8qa7+BM67vfLuUsfImaMgUp
         0JcjNkT9DXPlCS1x2Y9hdnymLuf9Om21rlyaF3JYQT7WwT24eiON++vUK39CZE8y7TMN
         eECaF6W2C/Jmje2rqLMVmYAe+FFlsVOgatQYrp1TtlzrBJ8VaQCC4TIJjMlT78HWtkiT
         bUeA==
X-Gm-Message-State: APuU4Z8JUKivCPp9jN2VfpvRMg/dGUWUFcEAgasC/7IDud+WttMFKGra
	wgxE53IQdEkIRL4FmMKguMOM2UYet25FF/S4nsB4rH55qYCtrvwr+Xvv
X-Gm-Gg: AYBFou2xTi9aN//OOMBiIZ9zdDmmdS1t+J+2Cjd/oyzacR+vM0KX9sQlQsIn/Ywz7eZ
	PR4bt0xpWGQiYrfm6C4HqqW1G0KjBpUTylEq5H/2dEaKgiYauMiDiQBXQy3bGGf+32etrcxYpI5
	6oZ+DhwDfHBwPABBM/Ymmy2pDMa4HhHAFbDoVjqrdWbtefBGIH46XSzBBLFksuzSHHxS8Zu5CEW
	taTJZ8Cw59FlWp5PmJPDIyENVKfF+nu9l0w2Y588AAz9X9etYZo2GDyUDKSRgITQJ5IUKrVTF71
	3gQYJW3x0JL131+G+Ie1OdJw5NEl70E4OPHdXh0weJ0dl8i/BO81piLHF+lWY/w7pcblsISWI4z
	JPlwWGuwkTwB289HQtSoCQfc58MgOvS0ZOgWgBv2S9yglvBRBQ4p3QzxqcdpWJaK+NQCgOxbvTZ
	YKXV8a1pnyeWH5LgWopZsHD7Pha3fgpuGetdb9hIDNT96pDf0xfkaCXDMoyhhO3ObdiEqtkZLL5
	rMH6bdkcV/PvwHoJBlArRWES5Wz1ZsxhB76jA0eIPvRxRnKGURuQR/H/VJnG51Q/nPFgPuWRjg1
	fqIu8+fpW8U8nhZeTxu1JCIZQw8qmtw5sI4iKH7OGldyIEN8iv+r4tAXn1k5SQNn9g3t
X-Received: by 2002:a17:902:e5d2:b0:2e7:e73e:7091 with SMTP id d9443c01a7336-2eb364bcec2mr126948885ad.31.1793676587056;
        Mon, 02 Nov 2026 19:29:47 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928104asm33984555ad.53.2026.11.02.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:29:46 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: Protect pkey method checks against type removal
Date: Tue,  3 Nov 2026 11:29:40 +0800
Message-ID: <20261103032940.51826-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In-tree, turris-signing-key provides such methods; out-of-tree asymmetric
key types are affected as well.

Hold key->sem for reading from the lookup until the parameter block is
freed, so the type cannot be retired between the method check and the
matching call.

This is the same type-removal problem recently fixed for the read
(925c84e3cc21) and update (aef3a8a4f988) methods.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 security/keys/keyctl_pkey.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6..b7e3648 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -17,7 +17,10 @@
 static void keyctl_pkey_params_free(struct kernel_pkey_params *params)
 {
 	kfree(params->info);
-	key_put(params->key);
+	if (params->key) {
+		up_read(&params->key->sem);
+		key_put(params->key);
+	}
 }
 
 enum {
@@ -100,6 +103,7 @@ static int keyctl_pkey_params_get(key_serial_t id,
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
 
+	down_read(&params->key->sem);
 	if (!params->key->type->asym_query)
 		return -EOPNOTSUPP;
 
