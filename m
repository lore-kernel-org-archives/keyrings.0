Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421850;
	b=d7gcUH85I78TM2wu9Ebi5RRI6qJFN9mgGIGmqCqhdDqG5lIz4EI4wPG+NSq0pltIYPlw
	 Q+u+Rr8iiuN1jjLLutoD0Ul5NpppYpVLHAYZow9yvJcQqz+/ZsWnNhZL5b70QB0eGj8hR
	 mIaxHRmaEyFasxRa5LwQxX0oPTF5nTy85s5VHHSk/PQwIZmC22Z0ssFbd9MJjk65RULdC
	 gq6bRFkMTgp+4cMuGMdkVuso1B0rrq3ksFzMelBpGbYm8PtJLiFbIGtelaMXu8R62AcB5
	 JzI3Pp37nA5WLG9GZUVaRF7f+oaVCD1qR326V+3roeDJoOQC+GU97qcxnThlfR9rfzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421850;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=M3PcnN3aKQnlUzuhBU8dosYVkkzA4/AToXSbAxao4Cg=;
	b=I7qikE/2kzPy4ZLcvq2iWcoMKqFmj7U1zbrzPrRBWtxB6as34cDZ6ZLDrq91VzKB7Trz
	 x4VACcZeDb74XzZMMBkg3z/l8UDyPg8glCKNuPQSkzX/i9i7wwtqqgNKBKTOHPAUcZM/5
	 u+CqfDQKCjpaiqBlxbmHjfamSLtVmKPkt/iFbY50B3iuR5VMt7kNtQhbpHmqXAoVtY6mN
	 ENLc5SCoe2IpQ3ZpI80ZSbmzyrZ1rMK7P4mm1pLqENeyIgCHVLZMY6bz+JAGZ88vrkMhv
	 uAu58/Yovex+DVdyMlzGjbEWDKoFEv9uW7/1cwD6E2THZ+w2oRqSm0kMCY0nFjhP4Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6LEr8Y5;
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DA60740AF
	for <keyrings.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6LEr8Y5
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488946513FF
	for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421850; cv=none; b=diuCbYhxPbeKLVQ5kH2Ztc+/ZnDQaa0cTCkv6yRb5CpR20pVgmYES5lwjxoHRDSYI4W/kXbCHAFVR2GQtidKaTDbLThLCz45jC6iC47+ZYBaXCBWvRGqXh2lCP/PTA4z8XuS57P9Nok7LkZB/ZGx40yhLpB4LCoX3OdkfGgDCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421850; c=relaxed/simple;
	bh=UXrNDgNR3QTsl2j+GxmdN0HiJ3fQsoooaDnPJ7vbFso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E24kWOeNNY2L1GW8xHKrl0WgbOMoxIU2Sav0GaoK5uLMGzmUsT+sOkVMvED0L+1a7xkVkr/ruMg7bbx4JNI1B5HEmpkk/TQesSJVEqz8OFq7Rd3q7UJCdglZ6gzDMxnykekZ7VYquBuPazH8cukeQdcxyVKnNFZJtSVZwH4t1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6LEr8Y5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso322367b3a.2
        for <keyrings@vger.kernel.org>; Mon, 19 Oct 2026 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421849; x=1793026649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3PcnN3aKQnlUzuhBU8dosYVkkzA4/AToXSbAxao4Cg=;
        b=E6LEr8Y5Kg2fXeP2nlPF3U7B0wZx2u75WLmFzUTZWMclb0XLuMfgaPUpumZ0nDWcfP
         ahoYtVu3zhM31RC2xGTem9im3XVFMSziW0xnv1P9Nu3RX8+xJwVuWPqyyI3QCLMhh6Su
         KVGQ759PrKiVIqWTQ5CIDzCIfcoPOzs1Hw7ZURuOn367urWGrdpGTZpWXYwH3rzom3gf
         mHJCUVz9+ymm0caUsGGTSWNZR6J15r7iGc1sRLnV2J22kU7OT8L7KFP1334TajEB8Kb9
         m1QAqnLHLaOWfkOYfoytCf2gV3yea3S/Ft9RqM71ga8gfggAYgiFL9g8fSC71QxnEdaQ
         xDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421849; x=1793026649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3PcnN3aKQnlUzuhBU8dosYVkkzA4/AToXSbAxao4Cg=;
        b=oRBomA/MxszcHkKsxZZMfCkkqzQqf0fjY+QKrZ8RW6WetDH+vY6uW+iNF+/kSBIMug
         IVCu84bO81p+FlQpw7y1rDAyldMxS2rPmUGmBZxZbARkoCI7l8xmfN/PZRdm3qkz+8aK
         0BXZjRK3hKShAhceH/XfIPr1nUwzlwfqcsbQZVj95qLTB7ue5bHR3qtpjwt9Yatb4l0P
         Zj/58kdPF5lNTbXRzp1WLONIjTnXDuasthRq6QI0SDJLupJSs07gzZC5fYr1dX27gx6f
         BExrI0HgrMiGtxn7dZbRVUELBAfr5c9d4n3swnMEyo64Qn+QfTSWvkmWBujO08B1pKJj
         9HVQ==
