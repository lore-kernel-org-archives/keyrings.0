Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94483B42DC
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483486; cv=pass; b=FeJFwqgq8w2V1N37PIM9T+Ml3xvus+RYJ0zJ/WNjAWeVxumXJN+pazyZXRfpkujq5wJJbzr+nE24BSsAgvZWYaXJKg9NJLrlelkIvRd++MYkToD19lp57CpH4wLXu04w3BHMUCjk/lHc7/DfPZc0mFn2sd4LTMn7qayAOIHs3gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483486; c=relaxed/simple;
	bh=+41a4tL7rmy8uEnlxaX7O6RIzsuBIdtZXxzVbeVDLW8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=CfpO84HLuINuamif8/VOaPiT79GSPUF/1L5OVHQoHud3hxUm69PbpcVCTSG/d08hvEo2WykhGaLmZA3z2sA+qFcN+2N0KtyN4LcvJdhjxX8Kis/8LGwc8LWQ+/i7PWm/H+cWxFM0OAb2IW0icVDoBfWjZvLRXY23rvjB6BJDuxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXepuvMe; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXepuvMe"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b19e291cc6so2806803eaf.2
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 11:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483484; cv=none;
        d=google.com; s=arc-20260327;
        b=EaD3V7YWbe0YPPPjYT891hQOQV4x1pRAN2T6d8YPomzXCYiu0jkGp5+WHinb7HMzfY
         CWke1GtHziY36FWJz2AG3pRm99psomEGc8WHdG4JYU+jq6wp87Rlz6F1ANBQVYrLSV1X
         JGWmHrRmKr0Jzmh85Zjv+e8Y6F0lz4DJmARLHVSBWkjjPcD4nHHVWdT7jYJLt09DgF7V
         s+laGHw2kD8ziKMyOEQzVupM9S4TafFTWXln4r4R5kuoReLzrzET0cInbCP2eNC8v5j1
         dQddI0o+Vu1+nLpgC917fivI1hfZYRwV1NMSXRWdW8vkzoY5hBNjv5ZQukys/RHzu8+a
         Hm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:dkim-signature;
        bh=oHPyJzRaQSbv83TUFxBBmSfU/l/8PyBXMjzEMcpYZTs=;
        fh=c5XDIN3DuibLQY/ANT9mKKJq92UbeDeIB/WmlVRRHgk=;
        b=MnBP08TOUm8lUgitKDgSJeyvAXh7JDr+elJV+CGoU3y9YdTsowlv3o9poY5Mpugw/m
         09omdAqHTwQcAe2fGD8QLcHHlOSFm1ARC/N0RSreGLqxFfGDcRz1hPgoQOe+q6J58qyi
         MRkgqCP28oKEF3fGcXqwNfTneBJ4DJf95yi5k4a6CVzzxai9KBfIZEVpuGT6QLWqbrzw
         iqnB1DEmdE0LVhoO77gLpZYYG4ZZaiAs0c34p/KIX/FGd1Q8c5Mt8GMZTTGi//oDbA4V
         QY7J1Q/hr/rnNm5yLwSMRmTCtp84NlyN70DKrXfiOFH+GqNT347bH3pDbhomRbvYWTtu
         0Kzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483484; x=1792088284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHPyJzRaQSbv83TUFxBBmSfU/l/8PyBXMjzEMcpYZTs=;
        b=GXepuvMeskWA4LIciwNklp/gFg3uG3oDl/rVbCCAtwTF837w5IkdH5nJNAryhvMeqr
         cuDWTgtyQuhDoqyFvhdga2l7HcrrSJEGRW1WH7uwRTdgLY5RfwgJYJPq3oM22IiKw+F6
         VSKaQqLuvnjpBQVbyadLTJz4tadfmk8CFeZrTgP+lDXgy9m8QjJmg63O1uI3f1s12OI4
         KQVZZXa2jZRLYB5swOdArceAiqsEDbf96TDi72CZ7/QTln6N5fWc2PJFwMB0jlfpljDu
         mlIQ8QO7d8HHGX7PxbUX9j52qG2cF7sKop7KFFOP1PfQ3Xco8sT6jdbdUdUpVUsXwMnY
         jlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483484; x=1792088284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oHPyJzRaQSbv83TUFxBBmSfU/l/8PyBXMjzEMcpYZTs=;
        b=ftUBbUkVF47SE8ZteDs2oh/Z5Bxz8T5YdUwDiwZV5eXyulVr/vgmGT9kFdy5Zfm7Bc
         P6nF54Bg2RHimms6CDY47/NU2goaHbEUvVEIoui06MOASy7R2ha6lzvASlDwX4KGHel9
         ELAHWvJ7WOQ8f1sk69VPtp7TcQuM2hnSAOTJF1Rm3cJDv2hCQpqYRo7lmPG07wyRsbXh
         x/RpQqu18d9XpuwxodTneK79RkDzj1/Kin5q41MLXDtC2Fgzy+skDq9g4rpHSf9OhoSk
         1prszL1cLijKR4MB/93tqktJyFQl2l2LUQa9aqFHL04qW1h6+qMMVO9ROQlAZNvSs4CW
         tTxg==
