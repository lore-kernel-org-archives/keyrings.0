Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1B43CE65
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493091; cv=none; b=ce69qb7FUoQb48No2kfUF5cGZOn1553EqC44r8AT4bOQeFW1IJvTlzz13DsRK0BT4Ap95fRrWqFxmkQLHq468FHpB4azI+BqLUaajTj98yJSzTLT247QuMjyEhW5ZAn5pilgu3eZPjgDQ9U/bgaaRk5PFgbHFR66xIDrzP/3tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493091; c=relaxed/simple;
	bh=vQAwyxNj3AED0ZWDQ7B3q4d5Ag5/7cRBweYxf4EerGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svN6/LCyE2AATAClLpO8y1595TS6nKk7rcAGXs6+KxTlugveXHTFzQIK4+nwOh2JVJX8LruFwxpHT8kOV1TMvE2F/9VsP3yZA7HUsQ0dG6RSY0node3EZCliklz/drq2RlI6ioTYR8oaKgaypMMZOwv40rAt1cpN9Ng6Uk7Iyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=MxrzNy9+; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="MxrzNy9+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c9995ca60so1205737d50.1
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791493088; x=1792097888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LSvHBJQxiIqbp6o9z5pfgV7EhGFvpIA3j/HhyOfsFYA=;
        b=MxrzNy9+XPKZgP/QHITHgidKnejBpCbBqpde0Jhs8zaDZ8YVcC0/bmDnKthvi8QN7N
         XA3O6jQt1FITSUNJH1/lcjC5FrPLvMU1GLKEG5KFeSoTg1wFJl7cqPRPvtTJLnjJZTqi
         nVzlADlP+KdoC+dE/CA8m7BBtHxJKE5VAnPEmYfU36WeVhhtTDSWsevHAfI75wPEQ8u0
         mLAiZsDSApZH6fNtaB9NS2/gej1wpXBjHpaGLfA9KZVHWcRUmoBfUnqWJauupHmhmykS
         DKJ7g3T1Hf03AHzIcTFMuRsVtHif8zUYHlF4gRXmUF5H9+7VAUcD/pGLdPIBer445z0L
         uSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493088; x=1792097888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LSvHBJQxiIqbp6o9z5pfgV7EhGFvpIA3j/HhyOfsFYA=;
        b=QRstKXLFxSzBCjtJgB7dfjtunJgPtciwg6tE6pXZorH4bzOBWaWA/PMa4gigzFUkgS
         2p1R/KsJ8+UPpsi7YU7Jdm/sJ+RRso3KhKLeggihEpWgguqLl/ZWQnlMy024Vp+7mi7T
         gTtKKAvAFM3H/E2+EuKxFkrC6iXa77YVyw1pPnbT8pTfwnUNfe3GbOipFCHXdCrPDX51
         6fO5N3/AIBjvI9YJkBxUipPvMKrsh8p79ZKz/IirohmjdqpTcqzlVm0C3+RzKZeO0nqw
         ziXLcaTrnFVSELeCYIGFTFdEMGQKJp13ITiP66yliJAKiK5aSveJN2+072Tuu8FERlqG
         zrJw==
X-Forwarded-Encrypted: i=1; AKwUvBzPLmcmuaV4PAl8DXMrZ7mVcPUd2zOvzO9D3HJvdGc0eQ6xp6/17n0R3273nOqpLzqa/l9uGOZGKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbaOdUrgHKv4Wqk2SlikPhiA/7MqfMVOwqm5QFDEgwW1bmimqT
	EMYxgYwgY/JfJpI5RVhuCY6xpXcmJzclgi2iCfQzc7pnXDb3/+dexMiyvlen3uOGZvaw
X-Gm-Gg: AYBFou2sjQ6bVVsrnMRCep5y3MnO9mhv5SVztY4IWWCUI5M28v61sgCIG7Hl4OvUKgN
	EuZGDqA7l73VGdWEreZUUqQeJnLVJAOqrLBQS/JYvGTesCummyVHURgxmRmEQGzocXh0lNnvl26
	3Jgy3uIsGBG7qxDdvE+rj5K3UdBBGMnkPmCWRIZn97Wnj5p8uZ1Np/XA85JiIxp0B9NRv2XRon2
	Z/4BG5IvMMluxeEBcXnhqfTU7RGUJNFNFVf5l5UbKJXtAJeyXKw9IcSNNKtJ/vPPZNbsG6EfiAW
	SNyI5Y0V9JsiWEq5kbSnED0QUfYXF0Q3UJsUGUo6iBVW2VHs0ll1InUq88JhMCUKEKCj9pS+E58
	OGoF0+5f02iYJL71LRBphrZwFbLQQkZDd0xvKc/ZeeUKwwc+4dQ3xT6MfGRNmwybNIR2PdPs9AV
	Ur8jQYB7fHX79fHf5oAyK/DX7EE1TITfjPLejtQd1NVVpJDsZ+j+7HkMXTUQ8ARZ5WnYNvRVbEM
	Fuq1EtJ8S1iLi/Bn8tkF6+5ys6yWQ6izx0+yDEkQYKX8pzRPS/Naho=
X-Received: by 2002:a05:690e:4391:b0:675:6803:98bf with SMTP id 956f58d0204a3-6793628b5b5mr14774d50.45.1791493088070;
        Thu, 08 Oct 2026 13:58:08 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67935707401sm78814d50.24.2026.10.08.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:58:07 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Thu, 08 Oct 2026 15:57:37 -0500
Subject: [PATCH bpf-next v2 3/3] Documentation: keys: document IDs added
 since KEY_SPEC_REQKEY_AUTH_KEY
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-3-008456d189cb@amutable.com>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
In-Reply-To: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
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

