Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D644349B4
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493086; cv=none; b=u7AKpGDJTkzmZ8VgkCfEpgeA4C0xJ3Cr6k4yB9VN2Z3U5tilqh4E1+UQkOnT0K50a+d7pslalVlQcbIpnrhdlY+pDkovxPXMEmjhpO97XdY48VADHAuRKCbZIHP6fFDimsG71/Li8YHWYBEIAV7xx8ryQOf/F2NV9h6CkkhSuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493086; c=relaxed/simple;
	bh=vpbeEaPR3E1pmaT/xNDC5hjULFUimCv8YKxCMpWM/dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZTAT6V50K+tTpOhJElvTix9ZwTIczSS30XhKfLcSv8Qh3tLuKCqrch7u3zWqb2FlDZWXmhVlUpx4g74zlpROFszoA+/TNp2izCELLh1YIVGSW1iesvdQSdI0VIhCwpx2Ie5H9y81E7+d14WEXunyvIT+UVV5e0mn5BdWsITpqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=ZGQjSkiv; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="ZGQjSkiv"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768ced47aeso4022911d50.1
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791493083; x=1792097883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=ZGQjSkiv2AEUSaNPDRvhadrbCMs1ALgftpyqaSsdg83snUiUpmwdtkPBHcPjXcMSW5
         WTxrlWiKiSu+EiohigdEJyvDyhVbn64MLu/fV8wqp16F9oO2eu3g6wku9vB9EbmI0EB2
         LB0WiT2LDRLnb7pQca7cTWOuOr3HtS8ca1rVms1p3iMuRVnxHkLTRYX3M3TWpvURtRSj
         eBE8oMrgkHViifnMrhbObPdyBF9FhNEDWhglMesj5txF1bXZB9bHgf9B+uyEAXeKEaH8
         Mq4q1kDoBNvoY68r5QfLqMIsyxdPRH8aGDwENlYI12C3ehEf5R+UOFa5poKnY/LbpfB0
         fynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493083; x=1792097883;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V0S61SflNz3PvfgcGBGx11GkE7hBo5diSyO3i89hlIg=;
        b=zKhSDcUFH+DMZqUubxpkm/JJis4BPbEA/Y/ve7e1C1OE3Axv6w/jzDZY9S0CDLD2h5
         6ZOLk3CiBuT6Uk2dolMh59PZB1g4VNdDRr2elyGKtTgY5m7XjQc5RE3zu0d85bh06PN/
         n69p6VbLczzcwSOUJck702xdqiYpiGSidQSPUHPRWL+ibv69khauWJjtJJkhp2IITGFI
         W7nDfib3V671rVfZnbPaeLfOYGENAsAhhYJgnAsG7GHuU6WxLioaAwmHST8xAdlkgVWt
         jhQk5/13XqVJ9soh0vtCLbzYf9LF1U3FHA5oJX+2NKJvjS0RFzPqxHg3W0OCKtNCQYS4
         aYng==
X-Forwarded-Encrypted: i=1; AKwUvBwpcfYc60UT6OyLtxvjGshT/b3RsJBb8GQpJz+DlLahXanbzm0w8pMQnqmRVKcgHIXTnR7gIqBpNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwMyRxzJf+eQ/tgmeQsaZJhmkA3yghvzaNVPx0JJ57a16OL6OY
	tnlt/HdoVyffYsepPIubLN+H8AQ+pOUoWMmfyiUbPfJd3ivJnQdAJlyUIMIMAU1yDWK2
X-Gm-Gg: AYBFou3N01dxu6xiL/SNc+O1z4B+EZOAyHxo0U1Q/P6QJA7v1T1dcRNXCgodKGlNreo
	jvdRxlZZpp125u8RMjtSsaQlP+bitodhOukXcY12Psg9+ZU339PXls/LEH9r1UaJc/Gw0RXySie
	J+kDi4x2m/dB68HmCVSAMfqLYVXkBjwxlwrtlFoMDRsyOX5R5FgWFIBFYXhH/CpUb2jOEbwx5v9
	ia7zOVHbEeHqsBddEw4wRRuBRHQnLUuG/Pn2JedauqUcRC6G29YCaRoGRAnfLCxGosgnSR7xDet
	ONxlA45iPmUV7KbqzkU8tYf9m9Wcuqv9qnktXQHwkLIVKr2Nfixvi+phkfPMljsPyS1yQ8ulZC/
	7pO1f4YNIoq3eLT6xUVXlepCKSizQr1nvIlaXzHIyECbBVMyEiS2LyZIEbvsCNaGHaIiuwzQkeg
	o0pLgAHif5hur3puWaMoacmlE1Tl+9QVSBS3qVFkZrcjfvzSiTUJdwrVPvONXRweKHxrVV5L2d1
	MeUAPb+wC5RQ1TKtStMXud0HX0WUFo2uuW8K9bPJpVaSIxESp0/NP3B
X-Received: by 2002:a05:690e:d06:b0:678:4671:d9d1 with SMTP id 956f58d0204a3-679360087aamr34732d50.21.1791493083618;
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67935707401sm78814d50.24.2026.10.08.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:58:03 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH bpf-next v2 0/3] keys: Add well known IDs for
 fs-verity/dm-verity keys
Date: Thu, 08 Oct 2026 15:57:34 -0500
Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr0JmbU1bsIor72FYtHSQUSikrQ2Ec
 HcbbuDy5eX/t0FATxjgXmzgMVGgyWWQpwLaXrsXMrKZQXKpeC0qpt+9HrTDldkx5W1c2ScDWXS
 ROkLPKnG7GiXL0uAF8s/ssaPlaDzBzB1zuERosukpxMmvRzyJw//RSYJxxkUtpW1FqZR+6PEbt
 Rnw3E4jNPu+/wBcIMGP3wAAAA==
X-Change-ID: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5
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

This more or less follows the bpf keyring approach, allowing userspace
to easily find the keys instead of having to parse /proc/keys.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Changes in v2:
- Rebased / target bpf-next/for-next since 264d8fd2794f ("bpf, keys: Add a bpf
  keyring for program signature validation") only exists there.
- Grabbed Reviewed-by trailers.
- Link to v1: https://lore.kernel.org/r/20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com

---
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20260914-ajhalaney-dmverity-key-identifier-4187b6233be5

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

