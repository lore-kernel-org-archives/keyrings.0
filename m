Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831880;
	b=T+iwr+1M8HGCv2IKtpq8bcjVkxRLlfwhYhJxUyGTFJ9ZyDmNwg4vZUxdJd1VBF5szrgx
	 BrrMHbeAmexWt13wu3bl1zBKz7RfIWdgX3Y9y9QnE4qh5FdHY6XO6x1ljnAinQm3/lj0q
	 Pjc58XfQWlnp4jcs3mJBla6nvVJUwMJ+q8lxbqYWVpoBFe1ahjUeBgF2Pqh7pzN26rLQn
	 sndTxfIbvTil/q5q1J3DYzCwoQzNkpLmUwsr2paEfn2QJVKAmHJP4goSalO6FozWM4+H3
	 Dm6c9MA05Tjzkbwe5Cf9vmsXtxqBDBenSnTFu4bQ3j7P52YezaoMjjpvi5R+rMIBwnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831880;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=eOHjsspusfU6sZOt8ovIxCa3ef057Zof8I66FPeUQHg=;
	b=LcgQOXqqEoFQAo//zDEM0wwG2jAYvM+exWyIyKRQOEcCL/vhIfd2gb6RTZ8GhQmG1Oty
	 ZR9yRKm4eznwwuLBMjtq09k6NsQZodYiWJqQDONaMiGIfMexw7G9+3X1r+3R+n0IoI6WN
	 56ZfTV6RqDAWK9dYwxF2yIVVgs+XsP+RBrNDpWglp+aFp/+jmc3qKjMxdGRdFFqOLmbv4
	 Gr6cem8UF2SpoB7m69v8poH2CYVcxgvGrLG4JlIdSrRqEdfSiGzvEgfGJioY8x9lsltxy
	 VZ7HwnEm4UGa3hngTypF+wm1bcI4srIbFvlJPrDPR/MggGmKq+GpcSPgQDTXRz81Xrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A11606A31E;
	Sat, 28 Nov 2026 02:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A11606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb349518ead011f19a56ed5b684f684d-20261128
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
X-CID-O-INFO: VERSION:1.3.19,REQID:0cde317f-f4de-4d2a-8a57-9c6acc0b0e1b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:0cde317f-f4de-4d2a-8a57-9c6acc0b0e1b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:bc5cb7b1ca9e9edd1da1829313e35cfc,BulkI
	D:26112810111476XI8E8K,BulkQuantity:0,SF:17|19|64|66|78|80|81|82|83|102|12
	7|153|841|850|865|898|915,TC:nil,Content:0|15|50|99|300|310,EDM:-3,IP:-2,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fb349518ead011f19a56ed5b684f684d-20261128
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 331505988; Sat, 28 Nov 2026 10:11:11 +0800
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
Subject: Re: [PATCH v4 2/2] KEYS: Reject keyring creation with overridden credentials
Date: Fri, 27 Nov 2026 21:11:08 -0500
Message-ID: <20261128021108.3171324-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127121433.2400766-2-jarkko@kernel.org>
References: <20261127121433.2400766-1-jarkko@kernel.org> <20261127121433.2400766-2-jarkko@kernel.org>
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

On Fri, Nov 27, 2026 at 02:14:32PM +0200, Jarkko Sakkinen wrote:
> If the current task is running with overridden credentials calling
> commit_creds() is forbidden and triggers a BUG_ON().
> 
> Reject keyring creation with -EPERM when credentials are overridden.

Tested on the same arm64/KVM KASAN/lockdep setup on top of patch 1/2.
Under override_creds(), lookup_user_key() with KEY_LOOKUP_CREATE now
returns -EPERM for KEY_SPEC_{SESSION,PROCESS,THREAD,USER}_KEYRING
without hitting commit_creds().

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