X-Gm-Message-State: AFuF++kCmcwqbC9cYMSlyo9w5vWmWs+D8pVbcpYnMu1RYwoO6iDLa1oW
	6aKML5PYmH68n0f8p/vw05YBPtLeoDpFgWSNYye3i/NQxyAnPDqw6kN+JBJo5sjiyMHXVGIIaWP
	yimEiYD7OPKdPiGL+2DWxLCriY3VVb8ctDvFGdkw=
X-Gm-Gg: AYBFou23qWwwmzcT7ppNZlBzhfdKd3YpvgaAuMkX27K5xfXdOFdvoXEAKzfT0TDOkql
	4FAFMbnccz5IlKHIUMBbB5duCQFcBahe4ynNpHZ2T/oes9kkfiiKsgHBTxwUxtf6UjxEEtnwCob
	nM+oKwKfooSJFj/lJZ6LJu7ya6GyDoVk4ipXwDVgG3CiFFte0Jr68Pz9BkC7C266cAKbZ6YXOMT
	LuU6aVcLq5V8xfXQoD/8//OczhlQMpFAwP+nyZ3/Fo8PKsxFpejfuXnbJV8qYivAxk24bjj4EJ7
	8N215yg/D7av6kEzp7oN5mNOQj5s8BIn/ZCmjQ4cgvO/IKBbuMTRCvehfCHSibJ4grN0xu2zNbm
	R19at2phcXSqTnKOEHcqoTSo7SfktJgOPXUF47gfAApowpehv3xbV57Wa
X-Received: by 2002:a05:6820:2084:b0:6e0:e81:e5e3 with SMTP id
 006d021491bc7-6e7a7e3148cmr6456190eaf.33.1791483484475; Thu, 08 Oct 2026
 11:18:04 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 11:18:02 -0700
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 11:18:02 -0700
From: adrimg3196@gmail.com
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Oct 2026 11:18:02 -0700
X-Gm-Features: AclHuK_7AdH4Yory6sLd1VtAgff9c8q80qhbw3Iv3U6cvMK2ds-zddzKV9dQhLA
Message-ID: <CACO1+RQ5KXAAbjpiQ=cs0wLZ=z+=JQbW_-pgG+BM0f23W112Tg@mail.gmail.com>
Subject: [PATCH v2] KEYS: Fix key_reject_and_link() race with keyring restriction
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, jarkko@kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jarkko, you're right =E2=80=94 v1 arrived without the diff. Here's v2 with =
the
full patch.

The restrict_link check in key_reject_and_link() is done before taking
the keyring semaphore, racing with a concurrent keyring_restrict()
that installs the restriction while holding the semaphore in write
mode.

This is the same pattern that commit dd3ea3fc ("KEYS: Fix add_key()
race with keyring restriction") just fixed in __key_create_or_update()
by moving the restrict_link snapshot to after the semaphore is taken.

Move the check under __key_link_lock() so a restriction installed
concurrently cannot be bypassed when linking a negative key.

Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
---
 security/keys/key.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -588,10 +588,17 @@ int key_reject_and_link(struct key *key,
 	ret =3D -EBUSY;

 	if (keyring) {
-		if (keyring->restrict_link)
-			return -EPERM;
-
 		link_ret =3D __key_link_lock(keyring, &key->index_key);
 		if (link_ret =3D=3D 0) {
+			/*
+			 * Check the restriction under the keyring semaphore.
+			 * keyring_restrict() installs it while holding the
+			 * semaphore, so testing it beforehand races with a
+			 * concurrent restriction install (cf. the fix for
+			 * __key_create_or_update()).
+			 */
+			if (keyring->restrict_link) {
+				__key_link_end(keyring, &key->index_key, edit);
+				return -EPERM;
+			}
 			link_ret =3D __key_link_begin(keyring, &key->index_key, &edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
