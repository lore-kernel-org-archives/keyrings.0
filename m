Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489089;
	b=EGiVEAVBmRdxZPTTKyupC6OUm5RsLK7HUiPO/UuLOoBUaq9liZgDyDHD9Om9uSAWMB7E
	 0F3u1zLIRQL59oMC5yubKx+G0haUOadRumJNfBlLyJCBKiFNojTVSqRF8CIKh9PW92u3O
	 MZRHFXWpaqasxOB+6WZJQ2qE+8f35u7Vkjc6to33nPCe4n8sFQq9iaAYIEVSmk/J5wT7p
	 gNVRpvUQgG4GH29pRngF+scubeFcj87cpsSSHK1jeZK7z5tA0x8a3ud90213Yh7/+9oJ4
	 kNjK6VA+TaCLA9PUwzxgzGPU5tmJyxcZTLPr2I4bQSQ73alQ59J+32xHMG2Ddkc/URQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
	b=d7OEJvd/uehY3CIRJjGwqLUdXz4ujXCgc4gBbC/M2pPG3NTC8PD1Et6zBQjeNDFXdvj+
	 +UqDt/O3d+A3S5JuuiR4lv1dnpH0Tnt2+x3sNmBm2zApMzx9P2EGgAUIW5Z34xYPjw9Od
	 n8NSpfugPUpUREwg+Ao15RHJwhqdh9dvMs5/3jO3ZNPnnDnN+aGtPxDPr8qFUOFTGWD06
	 4JKVKh2CHLFzQYCatQHuuNheWuYybNnasdc7z4X3bt8BJNvRBUa7KIUSMG7fk7kjb/Bsb
	 y9uRKCrfme3D6K8Qp3iGRe7g4UQhhcG4k+amLmyjVdNAMNF4Nu1jRmGwtB66XUcDa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D0606A31E
	for <keyrings@vger.kernel.org>; Tue, 24 Nov 2026 02:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 309D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b14c80b210so904857a91.0
        for <keyrings@vger.kernel.org>; Mon, 23 Nov 2026 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795489088; x=1796093888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=MuqElge5ywtfzHq35FtslzC0hNsAzaejU1E3w15IRDL67GoXUJEVd1UciPryn+W6j/
         AS6vLAdUSzJuhweHqzFvtsDTmqWz+rzVXViNm3hCfMRw1/6/WFln7DYh6w7gH4ZxZ5kE
         WVIcz7/jncarv/uz8Rzv0MXitgIY7U3AxFhyTjJH3l7BqCjjWPJQJLUbinj+gXE9Ice6
         pcByujUfFzq6RbnXQEWF0mBvdCb+gP6sv1bmNamAYjH0KDL1UHqR77Ta7yItgmXCdJDv
         jlc6w9RpY7oMrBKaIkdRDNFnVJ65j+8D/qoJcGhNMxb78wY5MMmCcF27LcitpWWpMU94
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489088; x=1796093888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=d8OAWHVcfg9eoPg6dkq3/4/IEz7zGZuVdU/jlQY+3Zvw4VkM9bM/DElu5olr5c7qZq
         qY/nVAy1g6CYZ/xK5vZJJNWwQ6U0k0+ZukqwvpvJxU7ZW6eiAi9ToMnGFLXiRFA/Xt+i
         2pR/eBpJf3ZPkcNjTYPUbeRa21ZxPPmvQLJ5FFSlYXFG5oQmitO73QgZNIWmtMs8yUIi
         B4EPg/DvXyqGxdXdKjngNWrS4wCPglFx1mU2+Y7/PDBTZzlYQWNjBGtIdih+9KUeBQVp
         tOiwDYbqREnjrFqvJCErp5TXDotmFfSC35UoCFyJ35RHKvUdwthbByinotYr7Pmj5EoQ
         BRHg==
X-Gm-Message-State: APuU4Z88uTZOj2njPS233ibyB0EmiwRWARahrh8cKEvCHIe4gja3vBt8
	XtUgmsy/PynCnbXNEMjlMeO+8h1i4JtaCVbE5TemSxsA+qV3ZRGK4lyc
X-Gm-Gg: AZFdTZeK2qNkkpZX8ro+K63c2Voo/rSHJFnYPPvQIRWphVl+b3XqoPP2yTsE+WZZ9Jw
	6Q+EQPDfKqWwZTMl19/IkyFh+itXTQ6EHLlZ8Uu+8dHx7BLJpo28QG+5Bw2TEnS1IgM+cNelXIK
	dGaLGGS23uaF/rq7d8GbH5iEYpI2puFDZ1lHgQKIhBkidjWaRethWY4qBr1y4VtvCW4VFUEtjMu
	R8FTYk4oSlhxB7zYCDAQpFUMNoI+2oyHmCdqOBQEErOSPXYUtU3K7LIJRerqReMDCU9TtUUbE3n
	4ouSedH2fnyv0LeSNJYbGzlfkmJjMr1SVXnAS6+3wRIJ/TUIz2eHUQH2gEYnOkQ4ba3/M0YcOuM
	gdO9cYsu4L4qg7rgNMOFLda1tvPf5+cnuUMWK19Ve/ZVRGvYRvTzCXlcqtiMaQcoIUTprFW3KVX
	/OHL1roupb9q1dEjFf8mXGn+fDfmGmKwb3KFaZA/m5ALoMOeNSTOZaRP7zxSDskK9HcwrWB2Hkp
	DUQvh8twxiKVlps4Kls0Cplb/G7Jr+owHNSHIUzGIwy9CIsV8U/45qJFKJ5FCEbeIG8qCJrAyHJ
	SeiIF4HHSJDwsnWm1NdlKAdkhh05EFClFXoN20HGWlOBhsNpS4IePu3ZhivZ1mUaKs59aIMugg=
	=
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr10628516a91.49.1795489088382;
        Mon, 23 Nov 2026 18:58:08 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm25195844a91.8.2026.11.23.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:58:07 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 10:57:59 +0800
Message-ID: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
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

big_key_update() reserves quota with the raw payload length and then
destroys the old payload before instantiating the new one.  For a payload
of N < 16 bytes that reserve releases 16-N bytes, so the reserve of 16
done by generic_key_instantiate() charges them again and can fail with
-EDQUOT once the payload is already destroyed.  big_key_destroy() keeps
payload->length but clears path and data, so the key stays positive with
a stale length that KEYCTL_READ and KEYCTL_REVOKE then follow:

kernel BUG at fs/open.c:1145!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:dentry_open+0x7b/0x90
 big_key_read+0x141/0x280

Instantiate the new payload first and destroy the old one only on success;
a positive key's reservation is already 16 bytes, so it cannot fail.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
- Drop the comment in big_key_update(); it belongs in the changelog.
- Rework the changelog per the review below: the quota is released by the
  removed key_payload_reserve() call, not by big_key_destroy(), which only
  drops path and data.

Link: https://sashiko.dev/#/patchset/20261123165443.4092852-1-bsdhenrymartin@gmail.com?part=1

 security/keys/big_key.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..aa3e82ac93ee2 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,16 +193,24 @@ void big_key_destroy(struct key *key)
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

