Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3C3E5A3A
	for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355875; cv=none; b=kBcfqZjw0D+RTOieeLDc++IqYRJaI7yzykug4scYl3aMFrw7Px+dN3nbnKC7uy/JWXv3gQscbD+1Ga6p4O/nImhH5GfBvxrOU9Hz2vFhNLkZa6VM725fKTuEtihJ8FaNWOwpnMD3OvR8yMSeshX2gpzcw2ZoE08rGYv4Duz+eWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355875; c=relaxed/simple;
	bh=3vvntg+S2X+Ax/eMsRRgfXIb9auW/tXA/R5dpCGI/5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuOf45X84ImgBSQd0b8AfGbqbfDvw8z3Ct5aQAX4dPqU190AlaObCIDdXIv6Sl4xdDQooHAlN+Mv5qX+SFJIH/6s81oNcloR4y3jhkxcRVOCCV3/l8baE15xdz730jrIvmsBcHAAupeGgPhT1tKoVjtuapbmIOxgQExCyUiQOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtSeXVka; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtSeXVka"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3e03939so14901795e9.1
        for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355872; x=1781960672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=EtSeXVkaWCF9Qw3BXu3nd38sotcl/2lSC2GWMZjEUdfJaAoMI9/JZIsftYuRdB+6Z9
         waqpnD5fcdQpgeuQHG2XM28IeIoYtBi9Uss5YhGMs1CqMJI2eJg2VrjJw0VltPG3Y5zb
         EYXWN+WKjXR6s7NqhhDtDOWtC7Jd+WfufqzcuksH8xffZzVv3DqI2gAjrI6qjcs92sl4
         l4uWNEjNjgMVYFZTy7ICKgVOXR29AYr2j2STolTsn2Hgq/YQ32gYGIL4hZAA4HOTd76u
         J0hkhoLfAxC5cDd/bT7ipSoFtPAqQbw9FFXdpHFJ4UbxHpl3XxOYbsG9DQMzYgCaUPgX
         zVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355872; x=1781960672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=Y+qLAPERrhjHB8j27C+HiISCG6Ty04dpKU5Cu3gwplY33aoE2OKFGPIw1D5WdQNLTE
         tVl56Z/+ncgr20BpYFm7DujW02scmV34SCDX/00EFmHEq5DtjFhNqU9CkOmE3YIGDRwk
         ReC0v2RriZ0he0KFvb2I4nZ+4oPduFjaCXTCZVl0f3outZxOeuyebUDlUoBwWe6n0mUk
         QIgHjL9HkEFK6+sLuwiyLLjgFafiJDqoa/jMAUqwVXr3JJT1T5H4X74FRcbXEQ0GqPXl
         OaEYn2Sp5P1xR5sfa5DRJvf5Z8RGMDg1te/7gLdja7fROPXV+Hry0gfSsj9lDUB5Dofe
         vmXw==
X-Forwarded-Encrypted: i=1; AFNElJ+QVYOXNgD+ecWW4W2HwLogstWDIi3YUH+i46o3khZ66Oj836/WIhIgvagr9rqYDQX56BBP2usIKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiqors2UyOw8f0U0u+DLhDQYd+pqSqE+deFXFXD4U7ww6Ha8z6
	0wcAJj9o5X+NrAlejrXfzLFOn5ID0PoVmeJpVy9Jm5dQFSPseol3wjU=
X-Gm-Gg: Acq92OH7oWRE0OywVrZ5+zS9c6NkM5Uj5Ns9QybvkZ5ImdtyHLlX2UghpgCynkrP8B+
	LkVet+xIcWZGUjb36JjORqCbubtyZ/RuLknIw6Ecv+Ep5EDnF6BEpBBjyEsQV3WtbCXjNyek+sr
	++AUwBRsT5uS6NIVQ3X9yXggz17W6nnRLnmE7lKJs8yUuLxGp0ejITLPBz7Kq2mhEKlg23rxA+5
	hwYiYN3XOkXMEgVbPohmo/Me7WtW2tMuvCszQnccllZc3ZckDOpMH5q5on3KHmPD/9rdNv++FNL
	PRQhQx8x0Uj8pwPWnPZn928pL1xy0z8MaUPYVpNCSrnpMXgmqiv6kUekEhATPso0lTVygW4tVDL
	kHWaUlSxQHlB/t6TJDhVgPwB0sF0iEPktXESHIEZXQhF6vwb556HHBLGLyAbiWIQnnhRJCE56pT
	lL5et665frJTyft3+cOve0s1Q/xiK7moYPc0f12MO/+VXpDsTR0oCDdhYrcM2uP47s1LcMH0qkL
	U0SiBlz5gLsYNKJ9+XQLyA8N4zSVec5xlxRXG6N
X-Received: by 2002:a05:600c:8b5b:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490ec49f2bemr76562845e9.8.1781355871908;
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 2/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Sat, 13 Jun 2026 14:04:08 +0100
Message-ID: <20260613130408.13709-3-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130408.13709-1-med08elkadiri@gmail.com>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace two BUG() calls in keyctl_pkey_params_get_2() and
keyctl_pkey_e_d_s() default cases with -EOPNOTSUPP, matching
the error style already used in these functions.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyctl_pkey.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 97bc27bbf079..6b2821ffeb6c 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -155,7 +155,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 			return -EINVAL;
 		break;
 	default:
-		BUG();
+		return -EOPNOTSUPP;
 	}
 
 	params->in_len  = uparams.in_len;
@@ -238,7 +238,8 @@ long keyctl_pkey_e_d_s(int op,
 		params.op = kernel_pkey_sign;
 		break;
 	default:
-		BUG();
+		ret = -EOPNOTSUPP;
+		goto error_params;
 	}
 
 	in = memdup_user(_in, params.in_len);
-- 
2.43.0

