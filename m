Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452893;
	b=4Up+2Vx59jWCbv3kWL5gp/r91ycBBLrIjdpgVbnt4EbHbBVrtsmTPS5+TlPXIGSDEOXP
	 /l9smj+Zq3/xYARU+V6E+2g1LmomvoX4UyNMzRXjHjqGdrv4uxipHWp1Mju3U0B1Nm9Ux
	 jsA2a5/WPk7uDASJnnHwketKHY1BdZuQAPXSvtp/y4S0hkTybKHu6g9g/qtWVenFoKz+C
	 Ay1Q7ZJzW4GeM8OKq4dAlo+9hEbtso1/IOf6waXubKYfYJaAsi4i0/NJSKcFtrejvmuEI
	 IrLP5Pe1JWdoimZ2E08pCUgfbAB/fC2dkL/s+ac2iIv0+YTlZVx6sp3ZPPfKirgS1PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
	b=DcOzFB2Zk+uxVnhCTrF919TbpGKFs1L0Jok112E3BQjxBbICxxaOidLiZ//RGOI0ernM
	 85sze5mmnZ1gfCtupBPg86euOwkdUx8gh1HNoXN6L27olEkPUi7VWOAtC+BzEWymeBG6H
	 xczHxb8iEc61RwRgaGykdBHGoZI2//TE9LlvZNgx31g2Qu4gNUV4XA5wo+xpeiskh9v2Q
	 NC/7aax9scuYJ3K9CZGSNH4qma5713K3YHNjyTVCbDqvEud8FmseGTx5fIskbsr/4HQkN
	 ewJ8ZnpJ3pust8cubwTxgsbB6d1j52BSv+h3NWBNJ+Qcz4+LzuLodVOYEo5qkHVvR3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRVc6dku;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAF606A321
	for <keyrings@vger.kernel.org>; Mon, 23 Nov 2026 16:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCAF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRVc6dku
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3d125637aso690807a91.0
        for <keyrings@vger.kernel.org>; Mon, 23 Nov 2026 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452892; x=1796057692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
        b=jRVc6dkuxiaILyjn3zOynVacIqXrH5QflVYpsKlNkgLk3UCKb2sQuPbdHJSGwdnSMi
         kFftJfIPGhAT6oU++QqxP8GeB1r/3QJObdGm+O6P0UtASqHZEpBDeRfuMEwV3BWyen8g
         tTC77mh+gIBKILgyqXc7uLa38W6OPscd3VDlBHgAhGUv8Z+niJanDUvXsE48gBjTz3F7
         GvIKu2o6tYJXvCRpTZTPMLI6tuEwcbARUc3QgkuRpBBsHXsWHEphwUj5ERWnaBMLwtIo
         eRcI2BZR97JZubIEUIIMkcX8hCHuvclMhyt7bIxxs0GnOQwHaB86kApjpWye0UOqnSSs
         k3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452892; x=1796057692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
        b=WIHU5jpIj3AMsgJJFYwOmwRyFq2NWChJpxHbnk096cMFcvYvMIwFs0tjo/BIuYLUOb
         mf0ehAar09ZULdWL6myGDBYX0+7GOXl1MeICoJ07Bt0fLxxTxLG7XI3bVpEbW7VEW0CE
         GW6yeLmf7Qh26arBt01iQPTpIhbZhl3CUKtQiUapumtA/naVUgn0NhQuCJxgRNi45LMD
         IKcbSqP1a4FglCAfryPNVCE9MCXawAjgsCjXxkjeoJ34vvXlIyv+S0iQmu8sGO2f/Ykk
         8Lf0vwPkFBbY/Nxtq9EFKQB92Y2fJqtJ6e25l/bRn2hv9qGVxVVWGWSbO6vNbRfB2A9T
         jSfA==
X-Gm-Message-State: APuU4Z/f1leEmQ9Q80L0Sc2iJ1+yzypXumUS2tbry2ZEm8XNqfMU57Vi
	H+rPHM57lxUtOKykD0lZXs+YqWPe+EuBmxMIyTFZIrucm8A0QmIQAxG5hPlctS2JUNluhA==
