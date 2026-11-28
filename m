Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831879;
	b=EXpvRTjOyF5DYmnPOCGM+YqCSKdmsgz2oPI3/G1AuAZXAcaX3FQiZI0d/5dvueIEBLdp
	 sX8bv9g6dtJWCHEHHKr5S0sC2pe4rmCXh3+Oq9ZI9MsN9oErDtwaxfcQHmLZjQctH+zDc
	 Laxh9ySse+xuAiR/pYPYiPdogXsipp82VJRs/p2YgGbcH2k7dObx/LaRF05OMhgyjBEh6
	 QbigGyKXTW/Cnr8oxAR4wTf+/n0iNsjmZ34fux1thazQG2XS3eDTSg9495PJ7cmc/XMk4
	 RVOaj/nuV/oAPiFRtJtkuSSjHdKWS5g+ltQB7B9SOhFZYxhwlZsvLec72caxZA5zHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831879;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YbVGmp557UNHjjARzihyOmQ40F+0wbrVNQb6Jam4lJY=;
	b=hB12f6vCbVD/LC68VeMG9g+5i8r/lD2sg2XcswY8p2Y6r2dEJtZ9RKDv5cl+3hZMmM4t
	 HymPvlK7yKmURU4LUJTBodxioysG31vOqx+D501kXAtcbIXK8CBKGrNsdL6SoYKmBgrh6
	 FXwDQqh9Jqx3V1eloJVVDkjXdmJKnHsM0y/BSBbnm8No2cXquaVAs1TTpeFO5ekhlQP/q
	 EaoiKDx+mwhqlcOENwh4dtW2YmmV6+Ccdl2AL+b6le350SvnnLQijnnAsEy71yNq0oNA+
	 dHFaurOh2MKxybuiVy2XlEduERRAUhn+SSQo0P4B0cDZLKKFoDvjxl0v0sphkz7A98Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13080606A31C;
	Sat, 28 Nov 2026 02:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13080606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f987288eead011f19a56ed5b684f684d-20261128
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:078371f8-e486-4943-9d4a-e6bd0e2299d5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:078371f8-e486-4943-9d4a-e6bd0e2299d5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:7535750d372640e213a5a6b8012b147c,BulkI
	D:26112810111238VU2TPO,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,Fil
	e:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f987288eead011f19a56ed5b684f684d-20261128
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 429364367; Sat, 28 Nov 2026 10:11:08 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Guicai Ma <maguicai@kylinos.cn>,
	keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 1/2] KEYS: Return user session keyring on lookup
Date: Fri, 27 Nov 2026 21:11:05 -0500
Message-ID: <20261128021105.3171306-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127121433.2400766-1-jarkko@kernel.org>
References: <20261127121433.2400766-1-jarkko@kernel.org>
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

On Fri, Nov 27, 2026 at 02:14:31PM +0200, Jarkko Sakkinen wrote:
> A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
> without KEY_LOOKUP_CREATE mutates the credentials. This causes struct creds
> instances shared with other subsystems to become stale.
> 
> Address this by returning the resolved user session keyring directly
> without installing it into credentials.

Tested on jarkko/for-next-keys (aa9e16503df9) in an arm64/KVM guest with
KASAN and lockdep. With a small module calling
lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_SEARCH) under
override_creds(), the unpatched kernel hits the BUG at kernel/cred.c:376
and the patched one returns the user session keyring without setting
cred->session_keyring.

Userspace checks for KEYCTL_GET_KEYRING_ID (create=0 and 1) and
KEYCTL_SESSION_TO_PARENT (shared NULL and non-NULL session keyrings)
also pass cleanly.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
