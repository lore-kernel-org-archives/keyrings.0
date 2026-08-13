Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944B476CF4
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624828; cv=none; b=Hts3KySYhuyrpnh1bPNqh+u+KoZLVzgUZVyr9kWLdBMnfj+z5ldkHgbvVlHqQrtt7Cb5/23SJE7zfaWNMk/AeduLofLUH5fT9KwEVK1LC++EJYETOWeIuBfVU0Aybpc0pe2aYQbIebkumtjSCNkumZS5bzFrx/LJCkfiZ7U68YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624828; c=relaxed/simple;
	bh=kZVXyLyM/GVc2wXcF2xaIfTYMUKFc8zlenZb+6U9AdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJlhpStAaj8rwaUHz5FHI61DxuFGGhXVq6bqqkQWUnxSlR/sj5S0hBzHEfZsKoc6Q4kpEl02ysIM/ks90cSA0YtvZUwSBoWnsH2Y/NuZDLXlJHJd9N1Hm7OPhjRNO2H7Amn1vMdpAhxvBKWUxcdBkBkqFrhxnVt7jhF7IicWk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jetONqVl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jetONqVl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1925959b3a.2
        for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786624825; x=1787229625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWg4UYHkA9s33zhrk75mu6M5WGetZ/Z5iOlL+3QXDpk=;
        b=jetONqVlCz20tnbHC4sZyvSD2omZhZF43anKQz0eiunP9GLAHvPO9YlJsWkbCDXXJ7
         8gFAnbxMrBQIhtq1d94hVP+tFF3d2/JC0YhOqXsdJEWyo7SagHETzcHC0H8xN2WxDijI
         cUCmBk0JdAqOLMkfAfZLo3vgPX+KV1N6mi08cRf+ktAJYbNtg3+oK0zL1hEGf53tZFHv
         Ek20aUIB99oRKFfIDHwQBxjRwmJSRN5jTtUu3W/i1GZE0xcBxALAisKJK/gha7Glgfcb
         dM2phfmHPoLFnqy+3jK6PRlheKASixnldI8O470/TLLupQzyyCTDFAVCz+5PpH9RjWnL
         oh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786624825; x=1787229625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWg4UYHkA9s33zhrk75mu6M5WGetZ/Z5iOlL+3QXDpk=;
        b=W22zVJWndkAwCcMbjuYSwx8vb63lfHta0BaEqldp8i/pDtAAg6uhTGqhwmvkZzolyy
         CvDW/j4VVRLk8cybVCoppwygj7XHFnv4BWSsuh0Pm6yoSvzFJjhKAbSNUvAHbbbRFG9G
         X2ZNZwYVatC7zcHHk40rraKFwnhCykI1pkDy+O8UaD3x2vdDSSKRb0+8sxRvCp5l49LZ
         wVxO4hlRRCfTqiyN0BMWhZKgBJ7qGtR3ndtU8P4sRSnmom0Sg17M/tman9FE/AEDs9aO
         J04fwEDbHboh+O4ro63jvfl+18Cq5CqKyGjOjxeDF8I0hmEtqYGwIsEymHDOyVKXmdCF
         x0gw==
X-Gm-Message-State: AOJu0YxZoEE8o0f6XS6Bn4PpJTUPgFmFcUhfOMiGbtf3iHRvk5jZv3jn
	uwGWSIqwHNBOWUtBAKGipjOmwF+tW0ZvIk7L0X1Q7oRMgCDGKVM2kn//TYu5ku3a
X-Gm-Gg: AR+sD120OUTTHT8K6lCN5LobkVyR6h0xIiYnNEOKa7pxPVKw7A3Ux0zFgjPdTwPCTgg
	/lL5XekpSngssZqBzvO9F/vYgQRmxzH8E5vpvvcHgF8ZNyvCaouSbKUWvw+Tqu2uVvaRnLT9XRi
	mzKtwClquPDJw2qBlrZADXdQ6yXJfqRh7pxVQEhNPYUe+k84HlUMy8G3RPFIA+TgR44nJDGDaxw
	VKosGxKdPO8x+gAXNqIsBwm0CWANodsi2a723udydiLK/9ln0MQwFtQuthtvV2UTSEVJKbP2qXX
	eZuMcqf51LzD1ulmlgOAJqoBzkcqTlxYdLGNDSkgoAuOFjSoSuz19sfxCZe88fBIu5mfT8lJY/Q
	K+hGQujQusqeTdGBXBXfY9xSvRvBfzLo0gxpJzUWCUK2wp/kEZZJNviOeUiFPCSD/xXywfQHSfq
	scDfos0+M5nH3NcjT+DZCYxauFi+AAR4Kt31AnNXTbDKBqkS2yT639rchom0pCjfr70YCv/K1kV
	Ewcm64BjeE=
X-Received: by 2002:a05:6a00:aa83:b0:845:363e:12d9 with SMTP id d2e1a72fcca58-84fc7492a10mr5851741b3a.3.1786624825151;
        Thu, 13 Aug 2026 05:40:25 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc5aaea05sm794718b3a.60.2026.08.13.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:40:24 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Mat Martineau <martineau@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH] KEYS: asymmetric: reject non-positive restriction keys
Date: Thu, 13 Aug 2026 21:40:10 +0900
Message-ID: <20260813124010.2546648-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asymmetric_lookup_restriction() resolves the serial in a
key_or_keyring restriction with key_lookup().  This can return a negative
or uninstantiated key as well as a positive one, and the restriction then
retains that key.

When the key has the asymmetric type, key_or_keyring_common() treats it as
a usable trust key and dereferences asymmetric_key_ids(trusted).  Negative
asymmetric keys have no payload, so linking an asymmetric key to the
restricted keyring causes a NULL pointer dereference.

A process can retain a negative asymmetric key after a request_key() upcall
fails and use its serial to restrict a keyring it owns.  Linking a valid
X.509 key to that keyring then triggers the fault without special
privileges.  On systems configured to panic on oops, this is a local denial
of service.

KASAN reports:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:key_or_keyring_common+0x688/0x880
  Call Trace:
   key_link+0x1e1/0x300
   keyctl_keyring_link+0x6e/0xc0
   __do_sys_keyctl+0x299/0x530

Reject keys that have not been positively instantiated before installing
the restriction.  The explicit NULL trust key used by
key_or_keyring:0:chain remains unaffected.

Fixes: 7e3c4d22083f ("KEYS: Restrict asymmetric key linkage using a specific keychain")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 crypto/asymmetric_keys/asymmetric_type.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 16a7ae16593c9e..ce78dbc8b8c1cc 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -553,6 +553,11 @@ static struct key_restriction *asymmetric_lookup_restriction(
 				ret = ERR_CAST(key);
 				goto out;
 			}
+			if (!key_is_positive(key)) {
+				key_put(key);
+				ret = ERR_PTR(-ENOKEY);
+				goto out;
+			}
 		}
 
 		ret = asymmetric_restriction_alloc(link_fn, key);

base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.54.0

