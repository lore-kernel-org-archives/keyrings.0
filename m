Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C048EC8A
	for <keyrings@vger.kernel.org>; Mon, 14 Sep 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404129; cv=none; b=DdafCLwSqEszdGRpyPyP0LPCvdcgN4h8I1q8Y1t/cYg4T4MbGvzgkPr1qzhze1DYj1FJfl36uXBI1ITE9pltLX6pif5sPFCPq/gdvdmi110589t6pEEav3e7zkM5lVizbQ9MRTdEhkVcl7zVisy7296NlDVibJOvAjeW5VxE4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404129; c=relaxed/simple;
	bh=fyPrl3WvozGTDDVsDO8MGVfKnhRCs2T8g6qKeea9uQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gfzq4VpDIqa49ZXxv4zomufwVzzPJNOMU/I2R6ASQNC5gCF+EIA6uGSC8DrCpKr27sPWfRyyFiMXIGXYP/+9Nf9G4+mdm9CkcgajvU5vN6wdlyjGS19Kam1KHfBk8TphGNhEzsC+wS5rXLrho851tRkUrpb0/tHEiZjWPQeF4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=f5lMeVgu; arc=none smtp.client-ip=74.125.224.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="f5lMeVgu"
Received: by mail-yx2-f9.google.com with SMTP id 956f58d0204a3-66e5f4dc13bso944254d50.1
        for <keyrings@vger.kernel.org>; Mon, 14 Sep 2026 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789404124; x=1790008924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndMM0TFrryHnZOvHnxhOWJr9tGmJVwIhyX6o7UKbX40=;
        b=f5lMeVguGh1mH4Nna49X7IZNiBsDiRwwgHAAwhJRQY+ZByij2jyEx4lsK54K5OA2+e
         jFm9UiDUQT3kDyC5tHE/XGiNnorfF2b4xKZPEvrPqNyY0+M2Hgz/zCdPva7/qr/9dOOm
         UfQzb0QXf+wLNVjOK6HTBvlVi0SsMFokmKKGN5+bduK+hDLiRorkhsn+7G7qYXHj2siE
         beLXJ/xcGk867HZ5ZqoElH6M34ATJo2y9mFIG4m878j12sup1h1i0S/LryjR/yf3yBHv
         LLAqBHUl72QrDEwXVRhWS0cv2jeK0+wGMdBDFwu3ZMOQ2VNx0SBCK4ibsE4f/lm5Ur4n
         6cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789404124; x=1790008924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndMM0TFrryHnZOvHnxhOWJr9tGmJVwIhyX6o7UKbX40=;
        b=zDpaR0yQT0fP/mMbJHKRbqWaxrMqe3HqqTe3QTkyc4qYuvCyGtPnVm1VRToa+pik5P
         BS0xlbKygRZdSez+e6WRd/yAqnn7lXD08WBewsbyDByhcQ2eef6kCcdsdbt2ZTBwukRT
         7O4vAtqE6f/iJD6g64SEBfH9GhW1tEnzNblMG7IlF1VET63KZtt6DwGJuX8u+u1oU0yd
         5wPt3T1x/DBC/X2+ZAG6+K3UpxRhXDygdgYQk8vKpKAGiI+zS1f/w5JigUYmrgp7vDom
         vPRxklJtxWhWxcs030Uk1m4UcUy63uv7pYC6k5HTgngkVMrP8ouVsZOQDJCyme8HT6wm
         2UXg==
X-Forwarded-Encrypted: i=1; AKwUvBxJKvesKWZeXbH7PwWa+JFEkXeORFuDjFs8mWQxRtkDIejK1SgYjiLOIPUdoWdSOMp2sPYvMbAqzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lWx5e7zbG1ME6xOqEl2Jwsff09ExnHDlc6JWa9EAFLsQsOCa8o
	a2uftdtQuNde9rPwtaGDULUoNRrCNhohr6Nk2Z1OPPQmKKx7r7rvJupmp38bJ70rOQDJ
X-Gm-Gg: AYBFou33VLER+LD6YiNNFcFqGByBGhDV8ER4kuBr3JblG374V2E5wefqkLdLgM/EQ5p
	n/BXmc4khjaPw/mRg6qra8O7QrD3gf6ADnvTNmtPV4UzTXUnYMa18ZdT1aC5sb/uzH6IV8UGlyr
	LkdFEczDjF3Y287h724MkqYtKW8ub9kFhs6E0o35F/5KppElohAwy+wKHp8KmEVojOF2Er3TALz
	gODMZeN8wqcmA7CHZMpNDD7HNLswAYNB+sYUJJkActyFUpebT/aqSfHhCyvaix9vEuSXwhtE8yE
	hzShztrwRbf54nv3zGNmmxZ3GoBaDkkwyz6uHr4s3r8XzeO4PB0E7uafQQnBgQKK1euILi7eDgF
	5r2n2ZwaZMCNFf7Lnb4k5y97A0BwY6jPB9idJcnXOj1buDBcc+MzUlOgGs7g5UPmObGO6t6FcvG
	SACJLbDSSC7yHjTYmtEYvTqLxJq/hRfT5KmwrYOTEQLwbsLG+B8amtuv7vfKz6
X-Received: by 2002:a05:690e:810:20b0:671:4a9e:7c91 with SMTP id 956f58d0204a3-6714dfd252cmr743318d50.10.1789404124390;
        Mon, 14 Sep 2026 09:42:04 -0700 (PDT)
Received: from [192.168.1.110] ([2600:1700:1ff0:d0ef::d15])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df42a8sm4879023d50.8.2026.09.14.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:42:04 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 14 Sep 2026 11:41:44 -0500
Subject: [PATCH 3/3] Documentation: keys: document IDs added since
 KEY_SPEC_REQKEY_AUTH_KEY
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ajhalaney-dmverity-key-identifier-v1-3-01922dc1366a@amutable.com>
References: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
In-Reply-To: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

The table of special key IDs stops at KEY_SPEC_REQKEY_AUTH_KEY.
Fill in all the new ones.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 Documentation/security/keys/core.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..37ed42382f16 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -372,6 +372,19 @@ process making the call::
 	KEY_SPEC_GROUP_KEYRING		-6	GID-specific keyring
 	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
 						  authorisation key
+	KEY_SPEC_REQUESTOR_KEYRING	-8	request_key() destination
+						  keyring
+
+There are also values that refer to a specific kernel keyring rather than to
+anything belonging to the caller.  These keyrings are not linked into any
+keyring, so a search cannot reach them and the ID is the only way to name
+one::
+
+	CONSTANT			VALUE	KEY REFERENCED
+	==============================	======	===========================
+	KEY_SPEC_BPF_KEYRING		-9	the ".bpf" keyring
+	KEY_SPEC_DM_VERITY_KEYRING	-10	the ".dm-verity" keyring
+	KEY_SPEC_FS_VERITY_KEYRING	-11	the ".fs-verity" keyring
 
 
 The main syscalls are:

-- 
2.55.0

