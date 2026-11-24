Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497939;
	b=PXwGuVo7qKJr16hBsc41PU9MSgYeoZ9St+2Sb7IyycobRNsQDZxEcSGaapUIM0cXPLFg
	 Q2CeasGR0VtbiNflEUXdVlJwkWPaNDZgP3zyZBKevDKUBUVaGPYjX4EqmIUBdmH7PfsOf
	 TrYZAVk4/TeH4cmg9aoewp0fMShVQ7CbDPcJaFBqwMgCxYf3hr2kJRhwJEqLyGDQwlxvG
	 HaNBzWhOXVLDehbQoFphJOaKeIjkBLh/rrU15Vv8vaTcEbaPjqXSvR0tQ9FW5orGu9r7d
	 bbEZo/jByN09l/UV5LT5ccruga+c9wVN+XfymU3Vcz/repvPwYwoQRq/bUiKwLJetYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497939;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=gt7qPrM9qdKVWUQeM+5YYRxWTA6OuBqueaSihtYdXpM=;
	b=bClzzMeNDwQWtDIt2x83Foka4GVQjKla6I3oAWtJS7HmkXus4R82thkTaRdJz1duDyz8
	 YY0Lurt4ycL7wywZkecbXzsBaSuvkMmeb4kQCnrzgpepz8Xbn6+ZrAdwpEf+XQO+0+vrF
	 Kn9OuHvFfK5N4y+eaZ131TtKpIP23qLEIxdWeisnM9GwX8zli0J6MQDDecugReD5TxWau
	 eGmGUHlp+mn0bfQ0M5VcpjeUGrSifsfkmKS+Jc8NHffemZIprdJLBlNCdynkSz7JdDHmD
	 erRdZGireNAraOSO3KQ9rMD8lH4Z6XHBV4H1mfjqX2N8bIOtASKJRMih7h4WNqUg4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B3606A326;
	Tue, 24 Nov 2026 05:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7534ae96e7c711f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2ac807dd-1c9a-4e57-9293-8dfcc65ffee5,IP:10,
	URL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:17
X-CID-INFO: VERSION:1.3.19,REQID:2ac807dd-1c9a-4e57-9293-8dfcc65ffee5,IP:10,UR
	L:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:17
X-CID-META: VersionHash:7db8b62,CLOUDID:6525c901083e2b5399c99180e13d4bee,BulkI
	D:261124052649EMM1JUQD,BulkQuantity:1,SF:17|19|64|66|78|80|81|82|83|102|12
	7|136|153|841|850|865|898|915,TC:nil,Content:4|15|50|99,EDM:-3|-100,IP:-2,
	URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7534ae96e7c711f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 917687200; Tue, 24 Nov 2026 13:25:27 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH 2/2] KEYS: Fix asym key overflow in keyctl_pkey_verify()
Date: Tue, 24 Nov 2026 00:25:23 -0500
Message-ID: <20261124052524.939642-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123211959.4102708-3-jarkko@kernel.org>
References: <20261123211959.4102708-3-jarkko@kernel.org>
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

On Mon, Nov 23, 2026 at 11:19:59PM +0200, Jarkko Sakkinen wrote:
> While verifying a variable-length signature shorter than info.max_sig_size,
> memdup_user() reads past the end of the caller's _in2 and passes trailing
> bytes to ->asym_verify_signature().
> 
> Set params->in2_len to uparams.in2_len in the KEYCTL_PKEY_VERIFY case.
[...]
> @@ -176,7 +176,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  			goto out_up_key_sem;
>  		}
>  
> -		params->out_len = info.max_sig_size;
> +		params->in2_len = uparams.in2_len;
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;

Tested this series with an RSA-2048 key (enc=pkcs1 hash=sha256) on
arm64. A truncated signature with the remaining bytes still present in
userspace memory and a short signature placed right before an unmapped
page now both fail with -EINVAL, and normal signature verification
still passes.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