X-Gm-Message-State: AFq9FYJ6r6JQxDuYm8aeq7DUMHInuKpWpf7O5ZRfKhuHmm5K/i7+rV2p
	7O6gMJjpkECGxfAjg99G+1GcURR79yKQaJvIegoJrp5l4Vj0oI8AAMXr
X-Gm-Gg: AYBFou2yIQWx2axc05G6TLv6oG+f7LUBXDurQGuHyM0TTbsKvoOnb/IoqL1FeIRmu4y
	UMwlvbSoSoEpJ2WQEFuV2DUp/uUDOMSLt+ydy3s9pgbLGO1ubH2DT7bY4HcQrPhJ/7qz3s0aDMs
	fDSw/UbbTjSfFzcVXpRtUn+VgYzOhUwCJcrrpA29B4PWyrA3Vjz3S8NFO86xtLJuYFM/tcay2wy
	lTcXmPXMwv7T5Udw0vc8NHMWwfGrHl0PP3SeDtaX4c8hdqvvc/axHgS2DlTjT/ZwfqG9oiZfJDg
	9r2xH80sxIMy9N356dHxkJ8PRuS8CktBiZuzTmR8m+/zq6mhOvCi3/H8mkzDC2HbF9xhZ//PXXF
	6wIs2D6nKPPmhznxtvIIkaTX808Is3Hmr0mqKiH3BtZa1+qeEK1hlLgyeBaGWOhtd9B7n65UBt3
	FVkoucjHyYsY7MjyNuzKyoB7f6XFszOTzW2Zovrwg1Cotq6nPGrRBDrbA3Bkav6gcgtg==
X-Received: by 2002:a05:6a00:4acd:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8a04ce2f07fmr6548575b3a.37.1792421848612;
        Mon, 19 Oct 2026 07:57:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e508sm4143469b3a.28.2026.10.19.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:57:28 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] keys: Protect the read method check against type removal
Date: Mon, 19 Oct 2026 22:57:21 +0800
Message-Id: <pm-key-management-objects-candidate-0010-v7-fc85721ff5cfb9e33ac6@gmail.com>
X-Mailer: git-send-email 2.34.1
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

keyctl_read_key() checks key->type->read without holding key->sem.
A reference keeps the key alive, but does not pin the module containing
its type. A surviving RxRPC key can therefore be read while AF_RXRPC
is being unloaded:

  KEYCTL_READ task                    Module unload and key GC
  ----------------                   ------------------------
  lookup_user_key()
  permission / possession checks
  load key->type
                                     af_rxrpc_exit()
                                       unregister_key_type()
                                         GC: down_write(key->sem)
                                         GC: retype to key_type_dead
                                         GC: up_write(key->sem)
                                       unregister_key_type() returns
                                     free_module()
  read saved type's read member

The final access can read freed module storage. The read invocation in
__keyctl_read_key() is already protected by key->sem, but the earlier
method check is outside that critical section.

Move the method check into __keyctl_read_key(), after key_validate() and
under its existing read hold on key->sem. The check and invocation then
use the same protected type for length queries and every read retry.
The GC cannot retype the key until the semaphore is released, and type
unregistration waits for that GC pass before the module can be freed.

Return -EOPNOTSUPP when validation succeeds and the type has no read
method. A temporary buffer may now be allocated before this result;
allocation and copying to userspace remain outside the semaphore.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v2:
- Move the method check into __keyctl_read_key() under its existing read
  hold on key->sem and remove the outer check.
- Perform key validation before checking and invoking the read method.

Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com

 security/keys/keyctl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 5a5efa26ed0e..36ffba0ebba6 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -808,8 +808,12 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
 
 	down_read(&key->sem);
 	ret = key_validate(key);
-	if (ret == 0)
-		ret = key->type->read(key, buffer, buflen);
+	if (ret == 0) {
+		if (key->type->read)
+			ret = key->type->read(key, buffer, buflen);
+		else
+			ret = -EOPNOTSUPP;
+	}
 	up_read(&key->sem);
 	return ret;
 }
@@ -863,11 +867,6 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
-	if (!key->type->read) {
-		ret = -EOPNOTSUPP;
-		goto key_put_out;
-	}
-
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
 		ret = __keyctl_read_key(key, NULL, 0);

base-commit: 89f5f41d296889f3b896c3ca67fcdf7d42bbdf10
-- 
2.43.0