X-Gm-Gg: AZFdTZeXrOjgsaLb2DdsJr/Tdhs0PjyUruqnuY2CRtEIZlxoRSm3QYjH56Rlw2BlQfH
	BwZKLzOZLK0orUXKkFhX+6AdLtAhPlCJUy7sVWRqFWvW36uVbz+gfHVxG9qp1jnNRDzst5CHlnu
	HY5Hx4u9K8HTHGgJT19k6DPkUHny7yoVTAc3ZEiWjJBUOve90o8tqvWIryr3dRwfIraorvSp8v9
	PdFmu7mYDk4iFWsCa8ywOYg6T2HFiCmyDeDJPuX4ooRy6Xo6JoRCoXPSiI+kGN/kIqGCxMmLHA2
	St5AO0Ijcwf77WorIvR30fIzKSmNYHwwfSGciOfxdz359ZAi5kf4A93WWe1GgWDp1vagi0jZeGA
	F7a1/FULpUwnULVUWVoLSL5nkYY2ggvR4J+rO8yYIKXT7tr436xBZNBq7sSTJuNxhIbutOBg7l6
	8FgyrsnArdcXYPvWg9y94wqyMrDKbCwYwW8KOhrSCFv1q281dLWhRDaIvgsggNmP0zVFEvC49c7
	wRlsJ6VYMPcyumhGMEamdfABzJd7iR6Zok43z0H5t193BuhBmA+HeTcMM3jP8iBLUkS1D8SY8I2
	Xxv1RUCIt4LJQiDvccJ2eOPIqvfiOaq0bsme9xI3n+1zxcU5ZHGz3QIwJapCuWlfHaHkQ1O47ew
	=
X-Received: by 2002:a17:90b:4a48:b0:3b3:b5b4:e4a9 with SMTP id 98e67ed59e1d1-3b41c7ac07amr11177322a91.3.1795452892153;
        Mon, 23 Nov 2026 08:54:52 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm7976358a91.3.2026.11.23.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:54:51 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Jason@zx2c4.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 00:54:43 +0800
Message-ID: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

big_key_update() destroys the old payload with big_key_destroy() before
calling generic_key_instantiate(), which can fail.  The destroy drops the
payload's path and data but keeps payload->length.  If instantiate fails,
e.g. with -EDQUOT when a concurrent allocation grabs the quota freed by
the destroy, the key stays positive with a gutted payload and a stale
length.

A later KEYCTL_READ on such a key follows the stale length.  For a
file-backed payload it hits BUG_ON(!path->mnt) in dentry_open().  For a
buffer-backed one it memcpy()s from a NULL payload->data.  KEYCTL_REVOKE
passes the NULL path to vfs_truncate().  All of these crash the kernel,
e.g. on mainline v7.4-rc4:

kernel BUG at fs/open.c:1145!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:dentry_open+0x7b/0x90
 big_key_read+0x141/0x280

Fix the ordering: instantiate the new payload first and destroy the old
one only on success.  There is no need to release the old quota first:
a big_key payload always reserves a fixed 16 bytes, which was already
charged when the key was instantiated, so the instantiate of a positive
key leaves the reservation unchanged and cannot fail.  Releasing it
first was what allowed a concurrent allocation to take the quota and
make the instantiate fail after the payload had been destroyed.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/keys/big_key.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..3bf371f6c28d3 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,16 +193,31 @@ void big_key_destroy(struct key *key)
  */
 int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
+	struct big_key_payload old = { };
+	bool positive = key_is_positive(key);
 	int ret;
 
-	ret = key_payload_reserve(key, prep->datalen);
+	if (positive)
+		old = *to_big_key_payload(key->payload);
+
+	/*
+	 * The quota for a big_key payload is a fixed 16 bytes that was
+	 * already reserved when the key was instantiated, so the instantiate
+	 * below does not change the reservation of a positive key.  Do not
+	 * release it first: a concurrent allocation could take the quota and
+	 * make the instantiate fail after the old payload was destroyed.
+	 */
+	ret = generic_key_instantiate(key, prep);
 	if (ret < 0)
 		return ret;
 
-	if (key_is_positive(key))
-		big_key_destroy(key);
+	if (positive) {
+		if (old.length > BIG_KEY_FILE_THRESHOLD)
+			path_put(&old.path);
+		kfree_sensitive(old.data);
+	}
 
-	return generic_key_instantiate(key, prep);
+	return 0;
 }
 
 /*
-- 
2.53.0

